/* 
<P4Program>(75024)
  <Type_Error>(18)
  <Type_Extern>(89)
  <Type_Extern>(126)
  <Method>(140)
  <Declaration_MatchKind>(165)
  <Declaration_MatchKind>(171)
  <Type_Struct>(75132)
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
  <Method>(616)
  <Type_Extern>(667)
  <Type_Parser>(771)
  <Type_Control>(788)
  <Type_Control>(814)
  <Type_Control>(840)
  <Type_Control>(857)
  <Type_Control>(879)
  <Type_Package>(942)
  <Type_Header>(998)
  <Type_Struct>(1655)
  <Type_Struct>(75574)
  <P4Parser>(75584)
  <P4Control>(75640)
  <P4Control>(1937)
  <P4Control>(75789)
  <P4Control>(1991)
  <P4Control>(2014)
  <Declaration_Instance>(75852) */
/* 
  <Type_Error>(18) */
#include <core.p4>
#include <v1model.p4>

/* 
  <Type_Header>(998) */
header ethernet_t {
/* 
    <StructField>(971)
      <Annotations>(3)
      <Type_Bits>(272) */
        bit<48> dl_dst;
/* 
    <StructField>(977)
      <Annotations>(3)
      <Type_Bits>(272) */
        bit<48> dl_src;
/* 
    <StructField>(983)
      <Annotations>(3)
      <Type_Bits>(207) */
        bit<16> dl_type;
}

/* 
  <Type_Struct>(1655) */
struct metadata {
}

/* 
  <Type_Struct>(75574) */
struct headers {
/* 
    <StructField>(75576)
      <Annotations>(75577)
      <Type_Name>(1660) */
        @name("eth") 
    ethernet_t eth;
}

/* 
  <P4Parser>(75584) */
/* 
    <Type_Parser>(1690)
      <Annotations>(3)
      <TypeParameters>(1688)
      <ParameterList>(1668) */
parser ParserImpl(/* 
        <Parameter>(1672)
          <Annotations>(3)
          <Type_Name>(1671) */
packet_in packet, /* 
        <Parameter>(1675)
          <Annotations>(3)
          <Type_Name>(1674) */
out headers hdr, /* 
        <Parameter>(1680)
          <Annotations>(3)
          <Type_Name>(1679) */
inout metadata meta, /* 
        <Parameter>(1685)
          <Annotations>(3)
          <Type_Name>(1684) */
inout standard_metadata_t standard_metadata) {
    /* 
    <ParserState>(75606) */
    @name("parse_ethernet") state parse_ethernet {
        /* 
      <MethodCallStatement>(75613)
        <MethodCallExpression>(75614)
          <Member>(75615)extract
            <PathExpression>(75616)
              packet
          <Vector<Type>>(11410), size=1
            <Type_Name>(11411)
              ethernet_t
          <Vector<Expression>>(75621), size=1
            <Member>(75622)eth
              <PathExpression>(75623)
                hdr */
        packet.extract<ethernet_t>(hdr.eth);
/* 
      <PathExpression>(75625)
        accept */
                transition accept;
    }
    /* 
    <ParserState>(75627) */
    @name("start") state start {
/* 
      <PathExpression>(75634)
        parse_ethernet */
                transition parse_ethernet;
    }
}

/* 
  <P4Control>(75640) */
/* 
    <Type_Control>(1780)
      <Annotations>(3)
      <TypeParameters>(1778)
      <ParameterList>(1761) */
