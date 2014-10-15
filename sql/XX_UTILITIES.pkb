CREATE OR REPLACE PACKAGE BODY BOLINF.XX_UTILITIES AS

cursor  FLEX_VALUE_DESCRIPTION_DATA( p_FLEX_VALUE_SET_NAME varchar, p_FLEX_VALUE varchar, p_language varchar) is
 select FLEX_VALUE_SET_NAME, FV1.FLEX_VALUE, FVT1.DESCRIPTION
   from APPS.FND_FLEX_VALUE_SETS FVS1
       ,APPS.FND_FLEX_VALUES FV1
       ,APPS.FND_FLEX_VALUES_TL FVT1
   where FVS1.FLEX_VALUE_SET_NAME = p_FLEX_VALUE_SET_NAME --'XX_INV_MIC_SEGMENT_VALUES_VS'
     AND FVS1.FLEX_VALUE_SET_ID = FV1.FLEX_VALUE_SET_ID
     AND FV1.FLEX_VALUE_ID = FVT1.FLEX_VALUE_ID
     AND FVT1.LANGUAGE = p_language 
     and FV1.FLEX_VALUE = p_FLEX_VALUE
     ;

cursor  LOOKUP_DESCRIPTION_DATA( p_LOOKUP_TYPE varchar, p_LOOKUP_CODE varchar, p_language varchar) is
 select LOOKUP_TYPE, LOOKUP_CODE, MEANING ,DESCRIPTION
     from   FND_LOOKUP_VALUES
     where LANGUAGE = p_language
     and LOOKUP_CODE = p_LOOKUP_CODE
     and LOOKUP_TYPE  = p_LOOKUP_TYPE
     ;


FUNCTION CLEAR_TEXT (P_TEXTO  VARCHAR2) RETURN VARCHAR2  IS

  V_TEXTO  VARCHAR2(5000 BYTE);

BEGIN

  V_TEXTO := REPLACE (V_TEXTO, CHR(1), NULL);

  V_TEXTO := REPLACE (V_TEXTO, CHR(2), NULL);

  V_TEXTO := REPLACE (V_TEXTO, CHR(3), NULL);

  V_TEXTO := REPLACE (V_TEXTO, CHR(4), NULL);

  V_TEXTO := REPLACE (V_TEXTO, CHR(5), NULL);

  V_TEXTO := REPLACE (V_TEXTO, CHR(6), NULL);

  V_TEXTO := REPLACE (V_TEXTO, CHR(7), NULL);

  V_TEXTO := REPLACE (V_TEXTO, CHR(8), NULL);

  V_TEXTO := REPLACE (V_TEXTO, CHR(9), NULL);

  V_TEXTO := REPLACE (V_TEXTO, CHR(10), NULL);

  V_TEXTO := REPLACE (V_TEXTO, CHR(11), NULL);

  V_TEXTO := REPLACE (V_TEXTO, CHR(12), NULL);

  V_TEXTO := REPLACE (V_TEXTO, CHR(13), NULL);

  V_TEXTO := REPLACE (V_TEXTO, CHR(14), NULL);

  V_TEXTO := REPLACE (V_TEXTO, CHR(15), NULL);

  V_TEXTO := REPLACE (V_TEXTO, CHR(16), NULL);

  V_TEXTO := REPLACE (V_TEXTO, CHR(17), NULL);

  V_TEXTO := REPLACE (V_TEXTO, CHR(18), NULL);

  V_TEXTO := REPLACE (V_TEXTO, CHR(19), NULL);

  V_TEXTO := REPLACE (V_TEXTO, CHR(20), NULL);

  V_TEXTO := REPLACE (V_TEXTO, CHR(21), NULL);

  V_TEXTO := REPLACE (V_TEXTO, CHR(22), NULL);

  V_TEXTO := REPLACE (V_TEXTO, CHR(23), NULL);

  V_TEXTO := REPLACE (V_TEXTO, CHR(24), NULL);

  V_TEXTO := REPLACE (V_TEXTO, CHR(25), NULL);

  V_TEXTO := REPLACE (V_TEXTO, CHR(26), NULL);

  V_TEXTO := REPLACE (V_TEXTO, CHR(27), NULL);

  V_TEXTO := REPLACE (V_TEXTO, CHR(28), NULL);

  V_TEXTO := REPLACE (V_TEXTO, CHR(29), NULL);

  V_TEXTO := REPLACE (V_TEXTO, CHR(30), NULL);

  V_TEXTO := REPLACE (V_TEXTO, CHR(31), NULL);

  V_TEXTO := REPLACE (V_TEXTO, CHR(199), NULL);

  V_TEXTO := REPLACE (V_TEXTO, CHR(127), NULL);

  V_TEXTO := REPLACE (V_TEXTO, CHR(160), NULL);

  V_TEXTO := REPLACE (V_TEXTO, CHR(208), NULL);

