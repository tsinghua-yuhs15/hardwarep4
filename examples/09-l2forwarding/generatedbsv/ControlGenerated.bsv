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
    FORWARD,
    DROP,
    NOACTION1
} ForwardTblActionT deriving (Bits, Eq, FShow);
`MATCHTABLE_SIM(11, 54, 2, forward_tbl)
typedef Table#(3, MetadataRequest, ForwardTblParam, ConnectalTypes::ForwardTblReqT, ConnectalTypes::ForwardTblRspT) ForwardTblTable;
typedef MatchTable#(1, 11, 256, SizeOf#(ConnectalTypes::ForwardTblReqT), SizeOf#(ConnectalTypes::ForwardTblRspT)) ForwardTblMatchTable;
`SynthBuildModule1(mkMatchTable, String, ForwardTblMatchTable, mkMatchTable_ForwardTbl)
instance Table_request #(ConnectalTypes::ForwardTblReqT);
    function ConnectalTypes::ForwardTblReqT table_request(MetadataRequest data);
        ConnectalTypes::ForwardTblReqT v = defaultValue;
        if (data.meta.hdr.ethernet matches tagged Valid .ethernet) begin
            let dstAddr = ethernet.hdr.dstAddr;
            v = ConnectalTypes::ForwardTblReqT {dl_dst: dl_dst, padding: 0};
        end
        return v;
    endfunction
endinstance
instance Table_execute #(ConnectalTypes::ForwardTblRspT, ForwardTblParam, 3);
    function Action table_execute(ConnectalTypes::ForwardTblRspT resp, MetadataRequest metadata, Vector#(3, FIFOF#(Tuple2#(MetadataRequest, ForwardTblParam))) fifos);
        action
        case (unpack(resp._action)) matches
        endcase
        endaction
    endfunction
endinstance
typedef Engine#(1, MetadataRequest, ForwardTblParam) NoActionAction;
// mark_to_drop 
typedef Engine#(1, MetadataRequest, ForwardTblParam) DropAction;
// INST (9) standard_metadata.egress_spec; = _port;
typedef Engine#(1, MetadataRequest, ForwardTblParam) ForwardAction;
instance Action_execute #(ForwardTblParam);
    function ActionValue#(MetadataRequest) step_1 (MetadataRequest meta, ForwardTblParam param);
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
    method Action forward_tbl_add_entry(ConnectalTypes::ForwardTblReqT key, ConnectalTypes::ForwardTblRspT value);
    method Action set_verbosity(int verbosity);
endinterface
module mkIngress (Ingress);
    `PRINT_DEBUG_MSG
    FIFOF#(MetadataRequest) entry_req_ff <- mkFIFOF;
    FIFOF#(MetadataRequest) entry_rsp_ff <- mkFIFOF;
    FIFOF#(MetadataRequest) forward_tbl_req_ff <- mkFIFOF;
    FIFOF#(MetadataRequest) forward_tbl_rsp_ff <- mkFIFOF;
    FIFOF#(MetadataRequest) exit_req_ff <- mkFIFOF;
    FIFOF#(MetadataRequest) exit_rsp_ff <- mkFIFOF;
    Control::NoActionAction noAction_action <- mkEngine(toList(vec(step_1)));
    Control::DropAction drop_action <- mkEngine(toList(vec(step_1)));
    Control::ForwardAction forward_action <- mkEngine(toList(vec(step_1)));
    ForwardTblMatchTable forward_tbl_table <- mkMatchTable_ForwardTbl("forward_tbl");
    Control::ForwardTblTable forward_tbl <- mkTable(table_request, table_execute, forward_tbl_table);
    messageM(printType(typeOf(forward_tbl_table)));
    messageM(printType(typeOf(forward_tbl)));
    mkConnection(toClient(forward_tbl_req_ff, forward_tbl_rsp_ff), forward_tbl.prev_control_state);
    mkConnection(forward_tbl.next_control_state[0], forward_action.prev_control_state);
    mkConnection(forward_tbl.next_control_state[1], drop_action.prev_control_state);
    mkConnection(forward_tbl.next_control_state[2], noAction_action.prev_control_state);
    rule rl_entry if (entry_req_ff.notEmpty);
        entry_req_ff.deq;
        let _req = entry_req_ff.first;
        let meta = _req.meta;
        let pkt = _req.pkt;
        MetadataRequest req = MetadataRequest {pkt: pkt, meta: meta};
        forward_tbl_req_ff.enq(req);
        dbprint(3, $format("forward_tbl", fshow(meta)));
    endrule
    rule rl_forward_tbl if (forward_tbl_rsp_ff.notEmpty);
        forward_tbl_rsp_ff.deq;
        let _rsp = forward_tbl_rsp_ff.first;
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
    method forward_tbl_add_entry = forward_tbl.add_entry;
    method Action set_verbosity (int verbosity);
        cf_verbosity <= verbosity;
        forward_tbl.set_verbosity(verbosity);
    endmethod
endmodule
// =============== control egress ==============
interface Egress;
    interface PipeIn#(MetadataRequest) prev;
    interface PipeOut#(MetadataRequest) next;
    method Action set_verbosity(int verbosity);
endinterface
module mkEgress (Egress);
    `PRINT_DEBUG_MSG
    FIFOF#(MetadataRequest) entry_req_ff <- mkFIFOF;
    FIFOF#(MetadataRequest) entry_rsp_ff <- mkFIFOF;
    FIFOF#(MetadataRequest) exit_req_ff <- mkFIFOF;
    FIFOF#(MetadataRequest) exit_rsp_ff <- mkFIFOF;
    rule rl_entry if (entry_req_ff.notEmpty);
        entry_req_ff.deq;
        let _req = entry_req_ff.first;
        let meta = _req.meta;
        let pkt = _req.pkt;
        MetadataRequest req = MetadataRequest {pkt: pkt, meta: meta};
        exit_req_ff.enq(req);
        dbprint(3, $format("exit", fshow(meta)));
    endrule
    interface prev = toPipeIn(entry_req_ff);
    interface next = toPipeOut(exit_req_ff);
    method Action set_verbosity (int verbosity);
        cf_verbosity <= verbosity;
    endmethod
endmodule
