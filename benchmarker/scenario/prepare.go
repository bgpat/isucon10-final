package scenario

import (
	"context"
	"time"

	"github.com/isucon/isucandar/failure"

	"github.com/isucon/isucandar"
	"github.com/isucon/isucandar/agent"
	"github.com/isucon/isucon10-final/benchmarker/model"
)

func (s *Scenario) Prepare(ctx context.Context, step *isucandar.BenchmarkStep) error {
	ContestantLogger.Printf("===> PREPARE")

	a, err := s.NewAgent(agent.WithNoCache(), agent.WithNoCookie(), agent.WithTimeout(20*time.Second))
	if err != nil {
		return failure.NewError(ErrCritical, err)
	}
	a.Name = "benchmarker-initializer"

	if err := s.prepareCheck(ctx, step); err != nil {
		return err
	}

	s.Contest = model.NewContest(time.Now())
	initResponse, initHttpResponse, err := InitializeAction(ctx, a, s.Contest)
	if err != nil {
		return failure.NewError(ErrCritical, err)
	}

	errs := verifyInitializeAction(initResponse, initHttpResponse)
	for _, err := range errs {
		step.AddError(failure.NewError(ErrCritical, err))
	}

	if len(errs) > 0 {
		return ErrScenarioCancel
	}

	s.Language = initResponse.GetLanguage()
	s.Contest.GRPCHost = initResponse.GetBenchmarkServer().GetHost()
	s.Contest.GRPCPort = initResponse.GetBenchmarkServer().GetPort()

	s.PushService.OnInvalidPush = func(id string, err error) {
		s.handleInvalidPush(id, err, step)
	}

	return nil
}

func (s *Scenario) prepareCheck(ctx context.Context, step *isucandar.BenchmarkStep) error {
	return nil
}
