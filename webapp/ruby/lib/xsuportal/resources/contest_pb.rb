# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: xsuportal/resources/contest.proto

require 'google/protobuf'

require 'google/protobuf/timestamp_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("xsuportal/resources/contest.proto", :syntax => :proto3) do
    add_message "xsuportal.proto.resources.Contest" do
      optional :registration_open_at, :message, 1, "google.protobuf.Timestamp"
      optional :contest_starts_at, :message, 3, "google.protobuf.Timestamp"
      optional :contest_freezes_at, :message, 4, "google.protobuf.Timestamp"
      optional :contest_ends_at, :message, 5, "google.protobuf.Timestamp"
    end
    add_enum "xsuportal.proto.resources.Contest.Status" do
      value :STANDBY, 0
      value :REGISTRATION, 1
      value :STARTED, 2
      value :FROZEN, 3
      value :FINISHED, 4
    end
  end
end

module Xsuportal
  module Proto
    module Resources
      Contest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("xsuportal.proto.resources.Contest").msgclass
      Contest::Status = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("xsuportal.proto.resources.Contest.Status").enummodule
    end
  end
end
