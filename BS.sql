SELECT * FROM DBA_USERS;
SELECT * FROM TAB;

-- DATABASE사용하기
-- 1. 사용할 계정을 관리자(SYSTEM) 계정으로 생성해줌
--     - 관리자로 접속해서 생성명령어를 이용함.
-- 2. 생성한 계정이 DATABASE를 이용하기 위해서는 권한부여 해줘야 한다.
--    - 관리자로 접속해서 권한 부여명령어를 이용
--    - 부여권한 : 접속할수있는 권한(CONNECT), 사용할 수 있는 권한(RESOURCE)

-- 계정생성하는 명령어
-- CREATE USER 사용자계정명 IDENTIFIED BY 비밀번호 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
CREATE USER BS IDENTIFIED BY BS DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
-- 18C버전부터 사용자계정명에 ##을 붙여서 생성해야 한다.
-- ##안붙일 수 있게 설정하기
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

-- DB에 등록되어 있는 사용자 조회하기
SELECT * FROM DBA_USERS;

-- 사용자를 생성하더라고 권한이 없으면 DB를 이용할 수 없다.
-- 사용자에게 권한부여하기
-- GRANT 권한 or 롤(역할) TO 사용자계정명
GRANT CONNECT TO BS;
-- 테이블을 이용할 수 있는 권한을 부여하기
GRANT RESOURCE TO BS;

GRANT CONNECT, RESOURCE TO BS;

-- BS계정에서 SQL문 실행해보기
SELECT * FROM TAB; --계정에서 이용하고 있는 테이블을 조회하는 명령어
CREATE TABLE TEST(
    TEST VARCHAR2(200)
);
-- USER01/USER01라는 계정을 생성하고 접속하고 아래 명령어 실행하기
--CREATE TABLE USER01(
-- AGE NUMBER
--); 

CREATE USER USER01 IDENTIFIED BY USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
GRANT RESOURCE, CONNECT TO USER01;

CREATE TABLE USER01 (
    AGE NUMBER
);
--
SELECT * FROM TAB;
SELECT * FROM BS.TEST;
SELECT * FROM USER01.USER01;

-- 기본실습 DB에 대해 알아보자.
-- 사원, 부서, 직책, 근무지, 급여수준, 근무지별 국가
-- 사원테이블의 정보확인하기
SELECT * FROM EMPLOYEE;
-- 부서테이블의 정보확인하기
SELECT * FROM DEPARTMENT;
-- 직책에 대한 정보확인하기
SELECT * FROM JOB;
-- 부서별 근무지
SELECT * FROM LOCATION;
-- 근무지역 국가별정보
SELECT * FROM NATIONAL;
-- 급여수준
SELECT * FROM SAL_GRADE;

-- SELECT문을 활용하기
-- 기본문법
-- SELECT 컬럼명,컬럼명.... OR *
-- FROM 테이블명;

-- SELECT문을 이용해서 EMPLOYEE테이블 조회하기
SELECT EMP_NAME, EMP_NO, EMAIL, PHONE
FROM EMPLOYEE;
-- SELECT문을 이용해서 EMPLOYEE테이블의 전체 컬럼 조회하기
SELECT *
FROM EMPLOYEE;

-- 전체 사원의 이름, 월급, 보너스 입사일을 조회하기
SELECT EMP_NAME, SALARY, BONUS, HIRE_DATE
FROM EMPLOYEE;

-- 모든 내용을 확인할때는 SELECT문을 이용함.
-- SELECT문을 이용해서 산술연산처리하기
-- +,-,*,/(사칙연산) -> 피연산자 리터럴, 컬럼값
SELECT 10+20, 10-20, 20/3, 5*4
FROM DUAL;

-- 리터럴, 컬럼 연산
-- 전체사원의 급여에 100 더하기
SELECT EMP_NAME, SALARY+100, SALARY
FROM EMPLOYEE;

-- 컬럼, 컬럼 연산
SELECT EMP_NAME, SALARY+BONUS
FROM EMPLOYEE;
-- NULL값과 연산은 불가능하다 -> 결과가 무조건 NULL로 출력됨.
SELECT SALARY, BONUS
FROM EMPLOYEE;

-- 산술연산은 숫자형만 가능하다.
-- 오라클에서 문자열 리터럴은 ''을 사용한다.
SELECT '이제 점심먹자'+100
FROM DUAL;

SELECT EMP_NAME, SALARY, BONUS, 10+30
FROM EMPLOYEE;

-- 사원테이블에서  사원명, 부서코드, 월급, 연봉 조회하기
SELECT EMP_NAME, DEPT_CODE, SALARY, SALARY*12
FROM EMPLOYEE;
-- 사원테이블에서  사원명, 부서코드, 월급, 보너스가 포함된 연봉 조회하기
SELECT EMP_NAME,DEPT_CODE, SALARY, (SALARY+(SALARY*BONUS))*12
FROM EMPLOYEE;

-- 테이블에 존재하는 컬럼만 조회가 가능하다
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE;
--SELECT * FROM DEPARTMENT;

SELECT * FROM EMPLOYEE;
-- 조회된 컬럼에 별칭을 부여할 수 있다. -> 가상컬럼에 많이 사용
-- AS 예약어를 사용한다.
-- 예) SELECT EMP_NAME AS 사원명 FROM EMPLOYEE
SELECT EMP_NAME AS 사원명, SALARY AS 월급, EMAIL AS 이메일
FROM EMPLOYEE;
-- AS 를 생략하고 띄어쓰기로 부여할 수 있다.
SELECT EMP_NAME 사원명, SALARY 월급, EMAIL 이메일
FROM EMPLOYEE;

-- 별칭에 띄어쓰기, 특수기호가 가능하니?
SELECT EMP_NAME AS "사 원 명", SALARY AS "$월$급"
FROM EMPLOYEE;


-- 조회되는 데이터의 중복을 제거해주는 명령어 : DISTINCT
-- 컬럼명 앞에 사용, SELECT문의 맨 앞에 작성
-- SELECT DISTINCT 컬럼명[,컬럼명...] FROM 테이블명
SELECT DEPT_CODE FROM EMPLOYEE;
SELECT DISTINCT DEPT_CODE FROM EMPLOYEE;
-- SELECT EMP_NAME, DISTINCT DEPT_CODE FROM EMEPLOYEE;
SELECT DISTINCT DEPT_CODE, EMP_NAME FROM EMPLOYEE;
SELECT DEPT_CODE, JOB_CODE FROM EMPLOYEE;
SELECT DISTINCT DEPT_CODE, JOB_CODE, SALARY FROM EMPLOYEE;

-- 오라클에서 문자열을 연결해주는 연산자 -> ||
SELECT '점심'+'맛있다' 
FROM DUAL;

SELECT '점심'||'맛없다 FEAT 반장'
FROM DUAL;
-- || 연산은 컬럼을 합쳐서 출력할때도 사용한다.
SELECT EMP_NAME||EMP_NO||EMAIL AS INFO
FROM EMPLOYEE;
SELECT EMP_NAME||SALARY||BONUS
FROM EMPLOYEE;

SELECT EMP_NAME||'님의 월급은 '||SALARY||' 보너스'||BONUS
FROM EMPLOYEE;

