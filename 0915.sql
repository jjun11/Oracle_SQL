SELECT* FROM EMP;
-- 문자 함수 : 문자 데이터를 가공하는 것
-- UPPER : 대문자로 변환 LOWER : 소문자로 변환 INITCAP : 첫자를 대문자로 
SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME)
FROM EMP;

SELECT ENAME, UPPER(ENAME), INITCAP(ENAME)
FROM EMP;

SELECT *
FROM EMP
WHERE UPPER(ENAME) = UPPER('JAMES');

-- LENGTH : 문자열 길이를 반환
-- LENGTHB : 문자열의 바이트 수 반환
SELECT LENGTH('한글'), LENGTHB('한글') -- 2, 6 (글자 하나당 3바이트)
FROM DUAL;

-- SUBSTR / SUBSTRB
-- 데이터베이스는 시작위치가 0이 아님, 2번째 매개변수는 길이,  3번째 매개변수를 생략하면 끝까지
SELECT JOB, SUBSTR(JOB /*CHAR*/, 1 /*POSITION*/, 2 /*SUBSTRING_LENGTH*/), SUBSTR(JOB, 3, 2), SUBSTR(JOB, 5)
FROM EMP;

SELECT JOB, 
    SUBSTR(JOB, -LENGTH(JOB)), --음수는 뒤에서 계산 ,길이에 대한 
    SUBSTR(JOB, -LENGTH(JOB), 2), -- -LENGTH(JOB) : -글자수이므로 SALESMAN이면  뒤에서부터 8글자, 즉 S부터 2글자
    SUBSTR(JOB, -3) -- 뒤에서 3글자
FROM EMP;

-- INSTR : 문자열 데이터 안에 특정 문자나 문자열이 어디에 포함되어 있는지 알고자 할 때 사용
SELECT INSTR('HELLO, ORACLE!' /*문자*/, 'L' /*찾을 문자, 찾을시작위치, 몇번째인지*/) AS INSTR_1, -- 3 : H부터 3번째
    INSTR('HELLO, ORACLE!', 'L', 5) AS INSTR_2, -- 12 : 5번째문자(O)부터 L을 찾으니 그 전의L은 생략, 12번째의 L이 찾아짐
    INSTR('HELLO, ORACLE!', 'L', 2, 2) AS INSTR_3 -- 4 : 2번째문자(E)부터 두번째 L을 찾으니, 2번째 L인 4번째순서의 L이 찾아짐
FROM DUAL;

-- 특정 문자가 포함된 행 찾기
SELECT *
FROM EMP
WHERE INSTR(ENAME, 'S') > 0;

SELECT *
FROM EMP
WHERE ENAME LIKE '%S%';

-- REPLACE : 특정 문자열 데이터에 포함된 문자를 다른 문자로 대체할 경우 사용
-- 대체할 문자를 넣지 않으면 해당문자 삭제
SELECT '010-1234-5678' AS REPLACE_BEFORE,
    REPLACE('010-1234-5678', '-', ' ') AS REPLACE_1, -- 공백으로 대체 : 010 1234 5678
    REPLACE('010-1234-5678', '-') AS REPLACE_2 -- 해당 문자 삭제 : 01012345678
FROM DUAL;

-- LPAD / RPAD : 기준 공간의 칸 수를 특정 문자로 채우는 함수
SELECT LPAD('ORACLE', 10, '+')
FROM DUAL;
SELECT RPAD('ORACLE', 10, '+')
FROM DUAL;

SELECT 'ORACLE',
    LPAD('ORACLE', 10, '#') AS LPAD_1, -- 총 10칸으로 해서 왼쪽에 # 채움 : '####ORACLE'
    RPAD('ORACLE', 10, '*') AS RPAD_1, -- 총 10칸으로 해서 오른쪽에 * 채움 : 'ORACLE****'
    LPAD('ORACLE', 10) AS LPAD_2, -- 총 10칸으로 해서 왼쪽에 공백으로 채움 : '    ORACLE'
    RPAD('ORACLE', 10) AS RPAD_2 -- 총 10칸으로 해서 오른쪽에 공백으로 채움 : 'ORACLE    '
FROM DUAL;

-- 개인정보 뒤자리 *표시로 출력하기
SELECT
    RPAD('971225-', 14, '*') AS RPAD_JMNO,
    RPAD('010-1234-', 13, '*') AS RPAD_PHONE
FROM DUAL;

-- 두 문자열을 합치는 CONCAT 함수
SELECT CONCAT(EMPNO, ENAME),
    CONCAT(EMPNO, CONCAT(':', ENAME))
