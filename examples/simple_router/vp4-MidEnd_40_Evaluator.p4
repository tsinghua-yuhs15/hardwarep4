/* 
<P4Program>(147850)
  <Type_Header>(68229)
  <Type_Header>(68234)
  <Type_Error>(18)
  <Type_Extern>(89)
  <Type_Extern>(126)
  <Method>(140)
  <Declaration_MatchKind>(165)
  <Declaration_MatchKind>(171)
  <Type_Struct>(144588)
  <Type_Extern>(354)
  <Type_Enum>(362)
  <Type_Enum>(368)
  <Type_Extern>(399)
  <Type_Extern>(425)
  <Type_Extern>(463)
  <Type_Extern>(495)
  <Type_Extern>(544)
  <Type_Extern>(562)
  <Type_Enum>(607)
  <Type_Extern>(667)
  <Type_Parser>(771)
  <Type_Control>(788)
  <Type_Control>(814)
  <Type_Control>(840)
  <Type_Control>(857)
  <Type_Control>(879)
  <Type_Package>(942)
  <Type_Struct>(4473)
  <Type_Struct>(4201)
  <Type_Struct>(4312)
  <Type_Struct>(4345)
  <Type_Header>(66786)
  <Type_Header>(4431)
  <Type_Struct>(145088)
  <Type_Struct>(145122)
  <P4Parser>(148524)
  <P4Control>(91553)
  <P4Control>(91574)
  <P4Control>(145295)
  <P4Control>(67337)
  <P4Control>(67360)
  <Declaration_Instance>(145358) */
/* 
  <Type_Header>(68229) */
header description_header_t_1 {
/* 
    <StructField>(4362)
      <Annotations>(3)
      <Type_Bits>(954) */
        bit<8>  dh_flag;
/* 
    <StructField>(4368)
      <Annotations>(3)
      <Type_Bits>(954) */
        bit<8>  dh_length;
/* 
    <StructField>(4374)
      <Annotations>(3)
      <Type_Bits>(207) */
        bit<16> dh_policy_id;
}

/* 
  <Type_Header>(68234) */
header description_header_t_2 {
/* 
    <StructField>(68231)
      <Annotations>(3)
      <Type_Varbits>(66807) */
        varbit<992> dh_load_header;
}

/* 
  <Type_Error>(18) */
#include <core.p4>
#include <v1model.p4>

/* 
  <Type_Struct>(4473) */
struct context_metadata_t {
/* 
    <StructField>(4441)
      <Annotations>(3)
      <Type_Bits>(207) */
        bit<16> r1;
/* 
    <StructField>(4447)
      <Annotations>(3)
      <Type_Bits>(207) */
        bit<16> r2;
/* 
    <StructField>(4453)
      <Annotations>(3)
      <Type_Bits>(207) */
        bit<16> r3;
/* 
    <StructField>(4459)
      <Annotations>(3)
      <Type_Bits>(207) */
        bit<16> r4;
/* 
    <StructField>(4465)
      <Annotations>(3)
      <Type_Bits>(0) */
        bit<32> r5;
}

/* 
  <Type_Struct>(4201) */