-- 원하는 ROW(DATA)만 출력하기
-- 지정한 조건에 맞는 데이터만 가져오기
-- WHERE 조건식 이용한다.
-- 사용방식
-- SELECT 컬럼, 컬럼...... OR *
-- FROM 테이블명
-- WHERE 조건식

SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE='D9';
-- 사원 중 월급이 200만원이상인 사원을 조회하기
SELECT * 
FROM EMPLOYEE
WHERE SALARY>=2000000;

-- 사원 중 직책이 J2가 아닌 사원 조회하기
SELECT *
FROM EMPLOYEE
WHERE JOB_CODE != 'J2';

-- 여러개의 비교연산 처리하기
-- 사원 중 부서가 D5이고 월급이 300만원 이상인 사원의 이름, 부서코드, 월급 조회하기
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5' AND SALARY>=3000000;

-- 사원 중 부서가 D5이거나 월급이 300만원 이상인 사원의 이름, 부서코드, 월급 조회하기
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5' OR SALARY>=3000000;

SELECT * 
FROM EMPLOYEE
WHERE 1=2;

-- 날짜를 대소비교하기
-- 날짜를 대소비교할때는 문자로 비교, 문자열 패턴을 맞춰줌.
-- 기본적이 날짜를 표시하는 문자열 패턴 : YY/MM/DD -> 'YY/MM/DD'
SELECT HIRE_DATE 
FROM EMPLOYEE;
-- 입사일이 2000년 01월 01일 이전이 사원의 이름, 입사일을 조회하기
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE<'00/01/01';

-- 입사일이 95년 01월 01일이전인 사원의 전체내용 조회하기
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE < '95/01/01';

-- 특정 범위에 있는 값을 조회하기
-- 사원 중 월급 200만원이상 300만원 이하 월급을 받는 사원의 사원명, 월급, 보너스, 입사일을 조회하기
SELECT EMP_NAME, SALARY, BONUS, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY>=2000000 AND SALARY <=3000000;
-- 사원중 입사일이 00년01월01부터 02년12월31일 까지인 사원 전체 조회하기
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE>='00/01/01' AND HIRE_DATE<='02/12/31';

-- 범위의 값을 조회할때 BETWEEN AND 연산을 이용하기
-- 컬럼명 BETWEEN 값 AND 값 ;
SELECT EMP_NAME, SALARY, BONUS, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY BETWEEN 2000000 AND 3000000;
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '00/01/01' AND '02/12/31' AND DEPT_CODE ='D9';

-- LIKE연산자 이용하기
-- 검색을 문자열 패턴으로 검색하는 기능 -> 부분일치, 포함여부, 원하는 문자열패턴검색
-- 문자열 패턴을 나타내는 기호
-- % : 문자가 0개이상 아무문자나 허용할때 사용
-- 예)  %강% : 강 o, 한강, 두강, 두만강, 한강다리, 강강술래 -> 강이 포함되어있는 문자열
--      %강 : 강으로 끝나는 말
--      강% : 강으로 시작하는 말
-- _ : 문자가 1개 아무문자나 허용할때 사용
-- 예) _강_ : 중간에 강이 있는 세글자
--    _강 : 강으로 끝나는 두글자
--    강_ : 강으로 시작하는 두글자
--    _강% : 두글자 이상의 두번째자리에 강을 포함하는 문자
-- 컬럼명 LIKE '패턴';

-- 사원 중 유씨성을 가진 사원의 이름, 월급, 부서코드를 조회
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '유__';

-- 이메일 주소에 yo를 포함하고 있는 사원의 사원명, 이메일 조회하기
SELECT EMP_NAME, EMAIL 
FROM EMPLOYEE
WHERE EMAIL LIKE '%yo%';

-- 이메일주소에 j를 포함하고 유씨성을 가진 사원 조회하기
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '%j%' AND EMP_NAME LIKE '유__'; 

-- LIKE에 일치하지 않는 사원 찾기
-- NOT부정연산사용
-- 김씨가 아닌 사원들 찾기
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME NOT LIKE '김%';

-- 이메일주소에 _앞글자가 3글자인 사원의 사원명 이메일 조회하기
SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___*_%' ESCAPE '*';

-- NULL값을 조회하기
-- NULL -> 쓰레기, 아무의미없는 값 -> 연산이 불가능
-- 오라클리 제공하는 NULL비교연산자를 사용
-- IS NULL, IS NOT NULL
-- 보너스를 받지 않는 사원조회하기
SELECT EMP_NAME,BONUS
FROM EMPLOYEE
--WHERE BONUS='(null)';
WHERE BONUS IS NULL;

-- 보너스를 받고있는 사원의 이름, 보IS너스를 조회하기
SELECT EMP_NAME,BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;


-- 조회된 컬럼값이 NULL일때 대체하기
-- NVL(컬럼명,대체값)함수를 이용
SELECT EMP_NAME, SALARY, NVL(BONUS,0)
FROM EMPLOYEE;

SELECT EMP_NAME, NVL(DEPT_CODE,'인턴') AS DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL;
--CREATE TABLE NAMETEST(
--    NAME2 VARCHAR2(200),
--    AGE NUMBER
--);
--
--INSERT INTO NAMETEST VALUES('유병승', 19);
--
--SELECT * FROM NAMETEST
--WHERE NAME2 NOT LIKE '%유%' OR NAME2 IS NULL;
--
--DROP TABLE NAMETEST;

-- 다중값 동등비교하기
-- IN / NOT IN : 여러개의 값을 OR로 연결해서 동등비교할때 사용하는 연산자
-- 사원 중 부서코드가 D5,D6,D7,D8인  사원구하기
SELECT * 
FROM EMPLOYEE
--WHERE DEPT_CODE='D5' OR DEPT_CODE='D6' OR DEPT_CODE='D7' OR DEPT_CODE='D8';
WHERE DEPT_CODE NOT IN ('D5','D6','D7','D8');

-- 서브쿼리문
--SELECT EMP_NAME, DEPT_CODE
--FROM EMPLOYEE
--WHERE DEPT_CODE IN(SELECT DEPT_ID FROM DEPARTMENT WHERE DEPT_TITLE='총무부' OR DEPT_TITLE LIKE '%해외%');

-- 연산자 우선순위
-- 직책이 J7이거나  J2인 사원 중 급여가 200만원이상인 사원을 조회하기
-- 이름, 월급, 직책코드
SELECT EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE (JOB_CODE='J7' OR JOB_CODE='J2') AND SALARY>=2000000;

--SCOTT/TIGER 계정을 생성 후 SCOTT_EN 테이블 추가

-- 1. 오라클을 설치한다. 
-- 2. SQLDEVELOPER압축 푼다 -> EXE파일 실행
-- 3. SYSTEM계정 접속생성하기 ->> DBA
-- 4. BS/BS 계정 생성, 권한 부여
-- 5. BS접속 생성하기 
-- 6. BS계정에서 BS.sql 스크립트실행하기
-- 7. BS계정에서 작업하기
-- 8. system계정으로 접속
-- 9. scott/tiger계정 생성 및 권한부여
-- 10. scott접속 생성
-- 11. scott 계정에서 scott_en.sql파일 실행

CREATE USER SCOTT IDENTIFIED BY TIGER DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
 GRANT CONNECT, RESOURCE TO SCOTT;


