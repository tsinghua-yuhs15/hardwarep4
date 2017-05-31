import DefaultValue::*;
typedef struct{
    Bit#(4) padding;
    Bit#(32) nhop_ipv4;
} ForwardReqT deriving (Bits, FShow);
instance DefaultValue#(ForwardReqT);
    defaultValue = unpack(0);
endinstance
typedef struct {
    Bit#(2) _action;
} ForwardRspT deriving (Bits, FShow);
import DefaultValue::*;
typedef struct{
    Bit#(4) padding;
    Bit#(32) dstAddr;
} Ipv4LpmReqT deriving (Bits, FShow);
instance DefaultValue#(Ipv4LpmReqT);
    defaultValue = unpack(0);
endinstance
typedef struct {
    Bit#(2) _action;
} Ipv4LpmRspT deriving (Bits, FShow);
import DefaultValue::*;
typedef struct{
    Bit#(9) egress_port;
} SendFrameReqT deriving (Bits, FShow);
instance DefaultValue#(SendFrameReqT);
    defaultValue = unpack(0);
endinstance
typedef struct {
    Bit#(2) _action;
} SendFrameRspT deriving (Bits, FShow);