FROM EMP
WHERE ENAME = 'JAMES';

-- TRIM / LTRIM / RTRIM : 문자열중에서 맨앞, 뒤 특정 문자열을 지우기 위해 사용
-- 지우고 싶은 문자가 맨 앞, 뒤에 있는경우만 제거됨, 공백이 있어도 안됨 
-- LTRIM 'DDDAD' 에서 'D'를 지우도록 하면 맨 왼쪽에서 D가 전부 지워져 'AD'가 됨 
-- 삭제할 문자를 지정하지 않으면 앞뒤 공백 제거
-- TRIM의 경우에는 문자지정이 불가능함 공백제거만 가능
SELECT '[' || TRIM('   _Oracle_    ') || ']' AS TRIM,
 '[' || LTRIM('  _Oracle_  ') || ']' AS LTRIM,
 '[' || LTRIM('<_Oracle_>', '<_') || ']' AS LTRIM_2,
 '[' || RTRIM(' _Oracle_ ') || ']' AS RTRIM,
 '[' || RTRIM('<_Oracle_>', '_>') || ']' AS RTRIM_2
 FROM DUAL;

 SELECT RRIM('DDFD  D', 'D') AS TRIM1
 FROM DUAL;

 -- 날짜 데이터를 다루는 날짜 함수
 -- SYSDATE : 운영체제의 현재 날짜와 시간정보를 가져옴
 SELECT SYSDATE FROM DUAL;

 SELECT SYSDATE AS 오늘,
    SYSDATE-1 AS 어제,
    SYSDATE+1 AS 내일
FROM DUAL;

-- 몇 개월 이후 날짜 구하는 ADD_MONTH 함수
-- 특정 날짜에 지정한 개월 수 이후의 날짜 데이터를 반환하는 함수 DELETE
SELECT SYSDATE,
    ADD_MONTHS(SYSDATE, 3) -- 2번째 인자는 달수를 의미
    FROM DUAL;

-- EMP TABLE 에서 입사 10주년이 되는 사원들 데이터 출력
SELECT EMPNO, ENAME, HIREDATE,
    ADD_MONTHS(HIREDATE, 120) AS 입사10주년
FROM EMP;

-- SYSDATE와 ADD_MONTHS 함수를 사용하여 현재 날짜와 6개월 후 날짜를 출력
SELECT SYSDATE AS 현재,
    ADD_MONTHS(SYSDATE, 6) AS "6개월 후",
FROM DUAL;