-- 오늘날짜를 출력할 수 있음 
--SYSDATE
SELECT SYSDATE FROM DUAL;
SELECT SYSDATE-10 FROM DUAL;
SELECT SYSDATE-HIRE_DATE
FROM EMPLOYEE;


-- 오라클에서 제공하는 함수에 대해 알아보자
-- 단일행함수 :  테이블의 모든 행에 결과가 반환되는 함수
--                  문자, 숫자, 날짜, 형변환, 선택함수(조건활용)
-- 그룹함수 :  테이블에 한개의 결과가 반환되는 함수
--               : 합계 평균 갯수 최대값 최소값

-- 단일행 함수 활용하기
-- 사용하는 위치
-- SELECT문의 컬럼을 작성하는 부분, WHERE절, 
-- INSERT, UPDATE, DELETE문에서 사용이 가능

-- 문자열함수에 대해알아보자
-- 문자열을 처리하는기능 
-- LENGTH : 지정된컬럼이나, 리터럴값에 대한 길이를 출력해주는 함수
-- LENGTH('문자열'||컬럼명)  - > 문자열의 갯수를 출력
SELECT LENGTH('오늘 월요일 힘내요!')
FROM DUAL;
SELECT EMAIL, LENGTH(EMAIL)
FROM EMPLOYEE;

-- 이메일이 16글자 이상인 사원을 조회하기
SELECT EMP_NAME, EMAIL, LENGTH(EMAIL)
FROM EMPLOYEE
WHERE LENGTH(EMAIL)>=16;

-- LENGTHB : 차지하는 BYTE를 출력
-- EXPRESS버전에서 한글은 3BYTE로 저장함. ENTERPRISE버전에서는 2BYTE
SELECT LENGTHB('ABCD'), LENGTHB('월요일')
FROM EMPLOYEE;