struct intrinsic_metadata_t {
/* 
    <StructField>(4103)
      <Annotations>(3)
      <Type_Bits>(272) */
        bit<48> ingress_global_timestamp;
/* 
    <StructField>(4109)
      <Annotations>(3)
      <Type_Bits>(954) */
        bit<8>  lf_field_list;
/* 
    <StructField>(4115)
      <Annotations>(3)
      <Type_Bits>(207) */
        bit<16> mcast_grp;
/* 
    <StructField>(4121)
      <Annotations>(3)
      <Type_Bits>(207) */
        bit<16> egress_rid;
/* 
    <StructField>(4127)
      <Annotations>(3)
      <Type_Bits>(954) */
        bit<8>  resubmit_flag;
/* 
    <StructField>(4133)
      <Annotations>(3)
      <Type_Bits>(954) */
        bit<8>  recirculate_flag;
/* 
    <StructField>(4139)
      <Annotations>(3)
      <Type_Bits>(954) */
        bit<8>  degist_receiver0;
/* 
    <StructField>(4145)
      <Annotations>(3)
      <Type_Bits>(954) */
        bit<8>  degist_receiver1;
/* 
    <StructField>(4151)
      <Annotations>(3)
      <Type_Bits>(954) */
        bit<8>  degist_receiver2;
/* 
    <StructField>(4157)
      <Annotations>(3)
      <Type_Bits>(954) */
        bit<8>  degist_receiver3;
/* 
    <StructField>(4163)
      <Annotations>(3)
      <Type_Bits>(954) */
        bit<8>  degist_receiver4;
/* 
    <StructField>(4169)
      <Annotations>(3)
      <Type_Bits>(954) */
        bit<8>  degist_receiver5;
/* 
    <StructField>(4175)
      <Annotations>(3)
      <Type_Bits>(954) */
        bit<8>  degist_receiver6;
/* 
    <StructField>(4181)
      <Annotations>(3)
      <Type_Bits>(954) */
        bit<8>  degist_receiver7;
/* 
    <StructField>(4187)
      <Annotations>(3)
      <Type_Bits>(954) */
        bit<8>  degist_receiver8;
/* 
    <StructField>(4193)
      <Annotations>(3)
      <Type_Bits>(954) */
        bit<8>  degist_receiver9;
}

/* 
  <Type_Struct>(4312) */
struct program_metadata_t {
/* 
    <StructField>(4218)
      <Annotations>(3)
      <Type_Bits>(207) */
        bit<16> pmi_policy_id;
/* 
    <StructField>(4224)
      <Annotations>(3)
      <Type_Bits>(954) */
        bit<8>  pmi_program_id;
/* 
    <StructField>(4230)
      <Annotations>(3)
      <Type_Bits>(954) */
        bit<8>  pmi_stage_id;
/* 
    <StructField>(4236)
      <Annotations>(3)
      <Type_Bits>(272) */
        bit<48> pmi_action_chain_id;
/* 
    <StructField>(4242)
      <Annotations>(3)
      <Type_Bits>(272) */
        bit<48> pmi_action_chain_bitmap;
/* 
    <StructField>(4248)
      <Annotations>(3)
      <Type_Bits>(272) */
        bit<48> pmi_match_chain_result;
/* 
    <StructField>(4255)
      <Annotations>(3)
      <Type_Bits>(4254) */
        bit<3>  pmi_match_chain_bitmap;
/* 
    <StructField>(4261)
      <Annotations>(3)
      <Type_Bits>(203) */
        bit<1>  pmi_recirculate_flag;
/* 
    <StructField>(4267)
      <Annotations>(3)
      <Type_Bits>(203) */
        bit<1>  pmi_remove_or_add_flag;
/* 
    <StructField>(4273)
      <Annotations>(3)
      <Type_Bits>(203) */
        bit<1>  pmi_mod_flag;
/* 
    <StructField>(4280)
      <Annotations>(3)
      <Type_Bits>(4279) */
        bit<2>  pmi_op;
/* 
    <StructField>(4286)
      <Annotations>(3)
      <Type_Bits>(207) */
        bit<16> pmi_left_expr;
/* 
    <StructField>(4292)
      <Annotations>(3)
      <Type_Bits>(207) */
        bit<16> pmi_right_expr;
/* 
    <StructField>(4298)
      <Annotations>(3)
      <Type_Bits>(0) */
        bit<32> pmi_counter;
/* 
    <StructField>(4304)
      <Annotations>(3)
      <Type_Bits>(207) */
        bit<16> pmi_hash;
}

/* 
  <Type_Struct>(4345) */
struct user_metadata_t {
/* 
    <StructField>(4330)
      <Annotations>(3)
      <Type_Bits>(4329) */
        bit<256> umi_user_metadata;
/* 
    <StructField>(4337)
      <Annotations>(3)
      <Type_Bits>(4336) */
        bit<800> umi_load_header;
}

