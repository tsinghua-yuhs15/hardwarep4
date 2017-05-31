import DefaultValue::*;
typedef struct{
    Bit#(6) padding;
    Bit#(48) dl_dst;
} ForwardTblReqT deriving (Bits, FShow);
instance DefaultValue#(ForwardTblReqT);
    defaultValue = unpack(0);
endinstance
typedef struct {
    Bit#(2) _action;
} ForwardTblRspT deriving (Bits, FShow);
