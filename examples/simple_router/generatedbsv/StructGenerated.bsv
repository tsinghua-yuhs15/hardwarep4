typedef struct {
    Bit#(48) dstAddr;
    Bit#(48) srcAddr;
    Bit#(16) etherType;
} EthernetT deriving (Bits, Eq, FShow);
function EthernetT extract_ethernet_t(Bit#(112) data);
    return unpack(byteSwap(data));
endfunction
typedef struct {
    Bit#(4) version;
    Bit#(4) ihl;
    Bit#(8) diffserv;
    Bit#(16) totalLen;
    Bit#(16) identification;
    Bit#(3) flags;
    Bit#(13) fragOffset;
    Bit#(8) ttl;
    Bit#(8) protocol;
    Bit#(16) hdrChecksum;
    Bit#(32) srcAddr;
    Bit#(32) dstAddr;
} Ipv4T deriving (Bits, Eq, FShow);
function Ipv4T extract_ipv4_t(Bit#(160) data);
    return unpack(byteSwap(data));
endfunction
typedef struct {
    Bit#(32) nhop_ipv4;
} RoutingMetadataT deriving (Bits, Eq, FShow);
instance DefaultValue#(RoutingMetadataT);
    defaultValue = unpack(0);
endinstance
typedef struct {
    Maybe#(Header#(EthernetT)) ethernet;
    Maybe#(Header#(Ipv4T)) ipv4;
} Headers deriving (Bits, Eq, FShow);
typedef struct {
    Maybe#(Bit#(32)) nhop_ipv4;
    Maybe#(Bit#(32)) dstAddr;
    Maybe#(Bit#(9)) egress_port;
    Maybe#(RoutingMetadataT) routing_metadata;
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