/* 
  <Type_Header>(66786) */
header description_header_t {
/* 
    <StructField>(4362)
      <Annotations>(3)
      <Type_Bits>(954) */
        bit<8>      dh_flag;
/* 
    <StructField>(4368)
      <Annotations>(3)
      <Type_Bits>(954) */
        bit<8>      dh_length;
/* 
    <StructField>(4374)
      <Annotations>(3)
      <Type_Bits>(207) */
        bit<16>     dh_policy_id;
/* 
    <StructField>(66806)
      <Annotations>(66808)
      <Type_Varbits>(66807) */
        @length(dh_length) 
    varbit<992> dh_load_header;
}

/* 
  <Type_Header>(4431) */
header header_stack_t {
/* 
    <StructField>(4416)
      <Annotations>(3)
      <Type_Bits>(954) */
        bit<8> hs_byte;
}

/* 
  <Type_Struct>(145088) */
struct metadata {
/* 
    <StructField>(145090)
      <Annotations>(145091)
      <Type_Name>(66825) */
        @name("context_data") 
    context_metadata_t   context_data;
/* 
    <StructField>(145098)
      <Annotations>(145099)
      <Type_Name>(66834) */
        @name("intrinsic_metadata") 
    intrinsic_metadata_t intrinsic_metadata;
/* 
    <StructField>(145106)
      <Annotations>(145107)
      <Type_Name>(66843) */
        @name("pmiInstance") 
    program_metadata_t   pmiInstance;
/* 
    <StructField>(145114)
      <Annotations>(145115)
      <Type_Name>(66852) */
        @name("umiInstance") 
    user_metadata_t      umiInstance;
}

/* 
  <Type_Struct>(145122) */
struct headers {
/* 
    <StructField>(145124)
      <Annotations>(145125)
      <Type_Name>(66863) */
        @name("dhInstance") 
    description_header_t                                                                                                    dhInstance;
/* 
    <StructField>(145132)
      <Annotations>(145133)
      <Type_Stack>(145138) */
        @name("hsInstance") 
    /* 
<Type_Stack>(145138)
  <Type_Name>(66872)
  <Constant>(145141) 128
    <Type_InfInt>(117506) */
header_stack_t[128] hsInstance;
}

/* 
  <P4Parser>(148524) */
/* 
    <Type_Parser>(66905)
      <Annotations>(3)
      <TypeParameters>(66903)
      <ParameterList>(66883) */
