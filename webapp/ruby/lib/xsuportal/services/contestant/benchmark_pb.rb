# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: xsuportal/services/contestant/benchmark.proto

require 'google/protobuf'

require 'xsuportal/resources/benchmark_job_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("xsuportal/services/contestant/benchmark.proto", :syntax => :proto3) do
    add_message "xsuportal.proto.services.contestant.ListBenchmarkJobsRequest" do
    end
    add_message "xsuportal.proto.services.contestant.ListBenchmarkJobsResponse" do
      repeated :jobs, :message, 1, "xsuportal.proto.resources.BenchmarkJob"
    end
    add_message "xsuportal.proto.services.contestant.EnqueueBenchmarkJobRequest" do
      optional :target_hostname, :string, 10
    end
    add_message "xsuportal.proto.services.contestant.EnqueueBenchmarkJobResponse" do
      optional :job, :message, 1, "xsuportal.proto.resources.BenchmarkJob"
    end
    add_message "xsuportal.proto.services.contestant.GetBenchmarkJobQuery" do
      optional :id, :int64, 1
    end
    add_message "xsuportal.proto.services.contestant.GetBenchmarkJobResponse" do
      optional :job, :message, 1, "xsuportal.proto.resources.BenchmarkJob"
    end
  end
end

module Xsuportal
  module Proto
    module Services
      module Contestant
        ListBenchmarkJobsRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("xsuportal.proto.services.contestant.ListBenchmarkJobsRequest").msgclass
        ListBenchmarkJobsResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("xsuportal.proto.services.contestant.ListBenchmarkJobsResponse").msgclass
        EnqueueBenchmarkJobRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("xsuportal.proto.services.contestant.EnqueueBenchmarkJobRequest").msgclass
        EnqueueBenchmarkJobResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("xsuportal.proto.services.contestant.EnqueueBenchmarkJobResponse").msgclass
        GetBenchmarkJobQuery = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("xsuportal.proto.services.contestant.GetBenchmarkJobQuery").msgclass
        GetBenchmarkJobResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("xsuportal.proto.services.contestant.GetBenchmarkJobResponse").msgclass
      end
    end
  end
end
