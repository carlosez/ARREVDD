
                     


SELECT 
RP.LEDGER_ID
      ,RP.LEDGER_NAME
      ,RP.CURRENCY_CODE
      ,RP.PERIOD_NAME
      ,RP.USER_JE_SOURCE_NAME
      ,RP.JE_BATCH_ID
      ,RP.JE_HEADER_ID
      ,RP.CHART_OF_ACCOUNTS_ID
      ,RP.GL_USER
      ,RP.JE_CREATION_DATE
      ,RP.JE_LINE_NUM
      ,RP.JE_STATUS
      ,RP.JE_NAME
      ,nvl(RP.ACCOUNTED_DR,0) ACCOUNTED_DR
      ,nvl(RP.ACCOUNTED_CR,0) ACCOUNTED_CR
      ,RP.AR_USER
      ,RP.AR_CREATION_DATE
      ,RP.TRX_TYPE_NAME
      ,RP.TRX_NUMBER
      ,RP.LINE_NUMBER
      ,RP.LINE_TYPE
      ,RP.LINE_DESCRIPTION
      ,RP.CUSTOMER_REFERENCE
      ,RP.PARTY_NAME
      ,RP.CODE_COMBINATION_ID
,RP.SEGMENT1   ,RP.SEGMENT1_DESC 
,RP.SEGMENT2   ,RP.SEGMENT2_DESC 
,RP.SEGMENT3   ,RP.SEGMENT3_DESC 
,RP.SEGMENT4   ,RP.SEGMENT4_DESC 
,RP.SEGMENT5   ,RP.SEGMENT5_DESC 
,RP.SEGMENT6   ,RP.SEGMENT6_DESC 
,RP.SEGMENT7   ,RP.SEGMENT7_DESC 
,RP.SEGMENT8   ,RP.SEGMENT8_DESC 
,RP.SEGMENT9   ,RP.SEGMENT9_DESC 
,RP.SEGMENT10   ,RP.SEGMENT10_DESC 
,RP.SEGMENT11   ,RP.SEGMENT11_DESC 
,RP.SEGMENT12   ,RP.SEGMENT12_DESC 
,RP.SEGMENT13   ,RP.SEGMENT13_DESC 
  FROM bolinf.XXSV_GL_JE_AR_TRX_CUST_REPORT RP
    , gl_code_combinations_kfv gcc
 WHERE RP.period_name IN
          (SELECT PR.PERIOD_NAME
             FROM apps.GL_PERIODS PR
            WHERE PR.PERIOD_SET_NAME = 'MIC_CALENDARIO'
              AND PR.ADJUSTMENT_PERIOD_FLAG = 'N'
              AND PR.START_DATE >= (SELECT START_DATE
                                   FROM apps.GL_PERIODS PR
                                  WHERE period_name = :P_PERIOD_INI
                                    AND PERIOD_SET_NAME = 'MIC_CALENDARIO')
              AND PR.START_DATE <= (SELECT START_DATE
                                   FROM apps.GL_PERIODS PR
                                  WHERE period_name = :P_PERIOD_FIN
                                    AND PERIOD_SET_NAME = 'MIC_CALENDARIO'))
   AND RP.ledger_id = :P_LEDGER_ID
     and ( (        :P_MIN_FLEX is null 
                and :P_MAX_FLEX is null
            )
              or
            (       gcc.segment1  between substr(:P_MIN_FLEX,1,6)  and substr(:P_MAX_FLEX,1,6)
                AND gcc.segment2  between substr(:P_MIN_FLEX,8,8)  and substr(:P_MAX_FLEX,8,8)
                AND gcc.segment3  between substr(:P_MIN_FLEX,17,8) and substr(:P_MAX_FLEX,17,8)
                AND gcc.segment4  between substr(:P_MIN_FLEX,26,5) and substr(:P_MAX_FLEX,26,5)
                AND gcc.segment5  between substr(:P_MIN_FLEX,32,3) and substr(:P_MAX_FLEX,32,3)
                AND gcc.segment6  between substr(:P_MIN_FLEX,36,3) and substr(:P_MAX_FLEX,36,3)
                AND gcc.segment7  between substr(:P_MIN_FLEX,40,2) and substr(:P_MAX_FLEX,40,2)
                AND gcc.segment8  between substr(:P_MIN_FLEX,43,3) and substr(:P_MAX_FLEX,43,3)
                AND gcc.segment9  between substr(:P_MIN_FLEX,47,6) and substr(:P_MAX_FLEX,47,6)
                AND gcc.segment10 between substr(:P_MIN_FLEX,54,6) and substr(:P_MAX_FLEX,54,6)
                AND gcc.segment11 between substr(:P_MIN_FLEX,61,3) and substr(:P_MAX_FLEX,61,3)
                AND gcc.segment12 between substr(:P_MIN_FLEX,65,5) and substr(:P_MAX_FLEX,65,5)
                AND gcc.segment13 between substr(:P_MIN_FLEX,71,5) and substr(:P_MAX_FLEX,71,5)
            ) )
   AND    ( :P_ACCOUNTS = 'ONLY_REVENUE'
               AND RP.SEGMENT2 LIKE '4%'
                OR 
            :P_ACCOUNTS = 'ALL_ACCOUNTING'
          )
  and RP.code_combination_id = gcc.code_combination_id
