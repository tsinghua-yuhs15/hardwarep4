/* 
<P4Program>(32462)
  <Type_Error>(18)
  <Type_Extern>(89)
  <Type_Extern>(126)
  <Method>(140)
  <P4Action>(32561)
  <Declaration_MatchKind>(165)
  <Declaration_MatchKind>(171)
  <Type_Struct>(324)
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
  <Type_Struct>(1657)
  <P4Parser>(31012)
  <P4Control>(31070)
  <P4Control>(1937)
  <P4Control>(31215)
  <P4Control>(1991)
  <P4Control>(2014)
  <Declaration_Instance>(11627) */
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
  <Type_Struct>(1657) */
struct headers {
/* 
    <StructField>(1667)
      <Annotations>(1665)
      <Type_Name>(1660) */
        @name("eth") 
    ethernet_t eth;
}

/* 
  <P4Parser>(31012) */
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
    <ParserState>(31034) */
    @name("parse_ethernet") state parse_ethernet {
        /* 
      <MethodCallStatement>(28822)
        <MethodCallExpression>(28821)
          <Member>(28819)extract
            <PathExpression>(1725)
              packet
          <Vector<Type>>(11410), size=1
            <Type_Name>(11411)
              ethernet_t
          <Vector<Expression>>(28776), size=1
            <Member>(28820)eth
              <PathExpression>(1707)
                hdr */
        packet.extract<ethernet_t>(hdr.eth);
/* 
      <PathExpression>(1731)
        accept */
                transition accept;
    }
    /* 
    <ParserState>(1752) */
    @name("start") state start {
/* 
      <PathExpression>(1743)
        parse_ethernet */
                transition parse_ethernet;
    }
}

/* 
  <P4Control>(31070) */
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
    <P4Action>(31088)
      <Annotations>(1816)
      <ParameterList>(1784)
      <BlockStatement>(31097) */
    @name(".forward") action forward_0(/* 
        <Parameter>(1786)
          <Annotations>(3)
          <Type_Bits>(187) */
bit<9> _port) /* 
      <BlockStatement>(31097) */
    {
        /* 
        <AssignmentStatement>(28889)
          <Member>(28886)egress_spec
            <PathExpression>(1806)
              standard_metadata
          <PathExpression>(28887)
            _port */
        standard_metadata.egress_spec = _port;
    }
    /* 
    <P4Action>(31107)
      <Annotations>(1833)
      <ParameterList>(1821)
      <BlockStatement>(31115) */
    @name("._drop") action _drop_0() /* 
      <BlockStatement>(31115) */
    {
        /* 
        <MethodCallStatement>(28917)
          <MethodCallExpression>(28916)
            <PathExpression>(28914)
              mark_to_drop
            <Vector<Type>>(1826), size=0
            <Vector<Expression>>(28913), size=0 */
        mark_to_drop();
    }
    /* 
    <P4Table>(25802)
      <Annotations>(1895)
      <TableProperties>(25808) */
    @name("forward_tbl") table forward_tbl_0 {
        /* 
        <Property>(25810) */
        actions = /* 
          <ActionList>(25811)
            <ActionListElement>(25813)
            <ActionListElement>(25821)
            <ActionListElement>(3782) */
        {
            /* 
            <ActionListElement>(25813)
              <Annotations>(3)
              <MethodCallExpression>(25814)
                <PathExpression>(25817)
                  forward_0/forward
                <Vector<Type>>(3773), size=0
                <Vector<Expression>>(3774), size=0 */
            forward_0();
            /* 
            <ActionListElement>(25821)
              <Annotations>(3)
              <MethodCallExpression>(25822)
                <PathExpression>(25825)
                  _drop_0/_drop
                <Vector<Type>>(3779), size=0
                <Vector<Expression>>(3780), size=0 */
            _drop_0();
            /* 
            <ActionListElement>(3782)
              <Annotations>(1851)
                <Annotation>(1848)
              <MethodCallExpression>(3791)
                <PathExpression>(1853)
                  NoAction
                <Vector<Type>>(3789), size=0
                <Vector<Expression>>(3790), size=0 */
            @default_only NoAction();
        }
        /* 
        <Property>(17744) */
        key = /* 
          <Key>(17745)
            <KeyElement>(17747) */
        {
/* 
              <KeyElement>(17747)
                <Annotations>(17758)
                <Member>(1860)dl_dst
                  <Member>(1875)eth
                    <PathExpression>(1874)
                      hdr
                <PathExpression>(1876)
                  exact */
                        hdr.eth.dl_dst: exact @name("hdr.eth.dl_dst") ;
        }
        /* 
        <Property>(1883) */
        size = /* 
          <ExpressionValue>(1882)
            <Constant>(1881) 1024
              <Type_InfInt>(1880) */
        1024;
        /* 
        <Property>(1890) */
        default_action = /* 
          <ExpressionValue>(1889)
            <MethodCallExpression>(1887)
              <PathExpression>(1884)
                NoAction
              <Vector<Type>>(1888), size=0
              <Vector<Expression>>(1886), size=0 */
        NoAction();
    }
    apply /* 
    <BlockStatement>(31184) */
    {
        /* 
      <MethodCallStatement>(29044)
        <MethodCallExpression>(29043)
          <Member>(29042)apply
            <PathExpression>(25873)
              forward_tbl_0/forward_tbl
          <Vector<Type>>(1906), size=0
          <Vector<Expression>>(29017), size=0 */
        forward_tbl_0.apply();
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
  <P4Control>(31215) */
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
    <BlockStatement>(31230) */
    {
        /* 
      <MethodCallStatement>(29189)
        <MethodCallExpression>(29188)
          <Member>(29186)emit
            <PathExpression>(1962)
              packet
          <Vector<Type>>(11590), size=1
            <Type_Name>(11591)
              ethernet_t
          <Vector<Expression>>(29143), size=1
            <Member>(29187)eth
              <PathExpression>(1944)
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
  <Declaration_Instance>(11627)
    <Annotations>(3)
    <Type_Specialized>(11656)
      <Type_Name>(2019)
      <Vector<Type>>(11651), size=2
    <Vector<Expression>>(2020), size=6
      <ConstructorCallExpression>(2024)
        <Type_Name>(2023)
          ParserImpl
        <Vector<Expression>>(2021), size=0
      <ConstructorCallExpression>(2027)
        <Type_Name>(2026)
          verifyChecksum
        <Vector<Expression>>(2021), size=0
      <ConstructorCallExpression>(2030)
        <Type_Name>(2029)
          ingress
        <Vector<Expression>>(2021), size=0
      <ConstructorCallExpression>(2033)
        <Type_Name>(2032)
          egress
        <Vector<Expression>>(2021), size=0
      <ConstructorCallExpression>(2036)
        <Type_Name>(2035)
          computeChecksum
        <Vector<Expression>>(2021), size=0
      <ConstructorCallExpression>(2039)
        <Type_Name>(2038)
          DeparserImpl
        <Vector<Expression>>(2021), size=0 */
/* 
    <Type_Specialized>(47444)
      <Type_Name>(2019)
        V1Switch
      <Vector<Type>>(47443), size=2
        <Type_Name>(11652)
        <Type_Name>(11654) */
V1Switch<headers, metadata>(ParserImpl(), verifyChecksum(), ingress(), egress(), computeChecksum(), DeparserImpl()) main;
