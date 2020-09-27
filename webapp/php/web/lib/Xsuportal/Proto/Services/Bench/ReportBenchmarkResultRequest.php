<?php
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: xsuportal/services/bench/reporting.proto

namespace Xsuportal\Proto\Services\Bench;

use Google\Protobuf\Internal\GPBType;
use Google\Protobuf\Internal\RepeatedField;
use Google\Protobuf\Internal\GPBUtil;

/**
 * Generated from protobuf message <code>xsuportal.proto.services.bench.ReportBenchmarkResultRequest</code>
 */
class ReportBenchmarkResultRequest extends \Google\Protobuf\Internal\Message
{
    /**
     * Generated from protobuf field <code>int64 job_id = 1;</code>
     */
    private $job_id = 0;
    /**
     * Generated from protobuf field <code>string handle = 2;</code>
     */
    private $handle = '';
    /**
     * Generated from protobuf field <code>int64 nonce = 3;</code>
     */
    private $nonce = 0;
    /**
     * Generated from protobuf field <code>.xsuportal.proto.resources.BenchmarkResult result = 4;</code>
     */
    private $result = null;

    /**
     * Constructor.
     *
     * @param array $data {
     *     Optional. Data for populating the Message object.
     *
     *     @type int|string $job_id
     *     @type string $handle
     *     @type int|string $nonce
     *     @type \Xsuportal\Proto\Resources\BenchmarkResult $result
     * }
     */
    public function __construct($data = NULL) {
        \GPBMetadata\Xsuportal\Services\Bench\Reporting::initOnce();
        parent::__construct($data);
    }

    /**
     * Generated from protobuf field <code>int64 job_id = 1;</code>
     * @return int|string
     */
    public function getJobId()
    {
        return $this->job_id;
    }

    /**
     * Generated from protobuf field <code>int64 job_id = 1;</code>
     * @param int|string $var
     * @return $this
     */
    public function setJobId($var)
    {
        GPBUtil::checkInt64($var);
        $this->job_id = $var;

        return $this;
    }

    /**
     * Generated from protobuf field <code>string handle = 2;</code>
     * @return string
     */
    public function getHandle()
    {
        return $this->handle;
    }

    /**
     * Generated from protobuf field <code>string handle = 2;</code>
     * @param string $var
     * @return $this
     */
    public function setHandle($var)
    {
        GPBUtil::checkString($var, True);
        $this->handle = $var;

        return $this;
    }

    /**
     * Generated from protobuf field <code>int64 nonce = 3;</code>
     * @return int|string
     */
    public function getNonce()
    {
        return $this->nonce;
    }

    /**
     * Generated from protobuf field <code>int64 nonce = 3;</code>
     * @param int|string $var
     * @return $this
     */
    public function setNonce($var)
    {
        GPBUtil::checkInt64($var);
        $this->nonce = $var;

        return $this;
    }

    /**
     * Generated from protobuf field <code>.xsuportal.proto.resources.BenchmarkResult result = 4;</code>
     * @return \Xsuportal\Proto\Resources\BenchmarkResult
     */
    public function getResult()
    {
        return $this->result;
    }

    /**
     * Generated from protobuf field <code>.xsuportal.proto.resources.BenchmarkResult result = 4;</code>
     * @param \Xsuportal\Proto\Resources\BenchmarkResult $var
     * @return $this
     */
    public function setResult($var)
    {
        GPBUtil::checkMessage($var, \Xsuportal\Proto\Resources\BenchmarkResult::class);
        $this->result = $var;

        return $this;
    }

}
