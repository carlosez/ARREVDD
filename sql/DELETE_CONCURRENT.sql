/* Formatted on 10/16/2014 8:33:13 AM (QP5 v5.139.911.3011) */
DECLARE
   CURSOR C1
   IS
      SELECT C.CONCURRENT_PROGRAM_NAME
            ,C.DESCRIPTION
            ,B.APPLICATION_SHORT_NAME
        FROM FND_APPLICATION_VL B, FND_CONCURRENT_PROGRAMS_VL C
       WHERE B.APPLICATION_ID = C.APPLICATION_ID
         AND C.CONCURRENT_PROGRAM_NAME IN ('XXSVARDRILLREV')
      ORDER BY 1;
BEGIN
   -- Suprimiendo Program o Concurrente
   FOR i IN C1
   LOOP
      BEGIN
         FND_PROGRAM.
         delete_program (
                         program_short_name   => i.CONCURRENT_PROGRAM_NAME
                        ,application          => i.APPLICATION_SHORT_NAME
                        );
      END;

      COMMIT;
   END LOOP;

   BEGIN
      XDO_DS_DEFINITIONS_PKG.
      DELETE_ROW (
                  X_APPLICATION_SHORT_NAME   => 'XBOL'
                 ,X_DATA_SOURCE_CODE         => 'XXSVARDRILLREV'
                 );
      XDO_TEMPLATES_PKG.
      DELETE_ROW (
                  X_APPLICATION_SHORT_NAME   => 'XBOL'
                 ,X_TEMPLATE_CODE            => 'XXSVARDRILLREV'
                 );
      COMMIT;
        begin
          DELETE FROM XDO.XDO_LOBS
           WHERE LOB_CODE = 'XXSVARDRILLREV';
       exception when others then null;
       end;
   EXCEPTION
      WHEN OTHERS
      THEN
         COMMIT;
   END;

   COMMIT;
END;
/