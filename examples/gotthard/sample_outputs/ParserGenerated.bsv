`ifdef PARSER_STRUCT
typedef enum {
    StateParseEthernet,
    StateParseGotthard,
    StateParseIpv4,
    StateParseOp,
    StateParseUdp,
    StateStart,
    StateAccept,
    StateReject
} ParserState deriving (Bits, Eq);
`endif
`ifdef PARSER_FUNCTION
function Action compute_next_state_parse_ethernet(Bit#(16) etherType);
    action
    let v = {etherType};
    case(v) matches
        2048: begin
            w_parse_ethernet_parse_ipv4.send();
        end
        default: begin
            w_parse_ethernet_accept.send();
        end
    endcase
    endaction
endfunction
`endif
`ifdef PARSER_FUNCTION
function Action compute_next_state_parse_gotthard(Bit#(8) remaining_cnt);
    action
    let v = {remaining_cnt};
    case(v) matches
        0: begin
            w_parse_gotthard_accept.send();
        end
        default: begin
            w_parse_gotthard_parse_op.send();
        end
    endcase
    endaction
endfunction
`endif
`ifdef PARSER_FUNCTION
function Action compute_next_state_parse_ipv4(Bit#(8) protocol);
    action
    let v = {protocol};
    case(v) matches
        17: begin
            w_parse_ipv4_parse_udp.send();
        end
        default: begin
            w_parse_ipv4_accept.send();
        end
    endcase
    endaction
endfunction
`endif
`ifdef PARSER_FUNCTION
function Action compute_next_state_parse_op(Bit#(8) remaining_cnt);
    action
    let v = {remaining_cnt};
    case(v) matches
        0: begin
            w_parse_op_accept.send();
        end
        default: begin
            w_parse_op_parse_op.send();
        end
    endcase
    endaction
endfunction
`endif
`ifdef PARSER_FUNCTION
function Action compute_next_state_parse_udp();
    action
    w_parse_udp_parse_gotthard.send();
    endaction
endfunction
`endif
`ifdef PARSER_FUNCTION
function Action compute_next_state_start();
    action
    w_start_parse_ethernet.send();
    endaction
endfunction
`endif
`ifdef PARSER_FUNCTION
let initState = StateParseEthernet;
`endif
`ifdef PARSER_STRUCT
typedef 112 ParseEthernetSz;
typedef 112 ParseGotthardSz;
typedef 160 ParseIpv4Sz;
typedef 1064 ParseOpSz;
typedef 64 ParseUdpSz;
`endif
`ifdef PARSER_FUNCTION
function Action extract_header(ParserState state, Bit#(512) data);
    action
    case (state) matches
        StateParseEthernet : begin
            let ethernet = extract_ethernet_t(truncate(data));
            Header#(EthernetT) header0 = defaultValue;
            header0.hdr = ethernet;
            header0.state = tagged Forward;
            ethernet_out_ff.enq(tagged Valid header0);
            compute_next_state_parse_ethernet(ethernet.etherType);
        end
        StateParseGotthard : begin
            let gotthard_hdr = extract_gotthard_hdr_t(truncate(data));
            Header#(GotthardHdrT) header0 = defaultValue;
            header0.hdr = gotthard_hdr;
            header0.state = tagged Forward;
            gotthard_hdr_out_ff.enq(tagged Valid header0);
            compute_next_state_parse_gotthard(parse_meta.remaining_cnt);
        end
        StateParseIpv4 : begin
            let ipv4 = extract_ipv4_t(truncate(data));
            Header#(Ipv4T) header0 = defaultValue;
            header0.hdr = ipv4;
            header0.state = tagged Forward;
            ipv4_out_ff.enq(tagged Valid header0);
            compute_next_state_parse_ipv4(ipv4.protocol);
        end
        StateParseOp : begin
            let next = extract_gotthard_op_t(truncate(data));
            OpParseMetaT parse_meta = fromMaybe(?, rg_parse_meta);
            let remaining_cnt = parse_meta.remaining_cnt+255;
            parse_meta.remaining_cnt= remaining_cnt;
            rg_parse_meta<= tagged Valid parse_meta;
            Header#(GotthardOpT) header0 = defaultValue;
            header0.hdr = next;
            header0.state = tagged Forward;
            next_out_ff.enq(tagged Valid header0);
            compute_next_state_parse_op(parse_meta.remaining_cnt);
        end
        StateParseUdp : begin
            let udp = extract_udp_t(truncate(data));
            Header#(UdpT) header0 = defaultValue;
            header0.hdr = udp;
            header0.state = tagged Forward;
            udp_out_ff.enq(tagged Valid header0);
            compute_next_state_parse_udp();
        end
        StateStart : begin
        end
        StateAccept : begin
        end
        StateReject : begin
        end
    endcase
    endaction
endfunction
`endif
`ifdef PARSER_RULES
`COLLECT_RULE(parse_fsm, joinRules(vec(genLoadRule(StateParseEthernet, valueOf(ParseEthernetSz)))));
`COLLECT_RULE(parse_fsm, joinRules(vec(genExtractRule(StateParseEthernet, valueOf(ParseEthernetSz)))));
`COLLECT_RULE(parse_fsm, joinRules(vec(genContRule(w_parse_ethernet_parse_ipv4, StateParseIpv4, valueOf(ParseIpv4Sz)))));
`COLLECT_RULE(parse_fsm, joinRules(vec(genAcceptRule(w_parse_ethernet_accept))));
`COLLECT_RULE(parse_fsm, joinRules(vec(genLoadRule(StateParseGotthard, valueOf(ParseGotthardSz)))));
`COLLECT_RULE(parse_fsm, joinRules(vec(genExtractRule(StateParseGotthard, valueOf(ParseGotthardSz)))));
`COLLECT_RULE(parse_fsm, joinRules(vec(genAcceptRule(w_parse_gotthard_accept))));
`COLLECT_RULE(parse_fsm, joinRules(vec(genAcceptRule(w_parse_gotthard_parse_op))));
`COLLECT_RULE(parse_fsm, joinRules(vec(genLoadRule(StateParseIpv4, valueOf(ParseIpv4Sz)))));
`COLLECT_RULE(parse_fsm, joinRules(vec(genExtractRule(StateParseIpv4, valueOf(ParseIpv4Sz)))));
`COLLECT_RULE(parse_fsm, joinRules(vec(genContRule(w_parse_ipv4_parse_udp, StateParseUdp, valueOf(ParseUdpSz)))));
`COLLECT_RULE(parse_fsm, joinRules(vec(genAcceptRule(w_parse_ipv4_accept))));
`COLLECT_RULE(parse_fsm, joinRules(vec(genLoadRule(StateParseOp, valueOf(ParseOpSz)))));
`COLLECT_RULE(parse_fsm, joinRules(vec(genExtractRule(StateParseOp, valueOf(ParseOpSz)))));
`COLLECT_RULE(parse_fsm, joinRules(vec(genAcceptRule(w_parse_op_accept))));
`COLLECT_RULE(parse_fsm, joinRules(vec(genAcceptRule(w_parse_op_parse_op))));
`COLLECT_RULE(parse_fsm, joinRules(vec(genLoadRule(StateParseUdp, valueOf(ParseUdpSz)))));
`COLLECT_RULE(parse_fsm, joinRules(vec(genExtractRule(StateParseUdp, valueOf(ParseUdpSz)))));
Vector#(18, Rules) fsmRules = toVector(parse_fsm);
`endif
`ifdef PARSER_RULES
rule rl_accept if (delay_ff.notEmpty);
    delay_ff.deq;
    MetadataT meta = defaultValue;
    meta.meta.intrinsic_metadata = rg_intrinsic_metadata;
    meta.meta.req_meta = rg_req_meta;
    meta.meta.routing_metadata = rg_routing_metadata;
    let ethernet <- toGet(ethernet_out_ff).get;
    meta.hdr.ethernet = ethernet;
    let gotthard_hdr <- toGet(gotthard_hdr_out_ff).get;
    meta.hdr.gotthard_hdr = gotthard_hdr;
    let ipv4 <- toGet(ipv4_out_ff).get;
    meta.hdr.ipv4 = ipv4;
    let parse_meta <- toGet(parse_meta_out_ff).get;
    meta.hdr.parse_meta = parse_meta;
    let udp <- toGet(udp_out_ff).get;
    meta.hdr.udp = udp;
    rg_tmp[0] <= 0;
    rg_shift_amt[0] <= 0;
    rg_buffered[0] <= 0;
    meta_in_ff.enq(meta);
endrule
`endif
`ifdef PARSER_STATE
PulseWire w_parse_ethernet_parse_ipv4 <- mkPulseWire();
PulseWire w_parse_ethernet_accept <- mkPulseWire();
PulseWire w_parse_gotthard_accept <- mkPulseWire();
PulseWire w_parse_gotthard_parse_op <- mkPulseWire();
PulseWire w_parse_ipv4_parse_udp <- mkPulseWire();
PulseWire w_parse_ipv4_accept <- mkPulseWire();
PulseWire w_parse_op_accept <- mkPulseWire();
PulseWire w_parse_op_parse_op <- mkPulseWire();
PulseWire w_parse_udp_parse_gotthard <- mkPulseWire();
PulseWire w_start_parse_ethernet <- mkPulseWire();
FIFOF#(Maybe#(Header#(EthernetT))) ethernet_out_ff <- mkDFIFOF(tagged Invalid);
FIFOF#(Maybe#(Header#(GotthardHdrT))) gotthard_hdr_out_ff <- mkDFIFOF(tagged Invalid);
FIFOF#(Maybe#(Header#(Ipv4T))) ipv4_out_ff <- mkDFIFOF(tagged Invalid);
FIFOF#(Maybe#(Header#(GotthardOpT))) next_out_ff <- mkDFIFOF(tagged Invalid);
FIFOF#(Maybe#(Header#(UdpT))) udp_out_ff <- mkDFIFOF(tagged Invalid);
Reg#(Maybe#(IntrinsicMetadataT)) rg_intrinsic_metadata <- mkReg(tagged Invalid);
Reg#(Maybe#(ReqMetaT)) rg_req_meta <- mkReg(tagged Invalid);
Reg#(Maybe#(RoutingMetadataT)) rg_routing_metadata <- mkReg(tagged Invalid);
`endif
