typedef struct {
    Bit#(48) dl_dst;
    Bit#(48) dl_src;
    Bit#(16) dl_type;
} EthernetT deriving (Bits, Eq, FShow);
function EthernetT extract_ethernet_t(Bit#(112) data);
    return unpack(byteSwap(data));
endfunction
typedef struct {
    Maybe#(Header#(EthernetT)) eth;
} Headers deriving (Bits, Eq, FShow);
typedef struct {
    Maybe#(Bit#(48)) dl_dst;
} Metadata deriving (Bits, Eq, FShow);
instance DefaultValue#(Metadata);
    defaultValue = unpack(0);
endinstance
typedef struct {
    Maybe#(Bit#(9)) ingress_port;
    Maybe#(Bit#(9)) egress_spec;
    Maybe#(Bit#(9)) egress_port;
    Maybe#(Bit#(32)) clone_spec;
    Maybe#(Bit#(32)) instance_type;
    Maybe#(Bit#(1)) drop;
    Maybe#(Bit#(16)) recirculate_port;
    Maybe#(Bit#(32)) packet_length;
    Maybe#(Bit#(32)) enq_timestamp;
    Maybe#(Bit#(19)) enq_qdepth;
    Maybe#(Bit#(32)) deq_timedelta;
    Maybe#(Bit#(19)) deq_qdepth;
    Maybe#(Bit#(48)) ingress_global_timestamp;
    Maybe#(Bit#(32)) lf_field_list;
    Maybe#(Bit#(16)) mcast_grp;
    Maybe#(Bit#(1)) resubmit_flag;
    Maybe#(Bit#(16)) egress_rid;
} StandardMetadataT deriving (Bits, Eq, FShow);
instance DefaultValue#(StandardMetadataT);
    defaultValue = unpack(0);
endinstance
