import Library::*;
import StructDefines::*;
import UnionDefines::*;
import ConnectalTypes::*;
import Table::*;
import Engine::*;
import Pipe::*;
import Lists::*;
`include "TieOff.defines"
`include "Debug.defines"
`include "SynthBuilder.defines"
`include "MatchTable.defines"
typedef enum {
    SETDMAC,
    DROP2,
    NOACTION3
} ForwardActionT deriving (Bits, Eq, FShow);
`MATCHTABLE_SIM(10, 36, 2, forward)
typedef Table#(3, MetadataRequest, ForwardParam, ConnectalTypes::ForwardReqT, ConnectalTypes::ForwardRspT) ForwardTable;
typedef MatchTable#(1, 10, 256, SizeOf#(ConnectalTypes::ForwardReqT), SizeOf#(ConnectalTypes::ForwardRspT)) ForwardMatchTable;
`SynthBuildModule1(mkMatchTable, String, ForwardMatchTable, mkMatchTable_Forward)
instance Table_request #(ConnectalTypes::ForwardReqT);
    function ConnectalTypes::ForwardReqT table_request(MetadataRequest data);
        ConnectalTypes::ForwardReqT v = defaultValue;
        if (data.meta.hdr.ethernet matches tagged Valid .ethernet) begin
            let dstAddr = ethernet.hdr.dstAddr;
            v = ConnectalTypes::ForwardReqT {nhop_ipv4: nhop_ipv4, padding: 0};
        end
        return v;
    endfunction