-- 두 날짜간의 개월 수 차이를 구하는 MONTHS_BETWEEN 함수
SELECT EMPNO, ENAME, HIREDATE, SYSDATE,
    MONTHS_BETWEEN(HIREDATE, SYSDATE) AS MONTHS1,
    MONTHS_BETWEEN(SYSDATE, HIREDATE) AS MONTHS2,
    TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTHS3,
    ROUND(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTHS4
FROM EMP;


-- 날짜 정보 추출 함수
-- EXTRACT 함수는 날짜 유형의 데이터로부터 날짜 정보를 분리하여 새로운 컬럼의 형태
SELECT EXTRACT(YEAR FROM DATE '2023-09-15') AS 연도추출
FROM DUAL;

SELECT *
FROM EMP
WHERE EXTRACT(MONTH FROM HIREDATE) = 12;

SELECT EXTRACT(MONTH FROM DATE '2023-09-15') AS 월추출,
EXTRACT(DAY FROM DATE '2023-09-15') AS 일추출
FROM DUAL;

-- 오늘 날짜에 대한 정보조회
SELECT SYSDATE AS 오늘날짜
FROM DUAL;
-- EMP테이블에서 사번, 사원명, 급여조회 (단, 급여는 100단위까지의 값만 출력처리하고 급여 기준 내림차순 정렬)
SELECT EMPNO, ENAME, TRUNC(SAL, -2)
FROM EMP
ORDER BY SAL DESC;
-- EMP테이블에서 사원번호가 홀수인 사원들을 조회
SELECT *
FROM EMP
WHERE MOD(EMPNO, 2) = 1;
-- EMP테이블에서 사원명, 입사일 조회 (단, 입사일은 년도와 월을 분리 추출해서 출력)
SELECT ENAME,EXTRACT(YEAR FROM HIREDATE) AS 입사연도 ,EXTRACT(MONTH FROM HIREDATE) AS 입사월
FROM EMP;
-- EMP테이블에서 9월에 입사한 직원의 정보 조회
SELECT *
FROM EMP
WHERE EXTRACT(MONTH FROM HIREDATE) = 9;
-- EMP테이블에서 81년도에 입사한 직원 조회
SELECT *
FROM EMP
WHERE EXTRACT(YEAR FROM HIREDATE) = 1981;
-- EMP테이블에서 이름이 'E'로 끝나는 직원 조회
SELECT *
FROM EMP
WHERE ENAME LIKE '%E';
-- EMP테이블에서 이름의 세번째 글자가 'R'인 직원의 정보 조회
SELECT *
FROM EMP
WHERE ENAME LIKE '__R%';
-- EMP테이블에서 사번, 사원명, 입사일, 입사일로부터 40년 되는 날짜 조회
SELECT EMPNO, ENAME, HIREDATE, ADD_MONTHS(HIREDATE, 480) AS 입사40년차
FROM EMP;
-- EMP테이블에서 입사일로부터 38년 이상 근무한 직원의 정보 조회
SELECT *
FROM EMP
WHERE MONTHS_BETWEEN(SYSDATE, HIREDATE) >= 456;
-- 오늘 날짜에서 년도만 추출
SELECT EXTRACT(YEAR FROM SYSDATE)
FROM DUAL;

-- 자료형을 변환하는 형 변환 함수
-- 자동 형 변환 : NUMBER + 문자타입 => NUMBER타입으로 자동 변환
SELECT EMPNO, ENAME, EMPNO + '500'
FROM EMP
WHERE ENAME = 'FORD';

SELECT EMPNO, ENAME, EMPNO + 'ABCD' -- 숫자가 아니어서 변환되지 않고 에러가 남
FROM EMP
WHERE ENAME = 'FORD';

-- 날짜, 숫자를 문자로 변환하는 TO_CHAR 함수
-- 주로 날짜 데이터를 문자 데이터로 변환하는데 사용
-- 자바의 SimpleDateFormat() 유사
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') AS "현재날짜시간"
FROM DUAL;

SELECT SYSDATE,
    TO_CHAR(SYSDATE, 'CC') AS 세기,
    TO_CHAR(SYSDATE, 'YY') AS 연도,
    TO_CHAR(SYSDATE, 'YYYY/MM/DD PM HH:MI:SS ') AS "년/월/일 시:분:초",
    TO_CHAR(SYSDATE, 'Q') AS "쿼터(분기)",
    TO_CHAR(SYSDATE, 'DD') AS 일,
    TO_CHAR(SYSDATE, 'DDD') AS 경과일,
    TO_CHAR(SYSDATE, 'HH') AS "12시간제",
    TO_CHAR(SYSDATE, 'HH12') AS "12시간제",
    TO_CHAR(SYSDATE, 'HH24') AS "24시간제",
    TO_CHAR(SYSDATE, 'W') AS 몇주차
FROM DUAL;

-- 언어별 날짜변환
SELECT SYSDATE,
     TO_CHAR(SYSDATE, 'MM') AS MM, -- 숫자
     TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = KOREAN' ) AS MON_KOR, -- 한국어
     TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = JAPANESE') AS MON_JPN, -- 일본어
     TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = ENGLISH' ) AS MON_ENG, -- 영어 SEP
     TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = KOREAN' ) AS MONTH_KOR, -- 한국어 전체 변화없음
     TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = JAPANESE') AS MONTH_JPN, -- 일본어 전체 변화없음
     TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = ENGLISH' ) AS MONTH_ENG -- 영어 전체 SEPTEMBER 
FROM DUAL;

-- 시간표기양식
SELECT SYSDATE,
     TO_CHAR(SYSDATE, 'HH24:MI:SS') AS HH24MISS,
     TO_CHAR(SYSDATE, 'HH12:MI:SS AM') AS HHMISS_AM,
     TO_CHAR(SYSDATE, 'HH:MI:SS P.M.') AS HHMISS_PM
FROM DUAL;

-- 숫자 데이터 형식 지정출력
SELECT SAL,
     TO_CHAR(SAL, '$999,999') AS SAL_$,
     TO_CHAR(SAL, 'L999,999') AS SAL_L,
     TO_CHAR(SAL, '999,999.00') AS SAL_1,
     TO_CHAR(SAL, '000,999,999.00') AS SAL_2,
     TO_CHAR(SAL, '000999999.99') AS SAL_3,
     TO_CHAR(SAL, '999,999,00') AS SAL_4
FROM EMP;

-- TO NUMBER() : NUMBER 타입으로 형 변환
SELECT TO_NUMBER('1300') - TO_NUMBER('1500') -- 문자 1300과 1500을 숫자로 형변환해서 1300-1500이 됨, -200 출력
FROM DUAL;

SELECT TO_NUMBER('1300') - '1500' -- 1300만 형변환했지만 자동으로 1500도 형변환해서 1300-1500, -200 출력
FROM DUAL;

-- TO DATE() : 문자열로 명시된 날짜를 날짜타입으로 형변환
SELECT TO_DATE('22/08/20', 'YY/MM/DD')
FROM DUAL;

-- 1981년 6월1일 이후에 입사한 사원정보 출력하기
SELECT *
FROM EMP
WHERE HIREDATE > '01-JUN-81';

SELECT *
FROM EMP
WHERE HIREDATE > TO_DATE('1981/06/01', 'YYYY/MM/DD');

-- NULL 처리 함수 : NULL은 값이 없음, 즉 할당되지 않음을 의미
-- NULL은 0이나 공백과는 다른 의미, 연산 불가능함
-- NVL(NULL 인지 검사할 열, 앞의 열 데이터가 NULL인 경우 반환할 데이터)
SELECT EMPNO, ENAME, SAL, COMM, SAL+COMM,
NVL(COMM, 0), SAL+NVL(COMM, 0)
FROM EMP;

-- NVL2() : NULL이 아닌경우와 NULL인경우 모두에 대해서 값을 지정할 수 있음
SELECT EMPNO, ENAME, COMM,
    NVL2(COMM, 'O', 'X') AS 성과급유무,
    NVL2(COMM, SAL*12+COMM, SAL*12) AS 연봉
FROM EMP;

-- NULLIF() : 두 값이 동일하면 NULL 반환, 아니면 첫 번째 값 반환
SELECT NULLIF(10, 10), NULLIF('A', 'B')
FROM DUAL;

-- DECODE : 주어진 데이터 값이 조건값과 일치하는 값 출력
-- 일치하는값이 없으면 기본값 출력
SELECT EMPNO, ENAME, JOB, SAL,
    DECODE(JOB, 'MANAGER', SAL*1.1, 
                'SALESMAN', SAL*1.05,
                'ANALYST', SAL,
                SAL*1.03) AS 연봉인상
FROM EMP;

-- CASE문
SELECT EMPNO, ENAME, JOB, SAL,
    CASE JOB
        WHEN 'MANGER' THEN SAL*1.1
        WHEN 'SALESMAN' THEN SAL*1.05
        WHEN 'ANALYST' THEN SAL
        ELSE SAL*1.03
    END AS 연봉인상
FROM EMP;

-- 열 값에 따라서 출력값이 달라지는 CASE문
SELECT EMPNO, ENAME, COMM,
    CASE
        WHEN COMM IS NULL THEN '해당사항 없음'
        WHEN COMM = 0 THEN '수당없음'
        WHEN COMM > 0 THEN '수당 : ' || COMM
    END AS 성과급기준
FROM EMP;        

-- 1번
SELECT EMPNO,
    RPAD(SUBSTR(EMPNO, 1, 2), 4, '*') AS MASKING_EMPNO,
    ENAME,
    RPAD(SUBSTR(ENAME, 1, 1), LENGTH(ENAME), '*') AS MASKING_ENAME
FROM EMP
WHERE LENGTH(ENAME) =5;

-- 2번
SELECT EMPNO, ENAME, SAL,
    TRUNC(SAL / 21.51, 2) AS 일급,
    TRUNC(SAL / 21.5 / 8, 1) AS 시급
FROM EMP;

-- 3번
-- NEXT_DAY(기준일자, 찾을 요일) : 기준 일자 다음에 오는 날짜를 구하는 함수
SELECT EMPNO, ENAME, HIREDATE
    TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE, 3), '월요일'), 'YYYY/MM/DD') AS 정직원진급,
    NVL(TO_CHAR(COMM), 'N/A')AS COMM
FROM EMP;

-- 4번
SELECT EMPNO, ENAME, MGR,
    CASE
        WHEN MGR IS NULL THEN '0000'
        WHEN SUBSTR(MGR, 1, 2) = '78' THEN '8888'
        WHEN SUBSTR(MGR, 1, 2) = '77' THEN '7777'
        WHEN SUBSTR(MGR, 1, 2) = '76' THEN '6666'
        WHEN SUBSTR(MGR, 1, 2) = '75' THEN '5555'
        ELSE TO_CHAR(MGR)
    END AS CHG_MGR
FROM EMP;

-- 다중행 함수 : 여러 행에 대해 함수가 적용되어 하나의 결과를 나타내는 함수(집계 함수)
SELECT SUM(SAL)
    FROM EMP;

SELECT SUM(SAL), ENAME
    FROM EMP
GROUP BY ENAME;

SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO, EMPNO;