<?php
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: xsuportal/services/admin/initialize.proto

namespace Xsuportal\Proto\Services\Admin\InitializeResponse;

use Google\Protobuf\Internal\GPBType;
use Google\Protobuf\Internal\RepeatedField;
use Google\Protobuf\Internal\GPBUtil;

/**
 * Generated from protobuf message <code>xsuportal.proto.services.admin.InitializeResponse.BenchmarkServer</code>
 */
class BenchmarkServer extends \Google\Protobuf\Internal\Message
{
    /**
     * Generated from protobuf field <code>string host = 1;</code>
     */
    private $host = '';
    /**
     * Generated from protobuf field <code>int64 port = 2;</code>
     */
    private $port = 0;

    /**
     * Constructor.
     *
     * @param array $data {
     *     Optional. Data for populating the Message object.
     *
     *     @type string $host
     *     @type int|string $port
     * }
     */
    public function __construct($data = NULL) {
        \GPBMetadata\Xsuportal\Services\Admin\Initialize::initOnce();
        parent::__construct($data);
    }

    /**
     * Generated from protobuf field <code>string host = 1;</code>
     * @return string
     */
    public function getHost()
    {
        return $this->host;
    }

    /**
     * Generated from protobuf field <code>string host = 1;</code>
     * @param string $var
     * @return $this
     */
    public function setHost($var)
    {
        GPBUtil::checkString($var, True);
        $this->host = $var;

        return $this;
    }

    /**
     * Generated from protobuf field <code>int64 port = 2;</code>
     * @return int|string
     */
    public function getPort()
    {
        return $this->port;
    }

    /**
     * Generated from protobuf field <code>int64 port = 2;</code>
     * @param int|string $var
     * @return $this
     */
    public function setPort($var)
    {
        GPBUtil::checkInt64($var);
        $this->port = $var;

        return $this;
    }

}

// Adding a class alias for backwards compatibility with the previous class name.
class_alias(BenchmarkServer::class, \Xsuportal\Proto\Services\Admin\InitializeResponse_BenchmarkServer::class);
