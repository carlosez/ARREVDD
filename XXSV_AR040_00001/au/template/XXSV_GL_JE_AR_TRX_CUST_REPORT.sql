/* Formatted on 10/15/2014 10:01:56 AM (QP5 v5.139.911.3011) */
CREATE OR REPLACE FORCE VIEW XXSV_GL_JE_AR_TRX_CUST_REPORT
(
   LEDGER_ID
  ,LEDGER_NAME
  ,CURRENCY_CODE
  ,PERIOD_NAME
  ,USER_JE_SOURCE_NAME
  ,JE_BATCH_ID
  ,JE_HEADER_ID
  ,CHART_OF_ACCOUNTS_ID
  ,GL_USER
  ,JE_CREATION_DATE
  ,JE_LINE_NUM
  ,JE_STATUS
  ,JE_NAME
  ,ACCOUNTED_DR
  ,ACCOUNTED_CR
  ,AR_USER
  ,AR_CREATION_DATE
  ,TRX_TYPE_NAME
  ,TRX_NUMBER
  ,LINE_NUMBER
  ,LINE_TYPE
  ,LINE_DESCRIPTION
  ,CUSTOMER_REFERENCE
  ,PARTY_NAME
  ,CODE_COMBINATION_ID
  ,SEGMENT1
  ,SEGMENT1_DESC
  ,SEGMENT2
  ,SEGMENT2_DESC
  ,SEGMENT3
  ,SEGMENT3_DESC
  ,SEGMENT4
  ,SEGMENT4_DESC
  ,SEGMENT5
  ,SEGMENT5_DESC
  ,SEGMENT6
  ,SEGMENT6_DESC
  ,SEGMENT7
  ,SEGMENT7_DESC
  ,SEGMENT8
  ,SEGMENT8_DESC
  ,SEGMENT9
  ,SEGMENT9_DESC
  ,SEGMENT10
  ,SEGMENT10_DESC
  ,SEGMENT11
  ,SEGMENT11_DESC
  ,SEGMENT12
  ,SEGMENT12_DESC
  ,SEGMENT13
  ,SEGMENT13_DESC
)
AS
   SELECT gll.ledger_id
         ,gll.NAME ledger_name
         ,gll.currency_code
         ,gjh.period_name
         ,XXSV_AR_REV_UTL.sub_lat_chr (gjs.user_je_source_name)
             user_je_source_name
         ,gjh.je_batch_id
         ,gjh.je_header_id
         ,gll.chart_of_accounts_id
         ,fnu.user_name gl_user
         ,gjh.creation_date je_creation_date
         ,gir.je_line_num
         ,XXSV_AR_REV_UTL.lookup_meaning ('MJE_BATCH_STATUS', gjl.status)
             je_status
         ,XXSV_AR_REV_UTL.sub_lat_chr (gjh.NAME) je_name
         ,xdl.unrounded_accounted_dr accounted_dr
         ,xdl.unrounded_accounted_cr accounted_cr
         ,fnuar.user_name ar_user
         ,rct.creation_date ar_creation_date
         ,ctt.NAME trx_type_name
         ,rct.trx_number
         ,ctl.line_number
         ,XXSV_AR_REV_UTL.lookup_meaning ('AUTOGL_TYPE', rctgd.account_class)
             line_type
         ,XXSV_AR_REV_UTL.sub_lat_chr (ctl.description) line_description
         ,ca.orig_system_reference customer_reference
         ,XXSV_AR_REV_UTL.sub_lat_chr (hzp.party_name)
         ,rctgd.code_combination_id
         ,glcc.segment1
         ,XXSV_AR_REV_UTL.
          flex_value_description ('XX_GL_MIC_COMPANY_VS', glcc.segment1)
         ,glcc.segment2
         ,XXSV_AR_REV_UTL.
          flex_value_description ('XX_GL_MIC_ACCOUNT_VS', glcc.segment2)
         ,glcc.segment3
         ,XXSV_AR_REV_UTL.
          flex_value_description ('XX_GL_MIC_LOCAL_VS', glcc.segment3)
         ,glcc.segment4
         ,XXSV_AR_REV_UTL.
          flex_value_description ('XX_GL_MIC_COST_CENTER_VS', glcc.segment4)
         ,glcc.segment5
         ,XXSV_AR_REV_UTL.
          flex_value_description ('XX_GL_MIC_TERRITORY_VS', glcc.segment5)
         ,glcc.segment6
         ,XXSV_AR_REV_UTL.
          flex_value_description ('XX_GL_MIC_BUSINESS_UNIT_VS', glcc.segment6)
         ,glcc.segment7
         ,XXSV_AR_REV_UTL.
          flex_value_description ('XX_GL_MIC_CATEGORY_VS', glcc.segment7)
         ,glcc.segment8
         ,XXSV_AR_REV_UTL.
          flex_value_description ('XX_GL_MIC_PRODUCT_VS', glcc.segment8)
         ,glcc.segment9
         ,XXSV_AR_REV_UTL.
          flex_value_description ('XX_GL_MIC_PROJECT_VS', glcc.segment9)
         ,glcc.segment10
         ,XXSV_AR_REV_UTL.
          flex_value_description ('XX_GL_MIC_INTERCOMPANY_VS', glcc.segment10)
         ,glcc.segment11
         ,XXSV_AR_REV_UTL.
          flex_value_description ('XX_GL_MIC_FLOW_VS', glcc.segment11)
         ,glcc.segment12
         ,XXSV_AR_REV_UTL.
          flex_value_description ('XX_GL_MIC_FUTURE1_VS', glcc.segment12)
         ,glcc.segment13
         ,XXSV_AR_REV_UTL.
          flex_value_description ('XX_GL_MIC_FUTURE2_VS', glcc.segment13)
     FROM apps.gl_je_headers gjh
         ,apps.gl_je_sources gjs
         ,apps.gl_je_lines gjl
         ,apps.fnd_user fnu
         ,apps.fnd_user fnuar
         ,apps.gl_code_combinations_kfv glcc
         ,apps.gl_import_references gir
         ,xla.xla_ae_lines xal
         ,xla.xla_ae_headers xah
         ,xla.xla_events xe
         ,xla.xla_transaction_entities xte
         ,xla.xla_distribution_links xdl
         ,apps.gl_ledgers gll
         ,apps.ra_cust_trx_line_gl_dist_all rctgd
         ,apps.ra_customer_trx_lines_all ctl
         ,apps.ra_customer_trx_all rct
         ,apps.ra_cust_trx_types_all ctt
         ,apps.hz_cust_accounts ca
         ,apps.hz_parties hzp
    WHERE gjh.created_by = fnu.user_id
      AND rct.created_by = fnuar.user_id
      AND gjh.ledger_id = gll.ledger_id
      AND gjh.je_header_id = gjl.je_header_id
      AND gjh.je_source = gjs.je_source_name
      AND gjs.LANGUAGE = USERENV ('LANG')
      AND xal.code_combination_id = glcc.code_combination_id
      AND gjl.je_header_id = gir.je_header_id
      AND gjl.je_line_num = gir.je_line_num
      AND gjh.actual_flag = 'A'
      AND gir.gl_sl_link_table = xal.gl_sl_link_table
      AND gir.gl_sl_link_id = xal.gl_sl_link_id
      AND xal.ae_header_id = xah.ae_header_id
      AND xah.event_id = xe.event_id
      AND xah.ae_header_id = xdl.ae_header_id
      AND xal.ae_line_num = xdl.ae_line_num
      AND (NVL (xal.accounted_dr, 0) != 0
        OR  NVL (xal.accounted_cr, 0) != 0)
      AND xe.entity_id = xte.entity_id
      AND xah.application_id = xal.application_id
      AND xal.application_id = xte.application_id
      AND xte.application_id = xdl.application_id
      AND xe.application_id = xte.application_id
      AND xah.application_id = xe.application_id
      AND xah.application_id = 222
      AND xdl.source_distribution_id_num_1 = rctgd.cust_trx_line_gl_dist_id
      AND rctgd.customer_trx_line_id = ctl.customer_trx_line_id(+)
      /* Dist sin linea */
      AND rctgd.customer_trx_id = rct.customer_trx_id
      AND rct.cust_trx_type_id = ctt.cust_trx_type_id
      AND rct.bill_to_customer_id = ca.cust_account_id
      AND ca.party_id = hzp.party_id
      AND xte.entity_code = 'TRANSACTIONS'
      AND gjh.je_source = 'Receivables'
      AND gjh.je_category IN
             ('Sales Invoices', 'Credit Memos', 'Debit Memos', 'Chargebacks');
/
exit
/