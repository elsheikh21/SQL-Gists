-- 1. Draw The Triangle 1
-- ORACLE SQL

SELECT rpad('*', x,' *')
FROM
    (SELECT LEVEL x
     FROM DUAL CONNECT BY LEVEL <= 40
     ORDER BY LEVEL DESC)
WHERE mod(x,2) = 0;

-- 2. Draw The Triangle 2
-- MS SQL
 DECLARE @row int = 1 WHILE (@row < 21) BEGIN print replicate('* ', @row)
SET @row = @row + 1 END -- 3. Print the prime numbers

SELECT LISTAGG(L1,'&') WITHIN
GROUP (
       ORDER BY L1)
FROM
    (SELECT L1
     FROM
         (SELECT LEVEL L1
          FROM DUAL CONNECT BY LEVEL<=1000)
     WHERE L1 <> 1 MINUS
         SELECT L1
         FROM
             (SELECT LEVEL L1
              FROM DUAL CONNECT BY LEVEL<=1000) A,

             (SELECT LEVEL L2
              FROM DUAL CONNECT BY LEVEL<=1000) B WHERE L2<=L1
         AND MOD(L1,L2)=0
         AND L1<>L2
         AND L2<>1);