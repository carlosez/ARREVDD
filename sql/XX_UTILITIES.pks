CREATE OR REPLACE PACKAGE BOLINF.XX_UTILITIES AUTHID CURRENT_USER

/*



 +=====================================================================================+

 Purpose: This package contains usefull functions that can be acces by multiple

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





/*Numero a Texto*/

FUNCTION Numero_a_Texto ( Imp Number, idioma varchar2 ) RETURN VarChar2;


/*Limpiar muchos caracteres para dejar solo numeros*/

function CLEAR_TEXT (P_TEXTO  VARCHAR2) RETURN VARCHAR2 ;

/*////////////////////////////////////////////////////////////////

       The following Functions were added on version 1.1

////////////////////////////////////////////////////////////////*/


/*Clear all characters exception numbers*/

function clr_txt_to_num (pin_string  VARCHAR2) RETURN VARCHAR2 ;

/* Clear text only left Leters*/

function clr_txt_only_ltr (pin_string  VARCHAR2) RETURN VARCHAR2 ;

function sub_lat_chr (pin_string  VARCHAR2) RETURN VARCHAR2 ;

FUNCTION sub_lat_chr_only_ltr (Pin_string  VARCHAR2) RETURN VARCHAR2;

function FLEX_VALUE_DESCRIPTION ( p_FLEX_VALUE_SET_NAME varchar, p_FLEX_VALUE varchar, p_language varchar2 default 'US' ) return varchar2;

function LOOKUP_MEANING ( p_LOOKUP_TYPE varchar, p_LOOKUP_CODE varchar, p_language varchar2 default 'US' ) return varchar2;


END XX_UTILITies;

/***************************************************
 Functions Addes in 1.2
****************************************************/
/