parser ParserImpl(/* 
        <Parameter>(66887)
          <Annotations>(3)
          <Type_Name>(66886) */
packet_in packet, /* 
        <Parameter>(66890)
          <Annotations>(3)
          <Type_Name>(66889) */
out headers hdr, /* 
        <Parameter>(66895)
          <Annotations>(3)
          <Type_Name>(66894) */
inout metadata meta, /* 
        <Parameter>(66900)
          <Annotations>(3)
          <Type_Name>(66899) */
inout standard_metadata_t standard_metadata) {
    /* 
    <Declaration_Variable>(148547) */
    description_header_t_1 tmp_hdr;
    /* 
    <Declaration_Variable>(148548) */
    description_header_t_2 tmp_hdr_0;
    /* 
    <ParserState>(145167) */
    @name("dh_parser") state dh_parser {
/* 
      <PathExpression>(145174)
        accept */
                transition accept;
    }
    /* 
    <ParserState>(145176) */
    @name("start") state start {
        /* 
      <MethodCallStatement>(145183)
        <MethodCallExpression>(145184)
          <Member>(145185)extract
            <PathExpression>(145186)
              packet
          <Vector<Type>>(78404), size=1
            <Type_Name>(78405)
              description_header_t_1
          <Vector<Expression>>(145191), size=1
            <PathExpression>(145192)
              tmp_hdr */
        packet.extract<description_header_t_1>(tmp_hdr);
        /* 
      <MethodCallStatement>(145194)
        <MethodCallExpression>(145195)
          <Member>(145196)extract
            <PathExpression>(145186)
              packet
          <Vector<Type>>(78418), size=1
            <Type_Name>(78419)
              description_header_t_2
          <Vector<Expression>>(145200), size=2
            <PathExpression>(145201)
              tmp_hdr_0
            <Cast>(145203)
              <Member>(145204)dh_length
                <PathExpression>(145205)
                  tmp_hdr
              <Type_Bits>(0) */
        packet.extract<description_header_t_2>(tmp_hdr_0, (bit<32>)tmp_hdr.dh_length);
        /* 
      <MethodCallStatement>(145207)
        <MethodCallExpression>(145208)
          <Member>(145209)setValid
            <Member>(145210)dhInstance
              <PathExpression>(145211)
                hdr
          <Vector<Type>>(68262), size=0
          <Vector<Expression>>(100347), size=0 */
        hdr.dhInstance.setValid();
        /* 
      <AssignmentStatement>(145215)
        <Member>(145216)dh_flag
          <Member>(145210)dhInstance
            <PathExpression>(145211)
              hdr
        <Member>(145217)dh_flag
          <PathExpression>(145218)
            tmp_hdr */
        hdr.dhInstance.dh_flag = tmp_hdr.dh_flag;
        /* 
      <AssignmentStatement>(145220)
        <Member>(145221)dh_length
          <Member>(145210)dhInstance
            <PathExpression>(145211)
              hdr
        <Member>(145222)dh_length
          <PathExpression>(145223)
            tmp_hdr */
        hdr.dhInstance.dh_length = tmp_hdr.dh_length;
        /* 
      <AssignmentStatement>(145225)
        <Member>(145226)dh_policy_id
          <Member>(145210)dhInstance
            <PathExpression>(145211)
              hdr
        <Member>(145227)dh_policy_id
          <PathExpression>(145228)
            tmp_hdr */
        hdr.dhInstance.dh_policy_id = tmp_hdr.dh_policy_id;
        /* 
      <AssignmentStatement>(145230)
        <Member>(145231)dh_load_header
          <Member>(145210)dhInstance
            <PathExpression>(145211)
              hdr
        <Member>(145232)dh_load_header
          <PathExpression>(145233)
            tmp_hdr_0 */
        hdr.dhInstance.dh_load_header = tmp_hdr_0.dh_load_header;
/* 
      <SelectExpression>(145235)
        <ListExpression>(145237)
          <Member>(145239)pmi_recirculate_flag
            <Member>(145240)pmiInstance
              <PathExpression>(145241)
                meta
        <SelectCase>(145243)
          <Constant>(67022) 0
            <Type_Bits>(203)
          <PathExpression>(145245)
            dh_parser
        <SelectCase>(145247)
          <DefaultExpression>(145248)
          <PathExpression>(145249)
            accept */
                transition select(meta.pmiInstance.pmi_recirculate_flag) {
            /* 
        <SelectCase>(145243)
          <Constant>(67022) 0
            <Type_Bits>(203)
          <PathExpression>(145245)
            dh_parser */
            1w0: dh_parser;
            /* 
        <SelectCase>(145247)
          <DefaultExpression>(145248)
          <PathExpression>(145249)
            accept */
            default: accept;
        }
    }
}

/* 
  <P4Control>(91553) */
/* 
    <Type_Control>(67066)
      <Annotations>(3)
      <TypeParameters>(67064)
      <ParameterList>(67047) */
control egress(/* 
        <Parameter>(67051)
          <Annotations>(3)
          <Type_Name>(67050) */
inout headers hdr, /* 
        <Parameter>(67056)
          <Annotations>(3)
          <Type_Name>(67055) */
inout metadata meta, /* 
        <Parameter>(67061)
          <Annotations>(3)
          <Type_Name>(67060) */
inout standard_metadata_t standard_metadata) {
    apply /* 
    <BlockStatement>(91571) */
    {
    }
}

/* 
  <P4Control>(91574) */
/* 
    <Type_Control>(67184)
      <Annotations>(3)
      <TypeParameters>(67182)
      <ParameterList>(67165) */