-- INSTR : JAVA의 INDEXOF 와 유사한 기능함.
-- INSTR('문자열'||컬럼,'찾을 문자'[,시작위치, 찾을번째(횟수)]
-- 오라클에서 인덱스번호는 1부터시작
-- 없는 값을 찾을때는 0이나온다.
SELECT INSTR('GD아카데미','GD'), INSTR('GD아카데미','아'),INSTR('GD아카데미','병')
FROM DUAL;

SELECT EMAIL, INSTR(EMAIL,'j')
FROM EMPLOYEE;


--EMAIL 주소에 j가 포함되어있는 사원찾기
--없으면 0이나 오니간 함수를 이용해서 찾을수도있다.
SELECT EMP_NAME,EMAIL
FROM EMPLOYEE
WHERE INSTR(EMAIL,'j')>0;

-- 시작위치 를 정해서 검색하기
-- 음수값을 집어넣으면 뒤에서부터찾는다.
-- 1부터 시작해서 3번째 를 찾아라
SELECT INSTR('GD아카데미 GD게임즈 GD음악사 GD화이팅','GD'),
            INSTR('GD아카데미 GD게임즈 GD음악사 GD화이팅','GD',3),
            -- 음수값을 집어넣으면 뒤에서부터찾는다.
            INSTR('GD아카데미 GD게임즈 GD음악사 GD화이팅','GD',-1),
            -- 1부터 시작해서 3번째 를 찾아라
            INSTR('GD아카데미 GD게임즈 GD음악사 GD화이팅','GD',1,3)
FROM DUAL;

-- 사원테이블에서 @의 위치를 찾기
SELECT EMP_NAME, EMAIL, INSTR(EMAIL,'@')
FROM EMPLOYEE;

-- LPAD/RPAD : 문자열의 길이가 지정한 길이만큼 차지 않았을때 빈공백을 채워주는 함수
-- LPAD/RPAD(문자열||컬럼,최대길이,대체문자)

--LPAD 왼쪽부터 빈공간채움
-- 대체문자를 정하지않앗다면 공백으로 출력
SELECT LPAD('유병승',10,'*'), LPAD('유병승',10)
FROM DUAL;
--RPAD 오른쪽부터 빈공간채움
SELECT RPAD('유병승',10,'@')
FROM DUAL;

-- 컬럼을 을 가져와서 사용가능
SELECT EMAIL, RPAD(EMAIL,20,'#')
FROM EMPLOYEE;

-- LTRIM/RTRIM : 공백을 제거하는 함수, 특정문자를 지정해서 삭제
-- LTRIM/RTRIM('문자열'||컬럼[,'특정문자'])
-- 공백으로 연달아있는 공백만지운다
-- 글자사이에 공백은 삭제하지않음
SELECT '              병승',  LTRIM ('             병승') , RTRIM('                병승              ')
FROM DUAL;
-- 특정문자를 지정해서 삭제할 수 있다.
-- 연달아있는 수만 지우고 다른문구가들어가있다면지우지않는다.
SELECT ' 병승2222', RTRIM('병승2222','2'), RTRIM('병승22122','2'),
RTRIM('병승22122','12')
FROM DUAL;

-- TRIM : 양쪽에 있는 값을 제거하는 함수, 기본 : 공백, 설정하면 설정값을 제거(한글자만)
-- TRIM(문자열||컬럼)
--              왼쪽      오른쪽     전부
-- TRIM(LEADING||TRAILING||BOTH '제거할문자' FROM 문자열||컬럼명)
    -- 삭제할 문자열은 한글자만가능!

SELECT '                    월요일                 ',TRIM( '                    월요일                 ')
,'ZZZZZZ마징가ZZZZZZ',TRIM('Z' FROM 'ZZZZZZ마징가ZZZZZZ'),
TRIM(LEADING 'Z' FROM 'ZZZZZZ마징가ZZZZZZ'),
TRIM(TRAILING 'Z' FROM 'ZZZZZZ마징가ZZZZZZ'),
TRIM(BOTH 'Z' FROM 'ZZZZZZ마징가ZZZZZZ')
FROM DUAL;

-- SUBSTR : 문자열을 잘라내는 기능 * JAVA SUBSTRING메소드와 동일
-- SUBSTR(문자열||컬럼명,시작인덱스번호,[,길이])
SELECT SUBSTR('SHOWMETHEMONEY',5), 
-- 5번째 중에 2개만 가져오겟다.
SUBSTR('SHOWMETHEMONEY',5,2),

SUBSTR('SHOWMETHEMONEY', INSTR('SHOWMETHEMONEY','MONEY')),

SUBSTR('SHOWMETHEMONEY',-5,2) 
FROM DUAL;

-- 사원의 이메일에서 아이디값만 출력하기
-- 아이디가 7글자이상인 사원만 조회
SELECT EMP_NAME, EMAIL,SUBSTR(EMAIL,1,INSTR(EMAIL,'@')-1) 
FROM EMPLOYEE
WHERE LENGTH(SUBSTR(EMAIL,1,INSTR(EMAIL,'@')-1))>=7;



-- 사원의 성별을 표시하는 번호를 출력
-- 여자사원만 조회
SELECT EMP_NAME , EMP_NO,SUBSTR(EMP_NO,8,1)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN (2,4);

-- 영문자를 처리하는 함수 : UPPER,LOWER, INITCAP
-- UPPER : 전부 대문자로처리
-- LOWER : 전부 소문자로 처리
-- INITCAP : 문자에 첫자리만 대문자
SELECT UPPER('Welcome to oRACLE worLd'),
LOWER('Welcome to oRACLE worLd'),
INITCAP('Welcome to oRACLE worLd')
FROM DUAL;

-- CONCAT : 문자열을 결합해주는 함수
-- | | 연산자와 동일하다.
SELECT EMP_NAME ||EMAIL, CONCAT(EMP_NAME, EMAIL)
,CONCAT(CONCAT(EMP_NAME, EMAIL),SALARY)
FROM EMPLOYEE;

-- REPLACE : 대상문자에서 지정문자를 찾아서 특정문자로 변경하는 것
-- PEPLACE(문자열||컬럼명,'찾을문자','대체문자')
SELECT EMAIL, REPLACE(EMAIL,'BS','GD')
FROM EMPLOYEE;
-- UPDATE문 사용 모든 이메일 변경
-- UPDATE EMPLOYEE SET EMAIL = REPLACE(EMAIL,'BS','GD');

-- REVERSE : 문자열을 거꾸로 만들어주는 기능
SELECT EMAIL, REVERSE(EMAIL), EMP_NAME, REVERSE(EMP_NAME),REVERSE(REVERSE(EMP_NAME))
FROM EMPLOYEE;

-- TRANSLATE :  매칭되는 문자로 변경해주는 함수
SELECT TRANSLATE ('010-3644-6259','0123456789','영일이삼사오육칠팔구')
FROM DUAL;


-- 숫자처리함수
-- ABS : 절대값을 처리하는 함수
SELECT ABS(-10), ABS(10)
FROM DUAL;

-- MOD : 나머지를 구하는 함수 * 자바의 %연산자와 동일한 함수
SELECT MOD(3,2)
FROM DUAL;

-- 전체를 출력할려면 별칭을 정해서 만들고 쓴다.
SELECT E.*, MOD(SALARY,3)
FROM EMPLOYEE E;

-- 소수점을 처리하는 함수
-- ROUND : 수서점을 반올림하는 함수
-- ROUND (숫자||컬럼명[,자리수])
SELECT 126.567,ROUND(126.567), ROUND(126.467),ROUND(126.567,2)
FROM DUAL;

-- 보너스를 포함한 월급구하기
SELECT EMP_NAME, SALARY, (SALARY+SALARY*NVL(BONUS,0)-(SALARY*0.03)),
ROUND(SALARY+SALARY*NVL(BONUS,0)-(SALARY*0.03))
FROM EMPLOYEE;

--FLOOR : 수서점자리 버림
SELECT 126.567, FLOOR(126.567)
FROM DUAL;

--TRUNC : 소수점자리를 버림 자리수를 지정
-- -2 는 소수점 앞으로 가서 0으로만들어버림 
SELECT 126.567, TRUNC(126.567) , TRUNC(126.567,2) ,TRUNC(126.567,-2),
    TRUNC(2123456.32,-2)
FROM DUAL;

-- CEIL : 소수점 올림
SELECT 126.567, CEIL(126.567),CEIL(126.111)
FROM EMPLOYEE;

-- 날짜처리함수 이용하기
-- 오라클에서 날짜를 출력할때는 두가지 방식이 있음
-- 1. SYSDATE예약어 -> 날짜 년/월/일 오늘 날짜(오라클이 설치되어있는 컴퓨터의 날짜)를 출력해줌.
-- 2. SYSTIMESTAMP예약어 -> 날짜+시간까지 출력해줌
SELECT SYSDATE, SYSTIMESTAMP
FROM DUAL;

--날짜도 산술연산처리가 가능하다, +,- 연산 가능 -> 일수가 차감, 추가됨.
SELECT SYSDATE, SYSDATE-2, SYSDATE+3,SYSDATE+30
FROM DUAL;

-- NEXT_DAY : 매개변수로 전달받은 요일 중 가장 가까운 다음 날짜 출력
--LOCALE의 값이 한국으로 되어있기에 월요일,수, 등등 가능
SELECT SYSDATE, NEXT_DAY(SYSDATE,'월'),NEXT_DAY(SYSDATE,'수')
FROM DUAL;

-- LOCALE의 값을 가지고 언어선택
SELECT * FROM V$NLS_PARAMETERS;
ALTER SESSION SET NLS_LANGUAGE = 'KOREAN';
SELECT SYSDATE, NEXT_DAY(SYSDATE,'MON'),NEXT_DAY(SYSDATE,'TUESDAY')
FROM DUAL;

-- LASY_DAY : 그달의 마지막날을 출력
SELECT SYSDATE, LAST_DAY(SYSDATE), LAST_DAY(SYSDATE+30)
FROM DUAL;

-- ADD_MONTHS : 개월수를 더하는 함수
SELECT SYSDATE, ADD_MONTHS(SYSDATE,4)
FROM DUAL;

-- MONTHS_BETWEEN : 두개의 날짜를 받아서 두날짜의 개월수를 계산해주는 함수
SELECT FLOOR (MONTHS_BETWEEN('23/08/17',SYSDATE))
FROM DUAL;

-- 날짜의 년도, 월, 일자를 따로 출력할 수 있는 함수
-- EXTRACT(YEAR||MONTH||DAY FROM 날짜)  : 숫자로 출력해줌.
-- 현재날짜의 년, 월, 일 출력하기
SELECT EXTRACT(YEAR FROM SYSDATE) AS 년 , EXTRACT(MONTH FROM SYSDATE) AS 월, EXTRACT(DAY FROM SYSDATE) AS 일
FROM DUAL;

-- 사원 중 12월에 입사한 사원들을 구하시오
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE   EXTRACT(MONTH FROM HIRE_DATE)=12;

-- 날짜에 숫자를 더할수있다.
SELECT EXTRACT(DAY FROM HIRE_DATE)+100
FROM EMPLOYEE;

-- 오늘부로 최주영씨가 군대로 다시끌려간다..? 군대복무기간은 1년6개월
-- 전역일자를 구하고, 전역때까지 먹는 짬밥수(하루세끼)를 구하기 

SELECT   SYSDATE AS 현재날짜, ADD_MONTHS(SYSDATE,18) AS 전역일자, (ADD_MONTHS(SYSDATE,18)-SYSDATE)*3 AS 짬밥
FROM DUAL;

-- 형변환 함수
-- 오라클에서는 자동형변환이 잘 작동을 한다.
-- 오라클 데이터를 저장하는 타입이 있음
-- 문자 : CHAR, VARCHAR2, NCHAR, NVARCHAR2 -> JAVA String과 동일하다.
-- 숫자 : NUMBER
-- 날짜 : DATE, TIMESTAMP

-- TO_CHAR :  숫자, 날짜를 문자형으로 변경해주는 함수
-- 날짜를 문자형으로 변경하기
-- 날짜값을 기호로표시해서 문자형으로 변경을 한다.
-- Y : 년, M : 월, D : 일 , H : 시 , MI : 분, ss : 초
SELECT SYSDATE, TO_CHAR(SYSDATE,'YYYY-MM-DD'), TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS')
FROM DUAL;

--컬럼에 시분초를 설정을안해서 안나옴
SELECT EMP_NAME, TO_CHAR(HIRE_DATE,'YYYY.MM.DD'), TO_CHAR(HIRE_DATE,'YYYY-MM-DD HH24:MI:SS')
FROM EMPLOYEE;

-- 숫자를 문자형으로 변경하기
-- 패턴에 맞춰서 변환 -> 자리수를 어떻게 표현할지 선택
-- 0 :  변환대상값의 자리수가 지정한 자리수와 일치하지않을때, 값이 없는 자리에 0을 표시하는 패턴
-- 9 :  변환대상값의 자리수가 지정한 자리수와 일치하지않을때, 값이 없는 자리에 생략하는 패턴 
-- 통화를 표시하고 싶을때는 L을 표시
-- FM을붙이면 공백제거
SELECT 1234567,TO_CHAR(1234567,'000,000,000'), TO_CHAR(1234567,'999,999,999'),
TO_CHAR(500,'L999,999')

FROM DUAL;


SELECT 180.5, TO_CHAR(180.5,'000,000.00'), TO_CHAR(180.5,'FM999,999.00') AS 키
FROM DUAL;

-- 월급을 통화표시하고 , 로 구분해서 출력하고 입사일은 0000.00.00으로 출력하기
SELECT EMP_NAME ,TO_CHAR(SALARY,'FML999,999,999') AS 급여 ,TO_CHAR(HIRE_DATE,'YYYY.MM.DD')AS 입사일
FROM EMPLOYEE;

-- 숫자형으로 변경하기
-- TO_NUMBER함수를 이용
-- 문자를 숫자형으로 변경하기
SELECT 1000000+1000000,TO_NUMBER('1,000,000','999,999,999')+1000000,
TO_CHAR(TO_NUMBER('1,000,000','999,999,999')+1000000,'FML999,999,999')
FROM DUAL;

-- 날짜형으로 변경하기
-- 숫자를 날짜로 변경
-- 문자열을 날짜로 변경
SELECT TO_DATE('23/12/25','YY/MM/DD')-SYSDATE, TO_DATE('241225','YYMMDD'),TO_DATE('25-12-25','YY-MM-DD')
FROM DUAL;

-- 년원일을 사용할떄 앞에 000이붙으면 조심해야한다 000은 읽지않기때문이다 그래서 문자열로 변경해서사용한다.
SELECT TO_DATE(20230405,'YYYY/MM/DD'), TO_DATE(230505,'YYMMDD'), TO_DATE (TO_CHAR(00224,'000000'),'YYMMDD')
FROM DUAL;

--NULL갑을 처리해주는 함수
--NVL함수 : NVL(컬럼,대체값)
--NVL2함수 : NVL2(컬럼,NULL아닐때, NULL일때)
SELECT EMP_NAME, DEPT_CODE, NVL(DEPT_CODE,'인턴'),
NVL2(DEPT_CODE,'있음','없음')
FROM EMPLOYEE;

-- 조건에 따라 출력할 값을 변경해주는 함수
-- 1. DECODE
-- DECODE(컬럼명 || 문자열, '예상값','대체값','예상값2','대체값2',.....)
-- 주민번호에서 8번째자리 수가 1이면 남자, 2이면 여자를 출력하는 컬럼추가하기
SELECT EMP_NAME, EMP_NO, DECODE(SUBSTR(EMP_NO,8,1),'1','남자','2','여자') AS GENDER
FROM EMPLOYEE;
--WHERE GENDER = '남자';

-- 각 직책코드의 명칭을 출력하기
-- J1은 대표, J2 부사장, J3 부장, J4 과장
-- 맨마지막에는 적으면디폴트값이된다.
SELECT EMP_NAME, DECODE(JOB_CODE,'J1','대표','J2','부사장','J3','부장','J4','과장','사원') AS 직책
FROM EMPLOYEE;

-- 2. CASE WHEN THEN ELSE 
-- CASE
--             WHEN 조건식 THEN 실행내용
--             WHEN 조건식 THEN 실행내용
--             WHEN 조건식 THEN 실행내용
--             ELSE 실행내용 
-- END

SELECT EMP_NAME, JOB_CODE,
            CASE
                    WHEN JOB_CODE = 'J1' THEN '대표'
                    WHEN JOB_CODE = 'J2' THEN '부사장'
                    WHEN JOB_CODE = 'J3' THEN '부장'
                    WHEN JOB_CODE = 'J4' THEN '과장'
                    ELSE '사원'
            END AS 직책,
            CASE JOB_CODE
                    WHEN 'J1' THEN '대표'
                    WHEN 'J2' THEN '부사장'
            END
FROM EMPLOYEE;

-- 월급을 기준으로 고액월급자와 중간월급자 그외를 나눠서 출력하기
-- 월급이 400만원 이상이면 고액
-- 월급이 400미만 300이상이면 중간월급자
-- 나머지는 그외를 출력하는 가상컬럼 만들기
-- 이름 , 월급 ,결과

SELECT EMP_NAME, SALARY,
            CASE
                    WHEN SALARY >=4000000 THEN '고액'
                    WHEN SALARY <4000000 AND  SALARY >=3000000 THEN '중간월급자'
                    ELSE '그외'
                    END AS 결과
FROM EMPLOYEE;

-- 사원테이블에서 현재나이 구하기
-- YY을가져올땐 무조건 현새기를 가져온다 EX) 2064,, 2085, 2077.....
-- RR 을가져올땐 
SELECT EMP_NAME, EMP_NO, EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2),'YY')) ||'살' AS YY년,
EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2),'RR')) ||'살' AS RR년,
EXTRACT(YEAR FROM SYSDATE) -(
TO_NUMBER(SUBSTR(EMP_NO,1,2))+
CASE
        WHEN SUBSTR(EMP_NO,8,1)IN (1,2) THEN 1900
        WHEN SUBSTR(EMP_NO,8,1)IN (3,4) THEN 2000
        END
        ) AS 살