control ingress(/* 
        <Parameter>(1765)
          <Annotations>(3)
          <Type_Name>(1764) */
inout headers hdr, /* 
        <Parameter>(1770)
          <Annotations>(3)
          <Type_Name>(1769) */
inout metadata meta, /* 
        <Parameter>(1775)
          <Annotations>(3)
          <Type_Name>(1774) */
inout standard_metadata_t standard_metadata) {
    /* 
    <P4Action>(75658)
      <Annotations>(75659)
      <ParameterList>(157)
      <BlockStatement>(32574) */
    @name("NoAction") action NoAction_0() /* 
      <BlockStatement>(32574) */
    {
    }
    /* 
    <P4Action>(75668)
      <Annotations>(75669)
      <ParameterList>(51418)
      <BlockStatement>(75677) */
    @name(".forward") action forward_0(/* 
        <Parameter>(51424)
          <Annotations>(3)
          <Type_Bits>(187) */
bit<9> _port) /* 
      <BlockStatement>(75677) */
    {
        /* 
        <AssignmentStatement>(75679)
          <Member>(75680)egress_spec
            <PathExpression>(75681)
              standard_metadata
          <PathExpression>(75683)
            _port */
        standard_metadata.egress_spec = _port;
    }
    /* 
    <P4Action>(75685)
      <Annotations>(75686)
      <ParameterList>(1821)
      <BlockStatement>(75693) */
    @name("._drop") action _drop_0() /* 
      <BlockStatement>(75693) */
    {
        /* 
        <MethodCallStatement>(75695)
          <MethodCallExpression>(75696)
            <PathExpression>(75697)
              mark_to_drop
            <Vector<Type>>(1826), size=0
            <Vector<Expression>>(28913), size=0 */
        mark_to_drop();
    }
    /* 
    <P4Table>(75701)
      <Annotations>(75702)
      <TableProperties>(75707) */
    @name("forward_tbl") table forward_tbl {
        /* 
        <Property>(75709) */
        actions = /* 
          <ActionList>(75710)
            <ActionListElement>(75712)
            <ActionListElement>(75718)
            <ActionListElement>(75724) */
        {
            /* 
            <ActionListElement>(75712)
              <Annotations>(3)
              <MethodCallExpression>(75713)
                <PathExpression>(75714)
                  forward_0/forward
                <Vector<Type>>(3773), size=0
                <Vector<Expression>>(58241), size=0 */
            forward_0();
            /* 
            <ActionListElement>(75718)
              <Annotations>(3)
              <MethodCallExpression>(75719)
                <PathExpression>(75720)
                  _drop_0/_drop
                <Vector<Type>>(3779), size=0
                <Vector<Expression>>(58259), size=0 */
            _drop_0();
            /* 
            <ActionListElement>(75724)
              <Annotations>(1851)
                <Annotation>(1848)
              <MethodCallExpression>(75729)
                <PathExpression>(75730)
                  NoAction_0/NoAction_1
                <Vector<Type>>(3789), size=0
                <Vector<Expression>>(58281), size=0 */
            @default_only NoAction_0();
        }
        /* 
        <Property>(75734) */
        key = /* 
          <Key>(75735)
            <KeyElement>(75737) */
        {
/* 
              <KeyElement>(75737)
                <Annotations>(75738)
                <Member>(75743)dl_dst
                  <Member>(75744)eth
                    <PathExpression>(75745)
                      hdr
                <PathExpression>(75747)
                  exact */
                        hdr.eth.dl_dst: exact @name("hdr.eth.dl_dst") ;
        }
        /* 
        <Property>(75749) */
        size = /* 
          <ExpressionValue>(75750)
            <Constant>(75751) 1024
              <Type_InfInt>(61247) */
        1024;
        /* 
        <Property>(75753) */
        default_action = /* 
          <ExpressionValue>(75754)
            <MethodCallExpression>(75755)
              <PathExpression>(75756)
                NoAction_0/NoAction_1
              <Vector<Type>>(1888), size=0
              <Vector<Expression>>(1886), size=0 */
        NoAction_0();
    }
    apply /* 
    <BlockStatement>(75760) */
    {
        /* 
      <MethodCallStatement>(75762)
        <MethodCallExpression>(75763)
          <Member>(75764)apply
            <PathExpression>(75765)
              forward_tbl
          <Vector<Type>>(1906), size=0
          <Vector<Expression>>(29017), size=0 */
        forward_tbl.apply();
    }
}

/* 
  <P4Control>(1937) */
/* 
    <Type_Control>(1934)
      <Annotations>(3)
      <TypeParameters>(1932)
      <ParameterList>(1915) */
