CREATE OR REPLACE PACKAGE BOLINF.XXSV_AR_REV_UTL AUTHID CURRENT_USER

/*



 +=====================================================================================+

 Purpose: This package contains usefull functions for Revenuew Drilldown

           concurrent programs

 Modification Log:
 Developer              Date            Description
 -------------------    ------------    ---------------------------------------------
 Carlos Torres          30-Abr-2013     1.0 - Initial Version
 Carlos Torres          03-Jun-2013     1.1 - Added Some new functions
 Carlos Torres          06-Oct-2014     1.2 - Added Value Set Description
 +=====================================================================================+

*/

IS

function sub_lat_chr (pin_string  VARCHAR2) RETURN VARCHAR2 ;

function FLEX_VALUE_DESCRIPTION ( p_FLEX_VALUE_SET_NAME varchar, p_FLEX_VALUE varchar, p_language varchar2 default 'US' ) return varchar2;

function FLEX_VALUE_DESC_ASCII ( p_FLEX_VALUE_SET_NAME varchar, p_FLEX_VALUE varchar, p_language varchar2 default 'US' ) return varchar2;

function LOOKUP_MEANING ( p_LOOKUP_TYPE varchar, p_LOOKUP_CODE varchar, p_language varchar2 default 'US' ) return varchar2;


END;
/
exit
/