FROM EMPLOYEE;

                    
insert into EMPLOYEE (EMP_ID,EMP_NAME,EMP_NO,EMAIL,PHONE,DEPT_CODE,JOB_CODE,SAL_LEVEL,SALARY,BONUS,MANAGER_ID,HIRE_DATE, ENT_DATE,ENT_YN) 
values ('251','월드컵','020808-2123341','go_dm@kh.or.kr',null,'D2','J2','S5',4480000,null,null,to_date('94/01/20','RR/MM/DD'),null,'N');
SELECT * FROM EMPLOYEE;


UPDATE EMPLOYEE SET EMP_NO = '320808-1123341' WHERE EMP_ID = '252';
COMMIT;

-- 그룹함수 활용하기
-- 테이블의 데이터에 대한 집계하는 함수들 합계, 평균, 갯수, 최대값, 최소값을 구하는 함수
-- 그룹함수의 결과는 기본적으로 한개의 값만 가져옴
-- 추가 컬럼을 선택하는것이 제한
-- 종류
-- SUM : 테이블의 특정컬럼에 대한 총합 -> SUM(컬럼(NUMBER))
-- AVG :  테이블의 특정컬럼에 대한 평균 -> AVG(컬럼(NUMBER))
-- COUNT : 테이블의 데이터수(ROW수) -> COUNT(* | | 컬럼)
-- MIN :  테이블의 특정컬럼에 대한 최소값 -> MIN(컬럼명)
-- MAX :  테이블의 특정컬럼에 대한 최대값 -> MAX(컬럼명)

-- 사원의 월급의 총합계를 구해보자
SELECT TO_CHAR (SUM(SALARY),'FML999,999,999') FROM EMPLOYEE;

