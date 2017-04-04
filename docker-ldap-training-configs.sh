#!/bin/sh

# write configs
# =============================================================================
# config.php
# =============================================================================
cat >/etc/phpldapadmin/config.php <<EOL
<?php

// map attribute names to user friendly names
\$config->custom->appearance['friendly_attrs'] = array(
        'facsimileTelephoneNumber' => 'Fax',
        'gid'                      => 'Group',
        'mail'                     => 'Email',
        'telephoneNumber'          => 'Telephone',
        'uid'                      => 'User Name',
        'userPassword'             => 'Password'
);

// servers
\$servers = new Datastore();
\$servers->newServer('ldap_pla');
\$servers->setValue('server','name','My LDAP Server');
\$servers->setValue('server','host','127.0.0.1');
\$servers->setValue('server','base',array('dc=test,dc=com'));
\$servers->setValue('login','auth_type','session');
\$servers->setValue('login','bind_id','cn=admin,dc=test,dc=com');
?>
EOL

# =============================================================================
# ldap master config
# =============================================================================
cat >/tmp/config.ldif <<EOL
dn: cn=config
objectClass: olcGlobal
cn: config
olcArgsFile: /var/run/slapd/slapd.args
olcLogLevel: none
olcPidFile: /var/run/slapd/slapd.pid
olcToolThreads: 1
structuralObjectClass: olcGlobal
entryUUID: 31ea0980-7875-1035-8d31-b7844b324fb9
creatorsName: cn=config
createTimestamp: 20160307055718Z
entryCSN: 20160307055718.459255Z#000000#000#000000
modifiersName: cn=config
modifyTimestamp: 20160307055718Z

dn: cn=module{0},cn=config
objectClass: olcModuleList
cn: module{0}
olcModulePath: /usr/lib/ldap
olcModuleLoad: {0}back_hdb
structuralObjectClass: olcModuleList
entryUUID: 31ea778a-7875-1035-8d39-b7844b324fb9
creatorsName: cn=config
createTimestamp: 20160307055718Z
entryCSN: 20160307055718.462109Z#000000#000#000000
modifiersName: cn=config
modifyTimestamp: 20160307055718Z

dn: cn=schema,cn=config
objectClass: olcSchemaConfig
cn: schema
structuralObjectClass: olcSchemaConfig
entryUUID: 31ea190c-7875-1035-8d34-b7844b324fb9
creatorsName: cn=config
createTimestamp: 20160307055718Z
entryCSN: 20160307055718.459691Z#000000#000#000000
modifiersName: cn=config
modifyTimestamp: 20160307055718Z

dn: cn={0}core,cn=schema,cn=config
objectClass: olcSchemaConfig
cn: {0}core
olcAttributeTypes: {0}( 2.5.4.2 NAME 'knowledgeInformation' DESC 'RFC2256: kno
 wledge information' EQUALITY caseIgnoreMatch SYNTAX 1.3.6.1.4.1.1466.115.121.
 1.15{32768} )
olcAttributeTypes: {1}( 2.5.4.4 NAME ( 'sn' 'surname' ) DESC 'RFC2256: last (f
 amily) name(s) for which the entity is known by' SUP name )
olcAttributeTypes: {2}( 2.5.4.5 NAME 'serialNumber' DESC 'RFC2256: serial numb
 er of the entity' EQUALITY caseIgnoreMatch SUBSTR caseIgnoreSubstringsMatch S
 YNTAX 1.3.6.1.4.1.1466.115.121.1.44{64} )