control egress(/* 
        <Parameter>(1919)
          <Annotations>(3)
          <Type_Name>(1918) */
inout headers hdr, /* 
        <Parameter>(1924)
          <Annotations>(3)
          <Type_Name>(1923) */
inout metadata meta, /* 
        <Parameter>(1929)
          <Annotations>(3)
          <Type_Name>(1928) */
inout standard_metadata_t standard_metadata) {
    apply /* 
    <BlockStatement>(1935) */
    {
    }
}

/* 
  <P4Control>(75789) */
/* 
    <Type_Control>(1956)
      <Annotations>(3)
      <TypeParameters>(1957)
      <ParameterList>(1949) */
control DeparserImpl(/* 
        <Parameter>(1953)
          <Annotations>(3)
          <Type_Name>(1952) */
packet_out packet, /* 
        <Parameter>(1943)
          <Annotations>(3)
          <Type_Name>(1942) */
in headers hdr) {
    apply /* 
    <BlockStatement>(75804) */
    {
        /* 
      <MethodCallStatement>(75806)
        <MethodCallExpression>(75807)
          <Member>(75808)emit
            <PathExpression>(75809)
              packet
          <Vector<Type>>(11590), size=1
            <Type_Name>(11591)
              ethernet_t
          <Vector<Expression>>(75814), size=1
            <Member>(75815)eth
              <PathExpression>(75816)
                hdr */
        packet.emit<ethernet_t>(hdr.eth);
    }
}

/* 
  <P4Control>(1991) */
/* 
    <Type_Control>(1984)
      <Annotations>(3)
      <TypeParameters>(1985)
      <ParameterList>(1972) */
control verifyChecksum(/* 
        <Parameter>(1976)
          <Annotations>(3)
          <Type_Name>(1975) */
in headers hdr, /* 
        <Parameter>(1981)
          <Annotations>(3)
          <Type_Name>(1980) */
inout metadata meta) {
    apply /* 
    <BlockStatement>(1988) */
    {
    }
}

/* 
  <P4Control>(2014) */
/* 
    <Type_Control>(2007)
      <Annotations>(3)
      <TypeParameters>(2008)
      <ParameterList>(1995) */
control computeChecksum(/* 
        <Parameter>(1999)
          <Annotations>(3)
          <Type_Name>(1998) */
inout headers hdr, /* 
        <Parameter>(2004)
          <Annotations>(3)
          <Type_Name>(2003) */
inout metadata meta) {
    apply /* 
    <BlockStatement>(2011) */
    {
    }
}

/* 
  <Declaration_Instance>(75852)
    <Annotations>(3)
    <Type_Specialized>(11656)
      <Type_Name>(2019)
      <Vector<Type>>(11651), size=2
    <Vector<Expression>>(75862), size=6
      <ConstructorCallExpression>(75863)
        <Type_Name>(2023)
          ParserImpl
        <Vector<Expression>>(2021), size=0
      <ConstructorCallExpression>(75867)
        <Type_Name>(2026)
          verifyChecksum
        <Vector<Expression>>(2021), size=0
      <ConstructorCallExpression>(75870)
        <Type_Name>(2029)
          ingress
        <Vector<Expression>>(2021), size=0
      <ConstructorCallExpression>(75873)
        <Type_Name>(2032)
          egress
        <Vector<Expression>>(2021), size=0
      <ConstructorCallExpression>(75876)
        <Type_Name>(2035)
          computeChecksum
        <Vector<Expression>>(2021), size=0
      <ConstructorCallExpression>(75879)
        <Type_Name>(2038)
          DeparserImpl
        <Vector<Expression>>(2021), size=0 */
/* 
    <Type_Specialized>(85471)
      <Type_Name>(2019)
        V1Switch
      <Vector<Type>>(85470), size=2
        <Type_Name>(11652)
        <Type_Name>(11654) */
V1Switch<headers, metadata>(ParserImpl(), verifyChecksum(), ingress(), egress(), computeChecksum(), DeparserImpl()) main;