-- D5 부서의 월급의 총합계를 구해보자
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE='D5';

-- 문자는 불가능
--SELECT SUM(EMP_NAME)
--FROM EMPLOYEE;

--J3사원의 급여 합계를 구하시옿
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE JOB_CODE ='J3';

-- 평균구하기 AVG함수
-- 전체사원에 대한 평균구하기
SELECT AVG(SALARY)FROM EMPLOYEE;
-- D5의 급여 평균을 구하기
SELECT AVG(SALARY) FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- D5부서의 급여합계와 평균구하기
-- 그룹함수 끼리 가져올수잇지만 기존컬럼은 가져올수가없다.
SELECT SUM(SALARY), AVG(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE='D5';

-- NULL값에 대해서는 어떻게 처리가 될까?
-- NULL값은 데이터를 제외해버린다.
SELECT SUM(BONUS),AVG(BONUS),AVG(NVL(BONUS,0))
FROM EMPLOYEE;

-- 테이블의 데이터수 확인하기
SELECT COUNT(*)
FROM EMPLOYEE;

-- 테이블의 데이터수 확인하기
-- 테이블에잇는값 모두 센다
--특정한컬럼을 출력한다면 NULL뺴고 전부 가져온다.
SELECT COUNT(*),COUNT(DEPT_CODE), COUNT(BONUS)
FROM EMPLOYEE;

-- D6부서의 인원 조회하세요
SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE
WHERE DEPT_CODE='D6';

-- 400만원 이상 월급을 받는 사원수
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SALARY>=4000000;

-- D5부서에서 보너스를 받고 있는 사원의수는?
SELECT COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE='D5' AND  BONUS IS NOT NULL ;

-- 부서가 D6, D5, D7인 사원의 수, 급여 합계, 평균을 조회하세요
SELECT COUNT(*) AS 사원의수 ,SUM(SALARY) AS 급여합계,AVG(SALARY) AS 평균
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D6','D7');

SELECT MAX(SALARY), MIN(SALARY)
FROM EMPLOYEE;

-- GROUP BY 절 활용하기
-- 그룹함수를 사용했을때 특정기준으로 컬럼값을 묶어서 처리하는 것 -> 묶인 그룹별 그룹함수의 결과가 출력됨.
-- SELECT 컬럼
-- FROM 테이블명
-- [WHERE 조건식]
-- [GROUP BY 컬럼명[,컬럼명,컬럼명,..... ]]
-- [ORDERY BY 컬럼명]

-- 부서별 급여 합계를 구하시오
SELECT DEPT_CODE,SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 직책별 급여의 합계, 평균을 구하시오
SELECT JOB_CODE,SUM(SALARY),AVG(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- 부서별 사원수 구하기
SELECT DEPT_CODE , COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- GROUP BY 절에는 다수의 컬럼을 넣을 수 있다.
SELECT DEPT_CODE, JOB_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE;

-- GROUP BY를 사용한 절에서 WHERE 도 사용이 가능하다.
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL
GROUP BY DEPT_CODE;

-- 부서별 인원이 3명이상인 부서만 출력하기
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
-- WHERE 는 그룹함수를 사용할수가없다.
--WHERE COUNT(*) >=3
GROUP BY DEPT_CODE
HAVING COUNT(*) >=3;

-- 직책별 인원수가 3명이상인 직책 출력하기
SELECT JOB_CODE , COUNT(*)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING COUNT(*)>=3;

-- 평균 급여가 300만원 이상인 부서출력하기
SELECT DEPT_CODE,AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY)>=3000000 AND COUNT(*)>=4;

-- 매니저가 관리하는 사원이 2명이상인 매니저 아이디 출력하기

SELECT MANAGER_ID , COUNT(*)
FROM EMPLOYEE
GROUP BY MANAGER_ID
HAVING COUNT(*)>=2 AND MANAGER_ID IS NOT NULL;

-- 남자, 여자의 급여 평균을 구하고 인원수를 구하기
SELECT DECODE(SUBSTR(EMP_NO,8,1),'1','남','3','남','2','여','4','여') AS 성별, AVG(SALARY) , COUNT(*)
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO,8,1),'1','남','3','남','2','여','4','여');

-- 각 그룹별 집계와 총 집계를 한번에 출력해주는 함수
-- ROLLUP(), CUBE()
-- GROUP BY ROLLUP(컬럼명)
-- GROUP BY CUBE(컬럼명)
--부서별 급여합계와 총합계를 조회하는 구문
SELECT SUM(SALARY)
FROM EMPLOYEE;
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY DEPT_CODE;

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY ROLLUP(DEPT_CODE);

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY CUBE(DEPT_CODE);

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
--GROUP BY ROLLUP(JOB_CODE);
GROUP BY CUBE(JOB_CODE);

-- ROLLUP, CUBE 함수의 인수로 한개이상의 컬럼을 넣을 수 있다.
-- ROLLUP : 두개이상의 인수를 전달했을때 두개 컬럼의 집계, 첫번째 인수컬럼의 소계, 전체 총계
-- CUBE : 두개이상 인수를 전달했을때 두개 컬럼의 집계, 첫번째 인수컬럼의 소계, 두번째 인수컬럼의 소개 , 전체 총계

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL 
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE);

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL 
GROUP BY CUBE(DEPT_CODE, JOB_CODE);


-- 부서별 , 직책별, 총사원을 한번에 조회하기
SELECT DEPT_CODE,JOB_CODE, COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY CUBE(DEPT_CODE, JOB_CODE);

-- GROUPING함수를 이용하면 집계한 결과에 대한 분기처리르 할 수 있다.
-- ROLLUP, CUBE로 집계된 ROW에 대한 분기처리
-- GROUPING 함수를 실행하면, ROLLUP, CUBE로 집계된 ROW 1을 반환 아니면 0을 반환

SELECT COUNT(*),DEPT_CODE, JOB_CODE,
CASE
WHEN GROUPING(DEPT_CODE)=0 AND GROUPING(JOB_CODE)=1 THEN '부서별인원'
WHEN GROUPING(DEPT_CODE)=1 AND GROUPING(JOB_CODE)=0 THEN '직책별인원'
WHEN GROUPING(DEPT_CODE)=0 AND GROUPING(JOB_CODE)=0 THEN '부서_직책인원'
WHEN GROUPING(DEPT_CODE)=1 AND GROUPING(JOB_CODE)=1 THEN '총인원'
END AS 결과
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY CUBE(DEPT_CODE, JOB_CODE);