endinstance
instance Table_execute #(ConnectalTypes::ForwardRspT, ForwardParam, 3);
    function Action table_execute(ConnectalTypes::ForwardRspT resp, MetadataRequest metadata, Vector#(3, FIFOF#(Tuple2#(MetadataRequest, ForwardParam))) fifos);
        action
        case (unpack(resp._action)) matches
        endcase
        endaction
    endfunction
endinstance
typedef enum {
    SETNHOP,
    DROP1,
    NOACTION4
} Ipv4LpmActionT deriving (Bits, Eq, FShow);
`MATCHTABLE_SIM(15, 36, 2, ipv4_lpm)
typedef Table#(3, MetadataRequest, Ipv4LpmParam, ConnectalTypes::Ipv4LpmReqT, ConnectalTypes::Ipv4LpmRspT) Ipv4LpmTable;
typedef MatchTable#(1, 15, 256, SizeOf#(ConnectalTypes::Ipv4LpmReqT), SizeOf#(ConnectalTypes::Ipv4LpmRspT)) Ipv4LpmMatchTable;
`SynthBuildModule1(mkMatchTable, String, Ipv4LpmMatchTable, mkMatchTable_Ipv4Lpm)
instance Table_request #(ConnectalTypes::Ipv4LpmReqT);
    function ConnectalTypes::Ipv4LpmReqT table_request(MetadataRequest data);
        ConnectalTypes::Ipv4LpmReqT v = defaultValue;
        if (data.meta.hdr.ethernet matches tagged Valid .ethernet) begin
            let dstAddr = ethernet.hdr.dstAddr;
            v = ConnectalTypes::Ipv4LpmReqT {dstAddr: dstAddr, padding: 0};
        end
        return v;
    endfunction
endinstance
instance Table_execute #(ConnectalTypes::Ipv4LpmRspT, Ipv4LpmParam, 3);
    function Action table_execute(ConnectalTypes::Ipv4LpmRspT resp, MetadataRequest metadata, Vector#(3, FIFOF#(Tuple2#(MetadataRequest, Ipv4LpmParam))) fifos);
        action
        case (unpack(resp._action)) matches
        endcase
        endaction
    endfunction
endinstance
typedef Engine#(1, MetadataRequest, Ipv4LpmParam) NoActionAction;
// mark_to_drop 
typedef Engine#(1, MetadataRequest, Ipv4LpmParam) Drop1Action;
// mark_to_drop 
typedef Engine#(1, MetadataRequest, ForwardParam) Drop2Action;
// INST (48) hdr.ethernet.dstAddr; = dmac;
typedef Engine#(1, MetadataRequest, ForwardParam) SetDmacAction;
instance Action_execute #(ForwardParam);
    function ActionValue#(MetadataRequest) step_1 (MetadataRequest meta, ForwardParam param);
        actionvalue
            $display("(%0d) step 1: ", $time, fshow(meta));
            return meta;
        endactionvalue
    endfunction
endinstance
// INST (32) meta.routing_metadata.nhop_ipv4; = nhop_ipv4;
// INST (9) standard_metadata.egress_port; = _port;
// INST (8) hdr.ipv4.ttl; = hdr.ipv4.ttl + 255;
typedef Engine#(1, MetadataRequest, Ipv4LpmParam) SetNhopAction;
instance Action_execute #(Ipv4LpmParam);
    function ActionValue#(MetadataRequest) step_1 (MetadataRequest meta, Ipv4LpmParam param);
        actionvalue
            $display("(%0d) step 1: ", $time, fshow(meta));
            return meta;
        endactionvalue
    endfunction
endinstance
// =============== control ingress ==============
interface Ingress;
    interface PipeIn#(MetadataRequest) prev;
    interface PipeOut#(MetadataRequest) next;
    method Action forward_add_entry(ConnectalTypes::ForwardReqT key, ConnectalTypes::ForwardRspT value);
    method Action ipv4_lpm_add_entry(ConnectalTypes::Ipv4LpmReqT key, ConnectalTypes::Ipv4LpmRspT value);
    method Action set_verbosity(int verbosity);
endinterface
module mkIngress (Ingress);
    `PRINT_DEBUG_MSG
    FIFOF#(MetadataRequest) entry_req_ff <- mkFIFOF;
    FIFOF#(MetadataRequest) entry_rsp_ff <- mkFIFOF;
    FIFOF#(MetadataRequest) forward_req_ff <- mkFIFOF;
    FIFOF#(MetadataRequest) forward_rsp_ff <- mkFIFOF;
    FIFOF#(MetadataRequest) ipv4_lpm_req_ff <- mkFIFOF;
    FIFOF#(MetadataRequest) ipv4_lpm_rsp_ff <- mkFIFOF;
    FIFOF#(MetadataRequest) node_2_req_ff <- mkFIFOF;
    FIFOF#(MetadataRequest) exit_req_ff <- mkFIFOF;
    FIFOF#(MetadataRequest) exit_rsp_ff <- mkFIFOF;
    Control::NoActionAction noAction_action <- mkEngine(toList(vec(step_1)));
    Control::Drop1Action drop1_action <- mkEngine(toList(vec(step_1)));
    Control::Drop2Action drop2_action <- mkEngine(toList(vec(step_1)));
    Control::SetDmacAction setdmac_action <- mkEngine(toList(vec(step_1)));
    Control::SetNhopAction setnhop_action <- mkEngine(toList(vec(step_1)));
    ForwardMatchTable forward_table <- mkMatchTable_Forward("forward");
    Control::ForwardTable forward <- mkTable(table_request, table_execute, forward_table);
    messageM(printType(typeOf(forward_table)));
    messageM(printType(typeOf(forward)));
    Ipv4LpmMatchTable ipv4_lpm_table <- mkMatchTable_Ipv4Lpm("ipv4_lpm");
    Control::Ipv4LpmTable ipv4_lpm <- mkTable(table_request, table_execute, ipv4_lpm_table);
    messageM(printType(typeOf(ipv4_lpm_table)));
    messageM(printType(typeOf(ipv4_lpm)));
    mkConnection(toClient(forward_req_ff, forward_rsp_ff), forward.prev_control_state);
    mkConnection(forward.next_control_state[0], setdmac_action.prev_control_state);
    mkConnection(forward.next_control_state[1], drop2_action.prev_control_state);
    mkConnection(forward.next_control_state[2], noAction_action.prev_control_state);
    mkConnection(toClient(ipv4_lpm_req_ff, ipv4_lpm_rsp_ff), ipv4_lpm.prev_control_state);
    mkConnection(ipv4_lpm.next_control_state[0], setnhop_action.prev_control_state);
    mkConnection(ipv4_lpm.next_control_state[1], drop1_action.prev_control_state);
    mkConnection(ipv4_lpm.next_control_state[2], noAction_action.prev_control_state);
    rule rl_entry if (entry_req_ff.notEmpty);
        entry_req_ff.deq;
        let _req = entry_req_ff.first;
        let meta = _req.meta;
        let pkt = _req.pkt;
        MetadataRequest req = MetadataRequest {pkt: pkt, meta: meta};
        node_2_req_ff.enq(req);
        dbprint(3, $format("node_2", fshow(meta)));
    endrule
    rule rl_node_2 if (node_2_req_ff.notEmpty);
        node_2_req_ff.deq;
        let _req = node_2_req_ff.first;
        let meta = _req.meta;
        if (meta.hdr.ipv4 matches tagged Valid .h &&& h.hdr.ttl > 0) begin
            ipv4_lpm_req_ff.enq(_req);
            dbprint(3, $format("node_2 true", fshow(meta)));
        end
        else begin
            _req_ff.enq(_req);
            dbprint(3, $format("node_2 false", fshow(meta)));
        end
    endrule
    rule rl_ipv4_lpm if (ipv4_lpm_rsp_ff.notEmpty);
        ipv4_lpm_rsp_ff.deq;
        let _rsp = ipv4_lpm_rsp_ff.first;
        let meta = _rsp.meta;
        let pkt = _rsp.pkt;
        case (_rsp) matches
            default: begin
                MetadataRequest req = MetadataRequest { pkt : pkt, meta : meta};
                forward_req_ff.enq(req);
                dbprint(3, $format("default ", fshow(meta)));
            end
        endcase
    endrule
    rule rl_forward if (forward_rsp_ff.notEmpty);
        forward_rsp_ff.deq;
        let _rsp = forward_rsp_ff.first;
        let meta = _rsp.meta;
        let pkt = _rsp.pkt;
        case (_rsp) matches
            default: begin
                MetadataRequest req = MetadataRequest { pkt : pkt, meta : meta};
                _req_ff.enq(req);
                dbprint(3, $format("default ", fshow(meta)));
            end
        endcase
    endrule
    interface prev = toPipeIn(entry_req_ff);
    interface next = toPipeOut(exit_req_ff);
    method forward_add_entry = forward.add_entry;
    method ipv4_lpm_add_entry = ipv4_lpm.add_entry;
    method Action set_verbosity (int verbosity);
        cf_verbosity <= verbosity;
        forward.set_verbosity(verbosity);
        ipv4_lpm.set_verbosity(verbosity);
    endmethod
endmodule
typedef enum {
    REWRITEMAC,
    DROP3,
    NOACTION2
} SendFrameActionT deriving (Bits, Eq, FShow);
`MATCHTABLE_SIM(27, 9, 2, send_frame)
typedef Table#(3, MetadataRequest, SendFrameParam, ConnectalTypes::SendFrameReqT, ConnectalTypes::SendFrameRspT) SendFrameTable;
typedef MatchTable#(1, 27, 256, SizeOf#(ConnectalTypes::SendFrameReqT), SizeOf#(ConnectalTypes::SendFrameRspT)) SendFrameMatchTable;
`SynthBuildModule1(mkMatchTable, String, SendFrameMatchTable, mkMatchTable_SendFrame)
instance Table_request #(ConnectalTypes::SendFrameReqT);
    function ConnectalTypes::SendFrameReqT table_request(MetadataRequest data);
        ConnectalTypes::SendFrameReqT v = defaultValue;
        if (data.meta.hdr.ethernet matches tagged Valid .ethernet) begin
            let dstAddr = ethernet.hdr.dstAddr;
            v = ConnectalTypes::SendFrameReqT {egress_port: egress_port};
        end
        return v;
    endfunction
endinstance
instance Table_execute #(ConnectalTypes::SendFrameRspT, SendFrameParam, 3);
    function Action table_execute(ConnectalTypes::SendFrameRspT resp, MetadataRequest metadata, Vector#(3, FIFOF#(Tuple2#(MetadataRequest, SendFrameParam))) fifos);
        action
        case (unpack(resp._action)) matches
        endcase
        endaction
    endfunction
endinstance
typedef Engine#(1, MetadataRequest, SendFrameParam) NoActionAction;
// mark_to_drop 
typedef Engine#(1, MetadataRequest, SendFrameParam) Drop3Action;
// INST (48) hdr.ethernet.srcAddr; = smac;
typedef Engine#(1, MetadataRequest, SendFrameParam) RewriteMacAction;
instance Action_execute #(SendFrameParam);
    function ActionValue#(MetadataRequest) step_1 (MetadataRequest meta, SendFrameParam param);
        actionvalue
            $display("(%0d) step 1: ", $time, fshow(meta));
            return meta;
        endactionvalue
    endfunction
endinstance
// =============== control egress ==============
interface Egress;
    interface PipeIn#(MetadataRequest) prev;
    interface PipeOut#(MetadataRequest) next;
    method Action send_frame_add_entry(ConnectalTypes::SendFrameReqT key, ConnectalTypes::SendFrameRspT value);
    method Action set_verbosity(int verbosity);
endinterface
module mkEgress (Egress);
    `PRINT_DEBUG_MSG
    FIFOF#(MetadataRequest) entry_req_ff <- mkFIFOF;
    FIFOF#(MetadataRequest) entry_rsp_ff <- mkFIFOF;
    FIFOF#(MetadataRequest) send_frame_req_ff <- mkFIFOF;
    FIFOF#(MetadataRequest) send_frame_rsp_ff <- mkFIFOF;
    FIFOF#(MetadataRequest) exit_req_ff <- mkFIFOF;
    FIFOF#(MetadataRequest) exit_rsp_ff <- mkFIFOF;
    Control::NoActionAction noAction_action <- mkEngine(toList(vec(step_1)));
    Control::Drop3Action drop3_action <- mkEngine(toList(vec(step_1)));
    Control::RewriteMacAction rewritemac_action <- mkEngine(toList(vec(step_1)));
    SendFrameMatchTable send_frame_table <- mkMatchTable_SendFrame("send_frame");
    Control::SendFrameTable send_frame <- mkTable(table_request, table_execute, send_frame_table);
    messageM(printType(typeOf(send_frame_table)));
    messageM(printType(typeOf(send_frame)));
    mkConnection(toClient(send_frame_req_ff, send_frame_rsp_ff), send_frame.prev_control_state);
    mkConnection(send_frame.next_control_state[0], rewritemac_action.prev_control_state);
    mkConnection(send_frame.next_control_state[1], drop3_action.prev_control_state);
    mkConnection(send_frame.next_control_state[2], noAction_action.prev_control_state);
    rule rl_entry if (entry_req_ff.notEmpty);
        entry_req_ff.deq;
        let _req = entry_req_ff.first;
        let meta = _req.meta;
        let pkt = _req.pkt;
        MetadataRequest req = MetadataRequest {pkt: pkt, meta: meta};
        send_frame_req_ff.enq(req);
        dbprint(3, $format("send_frame", fshow(meta)));
    endrule
    rule rl_send_frame if (send_frame_rsp_ff.notEmpty);
        send_frame_rsp_ff.deq;
        let _rsp = send_frame_rsp_ff.first;
        let meta = _rsp.meta;
        let pkt = _rsp.pkt;
        case (_rsp) matches
            default: begin
                MetadataRequest req = MetadataRequest { pkt : pkt, meta : meta};
                _req_ff.enq(req);
                dbprint(3, $format("default ", fshow(meta)));
            end
        endcase
    endrule
    interface prev = toPipeIn(entry_req_ff);
    interface next = toPipeOut(exit_req_ff);
    method send_frame_add_entry = send_frame.add_entry;
    method Action set_verbosity (int verbosity);
        cf_verbosity <= verbosity;
        send_frame.set_verbosity(verbosity);
    endmethod
endmodule
