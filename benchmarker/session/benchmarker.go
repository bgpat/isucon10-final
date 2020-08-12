package session

import (
	"context"
	"errors"
	"fmt"
	"github.com/isucon/isucon10-final/benchmarker/model"
	"github.com/isucon/isucon10-final/benchmarker/random"
	"github.com/isucon/isucon10-final/proto/xsuportal/resources"
	"github.com/isucon/isucon10-final/proto/xsuportal/services/bench"
	"google.golang.org/grpc"
)

type Benchmarker struct {
	conn           *grpc.ClientConn
	queueClinet    bench.BenchmarkQueueClient
	reportClient   bench.BenchmarkReportClient
	scoreGenerator *random.ScoreGenerator

	Team *model.Team
}

func NewBenchmarker(team *model.Team, host string, port int64) (*Benchmarker, error) {
	host = fmt.Sprintf("%s:%d", host, port)

	conn, err := grpc.Dial(host, grpc.WithInsecure())
	if err != nil {
		return nil, err
	}

	return &Benchmarker{
		conn:           conn,
		queueClinet:    bench.NewBenchmarkQueueClient(conn),
		reportClient:   bench.NewBenchmarkReportClient(conn),
		scoreGenerator: random.NewScoreGenerator(),
		Team:           team,
	}, nil
}

func (b *Benchmarker) Do(ctx context.Context, idx int64, team *model.Team) (*bench.ReportBenchmarkResultRequest, error) {
	scoreG := b.scoreGenerator
	req := &bench.ReceiveBenchmarkJobRequest{}
	if team != nil {
		req.TeamId = team.ID
		scoreG = team.ScoreGenerator
	}
	jobResponse, err := b.queueClinet.ReceiveBenchmarkJob(ctx, req)

	score := scoreG.Generate(idx)

	if err != nil {
		return nil, err
	}

	jobHandle := jobResponse.GetJobHandle()
	if jobHandle == nil {
		return nil, nil
	}

	reporter, err := b.reportClient.ReportBenchmarkResult(ctx)
	if err != nil {
		return nil, err
	}

	result := &bench.ReportBenchmarkResultRequest{
		JobId: jobHandle.GetJobId(),
		Result: &resources.BenchmarkResult{
			Finished: false,
			Score:    score.Int() / 2,
			ScoreBreakdown: &resources.BenchmarkResult_ScoreBreakdown{
				Base:      score.Base / 2,
				Deduction: score.Deduction / 2,
			},
			Reason: "",
			Stdout: "",
			Stderr: "",
		},
		Nonce: 1,
	}
	reporter.Send(result)
	reportResponse, err := reporter.Recv()
	if err != nil {
		return nil, err
	}
	if reportResponse.AckedNonce != 1 {
		return nil, errors.New("Invalid Nonce")
	}

	result = &bench.ReportBenchmarkResultRequest{
		JobId: jobHandle.GetJobId(),
		Result: &resources.BenchmarkResult{
			Finished: true,
			Passed:   !(score.FastFail || score.SlowFail),
			Score:    score.Int(),
			ScoreBreakdown: &resources.BenchmarkResult_ScoreBreakdown{
				Base:      score.Base,
				Deduction: score.Deduction,
			},
			Reason: "",
			Stdout: "",
			Stderr: "",
		},
		Nonce: 2,
	}
	reporter.Send(result)
	reporter.CloseSend()

	reportResponse, err = reporter.Recv()
	if err != nil {
		return nil, err
	}
	if reportResponse.AckedNonce != 2 {
		return nil, errors.New("Invalid Nonce")
	}

	return result, nil
}