/*  and gcc.concatenated_segments = '1SV001.41010502.00000000.00000.C00.202.20.201.000000.1HN001.000.00000.00000'*/
UNION ALL
/*  ------------Query 2-------------------*/
SELECT LD.LEDGER_ID
      ,LD.NAME LEDGER_NAME
      ,LD.CURRENCY_CODE
      ,H.PERIOD_NAME
      ,XXSV_AR_REV_UTL.sub_lat_chr(S.USER_JE_SOURCE_NAME)  USER_JE_SOURCE_NAME
      ,H.JE_BATCH_ID
      ,H.JE_HEADER_ID
      ,LD.CHART_OF_ACCOUNTS_ID
      ,U.USER_NAME USUARIO
      ,H.CREATION_DATE JE_CREATION_DATE
      ,L.JE_LINE_NUM
      ,bolinf.XXSV_AR_REV_UTL.lookup_meaning ('MJE_BATCH_STATUS', H.status) je_status
      ,XXSV_AR_REV_UTL.sub_lat_chr(H.name)  JE_NAME
      ,nvl(L.ENTERED_DR,0) ACCOUNTED_DR
      ,nvl(L.ENTERED_CR,0) ACCOUNTED_CR
      ,NULL AR_USER
      ,NULL AR_CREATION_DATE
      ,NULL TRX_TYPE_NAME
      ,NULL TRX_NUMBER
      ,NULL LINE_NUMBER
      ,NULL LINE_TYPE
      ,XXSV_AR_REV_UTL.sub_lat_chr(L.DESCRIPTION)
      ,NULL CUSTOMER_REFERENCE
      ,NULL PARTY_NAME
      ,gcc.code_combination_id
      ,gcc.segment1
      ,bolinf.XXSV_AR_REV_UTL.
       flex_value_desc_ascii ('XX_GL_MIC_COMPANY_VS', gcc.segment1)
      ,gcc.segment2
      ,bolinf.XXSV_AR_REV_UTL.
       flex_value_desc_ascii ('XX_GL_MIC_ACCOUNT_VS', gcc.segment2)
      ,gcc.segment3
      ,bolinf.XXSV_AR_REV_UTL.flex_value_desc_ascii ('XX_GL_MIC_LOCAL_VS', gcc.segment3)
      ,gcc.segment4
      ,bolinf.XXSV_AR_REV_UTL.
       flex_value_desc_ascii ('XX_GL_MIC_COST_CENTER_VS', gcc.segment4)
      ,gcc.segment5
      ,bolinf.XXSV_AR_REV_UTL.
       flex_value_desc_ascii ('XX_GL_MIC_TERRITORY_VS', gcc.segment5)
      ,gcc.segment6
      ,bolinf.XXSV_AR_REV_UTL.
       flex_value_desc_ascii ('XX_GL_MIC_BUSINESS_UNIT_VS', gcc.segment6)
      ,gcc.segment7
      ,bolinf.XXSV_AR_REV_UTL.
       flex_value_desc_ascii ('XX_GL_MIC_CATEGORY_VS', gcc.segment7)
      ,gcc.segment8
      ,bolinf.XXSV_AR_REV_UTL.
       flex_value_desc_ascii ('XX_GL_MIC_PRODUCT_VS', gcc.segment8)
      ,gcc.segment9
      ,bolinf.XXSV_AR_REV_UTL.
       flex_value_desc_ascii ('XX_GL_MIC_PROJECT_VS', gcc.segment9)
      ,gcc.segment10
      ,bolinf.XXSV_AR_REV_UTL.
       flex_value_desc_ascii ('XX_GL_MIC_INTERCOMPANY_VS', gcc.segment10)
      ,gcc.segment11
      ,bolinf.XXSV_AR_REV_UTL.flex_value_desc_ascii ('XX_GL_MIC_FLOW_VS', gcc.segment11)
      ,gcc.segment12
      ,bolinf.XXSV_AR_REV_UTL.
       flex_value_desc_ascii ('XX_GL_MIC_FUTURE1_VS', gcc.segment12)
      ,gcc.segment13
      ,bolinf.XXSV_AR_REV_UTL.
       flex_value_desc_ascii ('XX_GL_MIC_FUTURE2_VS', gcc.segment13)
  FROM APPS.GL_LEDGERS LD
      ,APPS.GL_JE_HEADERS H
      ,APPS.GL_JE_LINES L
      ,APPS.GL_JE_SOURCES S
      ,APPS.GL_JE_CATEGORIES C
      ,APPS.gl_code_combinations_kfv gcc
      ,APPS.FND_USER U
 WHERE LD.LEDGER_ID = :P_LEDGER_ID
   AND LD.LEDGER_ID = H.LEDGER_ID
   /*and gcc.concatenated_segments = '1SV001.41010502.00000000.00000.C00.202.20.201.000000.1HN001.000.00000.00000'*/
   AND H.ACTUAL_FLAG = 'A'
   AND H.PERIOD_NAME IN
          (SELECT PERIOD_NAME
             FROM apps.GL_PERIODS PR
            WHERE PERIOD_SET_NAME = 'MIC_CALENDARIO'
              AND ADJUSTMENT_PERIOD_FLAG = 'N'
              AND START_DATE >= (SELECT START_DATE
                                   FROM apps.GL_PERIODS PR
                                  WHERE period_name = :P_PERIOD_INI
                                    AND PERIOD_SET_NAME = 'MIC_CALENDARIO')
              AND START_DATE <= (SELECT START_DATE
                                   FROM apps.GL_PERIODS PR
                                  WHERE period_name = :P_PERIOD_FIN
                                    AND PERIOD_SET_NAME = 'MIC_CALENDARIO'))
   AND H.JE_SOURCE = S.JE_SOURCE_NAME
   AND H.JE_CATEGORY = C.JE_CATEGORY_NAME
   AND H.JE_HEADER_ID = L.JE_HEADER_ID 
   AND L.CODE_COMBINATION_ID = gcc.CODE_COMBINATION_ID
   AND H.JE_SOURCE IN ('Manual', 'Spreadsheet')
   AND    ( :P_ACCOUNTS = 'ONLY_REVENUE'
           AND gcc.SEGMENT2 LIKE '4%'
             OR 
            :P_ACCOUNTS = 'ALL_ACCOUNTING'
           )
     and ( (:P_MIN_FLEX is null 
        and :P_MAX_FLEX is null
        )
      or
        (   gcc.segment1  between substr(:P_MIN_FLEX,1,6)  and substr(:P_MAX_FLEX,1,6)
        AND gcc.segment2  between substr(:P_MIN_FLEX,8,8)  and substr(:P_MAX_FLEX,8,8)
        AND gcc.segment3  between substr(:P_MIN_FLEX,17,8) and substr(:P_MAX_FLEX,17,8)
        AND gcc.segment4  between substr(:P_MIN_FLEX,26,5) and substr(:P_MAX_FLEX,26,5)
        AND gcc.segment5  between substr(:P_MIN_FLEX,32,3) and substr(:P_MAX_FLEX,32,3)
        AND gcc.segment6  between substr(:P_MIN_FLEX,36,3) and substr(:P_MAX_FLEX,36,3)
        AND gcc.segment7  between substr(:P_MIN_FLEX,40,2) and substr(:P_MAX_FLEX,40,2)
        AND gcc.segment8  between substr(:P_MIN_FLEX,43,3) and substr(:P_MAX_FLEX,43,3)
        AND gcc.segment9  between substr(:P_MIN_FLEX,47,6) and substr(:P_MAX_FLEX,47,6)
        AND gcc.segment10 between substr(:P_MIN_FLEX,54,6) and substr(:P_MAX_FLEX,54,6)
        AND gcc.segment11 between substr(:P_MIN_FLEX,61,3) and substr(:P_MAX_FLEX,61,3)
        AND gcc.segment12 between substr(:P_MIN_FLEX,65,5) and substr(:P_MAX_FLEX,65,5)
        AND gcc.segment13 between substr(:P_MIN_FLEX,71,5) and substr(:P_MAX_FLEX,71,5)
        )
      )
   AND H.CREATED_BY = U.USER_ID
   AND EXISTS
          (SELECT NULL
             FROM APPS.GL_JE_HEADERS H2
                 ,APPS.GL_JE_LINES L2
                 ,APPS.GL_JE_SOURCES S2
                 ,APPS.GL_CODE_COMBINATIONS K2
            WHERE H2.LEDGER_ID = :P_LEDGER_ID
              AND H2.ACTUAL_FLAG = 'A'
              AND k2.SEGMENT2 LIKE '4%'
              AND H2.PERIOD_NAME IN
                     (SELECT PERIOD_NAME
                        FROM apps.GL_PERIODS PR
                       WHERE PERIOD_SET_NAME = 'MIC_CALENDARIO'
                         AND ADJUSTMENT_PERIOD_FLAG = 'N'
                         AND START_DATE >=
                                (SELECT START_DATE
                                   FROM apps.
                                        GL_PERIODS PR
                                  WHERE period_name = :P_PERIOD_INI
                                    AND PERIOD_SET_NAME = 'MIC_CALENDARIO')
                         AND START_DATE <=
                                (SELECT START_DATE
                                   FROM apps.GL_PERIODS PR
                                  WHERE period_name = :P_PERIOD_FIN
                                    AND PERIOD_SET_NAME = 'MIC_CALENDARIO'))
              AND H2.je_header_id = H.je_header_id
              AND H2.JE_SOURCE = S2.JE_SOURCE_NAME
              AND H2.JE_HEADER_ID = L2.JE_HEADER_ID
              AND L2.CODE_COMBINATION_ID = K2.CODE_COMBINATION_ID
              AND H2.JE_SOURCE IN ('Manual', 'Spreadsheet'))                      