control ingress(/* 
        <Parameter>(67169)
          <Annotations>(3)
          <Type_Name>(67168) */
inout headers hdr, /* 
        <Parameter>(67174)
          <Annotations>(3)
          <Type_Name>(67173) */
inout metadata meta, /* 
        <Parameter>(67179)
          <Annotations>(3)
          <Type_Name>(67178) */
inout standard_metadata_t standard_metadata) {
    apply /* 
    <BlockStatement>(91592) */
    {
    }
}

/* 
  <P4Control>(145295) */
/* 
    <Type_Control>(67302)
      <Annotations>(3)
      <TypeParameters>(67303)
      <ParameterList>(67295) */
control DeparserImpl(/* 
        <Parameter>(67299)
          <Annotations>(3)
          <Type_Name>(67298) */
packet_out packet, /* 
        <Parameter>(67289)
          <Annotations>(3)
          <Type_Name>(67288) */
in headers hdr) {
    apply /* 
    <BlockStatement>(145310) */
    {
        /* 
      <MethodCallStatement>(145312)
        <MethodCallExpression>(145313)
          <Member>(145314)emit
            <PathExpression>(145315)
              packet
          <Vector<Type>>(78578), size=1
            <Type_Name>(78579)
              description_header_t
          <Vector<Expression>>(145320), size=1
            <Member>(145321)dhInstance
              <PathExpression>(145322)
                hdr */
        packet.emit<description_header_t>(hdr.dhInstance);
    }
}

/* 
  <P4Control>(67337) */
/* 
    <Type_Control>(67330)
      <Annotations>(3)
      <TypeParameters>(67331)
      <ParameterList>(67318) */
control verifyChecksum(/* 
        <Parameter>(67322)
          <Annotations>(3)
          <Type_Name>(67321) */
in headers hdr, /* 
        <Parameter>(67327)
          <Annotations>(3)
          <Type_Name>(67326) */
inout metadata meta) {
    apply /* 
    <BlockStatement>(67334) */
    {
    }
}

/* 
  <P4Control>(67360) */
/* 
    <Type_Control>(67353)
      <Annotations>(3)
      <TypeParameters>(67354)
      <ParameterList>(67341) */
control computeChecksum(/* 
        <Parameter>(67345)
          <Annotations>(3)
          <Type_Name>(67344) */
inout headers hdr, /* 
        <Parameter>(67350)
          <Annotations>(3)
          <Type_Name>(67349) */
inout metadata meta) {
    apply /* 
    <BlockStatement>(67357) */
    {
    }
}

/* 
  <Declaration_Instance>(145358)
    <Annotations>(3)
    <Type_Specialized>(78644)
      <Type_Name>(67365)
      <Vector<Type>>(78639), size=2
    <Vector<Expression>>(145368), size=6
      <ConstructorCallExpression>(145369)
        <Type_Name>(67369)
          ParserImpl
        <Vector<Expression>>(67367), size=0
      <ConstructorCallExpression>(145373)
        <Type_Name>(67372)
          verifyChecksum
        <Vector<Expression>>(67367), size=0
      <ConstructorCallExpression>(145376)
        <Type_Name>(67375)
          ingress
        <Vector<Expression>>(67367), size=0
      <ConstructorCallExpression>(145379)
        <Type_Name>(67378)
          egress
        <Vector<Expression>>(67367), size=0
      <ConstructorCallExpression>(145382)
        <Type_Name>(67381)
          computeChecksum
        <Vector<Expression>>(67367), size=0
      <ConstructorCallExpression>(145385)
        <Type_Name>(67384)
          DeparserImpl
        <Vector<Expression>>(67367), size=0 */
/* 
    <Type_Specialized>(155775)
      <Type_Name>(67365)
        V1Switch
      <Vector<Type>>(155774), size=2
        <Type_Name>(78640)
        <Type_Name>(78642) */
V1Switch<headers, metadata>(ParserImpl(), verifyChecksum(), ingress(), egress(), computeChecksum(), DeparserImpl()) main;