-- 테이블에서 조회한 데이터 정렬하기
-- ORDER BY 구문을 사용함.
-- SELECT 컬럼명.....
-- FROM 테이블명
-- [WHERE 조건식]
-- [GROUP BY 컬럼명]
-- [HAVING 조건식]
-- 정렬방법은 생략가능 디포틀값으로 나옴 디폴트값 = 오름차순
-- [ORDER BY 컬럼명 정렬방식(DESC(내림),ASC(오름, DEFAULT)]

-- 이름을 기준으로 정렬하기
--오름차순
SELECT *
FROM EMPLOYEE
ORDER BY EMP_NAME;

--내림차순
SELECT *
FROM EMPLOYEE
ORDER BY EMP_NAME DESC;

-- 월급이 높은사람부터 낮은사람으로 정렬하기
-- 이름 , 급여, 보너스
SELECT EMP_NAME, SALARY, NVL(BONUS,0)
FROM EMPLOYEE
ORDER BY SALARY DESC;

-- 부서코드를 기준으로 오름차순정렬하고 값이 같으면 월급이 내림차순으로 정렬하기
SELECT *
FROM EMPLOYEE
ORDER BY DEPT_CODE ASC, SALARY DESC, EMP_NAME ASC;

-- 정렬햇을때 NULL값에 대한 처리
-- BONUS를 많이 받는 사원부터 출력하기
SELECT *
FROM EMPLOYEE
--ORDER BY BONUS  DESC; -- NULL인 값을 먼저 출력한다.
--ORDER BY BONUS  ASC; -- NULL인 값을 나중에 출력한다.
-- 옵션을 설정해서 NULL값출력위치를 변경할 수 있다.
--ORDER BY BONUS ASC NULLS FIRST;
ORDER BY BONUS ASC NULLS LAST;


-- ORDER BY 절에서는 별칭을 사용할 수 있음
SELECT EMP_NAME, SALARY AS 월급, BONUS
FROM EMPLOYEE
-- WHERE 에는 쓰지못한다'월급'  FROM을먼저 그다음 웨월 그다음에 별칭을 부여하기때문에 불가능하다.
ORDER BY 월급;


-- SELECT문을 이용해서 데이터를 조회하면 RESULT SET 이 출력되는데
-- RESULT SET 에 출력되는 컬럼에는 자동으로 INDEX번호가 1부터 부여가 된다.
SELECT *
FROM EMPLOYEE
-- SELECT 는 출력시 컬럼명에 순서대로 인덱스부여한다 그인덱스번호를 사용할수있다.
ORDER BY 2;


--  집합연산자
-- 여러개의 SELECT문을 한개의 결과(RESULT SET)으로 출력해주는 것
-- 첫번째 SELECT문의 컬럼수와 이후 SELECT문의 컬럼수가 같아야한다.
-- 각 컬럼별 데이터 타입도 동일해아한다.

-- UNION : 두개이상의 SELECT문을 합치는 연산자
-- SELECT 문 UNION SELECT문

-- UNION : 중복값이 있을때 하나만 출력된다.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY>=3000000;

-- UNION ALL :  중복값이있다면 중복값 포함시킨다
-- MINUIS : 중복값 포함 하지않는다.
-- INTERSECT :  중복값만 가져오다.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY>=3000000;



SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5'
UNION
-- 두 SELECT문의 컬럼의 수가 다르면 안된다.
--SELECT EMP_ID,EMP_NAME,SALARY,BONUS
--FROM EMPLOYEE
--WHERE SALARY>3000000;

-- 두개의 SELECT문의 컬럼의 타입도 맞춰야 한다.
SELECT EMP_ID,EMP_NAME,EMP_NO
FROM EMPLOYEE
WHERE SALARY>3000000;

-- 다른 테이블에 있는 데이터를 합치기
-- 맞는 컬럼이없을경우 고정값(리터럴값)을 정해서 넣을수도있다.
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
UNION
SELECT DEPT_ID, DEPT_TITLE , 10
FROM DEPARTMENT;

SELECT EMP_ID,EMP_NAME
FROM EMPLOYEE
UNION
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT
UNION
SELECT JOB_CODE, JOB_NAME
FROM JOB
MINUS
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D6','D7');

-- GROUPING SET
-- 여러 GROUP BY 절이 있는 구문을 하나로 작성하게 해주는 기능
-- 부서, 직책, 매니저별 급여평균
SELECT DEPT_CODE, JOB_CODE, MANAGER_ID , AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE,JOB_CODE, MANAGER_ID;
-- 부서, 직책별, 급여평균
SELECT DEPT_CODE, JOB_CODE , AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE,JOB_CODE;
-- 부서, 매니저별 급여평균
SELECT DEPT_CODE,  MANAGER_ID , AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, MANAGER_ID;

-- GROUPING SET 을 이용해서 묶어서 사용해줄수있다.
SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, AVG(SALARY)
FROM EMPLOYEE
GROUP BY GROUPING SETS((DEPT_CODE,JOB_CODE,MANAGER_ID),(DEPT_CODE,JOB_CODE),(DEPT_CODE, MANAGER_ID));


 --  JOIN에 대해 알아보자
 -- 두개이상의 테이블을 특정컬럼을 기준으로 연결해준, 기능
 -- JOIN은 두 종류가 있음
 -- 1. INNER JOIN : 기준되는 값이 일치하는 ROW만 가져오는 JOIN
 -- 2. OUTER JOIN :  기준이되는 값이 일치하지 않은 ROW도 가져오는 JOIN * 기준이 필요
 
 -- JOIN을 작성하는 방법 2가지
 -- 1. 오라클 조인방식 :  , 와 WHERE로 작성
 -- 2. ANSI 표준 조인방식 :  JOIN, ON | | USING 예약어를 사용해서 작성
 
 -- EMPLOYEE테이블과 DEPARTMENT테이블 JOIN하기
 SELECT* FROM EMPLOYEE;
 SELECT* FROM DEPARTMENT;
 
 -- 오라클방식으로 JOIN하기
 SELECT *
 FROM EMPLOYEE;
 
 SELECT*
 FROM EMPLOYEE, DEPARTMENT
 WHERE EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID;
 
 -- ANSI 표준으로 JOIN하기
 SELECT *
 FROM EMPLOYEE 
 JOIN DEPARTMENT ON EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID;
 
-- 사원에 대해 사원명, 이메일, 전화번호, 부서명을 조회하기
SELECT EMP_NAME, EMAIL, PHONE,DEPT_TITLE
FROM EMPLOYEE 
JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID; 

 -- JOIN 문에서도 WHERE절 사용하기
 -- 부서가 총무부인 사원  사원명, 월급, 보너스, 부서명 조회하기
 SELECT EMP_NAME, SALARY,BONUS, DEPT_TITLE
 FROM EMPLOYEE
 JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID
 WHERE DEPT_TITLE = '총무부';
 
 -- JOIN 문에서 GROUP BY 절 사용하기
 -- 부서별 평균급여를 출력하기 부서명, 평균급여
 SELECT DEPT_TITLE,AVG(SALARY)
 FROM EMPLOYEE
 JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
 GROUP BY DEPT_TITLE
HAVING AVG(SALARY)>=3000000;

-- JOIN할때 기준이되는 컬럼명이 중복된다면 반드시 별칭을 작성해야한다.
-- 사원명, 급여, 보너스, 직책명을 조회하기
-- 다른 테이블이지만 컬럼명이 같앗을경우 오류가뜬다. 
-- ambiguously 오류가떳을때 테이블앞에 별칭을 부여하던 명칭을 부여해야한다.
SELECT * --EMP_NAME ,SALARY, BONUS, JOB_NAME
FROM EMPLOYEE E
    JOIN JOB J ON E.JOB_CODE=J.JOB_CODE;

-- 중복되는 컬럼명으로 조인할 때는 USING을 이용할 수 있다.
-- 중복되는 코드가 하나만 출력이된다.
-- 하나만 출력되기때문에 별칭부여해서 구분할필요가없다.
-- USING 을사용할때 식별자(별칭)를 쓰지않는다.
SELECT * --EMP_NAME, SALARY, BONUS, JOB_NAME
FROM EMPLOYEE
    JOIN JOB  USING(JOB_CODE)
WHERE JOB_CODE='J3'; 
SELECT * FROM JOB;

-- 직책이 과장인 사원의 이름, 직책명, 직책코드, 월급을 조회하세요.
SELECT  EMP_NAME, JOB_NAME,JOB_CODE, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장';

-- JOIN 은 NULL값을 무시한다.
SELECT COUNT(*)
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID;

SELECT * FROM EMPLOYEE;

-- OUTER JOIN사용하기
-- 컬럼에 대해 동일비교를 했을때 없는 ROW를 출력해주는 JOIN
-- 기준이 되는 테이블(모든데이터를 출력함)을 설정해줘야한다.
-- LEFT OUTER JOIN : JOIN을 기준으로 왼쪽에 있는 테이블을 기준으로 설정
-- RIGHT OUTER JOIN : JOIN을 기준으로 오른쪽에 있는 테이블을 기준으로 설정
-- 일치되는 ROW가 없는 경우 모든 컬럼을 NULL로 표시한다.
-- OUTER 은 생략해도 상관없음
SELECT *
FROM EMPLOYEE LEFT  JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID;

SELECT *
FROM EMPLOYEE RIGHT OUTER JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID;

-- CROSS JOIN : 모든 ROW를 연결해주는 JOIN
-- 
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE CROSS JOIN DEPARTMENT
ORDER BY 1;

-- SELF JOIN : 한개의 테이블에 다른 컬럼의 값을 가지고 있는 컬럼이 있는 경우 그두개 컬럼을 이용해서 JOIN
SELECT * FROM EMPLOYEE;
-- MANAGER가 있는 사원의 이름, 매니저 아이디, 매니저 사원번호, 매니저 이름 조회
SELECT E.EMP_NAME,E.MANAGER_ID,M.EMP_ID,M.EMP_NAME
FROM EMPLOYEE E
JOIN EMPLOYEE M ON E.MANAGER_ID=M.EMP_ID;

-- 사원이름, 매니저아이디, 매니저사원번호, 매니저 이름 조회
-- 매니저가 없으면 없을 출력하기
SELECT E.EMP_NAME,NVL(E.MANAGER_ID,'없음'),NVL(M.EMP_ID,'없음') ,NVL(M.EMP_NAME,'없음')
FROM  EMPLOYEE E
         LEFT   JOIN EMPLOYEE M ON E.MANAGER_ID=M.EMP_ID;

SELECT * FROM EMPLOYEE;


-- 동등조인 동등비교를 해서 처리함. ON 컬럼명=컬럼명
-- 비동등조인에 대해 알아보자
-- 연결할 테이블이 범위값을 가져야한다.
SELECT * FROM SAL_GRADE;
SELECT * 
FROM EMPLOYEE
        JOIN SAL_GRADE ON SALARY BETWEEN MIN_SAL AND  MAX_SAL;
-- 회원등급 포이튼재로, 상품등급(상태) , 댓글 수에 따른 회원등급

-- 다중조인을 할 수 있다.
-- 3개이상의 테이블을 연결해서 사용하기
--사원의 사원명, 직책명, 부서명을 조회하기
SELECT EMP_NAME,JOB_NAME,DEPT_TITLE
FROM EMPLOYEE
        JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID
        JOIN JOB  USING(JOB_CODE);
        
-- 사원의 사원명, 부서명, 직챙명, 근무지역(LOCALNAME)조회하기
-- 부서명이 없으면 대기, 근무지역이 없으면 대기발령을 출력
SELECT EMP_NAME,NVL(DEPT_TITLE,'대기'),JOB_NAME,NVL(LOCAL_NAME,'대기발령')
FROM EMPLOYEE
        LEFT JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID
        LEFT JOIN LOCATION ON LOCATION_ID=LOCAL_CODE
        JOIN JOB USING(JOB_CODE);

-- 서브쿼리  : SELECT 문 안에 SELECT문이 하나 더 있는 쿼리문을 말함.
-- 서브쿼리는 반드시 괄호안에 작성을 해야한다.
-- 윤은혜사원과 동일한 급여를 받고있는 사원을 조회하기
SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME='윤은해';
SELECT *
FROM EMPLOYEE
WHERE SALARY = 2000000;

SELECT *
FROM EMPLOYEE
WHERE SALARY = (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '윤은해');

-- D5부서의 평균급여보다 많이 받는 사원구하기
SELECT *
FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEE WHERE DEPT_CODE = 'D5');