--  V_TEXTO := TRIM(V_TEXTO);

  V_TEXTO := REPLACE (V_TEXTO, '"');

  V_TEXTO := REPLACE (V_TEXTO, CHR(9), NULL);    -- ESPACIO

  V_TEXTO := REPLACE (V_TEXTO, CHR(10), NULL);   -- SALTO DE LINEA

  V_TEXTO := REPLACE (V_TEXTO, CHR(13), NULL);   -- SALTO DE LINEA

  V_TEXTO := REPLACE (V_TEXTO, CHR(36), NULL);   -- SIMBOLO DE DOLAR

  V_TEXTO := REPLACE (V_TEXTO, CHR(59), NULL);   -- PUNTO Y COMA

  V_TEXTO := REPLACE (V_TEXTO, CHR(199), NULL);  -- SALTO DE LINEA

  V_TEXTO := REPLACE (V_TEXTO, CHR(15712189), NULL); --CARACTER ESPECIAL

  V_TEXTO := LTRIM (RTRIM (V_TEXTO));

  --

  RETURN V_TEXTO;

END CLEAR_TEXT;



FUNCTION clr_txt_to_num (pin_string  VARCHAR2) RETURN VARCHAR2  IS

  V_TEXTO  VARCHAR2(5000 BYTE);

  v_char VARCHAR2(1 );

  v_length number;

BEGIN

     v_length := length(pin_string);

     V_TEXTO := '';

    IF v_length > 0 THEN

        for j in 0..v_length loop



            v_char := SUBSTRC(pin_string,j,1);



            if  ascii(v_char) between 48 and 57 then

              V_TEXTO := V_TEXTO || v_char;

            end if;



        end loop;

    END IF;



  RETURN V_TEXTO;



END clr_txt_to_num;



FUNCTION clr_txt_only_ltr (pin_string  VARCHAR2) RETURN VARCHAR2  IS

  V_TEXTO  VARCHAR2(4000);

  v_char VARCHAR2(2);

  v_length number;

BEGIN

     v_length := length(pin_string);

     V_TEXTO := '';



    for j in 0..v_length loop



        v_char := SUBSTRC(pin_string,j,1);



        if  (ascii(v_char) between 65 and 90) OR  (ascii(v_char) between 97 and 122) then

          V_TEXTO := V_TEXTO || v_char;

        end if;



    end loop;



  RETURN V_TEXTO;



END clr_txt_only_ltr;







FUNCTION sub_lat_chr (Pin_string  VARCHAR2) RETURN VARCHAR2  IS

    pout_string  VARCHAR2(4000);

    special_chr varchar2 (150);

    replace_chr varchar2 (150);



BEGIN



    special_chr := chr(50048)||chr(50049)||chr(50050)||chr(50051)||chr(50052)||chr(50056)||chr(50057)||chr(50058)||chr(50059)||chr(50060)||chr(50061)||chr(50062)||chr(50063)||chr(50065)||chr(50066)||chr(50067)||chr(50068)||chr(50069)||chr(50070)||chr(50073)||chr(50074)||chr(50075)||chr(50076)||chr(50080)||chr(50081)||chr(50082)||chr(50083)||chr(50084)||chr(50085)||chr(50086)||chr(50088)||chr(50089)||chr(50090)||chr(50091)||chr(50092)||chr(50093)||chr(50094)||chr(50095)||chr(50097)||chr(50098)||chr(50099)||chr(50100)||chr(50101)||chr(50102)||chr(50105)||chr(50106)||chr(50107)||chr(50108)||chr(50087)||chr(50055);

    replace_chr := 'AAAAAEEEEIIIINOOOOOUUUUaaaaaaeeeeeiiiinooooouuuucC';

    pout_string := translate ( pin_string, special_chr, replace_chr);



  RETURN pout_string;



END sub_lat_chr;



