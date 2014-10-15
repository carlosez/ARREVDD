


select 
 REGEXP_SUBSTR( :P_MIN_FLEX , '[^.]+', 1, 1 ) REGX, substr(:P_MIN_FLEX,1,6)
,REGEXP_SUBSTR( :P_MIN_FLEX , '[^.]+', 1, 2 ) REGX, substr(:P_MIN_FLEX,8,8)
,REGEXP_SUBSTR( :P_MIN_FLEX , '[^.]+', 1, 3 ) REGX, substr(:P_MIN_FLEX,17,8)
,REGEXP_SUBSTR( :P_MIN_FLEX , '[^.]+', 1, 4 ) REGX, substr(:P_MIN_FLEX,26,5)
,REGEXP_SUBSTR( :P_MIN_FLEX , '[^.]+', 1, 5 ) REGX, substr(:P_MIN_FLEX,32,3)
,REGEXP_SUBSTR( :P_MIN_FLEX , '[^.]+', 1, 6 ) REGX, substr(:P_MIN_FLEX,36,3)
,REGEXP_SUBSTR( :P_MIN_FLEX , '[^.]+', 1, 7 ) REGX, substr(:P_MIN_FLEX,40,2)
,REGEXP_SUBSTR( :P_MIN_FLEX , '[^.]+', 1, 8 ) REGX, substr(:P_MIN_FLEX,43,3)
,REGEXP_SUBSTR( :P_MIN_FLEX , '[^.]+', 1, 9 ) REGX, substr(:P_MIN_FLEX,47,6)
,REGEXP_SUBSTR( :P_MIN_FLEX , '[^.]+', 1, 10 ) REGX, substr(:P_MIN_FLEX,54,6)
,REGEXP_SUBSTR( :P_MIN_FLEX , '[^.]+', 1, 11 ) REGX, substr(:P_MIN_FLEX,61,3)
,REGEXP_SUBSTR( :P_MIN_FLEX , '[^.]+', 1, 12 ) REGX, substr(:P_MIN_FLEX,65,5)
,REGEXP_SUBSTR( :P_MIN_FLEX , '[^.]+', 1, 13 ) REGX, substr(:P_MIN_FLEX,71,5)
from dual



(   K2.segment1  between substr(:P_MIN_FLEX,1,6)  and substr(:P_MAX_FLEX,1,6)
AND K2.segment2  between substr(:P_MIN_FLEX,8,8)  and substr(:P_MAX_FLEX,8,8)
AND K2.segment3  between substr(:P_MIN_FLEX,17,8) and substr(:P_MAX_FLEX,17,8)
AND K2.segment3  between substr(:P_MIN_FLEX,26,5) and substr(:P_MAX_FLEX,26,5)
AND K2.segment5  between substr(:P_MIN_FLEX,32,3) and substr(:P_MAX_FLEX,32,3)
AND K2.segment7  between substr(:P_MIN_FLEX,36,3) and substr(:P_MAX_FLEX,36,3)
AND K2.segment7  between substr(:P_MIN_FLEX,40,2) and substr(:P_MAX_FLEX,40,2)
AND K2.segment8  between substr(:P_MIN_FLEX,43,3) and substr(:P_MAX_FLEX,43,3)
AND K2.segment9  between substr(:P_MIN_FLEX,47,6) and substr(:P_MAX_FLEX,47,6)
AND K2.segment10 between substr(:P_MIN_FLEX,54,6) and substr(:P_MAX_FLEX,54,6)
AND K2.segment11 between substr(:P_MIN_FLEX,61,3) and substr(:P_MAX_FLEX,61,3)
AND K2.segment12 between substr(:P_MIN_FLEX,65,5) and substr(:P_MAX_FLEX,65,5)
AND K2.segment13 between substr(:P_MIN_FLEX,71,5) and substr(:P_MAX_FLEX,71,5)
)