-- 1. 단일행서브쿼리
-- 서브쿼리 SELECT문의 결과가  1개열, 1개행인 것
-- 위에잇는것들이전부 단일행 서브쿼리다.
-- 컬럼(SELECT), WHERE절에 비교대상 값
-- 사원들의 급여 평균보다 많이 급여를 받는 사원의 이름, 급여 , 부서코드를 출력하기
SELECT EMP_NAME, SALARY, DEPT_CODE,(SELECT AVG(SALARY)FROM EMPLOYEE) AS AVG
FROM EMPLOYEE
WHERE SALARY>=(SELECT AVG(SALARY) FROM EMPLOYEE);
  
  -- 부서가 총무부인 사원을 조회하기
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_ID FROM DEPARTMENT WHERE  DEPT_TITLE='총무부');

-- 위에를 조인해서 사용할수도있다.
SELECT *
FROM EMPLOYEE
        JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE = '총무부';

-- 직책이 과장인 사원을 조회하기
SELECT *
FROM EMPLOYEE
WHERE JOB_CODE = (SELECT JOB_CODE FROM JOB WHERE JOB_NAME = '과장');

-- 2. 다중행 서브쿼리
-- 서브쿼리의 결과가 한개열 다수 행(ROW) 을 갖는 것
-- 직책이 부장, 과장인 사원을 조회하기
SELECT JOB_CODE
FROM JOB
WHERE JOB_NAME IN('부장','과장');

-- 다중행을 동등비교할때 = 을 사용불가능
-- OR 나 IN 으로 연결해서 사용한다.
SELECT *
FROM EMPLOYEE
WHERE JOB_CODE IN( SELECT JOB_CODE FROM JOB WHERE JOB_NAME IN ('부장','과장'));

-- 다중행에 대한 대소비교하기
-- >=, >, <, <=
--다중행 대소비교할떄는 쓰는명령어
-- ANY : OR로 ROW를 연결
-- ALL  :  AND로 ROW를 연결
-- 컬럼 >(=) ANY(서브쿼리) :  다중행 서브쿼리의 결과 중 하나라도 크면 참 -> 다중행 서브쿼리의 결과중 최소값보다 크면
-- 컬럼<(=) ANY(서브쿼리) :  다중행 서브쿼리의 결과 중 하나라도 작으면 참 -> 다중행 서브쿼리의 결과중 최대값보다 작으면 참
SELECT *
FROM EMPLOYEE
WHERE SALARY >=  (SELECT SALARY FROM EMPLOYEE WHERE DEPT_CODE IN('D5','D6'));

SELECT *
FROM EMPLOYEE
WHERE SALARY >= ANY(SELECT SALARY FROM EMPLOYEE WHERE DEPT_CODE IN ('D5','D6'));