olcAttributeTypes: {3}( 2.5.4.6 NAME ( 'c' 'countryName' ) DESC 'RFC2256: ISO-
 3166 country 2-letter code' SUP name SINGLE-VALUE )
olcAttributeTypes: {4}( 2.5.4.7 NAME ( 'l' 'localityName' ) DESC 'RFC2256: loc
 ality which this object resides in' SUP name )
olcAttributeTypes: {5}( 2.5.4.8 NAME ( 'st' 'stateOrProvinceName' ) DESC 'RFC2
 256: state or province which this object resides in' SUP name )
olcAttributeTypes: {6}( 2.5.4.9 NAME ( 'street' 'streetAddress' ) DESC 'RFC225
 6: street address of this object' EQUALITY caseIgnoreMatch SUBSTR caseIgnoreS
 ubstringsMatch SYNTAX 1.3.6.1.4.1.1466.115.121.1.15{128} )
olcAttributeTypes: {7}( 2.5.4.10 NAME ( 'o' 'organizationName' ) DESC 'RFC2256
 : organization this object belongs to' SUP name )
olcAttributeTypes: {8}( 2.5.4.11 NAME ( 'ou' 'organizationalUnitName' ) DESC '
 RFC2256: organizational unit this object belongs to' SUP name )
olcAttributeTypes: {9}( 2.5.4.12 NAME 'title' DESC 'RFC2256: title associated 
 with the entity' SUP name )
olcAttributeTypes: {10}( 2.5.4.14 NAME 'searchGuide' DESC 'RFC2256: search gui
 de, deprecated by enhancedSearchGuide' SYNTAX 1.3.6.1.4.1.1466.115.121.1.25 )
olcAttributeTypes: {11}( 2.5.4.15 NAME 'businessCategory' DESC 'RFC2256: busin
 ess category' EQUALITY caseIgnoreMatch SUBSTR caseIgnoreSubstringsMatch SYNTA
 X 1.3.6.1.4.1.1466.115.121.1.15{128} )
olcAttributeTypes: {12}( 2.5.4.16 NAME 'postalAddress' DESC 'RFC2256: postal a
 ddress' EQUALITY caseIgnoreListMatch SUBSTR caseIgnoreListSubstringsMatch SYN
 TAX 1.3.6.1.4.1.1466.115.121.1.41 )
olcAttributeTypes: {13}( 2.5.4.17 NAME 'postalCode' DESC 'RFC2256: postal code
 ' EQUALITY caseIgnoreMatch SUBSTR caseIgnoreSubstringsMatch SYNTAX 1.3.6.1.4.
 1.1466.115.121.1.15{40} )
olcAttributeTypes: {14}( 2.5.4.18 NAME 'postOfficeBox' DESC 'RFC2256: Post Off
 ice Box' EQUALITY caseIgnoreMatch SUBSTR caseIgnoreSubstringsMatch SYNTAX 1.3
 .6.1.4.1.1466.115.121.1.15{40} )
olcAttributeTypes: {15}( 2.5.4.19 NAME 'physicalDeliveryOfficeName' DESC 'RFC2
 256: Physical Delivery Office Name' EQUALITY caseIgnoreMatch SUBSTR caseIgnor
 eSubstringsMatch SYNTAX 1.3.6.1.4.1.1466.115.121.1.15{128} )
olcAttributeTypes: {16}( 2.5.4.20 NAME 'telephoneNumber' DESC 'RFC2256: Teleph
 one Number' EQUALITY telephoneNumberMatch SUBSTR telephoneNumberSubstringsMat
 ch SYNTAX 1.3.6.1.4.1.1466.115.121.1.50{32} )
olcAttributeTypes: {17}( 2.5.4.21 NAME 'telexNumber' DESC 'RFC2256: Telex Numb
 er' SYNTAX 1.3.6.1.4.1.1466.115.121.1.52 )
olcAttributeTypes: {18}( 2.5.4.22 NAME 'teletexTerminalIdentifier' DESC 'RFC22
 56: Teletex Terminal Identifier' SYNTAX 1.3.6.1.4.1.1466.115.121.1.51 )
olcAttributeTypes: {19}( 2.5.4.23 NAME ( 'facsimileTelephoneNumber' 'fax' ) DE
 SC 'RFC2256: Facsimile (Fax) Telephone Number' SYNTAX 1.3.6.1.4.1.1466.115.12
 1.1.22 )
olcAttributeTypes: {20}( 2.5.4.24 NAME 'x121Address' DESC 'RFC2256: X.121 Addr
 ess' EQUALITY numericStringMatch SUBSTR numericStringSubstringsMatch SYNTAX 1
 .3.6.1.4.1.1466.115.121.1.36{15} )
olcAttributeTypes: {21}( 2.5.4.25 NAME 'internationaliSDNNumber' DESC 'RFC2256
 : international ISDN number' EQUALITY numericStringMatch SUBSTR numericString
 SubstringsMatch SYNTAX 1.3.6.1.4.1.1466.115.121.1.36{16} )
olcAttributeTypes: {22}( 2.5.4.26 NAME 'registeredAddress' DESC 'RFC2256: regi
 stered postal address' SUP postalAddress SYNTAX 1.3.6.1.4.1.1466.115.121.1.41
  )
olcAttributeTypes: {23}( 2.5.4.27 NAME 'destinationIndicator' DESC 'RFC2256: d
 estination indicator' EQUALITY caseIgnoreMatch SUBSTR caseIgnoreSubstringsMat
 ch SYNTAX 1.3.6.1.4.1.1466.115.121.1.44{128} )
olcAttributeTypes: {24}( 2.5.4.28 NAME 'preferredDeliveryMethod' DESC 'RFC2256
 : preferred delivery method' SYNTAX 1.3.6.1.4.1.1466.115.121.1.14 SINGLE-VALU
 E )
olcAttributeTypes: {25}( 2.5.4.29 NAME 'presentationAddress' DESC 'RFC2256: pr
 esentation address' EQUALITY presentationAddressMatch SYNTAX 1.3.6.1.4.1.1466
 .115.121.1.43 SINGLE-VALUE )
olcAttributeTypes: {26}( 2.5.4.30 NAME 'supportedApplicationContext' DESC 'RFC
 2256: supported application context' EQUALITY objectIdentifierMatch SYNTAX 1.
 3.6.1.4.1.1466.115.121.1.38 )
olcAttributeTypes: {27}( 2.5.4.31 NAME 'member' DESC 'RFC2256: member of a gro
 up' SUP distinguishedName )
olcAttributeTypes: {28}( 2.5.4.32 NAME 'owner' DESC 'RFC2256: owner (of the ob
 ject)' SUP distinguishedName )
olcAttributeTypes: {29}( 2.5.4.33 NAME 'roleOccupant' DESC 'RFC2256: occupant 
 of role' SUP distinguishedName )
olcAttributeTypes: {30}( 2.5.4.36 NAME 'userCertificate' DESC 'RFC2256: X.509 
 user certificate, use ;binary' EQUALITY certificateExactMatch SYNTAX 1.3.6.1.
 4.1.1466.115.121.1.8 )
olcAttributeTypes: {31}( 2.5.4.37 NAME 'cACertificate' DESC 'RFC2256: X.509 CA
  certificate, use ;binary' EQUALITY certificateExactMatch SYNTAX 1.3.6.1.4.1.
 1466.115.121.1.8 )
olcAttributeTypes: {32}( 2.5.4.38 NAME 'authorityRevocationList' DESC 'RFC2256
 : X.509 authority revocation list, use ;binary' SYNTAX 1.3.6.1.4.1.1466.115.1
 21.1.9 )
olcAttributeTypes: {33}( 2.5.4.39 NAME 'certificateRevocationList' DESC 'RFC22
 56: X.509 certificate revocation list, use ;binary' SYNTAX 1.3.6.1.4.1.1466.1
 15.121.1.9 )
olcAttributeTypes: {34}( 2.5.4.40 NAME 'crossCertificatePair' DESC 'RFC2256: X
 .509 cross certificate pair, use ;binary' SYNTAX 1.3.6.1.4.1.1466.115.121.1.1
 0 )
olcAttributeTypes: {35}( 2.5.4.42 NAME ( 'givenName' 'gn' ) DESC 'RFC2256: fir
 st name(s) for which the entity is known by' SUP name )
olcAttributeTypes: {36}( 2.5.4.43 NAME 'initials' DESC 'RFC2256: initials of s
 ome or all of names, but not the surname(s).' SUP name )
olcAttributeTypes: {37}( 2.5.4.44 NAME 'generationQualifier' DESC 'RFC2256: na
 me qualifier indicating a generation' SUP name )
olcAttributeTypes: {38}( 2.5.4.45 NAME 'x500UniqueIdentifier' DESC 'RFC2256: X
 .500 unique identifier' EQUALITY bitStringMatch SYNTAX 1.3.6.1.4.1.1466.115.1
 21.1.6 )
olcAttributeTypes: {39}( 2.5.4.46 NAME 'dnQualifier' DESC 'RFC2256: DN qualifi
 er' EQUALITY caseIgnoreMatch ORDERING caseIgnoreOrderingMatch SUBSTR caseIgno
 reSubstringsMatch SYNTAX 1.3.6.1.4.1.1466.115.121.1.44 )
olcAttributeTypes: {40}( 2.5.4.47 NAME 'enhancedSearchGuide' DESC 'RFC2256: en
 hanced search guide' SYNTAX 1.3.6.1.4.1.1466.115.121.1.21 )
olcAttributeTypes: {41}( 2.5.4.48 NAME 'protocolInformation' DESC 'RFC2256: pr
 otocol information' EQUALITY protocolInformationMatch SYNTAX 1.3.6.1.4.1.1466
 .115.121.1.42 )
olcAttributeTypes: {42}( 2.5.4.50 NAME 'uniqueMember' DESC 'RFC2256: unique me
 mber of a group' EQUALITY uniqueMemberMatch SYNTAX 1.3.6.1.4.1.1466.115.121.1
 .34 )
olcAttributeTypes: {43}( 2.5.4.51 NAME 'houseIdentifier' DESC 'RFC2256: house 
 identifier' EQUALITY caseIgnoreMatch SUBSTR caseIgnoreSubstringsMatch SYNTAX 
 1.3.6.1.4.1.1466.115.121.1.15{32768} )
olcAttributeTypes: {44}( 2.5.4.52 NAME 'supportedAlgorithms' DESC 'RFC2256: su
 pported algorithms' SYNTAX 1.3.6.1.4.1.1466.115.121.1.49 )
olcAttributeTypes: {45}( 2.5.4.53 NAME 'deltaRevocationList' DESC 'RFC2256: de
 lta revocation list; use ;binary' SYNTAX 1.3.6.1.4.1.1466.115.121.1.9 )
olcAttributeTypes: {46}( 2.5.4.54 NAME 'dmdName' DESC 'RFC2256: name of DMD' S
 UP name )
olcAttributeTypes: {47}( 2.5.4.65 NAME 'pseudonym' DESC 'X.520(4th): pseudonym
  for the object' SUP name )
olcAttributeTypes: {48}( 0.9.2342.19200300.100.1.3 NAME ( 'mail' 'rfc822Mailbo
 x' ) DESC 'RFC1274: RFC822 Mailbox'   EQUALITY caseIgnoreIA5Match   SUBSTR ca
 seIgnoreIA5SubstringsMatch   SYNTAX 1.3.6.1.4.1.1466.115.121.1.26{256} )
olcAttributeTypes: {49}( 0.9.2342.19200300.100.1.25 NAME ( 'dc' 'domainCompone
 nt' ) DESC 'RFC1274/2247: domain component' EQUALITY caseIgnoreIA5Match SUBST
 R caseIgnoreIA5SubstringsMatch SYNTAX 1.3.6.1.4.1.1466.115.121.1.26 SINGLE-VA
 LUE )
olcAttributeTypes: {50}( 0.9.2342.19200300.100.1.37 NAME 'associatedDomain' DE
 SC 'RFC1274: domain associated with object' EQUALITY caseIgnoreIA5Match SUBST
 R caseIgnoreIA5SubstringsMatch SYNTAX 1.3.6.1.4.1.1466.115.121.1.26 )
olcAttributeTypes: {51}( 1.2.840.113549.1.9.1 NAME ( 'email' 'emailAddress' 'p
 kcs9email' ) DESC 'RFC3280: legacy attribute for email addresses in DNs' EQUA
 LITY caseIgnoreIA5Match SUBSTR caseIgnoreIA5SubstringsMatch SYNTAX 1.3.6.1.4.
 1.1466.115.121.1.26{128} )
olcObjectClasses: {0}( 2.5.6.2 NAME 'country' DESC 'RFC2256: a country' SUP to
 p STRUCTURAL MUST c MAY ( searchGuide $ description ) )
olcObjectClasses: {1}( 2.5.6.3 NAME 'locality' DESC 'RFC2256: a locality' SUP 
 top STRUCTURAL MAY ( street $ seeAlso $ searchGuide $ st $ l $ description ) 
 )
olcObjectClasses: {2}( 2.5.6.4 NAME 'organization' DESC 'RFC2256: an organizat
 ion' SUP top STRUCTURAL MUST o MAY ( userPassword $ searchGuide $ seeAlso $ b
 usinessCategory $ x121Address $ registeredAddress $ destinationIndicator $ pr
 eferredDeliveryMethod $ telexNumber $ teletexTerminalIdentifier $ telephoneNu
 mber $ internationaliSDNNumber $  facsimileTelephoneNumber $ street $ postOff
 iceBox $ postalCode $ postalAddress $ physicalDeliveryOfficeName $ st $ l $ d
 escription ) )
olcObjectClasses: {3}( 2.5.6.5 NAME 'organizationalUnit' DESC 'RFC2256: an org
 anizational unit' SUP top STRUCTURAL MUST ou MAY ( userPassword $ searchGuide
  $ seeAlso $ businessCategory $ x121Address $ registeredAddress $ destination
 Indicator $ preferredDeliveryMethod $ telexNumber $ teletexTerminalIdentifier
  $ telephoneNumber $ internationaliSDNNumber $ facsimileTelephoneNumber $ str
 eet $ postOfficeBox $ postalCode $ postalAddress $ physicalDeliveryOfficeName
  $ st $ l $ description ) )
olcObjectClasses: {4}( 2.5.6.6 NAME 'person' DESC 'RFC2256: a person' SUP top 
 STRUCTURAL MUST ( sn $ cn ) MAY ( userPassword $ telephoneNumber $ seeAlso $ 
 description ) )
olcObjectClasses: {5}( 2.5.6.7 NAME 'organizationalPerson' DESC 'RFC2256: an o
 rganizational person' SUP person STRUCTURAL MAY ( title $ x121Address $ regis
 teredAddress $ destinationIndicator $ preferredDeliveryMethod $ telexNumber $
  teletexTerminalIdentifier $ telephoneNumber $ internationaliSDNNumber $  fac
 simileTelephoneNumber $ street $ postOfficeBox $ postalCode $ postalAddress $
  physicalDeliveryOfficeName $ ou $ st $ l ) )
olcObjectClasses: {6}( 2.5.6.8 NAME 'organizationalRole' DESC 'RFC2256: an org
 anizational role' SUP top STRUCTURAL MUST cn MAY ( x121Address $ registeredAd
 dress $ destinationIndicator $ preferredDeliveryMethod $ telexNumber $ telete
 xTerminalIdentifier $ telephoneNumber $ internationaliSDNNumber $ facsimileTe
 lephoneNumber $ seeAlso $ roleOccupant $ preferredDeliveryMethod $ street $ p
 ostOfficeBox $ postalCode $ postalAddress $ physicalDeliveryOfficeName $ ou $
  st $ l $ description ) )
olcObjectClasses: {7}( 2.5.6.9 NAME 'groupOfNames' DESC 'RFC2256: a group of n
 ames (DNs)' SUP top STRUCTURAL MUST ( member $ cn ) MAY ( businessCategory $ 
 seeAlso $ owner $ ou $ o $ description ) )
olcObjectClasses: {8}( 2.5.6.10 NAME 'residentialPerson' DESC 'RFC2256: an res
 idential person' SUP person STRUCTURAL MUST l MAY ( businessCategory $ x121Ad
 dress $ registeredAddress $ destinationIndicator $ preferredDeliveryMethod $ 
 telexNumber $ teletexTerminalIdentifier $ telephoneNumber $ internationaliSDN
 Number $ facsimileTelephoneNumber $ preferredDeliveryMethod $ street $ postOf
 ficeBox $ postalCode $ postalAddress $ physicalDeliveryOfficeName $ st $ l ) 
 )
olcObjectClasses: {9}( 2.5.6.11 NAME 'applicationProcess' DESC 'RFC2256: an ap
 plication process' SUP top STRUCTURAL MUST cn MAY ( seeAlso $ ou $ l $ descri
 ption ) )
olcObjectClasses: {10}( 2.5.6.12 NAME 'applicationEntity' DESC 'RFC2256: an ap
 plication entity' SUP top STRUCTURAL MUST ( presentationAddress $ cn ) MAY ( 
 supportedApplicationContext $ seeAlso $ ou $ o $ l $ description ) )
olcObjectClasses: {11}( 2.5.6.13 NAME 'dSA' DESC 'RFC2256: a directory system 
 agent (a server)' SUP applicationEntity STRUCTURAL MAY knowledgeInformation )
olcObjectClasses: {12}( 2.5.6.14 NAME 'device' DESC 'RFC2256: a device' SUP to
 p STRUCTURAL MUST cn MAY ( serialNumber $ seeAlso $ owner $ ou $ o $ l $ desc
 ription ) )
olcObjectClasses: {13}( 2.5.6.15 NAME 'strongAuthenticationUser' DESC 'RFC2256
 : a strong authentication user' SUP top AUXILIARY MUST userCertificate )
olcObjectClasses: {14}( 2.5.6.16 NAME 'certificationAuthority' DESC 'RFC2256: 
 a certificate authority' SUP top AUXILIARY MUST ( authorityRevocationList $ c
 ertificateRevocationList $ cACertificate ) MAY crossCertificatePair )
olcObjectClasses: {15}( 2.5.6.17 NAME 'groupOfUniqueNames' DESC 'RFC2256: a gr
 oup of unique names (DN and Unique Identifier)' SUP top STRUCTURAL MUST ( uni
 queMember $ cn ) MAY ( businessCategory $ seeAlso $ owner $ ou $ o $ descript
 ion ) )
olcObjectClasses: {16}( 2.5.6.18 NAME 'userSecurityInformation' DESC 'RFC2256:
  a user security information' SUP top AUXILIARY MAY ( supportedAlgorithms ) )
olcObjectClasses: {17}( 2.5.6.16.2 NAME 'certificationAuthority-V2' SUP certif
 icationAuthority AUXILIARY MAY ( deltaRevocationList ) )
olcObjectClasses: {18}( 2.5.6.19 NAME 'cRLDistributionPoint' SUP top STRUCTURA
 L MUST ( cn ) MAY ( certificateRevocationList $ authorityRevocationList $ del
 taRevocationList ) )
olcObjectClasses: {19}( 2.5.6.20 NAME 'dmd' SUP top STRUCTURAL MUST ( dmdName 
 ) MAY ( userPassword $ searchGuide $ seeAlso $ businessCategory $ x121Address
  $ registeredAddress $ destinationIndicator $ preferredDeliveryMethod $ telex
 Number $ teletexTerminalIdentifier $ telephoneNumber $ internationaliSDNNumbe
 r $ facsimileTelephoneNumber $ street $ postOfficeBox $ postalCode $ postalAd
 dress $ physicalDeliveryOfficeName $ st $ l $ description ) )
olcObjectClasses: {20}( 2.5.6.21 NAME 'pkiUser' DESC 'RFC2587: a PKI user' SUP
  top AUXILIARY MAY userCertificate )
olcObjectClasses: {21}( 2.5.6.22 NAME 'pkiCA' DESC 'RFC2587: PKI certificate a
 uthority' SUP top AUXILIARY MAY ( authorityRevocationList $ certificateRevoca
 tionList $ cACertificate $ crossCertificatePair ) )
olcObjectClasses: {22}( 2.5.6.23 NAME 'deltaCRL' DESC 'RFC2587: PKI user' SUP 
 top AUXILIARY MAY deltaRevocationList )
olcObjectClasses: {23}( 1.3.6.1.4.1.250.3.15 NAME 'labeledURIObject' DESC 'RFC
 2079: object that contains the URI attribute type' MAY ( labeledURI ) SUP top
  AUXILIARY )
olcObjectClasses: {24}( 0.9.2342.19200300.100.4.19 NAME 'simpleSecurityObject'
  DESC 'RFC1274: simple security object' SUP top AUXILIARY MUST userPassword )
olcObjectClasses: {25}( 1.3.6.1.4.1.1466.344 NAME 'dcObject' DESC 'RFC2247: do
 main component object' SUP top AUXILIARY MUST dc )
olcObjectClasses: {26}( 1.3.6.1.1.3.1 NAME 'uidObject' DESC 'RFC2377: uid obje
 ct' SUP top AUXILIARY MUST uid )
structuralObjectClass: olcSchemaConfig
entryUUID: 31ea23de-7875-1035-8d35-b7844b324fb9
creatorsName: cn=config
createTimestamp: 20160307055718Z
entryCSN: 20160307055718.459968Z#000000#000#000000
modifiersName: cn=config
modifyTimestamp: 20160307055718Z

dn: cn={1}cosine,cn=schema,cn=config
objectClass: olcSchemaConfig
cn: {1}cosine
olcAttributeTypes: {0}( 0.9.2342.19200300.100.1.2 NAME 'textEncodedORAddress' 
 EQUALITY caseIgnoreMatch SUBSTR caseIgnoreSubstringsMatch SYNTAX 1.3.6.1.4.1.
 1466.115.121.1.15{256} )
olcAttributeTypes: {1}( 0.9.2342.19200300.100.1.4 NAME 'info' DESC 'RFC1274: g
 eneral information' EQUALITY caseIgnoreMatch SUBSTR caseIgnoreSubstringsMatch
  SYNTAX 1.3.6.1.4.1.1466.115.121.1.15{2048} )
olcAttributeTypes: {2}( 0.9.2342.19200300.100.1.5 NAME ( 'drink' 'favouriteDri
 nk' ) DESC 'RFC1274: favorite drink' EQUALITY caseIgnoreMatch SUBSTR caseIgno
 reSubstringsMatch SYNTAX 1.3.6.1.4.1.1466.115.121.1.15{256} )
olcAttributeTypes: {3}( 0.9.2342.19200300.100.1.6 NAME 'roomNumber' DESC 'RFC1
 274: room number' EQUALITY caseIgnoreMatch SUBSTR caseIgnoreSubstringsMatch S
 YNTAX 1.3.6.1.4.1.1466.115.121.1.15{256} )
olcAttributeTypes: {4}( 0.9.2342.19200300.100.1.7 NAME 'photo' DESC 'RFC1274: 
 photo (G3 fax)' SYNTAX 1.3.6.1.4.1.1466.115.121.1.23{25000} )
olcAttributeTypes: {5}( 0.9.2342.19200300.100.1.8 NAME 'userClass' DESC 'RFC12
 74: category of user' EQUALITY caseIgnoreMatch SUBSTR caseIgnoreSubstringsMat
 ch SYNTAX 1.3.6.1.4.1.1466.115.121.1.15{256} )
olcAttributeTypes: {6}( 0.9.2342.19200300.100.1.9 NAME 'host' DESC 'RFC1274: h
 ost computer' EQUALITY caseIgnoreMatch SUBSTR caseIgnoreSubstringsMatch SYNTA
 X 1.3.6.1.4.1.1466.115.121.1.15{256} )
olcAttributeTypes: {7}( 0.9.2342.19200300.100.1.10 NAME 'manager' DESC 'RFC127
 4: DN of manager' EQUALITY distinguishedNameMatch SYNTAX 1.3.6.1.4.1.1466.115
 .121.1.12 )
olcAttributeTypes: {8}( 0.9.2342.19200300.100.1.11 NAME 'documentIdentifier' D
 ESC 'RFC1274: unique identifier of document' EQUALITY caseIgnoreMatch SUBSTR 
 caseIgnoreSubstringsMatch SYNTAX 1.3.6.1.4.1.1466.115.121.1.15{256} )
olcAttributeTypes: {9}( 0.9.2342.19200300.100.1.12 NAME 'documentTitle' DESC '
 RFC1274: title of document' EQUALITY caseIgnoreMatch SUBSTR caseIgnoreSubstri
 ngsMatch SYNTAX 1.3.6.1.4.1.1466.115.121.1.15{256} )
olcAttributeTypes: {10}( 0.9.2342.19200300.100.1.13 NAME 'documentVersion' DES
 C 'RFC1274: version of document' EQUALITY caseIgnoreMatch SUBSTR caseIgnoreSu
 bstringsMatch SYNTAX 1.3.6.1.4.1.1466.115.121.1.15{256} )
olcAttributeTypes: {11}( 0.9.2342.19200300.100.1.14 NAME 'documentAuthor' DESC
  'RFC1274: DN of author of document' EQUALITY distinguishedNameMatch SYNTAX 1
 .3.6.1.4.1.1466.115.121.1.12 )
olcAttributeTypes: {12}( 0.9.2342.19200300.100.1.15 NAME 'documentLocation' DE
 SC 'RFC1274: location of document original' EQUALITY caseIgnoreMatch SUBSTR c
 aseIgnoreSubstringsMatch SYNTAX 1.3.6.1.4.1.1466.115.121.1.15{256} )
olcAttributeTypes: {13}( 0.9.2342.19200300.100.1.20 NAME ( 'homePhone' 'homeTe
 lephoneNumber' ) DESC 'RFC1274: home telephone number' EQUALITY telephoneNumb
 erMatch SUBSTR telephoneNumberSubstringsMatch SYNTAX 1.3.6.1.4.1.1466.115.121
 .1.50 )
olcAttributeTypes: {14}( 0.9.2342.19200300.100.1.21 NAME 'secretary' DESC 'RFC
 1274: DN of secretary' EQUALITY distinguishedNameMatch SYNTAX 1.3.6.1.4.1.146
 6.115.121.1.12 )
olcAttributeTypes: {15}( 0.9.2342.19200300.100.1.22 NAME 'otherMailbox' SYNTAX
  1.3.6.1.4.1.1466.115.121.1.39 )
olcAttributeTypes: {16}( 0.9.2342.19200300.100.1.26 NAME 'aRecord' EQUALITY ca
 seIgnoreIA5Match SYNTAX 1.3.6.1.4.1.1466.115.121.1.26 )
olcAttributeTypes: {17}( 0.9.2342.19200300.100.1.27 NAME 'mDRecord' EQUALITY c
 aseIgnoreIA5Match SYNTAX 1.3.6.1.4.1.1466.115.121.1.26 )
olcAttributeTypes: {18}( 0.9.2342.19200300.100.1.28 NAME 'mXRecord' EQUALITY c
 aseIgnoreIA5Match SYNTAX 1.3.6.1.4.1.1466.115.121.1.26 )
olcAttributeTypes: {19}( 0.9.2342.19200300.100.1.29 NAME 'nSRecord' EQUALITY c
 aseIgnoreIA5Match SYNTAX 1.3.6.1.4.1.1466.115.121.1.26 )
olcAttributeTypes: {20}( 0.9.2342.19200300.100.1.30 NAME 'sOARecord' EQUALITY 
 caseIgnoreIA5Match SYNTAX 1.3.6.1.4.1.1466.115.121.1.26 )
olcAttributeTypes: {21}( 0.9.2342.19200300.100.1.31 NAME 'cNAMERecord' EQUALIT
 Y caseIgnoreIA5Match SYNTAX 1.3.6.1.4.1.1466.115.121.1.26 )
olcAttributeTypes: {22}( 0.9.2342.19200300.100.1.38 NAME 'associatedName' DESC
  'RFC1274: DN of entry associated with domain' EQUALITY distinguishedNameMatc
 h SYNTAX 1.3.6.1.4.1.1466.115.121.1.12 )
olcAttributeTypes: {23}( 0.9.2342.19200300.100.1.39 NAME 'homePostalAddress' D
 ESC 'RFC1274: home postal address' EQUALITY caseIgnoreListMatch SUBSTR caseIg
 noreListSubstringsMatch SYNTAX 1.3.6.1.4.1.1466.115.121.1.41 )
olcAttributeTypes: {24}( 0.9.2342.19200300.100.1.40 NAME 'personalTitle' DESC 
 'RFC1274: personal title' EQUALITY caseIgnoreMatch SUBSTR caseIgnoreSubstring
 sMatch SYNTAX 1.3.6.1.4.1.1466.115.121.1.15{256} )
olcAttributeTypes: {25}( 0.9.2342.19200300.100.1.41 NAME ( 'mobile' 'mobileTel
 ephoneNumber' ) DESC 'RFC1274: mobile telephone number' EQUALITY telephoneNum
 berMatch SUBSTR telephoneNumberSubstringsMatch SYNTAX 1.3.6.1.4.1.1466.115.12
 1.1.50 )
olcAttributeTypes: {26}( 0.9.2342.19200300.100.1.42 NAME ( 'pager' 'pagerTelep
 honeNumber' ) DESC 'RFC1274: pager telephone number' EQUALITY telephoneNumber
 Match SUBSTR telephoneNumberSubstringsMatch SYNTAX 1.3.6.1.4.1.1466.115.121.1
 .50 )
olcAttributeTypes: {27}( 0.9.2342.19200300.100.1.43 NAME ( 'co' 'friendlyCount
 ryName' ) DESC 'RFC1274: friendly country name' EQUALITY caseIgnoreMatch SUBS
 TR caseIgnoreSubstringsMatch SYNTAX 1.3.6.1.4.1.1466.115.121.1.15 )
olcAttributeTypes: {28}( 0.9.2342.19200300.100.1.44 NAME 'uniqueIdentifier' DE
 SC 'RFC1274: unique identifer' EQUALITY caseIgnoreMatch SYNTAX 1.3.6.1.4.1.14
 66.115.121.1.15{256} )
olcAttributeTypes: {29}( 0.9.2342.19200300.100.1.45 NAME 'organizationalStatus
 ' DESC 'RFC1274: organizational status' EQUALITY caseIgnoreMatch SUBSTR caseI
 gnoreSubstringsMatch SYNTAX 1.3.6.1.4.1.1466.115.121.1.15{256} )
olcAttributeTypes: {30}( 0.9.2342.19200300.100.1.46 NAME 'janetMailbox' DESC '
 RFC1274: Janet mailbox' EQUALITY caseIgnoreIA5Match SUBSTR caseIgnoreIA5Subst
 ringsMatch SYNTAX 1.3.6.1.4.1.1466.115.121.1.26{256} )
olcAttributeTypes: {31}( 0.9.2342.19200300.100.1.47 NAME 'mailPreferenceOption
 ' DESC 'RFC1274: mail preference option' SYNTAX 1.3.6.1.4.1.1466.115.121.1.27
  )
olcAttributeTypes: {32}( 0.9.2342.19200300.100.1.48 NAME 'buildingName' DESC '
 RFC1274: name of building' EQUALITY caseIgnoreMatch SUBSTR caseIgnoreSubstrin
 gsMatch SYNTAX 1.3.6.1.4.1.1466.115.121.1.15{256} )
olcAttributeTypes: {33}( 0.9.2342.19200300.100.1.49 NAME 'dSAQuality' DESC 'RF
 C1274: DSA Quality' SYNTAX 1.3.6.1.4.1.1466.115.121.1.19 SINGLE-VALUE )
olcAttributeTypes: {34}( 0.9.2342.19200300.100.1.50 NAME 'singleLevelQuality' 
 DESC 'RFC1274: Single Level Quality' SYNTAX 1.3.6.1.4.1.1466.115.121.1.13 SIN
 GLE-VALUE )
olcAttributeTypes: {35}( 0.9.2342.19200300.100.1.51 NAME 'subtreeMinimumQualit
 y' DESC 'RFC1274: Subtree Mininum Quality' SYNTAX 1.3.6.1.4.1.1466.115.121.1.
 13 SINGLE-VALUE )
olcAttributeTypes: {36}( 0.9.2342.19200300.100.1.52 NAME 'subtreeMaximumQualit
 y' DESC 'RFC1274: Subtree Maximun Quality' SYNTAX 1.3.6.1.4.1.1466.115.121.1.
 13 SINGLE-VALUE )
olcAttributeTypes: {37}( 0.9.2342.19200300.100.1.53 NAME 'personalSignature' D
 ESC 'RFC1274: Personal Signature (G3 fax)' SYNTAX 1.3.6.1.4.1.1466.115.121.1.
 23 )
olcAttributeTypes: {38}( 0.9.2342.19200300.100.1.54 NAME 'dITRedirect' DESC 'R
 FC1274: DIT Redirect' EQUALITY distinguishedNameMatch SYNTAX 1.3.6.1.4.1.1466
 .115.121.1.12 )
olcAttributeTypes: {39}( 0.9.2342.19200300.100.1.55 NAME 'audio' DESC 'RFC1274
 : audio (u-law)' SYNTAX 1.3.6.1.4.1.1466.115.121.1.4{25000} )
olcAttributeTypes: {40}( 0.9.2342.19200300.100.1.56 NAME 'documentPublisher' D
 ESC 'RFC1274: publisher of document' EQUALITY caseIgnoreMatch SUBSTR caseIgno
 reSubstringsMatch SYNTAX 1.3.6.1.4.1.1466.115.121.1.15 )
olcObjectClasses: {0}( 0.9.2342.19200300.100.4.4 NAME ( 'pilotPerson' 'newPilo
 tPerson' ) SUP person STRUCTURAL MAY ( userid $ textEncodedORAddress $ rfc822
 Mailbox $ favouriteDrink $ roomNumber $ userClass $ homeTelephoneNumber $ hom
 ePostalAddress $ secretary $ personalTitle $ preferredDeliveryMethod $ busine
 ssCategory $ janetMailbox $ otherMailbox $ mobileTelephoneNumber $ pagerTelep
 honeNumber $ organizationalStatus $ mailPreferenceOption $ personalSignature 
 ) )
olcObjectClasses: {1}( 0.9.2342.19200300.100.4.5 NAME 'account' SUP top STRUCT
 URAL MUST userid MAY ( description $ seeAlso $ localityName $ organizationNam
 e $ organizationalUnitName $ host ) )
olcObjectClasses: {2}( 0.9.2342.19200300.100.4.6 NAME 'document' SUP top STRUC
 TURAL MUST documentIdentifier MAY ( commonName $ description $ seeAlso $ loca
 lityName $ organizationName $ organizationalUnitName $ documentTitle $ docume
 ntVersion $ documentAuthor $ documentLocation $ documentPublisher ) )
olcObjectClasses: {3}( 0.9.2342.19200300.100.4.7 NAME 'room' SUP top STRUCTURA
 L MUST commonName MAY ( roomNumber $ description $ seeAlso $ telephoneNumber 
 ) )
olcObjectClasses: {4}( 0.9.2342.19200300.100.4.9 NAME 'documentSeries' SUP top
  STRUCTURAL MUST commonName MAY ( description $ seeAlso $ telephonenumber $ l
 ocalityName $ organizationName $ organizationalUnitName ) )
olcObjectClasses: {5}( 0.9.2342.19200300.100.4.13 NAME 'domain' SUP top STRUCT
 URAL MUST domainComponent MAY ( associatedName $ organizationName $ descripti
 on $ businessCategory $ seeAlso $ searchGuide $ userPassword $ localityName $
  stateOrProvinceName $ streetAddress $ physicalDeliveryOfficeName $ postalAdd
 ress $ postalCode $ postOfficeBox $ streetAddress $ facsimileTelephoneNumber 
 $ internationalISDNNumber $ telephoneNumber $ teletexTerminalIdentifier $ tel
 exNumber $ preferredDeliveryMethod $ destinationIndicator $ registeredAddress
  $ x121Address ) )
olcObjectClasses: {6}( 0.9.2342.19200300.100.4.14 NAME 'RFC822localPart' SUP d
 omain STRUCTURAL MAY ( commonName $ surname $ description $ seeAlso $ telepho
 neNumber $ physicalDeliveryOfficeName $ postalAddress $ postalCode $ postOffi
 ceBox $ streetAddress $ facsimileTelephoneNumber $ internationalISDNNumber $ 
 telephoneNumber $ teletexTerminalIdentifier $ telexNumber $ preferredDelivery
 Method $ destinationIndicator $ registeredAddress $ x121Address ) )
olcObjectClasses: {7}( 0.9.2342.19200300.100.4.15 NAME 'dNSDomain' SUP domain 
 STRUCTURAL MAY ( ARecord $ MDRecord $ MXRecord $ NSRecord $ SOARecord $ CNAME
 Record ) )
olcObjectClasses: {8}( 0.9.2342.19200300.100.4.17 NAME 'domainRelatedObject' D
 ESC 'RFC1274: an object related to an domain' SUP top AUXILIARY MUST associat
 edDomain )
olcObjectClasses: {9}( 0.9.2342.19200300.100.4.18 NAME 'friendlyCountry' SUP c
 ountry STRUCTURAL MUST friendlyCountryName )
olcObjectClasses: {10}( 0.9.2342.19200300.100.4.20 NAME 'pilotOrganization' SU
 P ( organization $ organizationalUnit ) STRUCTURAL MAY buildingName )
olcObjectClasses: {11}( 0.9.2342.19200300.100.4.21 NAME 'pilotDSA' SUP dsa STR
 UCTURAL MAY dSAQuality )
olcObjectClasses: {12}( 0.9.2342.19200300.100.4.22 NAME 'qualityLabelledData' 
 SUP top AUXILIARY MUST dsaQuality MAY ( subtreeMinimumQuality $ subtreeMaximu
 mQuality ) )
structuralObjectClass: olcSchemaConfig
entryUUID: 31ea47c4-7875-1035-8d36-b7844b324fb9
creatorsName: cn=config
createTimestamp: 20160307055718Z
entryCSN: 20160307055718.460886Z#000000#000#000000
modifiersName: cn=config
modifyTimestamp: 20160307055718Z

dn: cn={2}nis,cn=schema,cn=config
objectClass: olcSchemaConfig
cn: {2}nis
olcAttributeTypes: {0}( 1.3.6.1.1.1.1.2 NAME 'gecos' DESC 'The GECOS field; th
 e common name' EQUALITY caseIgnoreIA5Match SUBSTR caseIgnoreIA5SubstringsMatc
 h SYNTAX 1.3.6.1.4.1.1466.115.121.1.26 SINGLE-VALUE )
olcAttributeTypes: {1}( 1.3.6.1.1.1.1.3 NAME 'homeDirectory' DESC 'The absolut
 e path to the home directory' EQUALITY caseExactIA5Match SYNTAX 1.3.6.1.4.1.1
 466.115.121.1.26 SINGLE-VALUE )
olcAttributeTypes: {2}( 1.3.6.1.1.1.1.4 NAME 'loginShell' DESC 'The path to th
 e login shell' EQUALITY caseExactIA5Match SYNTAX 1.3.6.1.4.1.1466.115.121.1.2
 6 SINGLE-VALUE )
olcAttributeTypes: {3}( 1.3.6.1.1.1.1.5 NAME 'shadowLastChange' EQUALITY integ
 erMatch SYNTAX 1.3.6.1.4.1.1466.115.121.1.27 SINGLE-VALUE )
olcAttributeTypes: {4}( 1.3.6.1.1.1.1.6 NAME 'shadowMin' EQUALITY integerMatch
  SYNTAX 1.3.6.1.4.1.1466.115.121.1.27 SINGLE-VALUE )
olcAttributeTypes: {5}( 1.3.6.1.1.1.1.7 NAME 'shadowMax' EQUALITY integerMatch
  SYNTAX 1.3.6.1.4.1.1466.115.121.1.27 SINGLE-VALUE )
olcAttributeTypes: {6}( 1.3.6.1.1.1.1.8 NAME 'shadowWarning' EQUALITY integerM
 atch SYNTAX 1.3.6.1.4.1.1466.115.121.1.27 SINGLE-VALUE )
olcAttributeTypes: {7}( 1.3.6.1.1.1.1.9 NAME 'shadowInactive' EQUALITY integer
 Match SYNTAX 1.3.6.1.4.1.1466.115.121.1.27 SINGLE-VALUE )
olcAttributeTypes: {8}( 1.3.6.1.1.1.1.10 NAME 'shadowExpire' EQUALITY integerM
 atch SYNTAX 1.3.6.1.4.1.1466.115.121.1.27 SINGLE-VALUE )
olcAttributeTypes: {9}( 1.3.6.1.1.1.1.11 NAME 'shadowFlag' EQUALITY integerMat
 ch SYNTAX 1.3.6.1.4.1.1466.115.121.1.27 SINGLE-VALUE )
olcAttributeTypes: {10}( 1.3.6.1.1.1.1.12 NAME 'memberUid' EQUALITY caseExactI
 A5Match SUBSTR caseExactIA5SubstringsMatch SYNTAX 1.3.6.1.4.1.1466.115.121.1.
 26 )
olcAttributeTypes: {11}( 1.3.6.1.1.1.1.13 NAME 'memberNisNetgroup' EQUALITY ca
 seExactIA5Match SUBSTR caseExactIA5SubstringsMatch SYNTAX 1.3.6.1.4.1.1466.11
 5.121.1.26 )
olcAttributeTypes: {12}( 1.3.6.1.1.1.1.14 NAME 'nisNetgroupTriple' DESC 'Netgr
 oup triple' SYNTAX 1.3.6.1.1.1.0.0 )
olcAttributeTypes: {13}( 1.3.6.1.1.1.1.15 NAME 'ipServicePort' EQUALITY intege
 rMatch SYNTAX 1.3.6.1.4.1.1466.115.121.1.27 SINGLE-VALUE )
olcAttributeTypes: {14}( 1.3.6.1.1.1.1.16 NAME 'ipServiceProtocol' SUP name )
olcAttributeTypes: {15}( 1.3.6.1.1.1.1.17 NAME 'ipProtocolNumber' EQUALITY int
 egerMatch SYNTAX 1.3.6.1.4.1.1466.115.121.1.27 SINGLE-VALUE )
olcAttributeTypes: {16}( 1.3.6.1.1.1.1.18 NAME 'oncRpcNumber' EQUALITY integer
 Match SYNTAX 1.3.6.1.4.1.1466.115.121.1.27 SINGLE-VALUE )
olcAttributeTypes: {17}( 1.3.6.1.1.1.1.19 NAME 'ipHostNumber' DESC 'IP address
 ' EQUALITY caseIgnoreIA5Match SYNTAX 1.3.6.1.4.1.1466.115.121.1.26{128} )
olcAttributeTypes: {18}( 1.3.6.1.1.1.1.20 NAME 'ipNetworkNumber' DESC 'IP netw
 ork' EQUALITY caseIgnoreIA5Match SYNTAX 1.3.6.1.4.1.1466.115.121.1.26{128} SI
 NGLE-VALUE )
olcAttributeTypes: {19}( 1.3.6.1.1.1.1.21 NAME 'ipNetmaskNumber' DESC 'IP netm
 ask' EQUALITY caseIgnoreIA5Match SYNTAX 1.3.6.1.4.1.1466.115.121.1.26{128} SI
 NGLE-VALUE )
olcAttributeTypes: {20}( 1.3.6.1.1.1.1.22 NAME 'macAddress' DESC 'MAC address'
  EQUALITY caseIgnoreIA5Match SYNTAX 1.3.6.1.4.1.1466.115.121.1.26{128} )
olcAttributeTypes: {21}( 1.3.6.1.1.1.1.23 NAME 'bootParameter' DESC 'rpc.bootp
 aramd parameter' SYNTAX 1.3.6.1.1.1.0.1 )
olcAttributeTypes: {22}( 1.3.6.1.1.1.1.24 NAME 'bootFile' DESC 'Boot image nam
 e' EQUALITY caseExactIA5Match SYNTAX 1.3.6.1.4.1.1466.115.121.1.26 )
olcAttributeTypes: {23}( 1.3.6.1.1.1.1.26 NAME 'nisMapName' SUP name )
olcAttributeTypes: {24}( 1.3.6.1.1.1.1.27 NAME 'nisMapEntry' EQUALITY caseExac
 tIA5Match SUBSTR caseExactIA5SubstringsMatch SYNTAX 1.3.6.1.4.1.1466.115.121.
 1.26{1024} SINGLE-VALUE )
olcObjectClasses: {0}( 1.3.6.1.1.1.2.0 NAME 'posixAccount' DESC 'Abstraction o
 f an account with POSIX attributes' SUP top AUXILIARY MUST ( cn $ uid $ uidNu
 mber $ gidNumber $ homeDirectory ) MAY ( userPassword $ loginShell $ gecos $ 
 description ) )
olcObjectClasses: {1}( 1.3.6.1.1.1.2.1 NAME 'shadowAccount' DESC 'Additional a
 ttributes for shadow passwords' SUP top AUXILIARY MUST uid MAY ( userPassword
  $ shadowLastChange $ shadowMin $ shadowMax $ shadowWarning $ shadowInactive 
 $ shadowExpire $ shadowFlag $ description ) )
olcObjectClasses: {2}( 1.3.6.1.1.1.2.2 NAME 'posixGroup' DESC 'Abstraction of 
 a group of accounts' SUP top STRUCTURAL MUST ( cn $ gidNumber ) MAY ( userPas
 sword $ memberUid $ description ) )
olcObjectClasses: {3}( 1.3.6.1.1.1.2.3 NAME 'ipService' DESC 'Abstraction an I
 nternet Protocol service' SUP top STRUCTURAL MUST ( cn $ ipServicePort $ ipSe
 rviceProtocol ) MAY description )
olcObjectClasses: {4}( 1.3.6.1.1.1.2.4 NAME 'ipProtocol' DESC 'Abstraction of 
 an IP protocol' SUP top STRUCTURAL MUST ( cn $ ipProtocolNumber $ description
  ) MAY description )
olcObjectClasses: {5}( 1.3.6.1.1.1.2.5 NAME 'oncRpc' DESC 'Abstraction of an O
 NC/RPC binding' SUP top STRUCTURAL MUST ( cn $ oncRpcNumber $ description ) M
 AY description )
olcObjectClasses: {6}( 1.3.6.1.1.1.2.6 NAME 'ipHost' DESC 'Abstraction of a ho
 st, an IP device' SUP top AUXILIARY MUST ( cn $ ipHostNumber ) MAY ( l $ desc
 ription $ manager ) )
olcObjectClasses: {7}( 1.3.6.1.1.1.2.7 NAME 'ipNetwork' DESC 'Abstraction of a
 n IP network' SUP top STRUCTURAL MUST ( cn $ ipNetworkNumber ) MAY ( ipNetmas
 kNumber $ l $ description $ manager ) )
olcObjectClasses: {8}( 1.3.6.1.1.1.2.8 NAME 'nisNetgroup' DESC 'Abstraction of
  a netgroup' SUP top STRUCTURAL MUST cn MAY ( nisNetgroupTriple $ memberNisNe
 tgroup $ description ) )
olcObjectClasses: {9}( 1.3.6.1.1.1.2.9 NAME 'nisMap' DESC 'A generic abstracti
 on of a NIS map' SUP top STRUCTURAL MUST nisMapName MAY description )
olcObjectClasses: {10}( 1.3.6.1.1.1.2.10 NAME 'nisObject' DESC 'An entry in a 
 NIS map' SUP top STRUCTURAL MUST ( cn $ nisMapEntry $ nisMapName ) MAY descri
 ption )
olcObjectClasses: {11}( 1.3.6.1.1.1.2.11 NAME 'ieee802Device' DESC 'A device w
 ith a MAC address' SUP top AUXILIARY MAY macAddress )
olcObjectClasses: {12}( 1.3.6.1.1.1.2.12 NAME 'bootableDevice' DESC 'A device 
 with boot parameters' SUP top AUXILIARY MAY ( bootFile $ bootParameter ) )
structuralObjectClass: olcSchemaConfig
entryUUID: 31ea607e-7875-1035-8d37-b7844b324fb9
creatorsName: cn=config
createTimestamp: 20160307055718Z
entryCSN: 20160307055718.461519Z#000000#000#000000
modifiersName: cn=config
modifyTimestamp: 20160307055718Z

dn: cn={3}inetorgperson,cn=schema,cn=config
objectClass: olcSchemaConfig
cn: {3}inetorgperson
olcAttributeTypes: {0}( 2.16.840.1.113730.3.1.1 NAME 'carLicense' DESC 'RFC279
 8: vehicle license or registration plate' EQUALITY caseIgnoreMatch SUBSTR cas
 eIgnoreSubstringsMatch SYNTAX 1.3.6.1.4.1.1466.115.121.1.15 )
olcAttributeTypes: {1}( 2.16.840.1.113730.3.1.2 NAME 'departmentNumber' DESC '
 RFC2798: identifies a department within an organization' EQUALITY caseIgnoreM
 atch SUBSTR caseIgnoreSubstringsMatch SYNTAX 1.3.6.1.4.1.1466.115.121.1.15 )
olcAttributeTypes: {2}( 2.16.840.1.113730.3.1.241 NAME 'displayName' DESC 'RFC
 2798: preferred name to be used when displaying entries' EQUALITY caseIgnoreM
 atch SUBSTR caseIgnoreSubstringsMatch SYNTAX 1.3.6.1.4.1.1466.115.121.1.15 SI
 NGLE-VALUE )
olcAttributeTypes: {3}( 2.16.840.1.113730.3.1.3 NAME 'employeeNumber' DESC 'RF
 C2798: numerically identifies an employee within an organization' EQUALITY ca
 seIgnoreMatch SUBSTR caseIgnoreSubstringsMatch SYNTAX 1.3.6.1.4.1.1466.115.12
 1.1.15 SINGLE-VALUE )
olcAttributeTypes: {4}( 2.16.840.1.113730.3.1.4 NAME 'employeeType' DESC 'RFC2
 798: type of employment for a person' EQUALITY caseIgnoreMatch SUBSTR caseIgn
 oreSubstringsMatch SYNTAX 1.3.6.1.4.1.1466.115.121.1.15 )
olcAttributeTypes: {5}( 0.9.2342.19200300.100.1.60 NAME 'jpegPhoto' DESC 'RFC2
 798: a JPEG image' SYNTAX 1.3.6.1.4.1.1466.115.121.1.28 )
olcAttributeTypes: {6}( 2.16.840.1.113730.3.1.39 NAME 'preferredLanguage' DESC
  'RFC2798: preferred written or spoken language for a person' EQUALITY caseIg
 noreMatch SUBSTR caseIgnoreSubstringsMatch SYNTAX 1.3.6.1.4.1.1466.115.121.1.
 15 SINGLE-VALUE )
olcAttributeTypes: {7}( 2.16.840.1.113730.3.1.40 NAME 'userSMIMECertificate' D
 ESC 'RFC2798: PKCS#7 SignedData used to support S/MIME' SYNTAX 1.3.6.1.4.1.14
 66.115.121.1.5 )
olcAttributeTypes: {8}( 2.16.840.1.113730.3.1.216 NAME 'userPKCS12' DESC 'RFC2
 798: personal identity information, a PKCS #12 PFX' SYNTAX 1.3.6.1.4.1.1466.1
 15.121.1.5 )
olcObjectClasses: {0}( 2.16.840.1.113730.3.2.2 NAME 'inetOrgPerson' DESC 'RFC2
 798: Internet Organizational Person' SUP organizationalPerson STRUCTURAL MAY 
 ( audio $ businessCategory $ carLicense $ departmentNumber $ displayName $ em
 ployeeNumber $ employeeType $ givenName $ homePhone $ homePostalAddress $ ini
 tials $ jpegPhoto $ labeledURI $ mail $ manager $ mobile $ o $ pager $ photo 
 $ roomNumber $ secretary $ uid $ userCertificate $ x500uniqueIdentifier $ pre
 ferredLanguage $ userSMIMECertificate $ userPKCS12 ) )
structuralObjectClass: olcSchemaConfig
entryUUID: 31ea703c-7875-1035-8d38-b7844b324fb9
creatorsName: cn=config
createTimestamp: 20160307055718Z
entryCSN: 20160307055718.461923Z#000000#000#000000
modifiersName: cn=config
modifyTimestamp: 20160307055718Z

dn: olcBackend={0}hdb,cn=config
objectClass: olcBackendConfig
olcBackend: {0}hdb
structuralObjectClass: olcBackendConfig
entryUUID: 31ea87ca-7875-1035-8d3a-b7844b324fb9
creatorsName: cn=config
createTimestamp: 20160307055718Z
entryCSN: 20160307055718.462526Z#000000#000#000000
modifiersName: cn=config
modifyTimestamp: 20160307055718Z

dn: olcDatabase={-1}frontend,cn=config
objectClass: olcDatabaseConfig
objectClass: olcFrontendConfig
olcDatabase: {-1}frontend
olcAccess: {0}to * by dn.exact=gidNumber=0+uidNumber=0,cn=peercred,cn=external
 ,cn=auth manage by * break
olcAccess: {1}to dn.exact="" by * read
olcAccess: {2}to dn.base="cn=Subschema" by * read
olcSizeLimit: 500
structuralObjectClass: olcDatabaseConfig
entryUUID: 31ea0dcc-7875-1035-8d32-b7844b324fb9
creatorsName: cn=config
createTimestamp: 20160307055718Z
entryCSN: 20160307055718.459403Z#000000#000#000000
modifiersName: cn=config
modifyTimestamp: 20160307055718Z

dn: olcDatabase={0}config,cn=config
objectClass: olcDatabaseConfig
olcDatabase: {0}config
olcAccess: {0}to * by dn.exact=gidNumber=0+uidNumber=0,cn=peercred,cn=external
 ,cn=auth manage by * break
structuralObjectClass: olcDatabaseConfig
entryUUID: 31ea139e-7875-1035-8d33-b7844b324fb9
creatorsName: cn=config
createTimestamp: 20160307055718Z
entryCSN: 20160307055718.459551Z#000000#000#000000
modifiersName: cn=config
modifyTimestamp: 20160307055718Z

dn: olcDatabase={1}hdb,cn=config
objectClass: olcDatabaseConfig
objectClass: olcHdbConfig
olcDatabase: {1}hdb
olcDbDirectory: /var/lib/ldap
olcSuffix: dc=test,dc=com
olcAccess: {0}to attrs=userPassword,shadowLastChange by self write by anonymou
 s auth by dn="cn=admin,dc=test,dc=com" write by * none
olcAccess: {1}to dn.base="" by * read
olcAccess: {2}to * by dn="cn=admin,dc=test,dc=com" write by * read
olcLastMod: TRUE
olcRootDN: cn=admin,dc=test,dc=com
olcRootPW:: e1NTSEF9SDlQZjROcGRTU0FHZGkzcFM2NmNYVUpXSVNRMmVKYmg=
olcDbCheckpoint: 512 30
olcDbConfig: {0}set_cachesize 0 2097152 0
olcDbConfig: {1}set_lk_max_objects 1500
olcDbConfig: {2}set_lk_max_locks 1500
olcDbConfig: {3}set_lk_max_lockers 1500
olcDbIndex: objectClass eq
structuralObjectClass: olcHdbConfig
entryUUID: 31ea8b58-7875-1035-8d3b-b7844b324fb9
creatorsName: cn=config
createTimestamp: 20160307055718Z
entryCSN: 20160307055718.462617Z#000000#000#000000
modifiersName: cn=config
modifyTimestamp: 20160307055718Z
EOL

# =============================================================================
# ldap data
# =============================================================================
cat >/tmp/data.ldif <<EOL
dn: dc=test,dc=com
objectClass: top
objectClass: dcObject
objectClass: organization
o: example
dc: test
structuralObjectClass: organization
entryUUID: 31fb3624-7875-1035-9130-41a6a6c2ae23
creatorsName: cn=admin,dc=test,dc=com
createTimestamp: 20160307055718Z
entryCSN: 20160307055718.571844Z#000000#000#000000
modifiersName: cn=admin,dc=test,dc=com
modifyTimestamp: 20160307055718Z

dn: cn=admin,dc=test,dc=com
objectClass: simpleSecurityObject
objectClass: organizationalRole
cn: admin
description: LDAP administrator
userPassword:: e1NTSEF9SDlQZjROcGRTU0FHZGkzcFM2NmNYVUpXSVNRMmVKYmg=
structuralObjectClass: organizationalRole
entryUUID: 31fd02ba-7875-1035-9131-41a6a6c2ae23
creatorsName: cn=admin,dc=test,dc=com
createTimestamp: 20160307055718Z
entryCSN: 20160307055718.583637Z#000000#000#000000
modifiersName: cn=admin,dc=test,dc=com
modifyTimestamp: 20160307055718Z

dn: ou=engineering,dc=test,dc=com
objectClass: organizationalUnit
objectClass: top
ou: engineering
structuralObjectClass: organizationalUnit
entryUUID: 2bc331de-78fd-1035-92be-89673b32bdfa
creatorsName: cn=admin,dc=test,dc=com
createTimestamp: 20160307221039Z
entryCSN: 20160307221039.693628Z#000000#000#000000
modifiersName: cn=admin,dc=test,dc=com
modifyTimestamp: 20160307221039Z

dn: cn=web,ou=engineering,dc=test,dc=com
gidNumber: 500
cn: web
objectClass: posixGroup
objectClass: top
structuralObjectClass: posixGroup
entryUUID: 902179ec-78fd-1035-92c2-89673b32bdfa
creatorsName: cn=admin,dc=test,dc=com
createTimestamp: 20160307221328Z
entryCSN: 20160307221328.083671Z#000000#000#000000
modifiersName: cn=admin,dc=test,dc=com
modifyTimestamp: 20160307221328Z

dn: cn=database,ou=engineering,dc=test,dc=com
gidNumber: 501
cn: database
objectClass: posixGroup
objectClass: top
structuralObjectClass: posixGroup
entryUUID: 9fff019a-78fd-1035-92c3-89673b32bdfa
creatorsName: cn=admin,dc=test,dc=com
createTimestamp: 20160307221354Z
entryCSN: 20160307221354.701314Z#000000#000#000000
modifiersName: cn=admin,dc=test,dc=com
modifyTimestamp: 20160307221354Z

dn: cn=infrastructure,ou=engineering,dc=test,dc=com
gidNumber: 502
cn: infrastructure
objectClass: posixGroup
objectClass: top
structuralObjectClass: posixGroup
entryUUID: a9403bb6-78fd-1035-92c4-89673b32bdfa
creatorsName: cn=admin,dc=test,dc=com
createTimestamp: 20160307221410Z
entryCSN: 20160307221410.228280Z#000000#000#000000
modifiersName: cn=admin,dc=test,dc=com
modifyTimestamp: 20160307221410Z

dn: ou=all users,dc=test,dc=com
objectClass: organizationalUnit
objectClass: top
ou: all users
structuralObjectClass: organizationalUnit
entryUUID: b12d710e-78fd-1035-92c5-89673b32bdfa
creatorsName: cn=admin,dc=test,dc=com
createTimestamp: 20160307221423Z
entryCSN: 20160307221423.526900Z#000000#000#000000
modifiersName: cn=admin,dc=test,dc=com
modifyTimestamp: 20160307221423Z

dn: cn=Jennifer Lawrence,ou=all users,dc=test,dc=com
gidNumber: 500
loginShell: /bin/sh
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: top
userPassword:: e01ENX1YMDNNTzFxblpkWWRneWZldUlMUG1RPT0=
uidNumber: 1000
structuralObjectClass: inetOrgPerson
entryUUID: cc16e612-78fd-1035-92c6-89673b32bdfa
creatorsName: cn=admin,dc=test,dc=com
createTimestamp: 20160307221508Z
cn: Jennifer Lawrence
givenName: Jennifer
homeDirectory: /home/users/jlaw
sn: Lawrence
uid: jlaw
entryCSN: 20160316070333.598525Z#000000#000#000000
modifiersName: cn=admin,dc=test,dc=com
modifyTimestamp: 20160316070333Z

dn: cn=Leonardo Dicaprio,ou=all users,dc=test,dc=com
gidNumber: 502
loginShell: /bin/sh
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: top
userPassword:: e01ENX1YMDNNTzFxblpkWWRneWZldUlMUG1RPT0=
uidNumber: 1001
structuralObjectClass: inetOrgPerson
entryUUID: e7c35ab2-78fd-1035-92c7-89673b32bdfa
creatorsName: cn=admin,dc=test,dc=com
createTimestamp: 20160307221555Z
cn: Leonardo Dicaprio
uid: leodicaprio
givenName: Leonardo
homeDirectory: /home/users/leodicaprio
sn: Dicaprio
entryCSN: 20160316070034.566242Z#000000#000#000000
modifiersName: cn=admin,dc=test,dc=com
modifyTimestamp: 20160316070034Z

dn: cn=Taylor Swift,ou=all users,dc=test,dc=com
gidNumber: 501
loginShell: /bin/sh
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: top
userPassword:: e01ENX1YMDNNTzFxblpkWWRneWZldUlMUG1RPT0=
uidNumber: 1002
structuralObjectClass: inetOrgPerson
entryUUID: 20063a8e-78fe-1035-92c8-89673b32bdfa
creatorsName: cn=admin,dc=test,dc=com
createTimestamp: 20160307221729Z
cn: Taylor Swift
givenName: Taylor
homeDirectory: /home/users/tswift
sn: Swift
uid: tswift
entryCSN: 20160316070119.452042Z#000000#000#000000
modifiersName: cn=admin,dc=test,dc=com
modifyTimestamp: 20160316070119Z

dn: ou=HR,dc=test,dc=com
objectClass: organizationalUnit
objectClass: top
ou: HR
structuralObjectClass: organizationalUnit
entryUUID: 4f8ba1f4-78fe-1035-92c9-89673b32bdfa
creatorsName: cn=admin,dc=test,dc=com
createTimestamp: 20160307221849Z
entryCSN: 20160307221849.224203Z#000000#000#000000
modifiersName: cn=admin,dc=test,dc=com
modifyTimestamp: 20160307221849Z

dn: cn=firing people team,ou=HR,dc=test,dc=com
gidNumber: 503
cn: firing people team
objectClass: posixGroup
objectClass: top
structuralObjectClass: posixGroup
entryUUID: 6e095c7a-78fe-1035-92ca-89673b32bdfa
creatorsName: cn=admin,dc=test,dc=com
createTimestamp: 20160307221940Z
entryCSN: 20160307221940.379825Z#000000#000#000000
modifiersName: cn=admin,dc=test,dc=com
modifyTimestamp: 20160307221940Z

dn: cn=Harrison Ford,ou=all users,dc=test,dc=com
loginShell: /bin/sh
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: top
userPassword:: e01ENX1YMDNNTzFxblpkWWRneWZldUlMUG1RPT0=
uidNumber: 1003
structuralObjectClass: inetOrgPerson
entryUUID: 84dfc984-78fe-1035-92cb-89673b32bdfa
creatorsName: cn=admin,dc=test,dc=com
createTimestamp: 20160307222018Z
cn: Harrison Ford
givenName: Harrison
homeDirectory: /home/users/hford
sn: Ford
uid: hford
gidNumber: 502
entryCSN: 20160318061821.698519Z#000000#000#000000
modifiersName: cn=admin,dc=test,dc=com
modifyTimestamp: 20160318061821Z

dn: cn=Chuck Norris,ou=all users,dc=test,dc=com
cn: Chuck Norris
givenName: Chuck
gidNumber: 502
homeDirectory: /home/users/cnorris
sn: Norris
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: top
userPassword:: e01ENX1YMDNNTzFxblpkWWRneWZldUlMUG1RPT0=
uidNumber: 1004
uid: cnorris
structuralObjectClass: inetOrgPerson
entryUUID: c35212fc-7f8a-1035-92cc-89673b32bdfa
creatorsName: cn=admin,dc=test,dc=com
createTimestamp: 20160316061919Z
entryCSN: 20160316061919.981504Z#000000#000#000000
modifiersName: cn=admin,dc=test,dc=com
modifyTimestamp: 20160316061919Z

dn: cn=Ellen Page,ou=all users,dc=test,dc=com
cn: Ellen Page
givenName: Ellen
gidNumber: 500
homeDirectory: /home/users/epage
sn: Page
loginShell: /bin/sh
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: top
userPassword:: e01ENX1YMDNNTzFxblpkWWRneWZldUlMUG1RPT0=
uidNumber: 1005
uid: epage
structuralObjectClass: inetOrgPerson
entryUUID: cef1438c-811d-1035-92cd-89673b32bdfa
creatorsName: cn=admin,dc=test,dc=com
createTimestamp: 20160318062426Z
entryCSN: 20160318062426.661736Z#000000#000#000000
modifiersName: cn=admin,dc=test,dc=com
modifyTimestamp: 20160318062426Z
EOL