FUNCTION sub_lat_chr_only_ltr (Pin_string  VARCHAR2) RETURN VARCHAR2  IS

    pout_string  VARCHAR2(4000);



BEGIN

    pout_string := sub_lat_chr(Pin_string );

    pout_string := clr_txt_only_ltr(pout_string);



  RETURN pout_string;

END sub_lat_chr_only_ltr;



FUNCTION Numero_a_Texto ( Imp Number, idioma varchar2)

RETURN VarChar2

IS



IMP_ROUND NUMBER;

imp_char VarChar2(12);

impd_char VarChar2(2);

importe_let varchar2(400);

flag number;



BEGIN





IMP_ROUND := ROUND(abs(imp),2);



    if Imp != 0 then

        flag :=  Imp / abs(Imp);

    else

        flag := 1;

    end if;



imp_char := To_Char(Trunc(IMP_ROUND));

impd_char:= RPAD(Substr(Ltrim(Ltrim(To_Char(IMP_ROUND - Trunc(IMP_ROUND)),'.'),','), 1, 2),2,'0');



if idioma = 'ESP' then

    SELECT

    decode(flag, -1,'MENOS ',1,'','')

    ||

    --Centenas de miles de millones.

    DECODE (SUBSTR(LPAD(imp_char,12,'0'),1,1),

    1,DECODE(SUBSTR(LPAD(imp_char,12,'0'),2,2),'00','CIEN ','CIENTO '),

    2,'DOSCIENTAS ',

    3,'TRESCIENTAS ',

    4,'CUATROCIENTAS ',

    5,'QUINIENTAS ',

    6,'SEISCIENTAS ',

    7,'SETECIENTAS ',

    8,'OCHOCIENTAS ',

    9,'NOVECIENTAS ',

    0,'')



    ||

    --Decenas miles de millones.

    DECODE (SUBSTR(LPAD(imp_char,12,'0'),2,1),

    1,DECODE (SUBSTR(LPAD(imp_char,12,'0'),3,1),

    0,'DIEZ ',

    1,'ONCE MIL ',

    2,'DOCE MIL ',

    3,'TRECE MIL ',

    4,'CATORCE MIL ',

    5,'QUINCE MIL ',

    6,'DICISEIS MIL ',

    7,'DIECISIETE MIL ',

    8,'DIECIOCHO MIL ',

    9,'DIECINUEVE MIL '),

    2,DECODE (SUBSTR(LPAD(imp_char,12,'0'),3,1), 0,'VEINTE ','VEINTI'),

    3,DECODE (SUBSTR(LPAD(imp_char,12,'0'),3,1), 0,'TREINTA ','TREINTA Y '),

    4,DECODE (SUBSTR(LPAD(imp_char,12,'0'),3,1), 0,'CUARENTA ','CUARENTA Y '),

    5,DECODE (SUBSTR(LPAD(imp_char,12,'0'),3,1), 0,'CINCUENTA ','CINCUENTA Y '),

    6,DECODE (SUBSTR(LPAD(imp_char,12,'0'),3,1), 0,'SESENTA ','SESENTA Y '),

    7,DECODE (SUBSTR(LPAD(imp_char,12,'0'),3,1), 0,'SETENTA ','SETENTA Y '),

    8,DECODE (SUBSTR(LPAD(imp_char,12,'0'),3,1), 0,'OCHENTA ','OCHENTA Y '),

    9,DECODE (SUBSTR(LPAD(imp_char,12,'0'),3,1), 0,'NOVENTA ','NOVENTA Y '),

    0,'')



    ||

    --Unidades de milles de millones

    DECODE (SUBSTR(LPAD(imp_char,12,'0'),3,1),

    1,DECODE(SUBSTR(LPAD(imp_char,12,'0'),2,1),'1','',

    DECODE(SUBSTR(LPAD(imp_char,12,'0'),1,3),'001','MIL ','UN MIL ' ) ),

    2,DECODE(SUBSTR(LPAD(imp_char,12,'0'),2,1),1,'','DOS MIL '),

    3,DECODE(SUBSTR(LPAD(imp_char,12,'0'),2,1),1,'','TRES MIL '),

    4,DECODE(SUBSTR(LPAD(imp_char,12,'0'),2,1),1,'','CUATRO MIL '),

    5,DECODE(SUBSTR(LPAD(imp_char,12,'0'),2,1),1,'','CINCO MIL '),

    6,DECODE(SUBSTR(LPAD(imp_char,12,'0'),2,1),1,'','SEIS MIL '),

    7,DECODE(SUBSTR(LPAD(imp_char,12,'0'),2,1),1,'','SIETE MIL '),

    8,DECODE(SUBSTR(LPAD(imp_char,12,'0'),2,1),1,'','OCHO MIL '),

    9,DECODE(SUBSTR(LPAD(imp_char,12,'0'),2,1),1,'','NUEVE MIL '),

    0,DECODE(SUBSTR(LPAD(imp_char,12,'0'),1,3),'000','','MIL '))



    ||

    --Centenas de millon.

    DECODE (SUBSTR(LPAD(imp_char,12,'0'),4,1),

    1,DECODE(SUBSTR(LPAD(imp_char,12,'0'),5,2),'00','CIEN ','CIENTO '),

    2,'DOSCIENTOS ',

    3,'TRESCIENTOS ',

    4,'CUATROCIENTOS ',

    5,'QUINIENTOS ',

    6,'SEISCIENTOS ',

    7,'SETECIENTOS ',

    8,'OCHOCIENTOS ',

    9,'NOVECIENTOS ',

    0,'')



    ||

    --Decenas de millon.

    DECODE (SUBSTR(LPAD(imp_char,12,'0'),5,1),

    1,DECODE (SUBSTR(LPAD(imp_char,12,'0'),6,1),

    0,'DIEZ ',

    1,'ONCE MILLONES ',

    2,'DOCE MILLONES ',

    3,'TRECE MILLONES ',

    4,'CATORCE MILLONES ',

    5,'QUINCE MILLONES ',

    6,'DICISEIS MILLONES ',

    7,'DIECISIETE MILLONES ',

    8,'DIECIOCHO MILLONES ',

    9,'DIECINUEVE MILLONES '),

    2,DECODE (SUBSTR(LPAD(imp_char,12,'0'),6,1), 0,'VEINTE ','VEINTI'),

    3,DECODE (SUBSTR(LPAD(imp_char,12,'0'),6,1), 0,'TREINTA ','TREINTA Y '),

    4,DECODE (SUBSTR(LPAD(imp_char,12,'0'),6,1), 0,'CUARENTA ','CUARENTA Y '),

    5,DECODE (SUBSTR(LPAD(imp_char,12,'0'),6,1), 0,'CINCUENTA ','CINCUENTA Y '),

    6,DECODE (SUBSTR(LPAD(imp_char,12,'0'),6,1), 0,'SESENTA ','SESENTA Y '),

    7,DECODE (SUBSTR(LPAD(imp_char,12,'0'),6,1), 0,'SETENTA ','SETENTA Y '),

    8,DECODE (SUBSTR(LPAD(imp_char,12,'0'),6,1), 0,'OCHENTA ','OCHENTA Y '),

    9,DECODE (SUBSTR(LPAD(imp_char,12,'0'),6,1), 0,'NOVENTA ','NOVENTA Y '),

    0,'')



    ||

    --Unidades de millon.

    DECODE (SUBSTR(LPAD(imp_char,12,'0'),6,1),

    1,DECODE(SUBSTR(LPAD(imp_char,12,'0'),5,1),'1','',

    DECODE(SUBSTR(LPAD(imp_char,12,'0'),3,2),'00','UN MILLON ','UN MILLONES ') ),

    2,DECODE(SUBSTR(LPAD(imp_char,12,'0'),5,1),1,'','DOS MILLONES '),

    3,DECODE(SUBSTR(LPAD(imp_char,12,'0'),5,1),1,'','TRES MILLONES '),

    4,DECODE(SUBSTR(LPAD(imp_char,12,'0'),5,1),1,'','CUATRO MILLONES '),

    5,DECODE(SUBSTR(LPAD(imp_char,12,'0'),5,1),1,'','CINCO MILLONES '),

    6,DECODE(SUBSTR(LPAD(imp_char,12,'0'),5,1),1,'','SEIS MILLONES '),

    7,DECODE(SUBSTR(LPAD(imp_char,12,'0'),5,1),1,'','SIETE MILLONES '),

    8,DECODE(SUBSTR(LPAD(imp_char,12,'0'),5,1),1,'','OCHO MILLONES '),

    9,DECODE(SUBSTR(LPAD(imp_char,12,'0'),5,1),1,'','NUEVE MILLONES '),

    0,DECODE(SUBSTR(LPAD(imp_char,12,'0'),3,3),'000','','MILLONES '))



    ||

    --Centenas de millar.

    DECODE (SUBSTR(LPAD(imp_char,12,'0'),7,1),

    1,DECODE(SUBSTR(LPAD(imp_char,12,'0'),8,2),'00','CIEN ','CIENTO '),

    2,'DOSCIENTOS ',

    3,'TRESCIENTOS ',

    4,'CUATROCIENTOS ',

    5,'QUINIENTOS ',

    6,'SEISCIENTOS ',

    7,'SETECIENTOS ',

    8,'OCHOCIENTOS ',

    9,'NOVECIENTOS ',

    0,'')



    ||

    --Decenas de millar.

    DECODE (SUBSTR(LPAD(imp_char,12,'0'),8,1),

    1,DECODE (SUBSTR(LPAD(imp_char,12,'0'),9,1),

    0,'DIEZ ',

    1,'ONCE MIL ',

    2,'DOCE MIL ',

    3,'TRECE MIL ',

    4,'CATORCE MIL ',

    5,'QUINCE MIL ',

    6,'DICISEIS MIL ',

    7,'DIECISIETE MIL ',

    8,'DIECIOCHO MIL ',

    9,'DIECINUEVE MIL '),

    2,DECODE (SUBSTR(LPAD(imp_char,12,'0'),9,1), 0,'VEINTE ','VEINTI'),

    3,DECODE (SUBSTR(LPAD(imp_char,12,'0'),9,1), 0,'TREINTA ','TREINTA Y '),

    4,DECODE (SUBSTR(LPAD(imp_char,12,'0'),9,1), 0,'CUARENTA ','CUARENTA Y '),

    5,DECODE (SUBSTR(LPAD(imp_char,12,'0'),9,1), 0,'CINCUENTA ','CINCUENTA Y '),

    6,DECODE (SUBSTR(LPAD(imp_char,12,'0'),9,1), 0,'SESENTA ','SESENTA Y '),

    7,DECODE (SUBSTR(LPAD(imp_char,12,'0'),9,1), 0,'SETENTA ','SETENTA Y '),

    8,DECODE (SUBSTR(LPAD(imp_char,12,'0'),9,1), 0,'OCHENTA ','OCHENTA Y '),

    9,DECODE (SUBSTR(LPAD(imp_char,12,'0'),9,1), 0,'NOVENTA ','NOVENTA Y '),

    0,'')



    ||

    --Unidades de millar

    DECODE (SUBSTR(LPAD(imp_char,12,'0'),9,1),

    1,DECODE(SUBSTR(LPAD(imp_char,12,'0'),8,1),'1','',

    DECODE(SUBSTR(LPAD(imp_char,12,'0'),7,3),'001','MIL ','UN MIL ' ) ),

    2,DECODE(SUBSTR(LPAD(imp_char,12,'0'),8,1),1,'','DOS MIL '),

    3,DECODE(SUBSTR(LPAD(imp_char,12,'0'),8,1),1,'','TRES MIL '),

    4,DECODE(SUBSTR(LPAD(imp_char,12,'0'),8,1),1,'','CUATRO MIL '),

    5,DECODE(SUBSTR(LPAD(imp_char,12,'0'),8,1),1,'','CINCO MIL '),

    6,DECODE(SUBSTR(LPAD(imp_char,12,'0'),8,1),1,'','SEIS MIL '),

    7,DECODE(SUBSTR(LPAD(imp_char,12,'0'),8,1),1,'','SIETE MIL '),

    8,DECODE(SUBSTR(LPAD(imp_char,12,'0'),8,1),1,'','OCHO MIL '),

    9,DECODE(SUBSTR(LPAD(imp_char,12,'0'),8,1),1,'','NUEVE MIL '),

    0,DECODE(SUBSTR(LPAD(imp_char,12,'0'),7,3),'000','','MIL '))



    ||

    --Centenas.

    DECODE (SUBSTR(LPAD(imp_char,12,'0'),10,1),

    1,DECODE(SUBSTR(LPAD(imp_char,12,'0'),11,2),'00','CIEN','CIENTO '),

    2,'DOSCIENTOS ',

    3,'TRESCIENTOS ',

    4,'CUATROCIENTOS ',

    5,'QUINIENTOS ',

    6,'SEISCIENTOS ',

    7,'SETECIENTOS ',

    8,'OCHOCIENTOS ',

    9,'NOVECIENTOS ',

    0,'')



    ||

    --Decenas.

    DECODE (SUBSTR(LPAD(imp_char,12,'0'),11,1),

    1,DECODE (SUBSTR(LPAD(imp_char,12,'0'),12),

    0,'DIEZ ',

    1,'ONCE ',

    2,'DOCE ',

    3,'TRECE ',

    4,'CATORCE ',

    5,'QUINCE ',

    6,'DICISEIS ',

    7,'DIECISIETE ',

    8,'DIECIOCHO ',

    9,'DIECINUEVE '),

    2,DECODE (SUBSTR(LPAD(imp_char,12,'0'),12), 0,'VEINTE ','VEINTI'),

    3,DECODE (SUBSTR(LPAD(imp_char,12,'0'),12), 0,'TREINTA ','TREINTA Y '),

    4,DECODE (SUBSTR(LPAD(imp_char,12,'0'),12), 0,'CUARENTA ','CUARENTA Y '),

    5,DECODE (SUBSTR(LPAD(imp_char,12,'0'),12), 0,'CINCUENTA ','CINCUENTA Y '),

    6,DECODE (SUBSTR(LPAD(imp_char,12,'0'),12), 0,'SESENTA ','SESENTA Y '),

    7,DECODE (SUBSTR(LPAD(imp_char,12,'0'),12), 0,'SETENTA ','SETENTA Y '),

    8,DECODE (SUBSTR(LPAD(imp_char,12,'0'),12), 0,'OCHENTA ','OCHENTA Y '),

    9,DECODE (SUBSTR(LPAD(imp_char,12,'0'),12), 0,'NOVENTA ','NOVENTA Y '),

    0,'')



    ||

    --Unidades.

    DECODE (SUBSTR(LPAD(imp_char,12,'0'),12,1),

    1,DECODE(SUBSTR(LPAD(imp_char,12,'0'),11,1),1,'','UN '),

    2,DECODE(SUBSTR(LPAD(imp_char,12,'0'),11,1),1,'','DOS '),

    3,DECODE(SUBSTR(LPAD(imp_char,12,'0'),11,1),1,'','TRES '),

    4,DECODE(SUBSTR(LPAD(imp_char,12,'0'),11,1),1,'','CUATRO '),

    5,DECODE(SUBSTR(LPAD(imp_char,12,'0'),11,1),1,'','CINCO '),

    6,DECODE(SUBSTR(LPAD(imp_char,12,'0'),11,1),1,'','SEIS '),

    7,DECODE(SUBSTR(LPAD(imp_char,12,'0'),11,1),1,'','SIETE '),

    8,DECODE(SUBSTR(LPAD(imp_char,12,'0'),11,1),1,'','OCHO '),

    9,DECODE(SUBSTR(LPAD(imp_char,12,'0'),11,1),1,'','NUEVE '),

    0,DECODE(SUBSTR(LPAD(imp_char,12,'0'),1,12),'000000000000','CERO ','') )

    ||

    DECODE(LPAD(impd_char,2,'0'),'00','','CON ')||impd_char||'/100'

    INTO importe_let

    FROM DUAL;

    end if;



RETURN (importe_let);

END Numero_a_Texto;

function FLEX_VALUE_DESCRIPTION ( p_FLEX_VALUE_SET_NAME varchar, p_FLEX_VALUE varchar, p_language varchar2 default 'US' ) return varchar2 is
v_description varchar2(240);
begin
    for X in  FLEX_VALUE_DESCRIPTION_data( p_FLEX_VALUE_SET_NAME , p_FLEX_VALUE, p_language ) loop
        v_description := x.DESCRIPTION;
    end loop;
    return v_description;
exception when others then
    return v_description;
end;

function LOOKUP_MEANING ( p_LOOKUP_TYPE varchar, p_LOOKUP_CODE varchar, p_language varchar2 default 'US' ) return varchar2 is
v_description varchar2(240);
begin
    for X in  LOOKUP_DESCRIPTION_data( p_LOOKUP_TYPE , p_LOOKUP_CODE, p_language ) loop
        v_description := x.MEANING;
    end loop;
    return v_description;
exception when others then
    return v_description;
end;

end XX_UTILITIES;
/
grant all on XX_UTILITIES to apps with grant option;
/
exit
/
