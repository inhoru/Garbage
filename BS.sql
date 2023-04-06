SELECT * FROM DBA_USERS;
SELECT * FROM TAB;

-- DATABASE����ϱ�
-- 1. ����� ������ ������(SYSTEM) �������� ��������
--     - �����ڷ� �����ؼ� ������ɾ �̿���.
-- 2. ������ ������ DATABASE�� �̿��ϱ� ���ؼ��� ���Ѻο� ����� �Ѵ�.
--    - �����ڷ� �����ؼ� ���� �ο���ɾ �̿�
--    - �ο����� : �����Ҽ��ִ� ����(CONNECT), ����� �� �ִ� ����(RESOURCE)

-- ���������ϴ� ��ɾ�
-- CREATE USER ����ڰ����� IDENTIFIED BY ��й�ȣ DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
CREATE USER BS IDENTIFIED BY BS DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
-- 18C�������� ����ڰ����� ##�� �ٿ��� �����ؾ� �Ѵ�.
-- ##�Ⱥ��� �� �ְ� �����ϱ�
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

-- DB�� ��ϵǾ� �ִ� ����� ��ȸ�ϱ�
SELECT * FROM DBA_USERS;

-- ����ڸ� �����ϴ���� ������ ������ DB�� �̿��� �� ����.
-- ����ڿ��� ���Ѻο��ϱ�
-- GRANT ���� or ��(����) TO ����ڰ�����
GRANT CONNECT TO BS;
-- ���̺��� �̿��� �� �ִ� ������ �ο��ϱ�
GRANT RESOURCE TO BS;

GRANT CONNECT, RESOURCE TO BS;

-- BS�������� SQL�� �����غ���
SELECT * FROM TAB; --�������� �̿��ϰ� �ִ� ���̺��� ��ȸ�ϴ� ��ɾ�
CREATE TABLE TEST(
    TEST VARCHAR2(200)
);
-- USER01/USER01��� ������ �����ϰ� �����ϰ� �Ʒ� ��ɾ� �����ϱ�
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

-- �⺻�ǽ� DB�� ���� �˾ƺ���.
-- ���, �μ�, ��å, �ٹ���, �޿�����, �ٹ����� ����
-- ������̺��� ����Ȯ���ϱ�
SELECT * FROM EMPLOYEE;
-- �μ����̺��� ����Ȯ���ϱ�
SELECT * FROM DEPARTMENT;
-- ��å�� ���� ����Ȯ���ϱ�
SELECT * FROM JOB;
-- �μ��� �ٹ���
SELECT * FROM LOCATION;
-- �ٹ����� ����������
SELECT * FROM NATIONAL;
-- �޿�����
SELECT * FROM SAL_GRADE;

-- SELECT���� Ȱ���ϱ�
-- �⺻����
-- SELECT �÷���,�÷���.... OR *
-- FROM ���̺��;

-- SELECT���� �̿��ؼ� EMPLOYEE���̺� ��ȸ�ϱ�
SELECT EMP_NAME, EMP_NO, EMAIL, PHONE
FROM EMPLOYEE;
-- SELECT���� �̿��ؼ� EMPLOYEE���̺��� ��ü �÷� ��ȸ�ϱ�
SELECT *
FROM EMPLOYEE;

-- ��ü ����� �̸�, ����, ���ʽ� �Ի����� ��ȸ�ϱ�
SELECT EMP_NAME, SALARY, BONUS, HIRE_DATE
FROM EMPLOYEE;

-- ��� ������ Ȯ���Ҷ��� SELECT���� �̿���.
-- SELECT���� �̿��ؼ� �������ó���ϱ�
-- +,-,*,/(��Ģ����) -> �ǿ����� ���ͷ�, �÷���
SELECT 10+20, 10-20, 20/3, 5*4
FROM DUAL;

-- ���ͷ�, �÷� ����
-- ��ü����� �޿��� 100 ���ϱ�
SELECT EMP_NAME, SALARY+100, SALARY
FROM EMPLOYEE;

-- �÷�, �÷� ����
SELECT EMP_NAME, SALARY+BONUS
FROM EMPLOYEE;
-- NULL���� ������ �Ұ����ϴ� -> ����� ������ NULL�� ��µ�.
SELECT SALARY, BONUS
FROM EMPLOYEE;

-- ��������� �������� �����ϴ�.
-- ����Ŭ���� ���ڿ� ���ͷ��� ''�� ����Ѵ�.
SELECT '���� ���ɸ���'+100
FROM DUAL;

SELECT EMP_NAME, SALARY, BONUS, 10+30
FROM EMPLOYEE;

-- ������̺���  �����, �μ��ڵ�, ����, ���� ��ȸ�ϱ�
SELECT EMP_NAME, DEPT_CODE, SALARY, SALARY*12
FROM EMPLOYEE;
-- ������̺���  �����, �μ��ڵ�, ����, ���ʽ��� ���Ե� ���� ��ȸ�ϱ�
SELECT EMP_NAME,DEPT_CODE, SALARY, (SALARY+(SALARY*BONUS))*12
FROM EMPLOYEE;

-- ���̺� �����ϴ� �÷��� ��ȸ�� �����ϴ�
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE;
--SELECT * FROM DEPARTMENT;

SELECT * FROM EMPLOYEE;
-- ��ȸ�� �÷��� ��Ī�� �ο��� �� �ִ�. -> �����÷��� ���� ���
-- AS ���� ����Ѵ�.
-- ��) SELECT EMP_NAME AS ����� FROM EMPLOYEE
SELECT EMP_NAME AS �����, SALARY AS ����, EMAIL AS �̸���
FROM EMPLOYEE;
-- AS �� �����ϰ� ����� �ο��� �� �ִ�.
SELECT EMP_NAME �����, SALARY ����, EMAIL �̸���
FROM EMPLOYEE;

-- ��Ī�� ����, Ư����ȣ�� �����ϴ�?
SELECT EMP_NAME AS "�� �� ��", SALARY AS "$��$��"
FROM EMPLOYEE;


-- ��ȸ�Ǵ� �������� �ߺ��� �������ִ� ��ɾ� : DISTINCT
-- �÷��� �տ� ���, SELECT���� �� �տ� �ۼ�
-- SELECT DISTINCT �÷���[,�÷���...] FROM ���̺��
SELECT DEPT_CODE FROM EMPLOYEE;
SELECT DISTINCT DEPT_CODE FROM EMPLOYEE;
-- SELECT EMP_NAME, DISTINCT DEPT_CODE FROM EMEPLOYEE;
SELECT DISTINCT DEPT_CODE, EMP_NAME FROM EMPLOYEE;
SELECT DEPT_CODE, JOB_CODE FROM EMPLOYEE;
SELECT DISTINCT DEPT_CODE, JOB_CODE, SALARY FROM EMPLOYEE;

-- ����Ŭ���� ���ڿ��� �������ִ� ������ -> ||
SELECT '����'+'���ִ�' 
FROM DUAL;

SELECT '����'||'������ FEAT ����'
FROM DUAL;
-- || ������ �÷��� ���ļ� ����Ҷ��� ����Ѵ�.
SELECT EMP_NAME||EMP_NO||EMAIL AS INFO
FROM EMPLOYEE;
SELECT EMP_NAME||SALARY||BONUS
FROM EMPLOYEE;

SELECT EMP_NAME||'���� ������ '||SALARY||' ���ʽ�'||BONUS
FROM EMPLOYEE;

-- ���ϴ� ROW(DATA)�� ����ϱ�
-- ������ ���ǿ� �´� �����͸� ��������
-- WHERE ���ǽ� �̿��Ѵ�.
-- �����
-- SELECT �÷�, �÷�...... OR *
-- FROM ���̺��
-- WHERE ���ǽ�

SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE='D9';
-- ��� �� ������ 200�����̻��� ����� ��ȸ�ϱ�
SELECT * 
FROM EMPLOYEE
WHERE SALARY>=2000000;

-- ��� �� ��å�� J2�� �ƴ� ��� ��ȸ�ϱ�
SELECT *
FROM EMPLOYEE
WHERE JOB_CODE != 'J2';

-- �������� �񱳿��� ó���ϱ�
-- ��� �� �μ��� D5�̰� ������ 300���� �̻��� ����� �̸�, �μ��ڵ�, ���� ��ȸ�ϱ�
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5' AND SALARY>=3000000;

-- ��� �� �μ��� D5�̰ų� ������ 300���� �̻��� ����� �̸�, �μ��ڵ�, ���� ��ȸ�ϱ�
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5' OR SALARY>=3000000;

SELECT * 
FROM EMPLOYEE
WHERE 1=2;

-- ��¥�� ��Һ��ϱ�
-- ��¥�� ��Һ��Ҷ��� ���ڷ� ��, ���ڿ� ������ ������.
-- �⺻���� ��¥�� ǥ���ϴ� ���ڿ� ���� : YY/MM/DD -> 'YY/MM/DD'
SELECT HIRE_DATE 
FROM EMPLOYEE;
-- �Ի����� 2000�� 01�� 01�� ������ ����� �̸�, �Ի����� ��ȸ�ϱ�
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE<'00/01/01';

-- �Ի����� 95�� 01�� 01�������� ����� ��ü���� ��ȸ�ϱ�
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE < '95/01/01';

-- Ư�� ������ �ִ� ���� ��ȸ�ϱ�
-- ��� �� ���� 200�����̻� 300���� ���� ������ �޴� ����� �����, ����, ���ʽ�, �Ի����� ��ȸ�ϱ�
SELECT EMP_NAME, SALARY, BONUS, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY>=2000000 AND SALARY <=3000000;
-- ����� �Ի����� 00��01��01���� 02��12��31�� ������ ��� ��ü ��ȸ�ϱ�
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE>='00/01/01' AND HIRE_DATE<='02/12/31';

-- ������ ���� ��ȸ�Ҷ� BETWEEN AND ������ �̿��ϱ�
-- �÷��� BETWEEN �� AND �� ;
SELECT EMP_NAME, SALARY, BONUS, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY BETWEEN 2000000 AND 3000000;
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '00/01/01' AND '02/12/31' AND DEPT_CODE ='D9';

-- LIKE������ �̿��ϱ�
-- �˻��� ���ڿ� �������� �˻��ϴ� ��� -> �κ���ġ, ���Կ���, ���ϴ� ���ڿ����ϰ˻�
-- ���ڿ� ������ ��Ÿ���� ��ȣ
-- % : ���ڰ� 0���̻� �ƹ����ڳ� ����Ҷ� ���
-- ��)  %��% : �� o, �Ѱ�, �ΰ�, �θ���, �Ѱ��ٸ�, �������� -> ���� ���ԵǾ��ִ� ���ڿ�
--      %�� : ������ ������ ��
--      ��% : ������ �����ϴ� ��
-- _ : ���ڰ� 1�� �ƹ����ڳ� ����Ҷ� ���
-- ��) _��_ : �߰��� ���� �ִ� ������
--    _�� : ������ ������ �α���
--    ��_ : ������ �����ϴ� �α���
--    _��% : �α��� �̻��� �ι�°�ڸ��� ���� �����ϴ� ����
-- �÷��� LIKE '����';

-- ��� �� �������� ���� ����� �̸�, ����, �μ��ڵ带 ��ȸ
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��__';

-- �̸��� �ּҿ� yo�� �����ϰ� �ִ� ����� �����, �̸��� ��ȸ�ϱ�
SELECT EMP_NAME, EMAIL 
FROM EMPLOYEE
WHERE EMAIL LIKE '%yo%';

-- �̸����ּҿ� j�� �����ϰ� �������� ���� ��� ��ȸ�ϱ�
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '%j%' AND EMP_NAME LIKE '��__'; 

-- LIKE�� ��ġ���� �ʴ� ��� ã��
-- NOT����������
-- �达�� �ƴ� ����� ã��
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME NOT LIKE '��%';

-- �̸����ּҿ� _�ձ��ڰ� 3������ ����� ����� �̸��� ��ȸ�ϱ�
SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___*_%' ESCAPE '*';

-- NULL���� ��ȸ�ϱ�
-- NULL -> ������, �ƹ��ǹ̾��� �� -> ������ �Ұ���
-- ����Ŭ�� �����ϴ� NULL�񱳿����ڸ� ���
-- IS NULL, IS NOT NULL
-- ���ʽ��� ���� �ʴ� �����ȸ�ϱ�
SELECT EMP_NAME,BONUS
FROM EMPLOYEE
--WHERE BONUS='(null)';
WHERE BONUS IS NULL;

-- ���ʽ��� �ް��ִ� ����� �̸�, ��IS�ʽ��� ��ȸ�ϱ�
SELECT EMP_NAME,BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;


-- ��ȸ�� �÷����� NULL�϶� ��ü�ϱ�
-- NVL(�÷���,��ü��)�Լ��� �̿�
SELECT EMP_NAME, SALARY, NVL(BONUS,0)
FROM EMPLOYEE;

SELECT EMP_NAME, NVL(DEPT_CODE,'����') AS DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL;
--CREATE TABLE NAMETEST(
--    NAME2 VARCHAR2(200),
--    AGE NUMBER
--);
--
--INSERT INTO NAMETEST VALUES('������', 19);
--
--SELECT * FROM NAMETEST
--WHERE NAME2 NOT LIKE '%��%' OR NAME2 IS NULL;
--
--DROP TABLE NAMETEST;

-- ���߰� ������ϱ�
-- IN / NOT IN : �������� ���� OR�� �����ؼ� ������Ҷ� ����ϴ� ������
-- ��� �� �μ��ڵ尡 D5,D6,D7,D8��  ������ϱ�
SELECT * 
FROM EMPLOYEE
--WHERE DEPT_CODE='D5' OR DEPT_CODE='D6' OR DEPT_CODE='D7' OR DEPT_CODE='D8';
WHERE DEPT_CODE NOT IN ('D5','D6','D7','D8');

-- ����������
--SELECT EMP_NAME, DEPT_CODE
--FROM EMPLOYEE
--WHERE DEPT_CODE IN(SELECT DEPT_ID FROM DEPARTMENT WHERE DEPT_TITLE='�ѹ���' OR DEPT_TITLE LIKE '%�ؿ�%');

-- ������ �켱����
-- ��å�� J7�̰ų�  J2�� ��� �� �޿��� 200�����̻��� ����� ��ȸ�ϱ�
-- �̸�, ����, ��å�ڵ�
SELECT EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE (JOB_CODE='J7' OR JOB_CODE='J2') AND SALARY>=2000000;

--SCOTT/TIGER ������ ���� �� SCOTT_EN ���̺� �߰�

-- 1. ����Ŭ�� ��ġ�Ѵ�. 
-- 2. SQLDEVELOPER���� Ǭ�� -> EXE���� ����
-- 3. SYSTEM���� ���ӻ����ϱ� ->> DBA
-- 4. BS/BS ���� ����, ���� �ο�
-- 5. BS���� �����ϱ� 
-- 6. BS�������� BS.sql ��ũ��Ʈ�����ϱ�
-- 7. BS�������� �۾��ϱ�
-- 8. system�������� ����
-- 9. scott/tiger���� ���� �� ���Ѻο�
-- 10. scott���� ����
-- 11. scott �������� scott_en.sql���� ����

CREATE USER SCOTT IDENTIFIED BY TIGER DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
 GRANT CONNECT, RESOURCE TO SCOTT;


-- ���ó�¥�� ����� �� ���� 
--SYSDATE
SELECT SYSDATE FROM DUAL;
SELECT SYSDATE-10 FROM DUAL;
SELECT SYSDATE-HIRE_DATE
FROM EMPLOYEE;


-- ����Ŭ���� �����ϴ� �Լ��� ���� �˾ƺ���
-- �������Լ� :  ���̺��� ��� �࿡ ����� ��ȯ�Ǵ� �Լ�
--                  ����, ����, ��¥, ����ȯ, �����Լ�(����Ȱ��)
-- �׷��Լ� :  ���̺� �Ѱ��� ����� ��ȯ�Ǵ� �Լ�
--               : �հ� ��� ���� �ִ밪 �ּҰ�

-- ������ �Լ� Ȱ���ϱ�
-- ����ϴ� ��ġ
-- SELECT���� �÷��� �ۼ��ϴ� �κ�, WHERE��, 
-- INSERT, UPDATE, DELETE������ ����� ����

-- ���ڿ��Լ��� ���ؾ˾ƺ���
-- ���ڿ��� ó���ϴ±�� 
-- LENGTH : �������÷��̳�, ���ͷ����� ���� ���̸� ������ִ� �Լ�
-- LENGTH('���ڿ�'||�÷���)  - > ���ڿ��� ������ ���
SELECT LENGTH('���� ������ ������!')
FROM DUAL;
SELECT EMAIL, LENGTH(EMAIL)
FROM EMPLOYEE;

-- �̸����� 16���� �̻��� ����� ��ȸ�ϱ�
SELECT EMP_NAME, EMAIL, LENGTH(EMAIL)
FROM EMPLOYEE
WHERE LENGTH(EMAIL)>=16;

-- LENGTHB : �����ϴ� BYTE�� ���
-- EXPRESS�������� �ѱ��� 3BYTE�� ������. ENTERPRISE���������� 2BYTE
SELECT LENGTHB('ABCD'), LENGTHB('������')
FROM EMPLOYEE;

-- INSTR : JAVA�� INDEXOF �� ������ �����.
-- INSTR('���ڿ�'||�÷�,'ã�� ����'[,������ġ, ã����°(Ƚ��)]
-- ����Ŭ���� �ε�����ȣ�� 1���ͽ���
-- ���� ���� ã������ 0�̳��´�.
SELECT INSTR('GD��ī����','GD'), INSTR('GD��ī����','��'),INSTR('GD��ī����','��')
FROM DUAL;

SELECT EMAIL, INSTR(EMAIL,'j')
FROM EMPLOYEE;


--EMAIL �ּҿ� j�� ���ԵǾ��ִ� ���ã��
--������ 0�̳� ���ϰ� �Լ��� �̿��ؼ� ã�������ִ�.
SELECT EMP_NAME,EMAIL
FROM EMPLOYEE
WHERE INSTR(EMAIL,'j')>0;

-- ������ġ �� ���ؼ� �˻��ϱ�
-- �������� ��������� �ڿ�������ã�´�.
-- 1���� �����ؼ� 3��° �� ã�ƶ�
SELECT INSTR('GD��ī���� GD������ GD���ǻ� GDȭ����','GD'),
            INSTR('GD��ī���� GD������ GD���ǻ� GDȭ����','GD',3),
            -- �������� ��������� �ڿ�������ã�´�.
            INSTR('GD��ī���� GD������ GD���ǻ� GDȭ����','GD',-1),
            -- 1���� �����ؼ� 3��° �� ã�ƶ�
            INSTR('GD��ī���� GD������ GD���ǻ� GDȭ����','GD',1,3)
FROM DUAL;

-- ������̺��� @�� ��ġ�� ã��
SELECT EMP_NAME, EMAIL, INSTR(EMAIL,'@')
FROM EMPLOYEE;

-- LPAD/RPAD : ���ڿ��� ���̰� ������ ���̸�ŭ ���� �ʾ����� ������� ä���ִ� �Լ�
-- LPAD/RPAD(���ڿ�||�÷�,�ִ����,��ü����)

--LPAD ���ʺ��� �����ä��
-- ��ü���ڸ� �������ʾѴٸ� �������� ���
SELECT LPAD('������',10,'*'), LPAD('������',10)
FROM DUAL;
--RPAD �����ʺ��� �����ä��
SELECT RPAD('������',10,'@')
FROM DUAL;

-- �÷��� �� �����ͼ� ��밡��
SELECT EMAIL, RPAD(EMAIL,20,'#')
FROM EMPLOYEE;

-- LTRIM/RTRIM : ������ �����ϴ� �Լ�, Ư�����ڸ� �����ؼ� ����
-- LTRIM/RTRIM('���ڿ�'||�÷�[,'Ư������'])
-- �������� ���޾��ִ� ���鸸�����
-- ���ڻ��̿� ������ ������������
SELECT '              ����',  LTRIM ('             ����') , RTRIM('                ����              ')
FROM DUAL;
-- Ư�����ڸ� �����ؼ� ������ �� �ִ�.
-- ���޾��ִ� ���� ����� �ٸ����������ִٸ��������ʴ´�.
SELECT ' ����2222', RTRIM('����2222','2'), RTRIM('����22122','2'),
RTRIM('����22122','12')
FROM DUAL;

-- TRIM : ���ʿ� �ִ� ���� �����ϴ� �Լ�, �⺻ : ����, �����ϸ� �������� ����(�ѱ��ڸ�)
-- TRIM(���ڿ�||�÷�)
--              ����      ������     ����
-- TRIM(LEADING||TRAILING||BOTH '�����ҹ���' FROM ���ڿ�||�÷���)
    -- ������ ���ڿ��� �ѱ��ڸ�����!

SELECT '                    ������                 ',TRIM( '                    ������                 ')
,'ZZZZZZ��¡��ZZZZZZ',TRIM('Z' FROM 'ZZZZZZ��¡��ZZZZZZ'),
TRIM(LEADING 'Z' FROM 'ZZZZZZ��¡��ZZZZZZ'),
TRIM(TRAILING 'Z' FROM 'ZZZZZZ��¡��ZZZZZZ'),
TRIM(BOTH 'Z' FROM 'ZZZZZZ��¡��ZZZZZZ')
FROM DUAL;

-- SUBSTR : ���ڿ��� �߶󳻴� ��� * JAVA SUBSTRING�޼ҵ�� ����
-- SUBSTR(���ڿ�||�÷���,�����ε�����ȣ,[,����])
SELECT SUBSTR('SHOWMETHEMONEY',5), 
-- 5��° �߿� 2���� �������ٴ�.
SUBSTR('SHOWMETHEMONEY',5,2),

SUBSTR('SHOWMETHEMONEY', INSTR('SHOWMETHEMONEY','MONEY')),

SUBSTR('SHOWMETHEMONEY',-5,2) 
FROM DUAL;

-- ����� �̸��Ͽ��� ���̵𰪸� ����ϱ�
-- ���̵� 7�����̻��� ����� ��ȸ
SELECT EMP_NAME, EMAIL,SUBSTR(EMAIL,1,INSTR(EMAIL,'@')-1) 
FROM EMPLOYEE
WHERE LENGTH(SUBSTR(EMAIL,1,INSTR(EMAIL,'@')-1))>=7;



-- ����� ������ ǥ���ϴ� ��ȣ�� ���
-- ���ڻ���� ��ȸ
SELECT EMP_NAME , EMP_NO,SUBSTR(EMP_NO,8,1)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN (2,4);

-- �����ڸ� ó���ϴ� �Լ� : UPPER,LOWER, INITCAP
-- UPPER : ���� �빮�ڷ�ó��
-- LOWER : ���� �ҹ��ڷ� ó��
-- INITCAP : ���ڿ� ù�ڸ��� �빮��
SELECT UPPER('Welcome to oRACLE worLd'),
LOWER('Welcome to oRACLE worLd'),
INITCAP('Welcome to oRACLE worLd')
FROM DUAL;

-- CONCAT : ���ڿ��� �������ִ� �Լ�
-- | | �����ڿ� �����ϴ�.
SELECT EMP_NAME ||EMAIL, CONCAT(EMP_NAME, EMAIL)
,CONCAT(CONCAT(EMP_NAME, EMAIL),SALARY)
FROM EMPLOYEE;

-- REPLACE : ����ڿ��� �������ڸ� ã�Ƽ� Ư�����ڷ� �����ϴ� ��
-- PEPLACE(���ڿ�||�÷���,'ã������','��ü����')
SELECT EMAIL, REPLACE(EMAIL,'BS','GD')
FROM EMPLOYEE;
-- UPDATE�� ��� ��� �̸��� ����
-- UPDATE EMPLOYEE SET EMAIL = REPLACE(EMAIL,'BS','GD');

-- REVERSE : ���ڿ��� �Ųٷ� ������ִ� ���
SELECT EMAIL, REVERSE(EMAIL), EMP_NAME, REVERSE(EMP_NAME),REVERSE(REVERSE(EMP_NAME))
FROM EMPLOYEE;

-- TRANSLATE :  ��Ī�Ǵ� ���ڷ� �������ִ� �Լ�
SELECT TRANSLATE ('010-3644-6259','0123456789','�����̻�����ĥ�ȱ�')
FROM DUAL;


-- ����ó���Լ�
-- ABS : ���밪�� ó���ϴ� �Լ�
SELECT ABS(-10), ABS(10)
FROM DUAL;

-- MOD : �������� ���ϴ� �Լ� * �ڹ��� %�����ڿ� ������ �Լ�
SELECT MOD(3,2)
FROM DUAL;

-- ��ü�� ����ҷ��� ��Ī�� ���ؼ� ����� ����.
SELECT E.*, MOD(SALARY,3)
FROM EMPLOYEE E;

-- �Ҽ����� ó���ϴ� �Լ�
-- ROUND : �������� �ݿø��ϴ� �Լ�
-- ROUND (����||�÷���[,�ڸ���])
SELECT 126.567,ROUND(126.567), ROUND(126.467),ROUND(126.567,2)
FROM DUAL;

-- ���ʽ��� ������ ���ޱ��ϱ�
SELECT EMP_NAME, SALARY, (SALARY+SALARY*NVL(BONUS,0)-(SALARY*0.03)),
ROUND(SALARY+SALARY*NVL(BONUS,0)-(SALARY*0.03))
FROM EMPLOYEE;

--FLOOR : �������ڸ� ����
SELECT 126.567, FLOOR(126.567)
FROM DUAL;

--TRUNC : �Ҽ����ڸ��� ���� �ڸ����� ����
-- -2 �� �Ҽ��� ������ ���� 0���θ������� 
SELECT 126.567, TRUNC(126.567) , TRUNC(126.567,2) ,TRUNC(126.567,-2),
    TRUNC(2123456.32,-2)
FROM DUAL;

-- CEIL : �Ҽ��� �ø�
SELECT 126.567, CEIL(126.567),CEIL(126.111)
FROM EMPLOYEE;

-- ��¥ó���Լ� �̿��ϱ�
-- ����Ŭ���� ��¥�� ����Ҷ��� �ΰ��� ����� ����
-- 1. SYSDATE����� -> ��¥ ��/��/�� ���� ��¥(����Ŭ�� ��ġ�Ǿ��ִ� ��ǻ���� ��¥)�� �������.
-- 2. SYSTIMESTAMP����� -> ��¥+�ð����� �������
SELECT SYSDATE, SYSTIMESTAMP
FROM DUAL;

--��¥�� �������ó���� �����ϴ�, +,- ���� ���� -> �ϼ��� ����, �߰���.
SELECT SYSDATE, SYSDATE-2, SYSDATE+3,SYSDATE+30
FROM DUAL;

-- NEXT_DAY : �Ű������� ���޹��� ���� �� ���� ����� ���� ��¥ ���
--LOCALE�� ���� �ѱ����� �Ǿ��ֱ⿡ ������,��, ��� ����
SELECT SYSDATE, NEXT_DAY(SYSDATE,'��'),NEXT_DAY(SYSDATE,'��')
FROM DUAL;

-- LOCALE�� ���� ������ ����
SELECT * FROM V$NLS_PARAMETERS;
ALTER SESSION SET NLS_LANGUAGE = 'KOREAN';
SELECT SYSDATE, NEXT_DAY(SYSDATE,'MON'),NEXT_DAY(SYSDATE,'TUESDAY')
FROM DUAL;

-- LASY_DAY : �״��� ���������� ���
SELECT SYSDATE, LAST_DAY(SYSDATE), LAST_DAY(SYSDATE+30)
FROM DUAL;

-- ADD_MONTHS : �������� ���ϴ� �Լ�
SELECT SYSDATE, ADD_MONTHS(SYSDATE,4)
FROM DUAL;

-- MONTHS_BETWEEN : �ΰ��� ��¥�� �޾Ƽ� �γ�¥�� �������� ������ִ� �Լ�
SELECT FLOOR (MONTHS_BETWEEN('23/08/17',SYSDATE))
FROM DUAL;

-- ��¥�� �⵵, ��, ���ڸ� ���� ����� �� �ִ� �Լ�
-- EXTRACT(YEAR||MONTH||DAY FROM ��¥)  : ���ڷ� �������.
-- ���糯¥�� ��, ��, �� ����ϱ�
SELECT EXTRACT(YEAR FROM SYSDATE) AS �� , EXTRACT(MONTH FROM SYSDATE) AS ��, EXTRACT(DAY FROM SYSDATE) AS ��
FROM DUAL;

-- ��� �� 12���� �Ի��� ������� ���Ͻÿ�
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE   EXTRACT(MONTH FROM HIRE_DATE)=12;

-- ��¥�� ���ڸ� ���Ҽ��ִ�.
SELECT EXTRACT(DAY FROM HIRE_DATE)+100
FROM EMPLOYEE;

-- ���úη� ���ֿ����� ����� �ٽò�������..? ���뺹���Ⱓ�� 1��6����
-- �������ڸ� ���ϰ�, ���������� �Դ� «���(�Ϸ缼��)�� ���ϱ� 

SELECT   SYSDATE AS ���糯¥, ADD_MONTHS(SYSDATE,18) AS ��������, (ADD_MONTHS(SYSDATE,18)-SYSDATE)*3 AS «��
FROM DUAL;

-- ����ȯ �Լ�
-- ����Ŭ������ �ڵ�����ȯ�� �� �۵��� �Ѵ�.
-- ����Ŭ �����͸� �����ϴ� Ÿ���� ����
-- ���� : CHAR, VARCHAR2, NCHAR, NVARCHAR2 -> JAVA String�� �����ϴ�.
-- ���� : NUMBER
-- ��¥ : DATE, TIMESTAMP

-- TO_CHAR :  ����, ��¥�� ���������� �������ִ� �Լ�
-- ��¥�� ���������� �����ϱ�
-- ��¥���� ��ȣ��ǥ���ؼ� ���������� ������ �Ѵ�.
-- Y : ��, M : ��, D : �� , H : �� , MI : ��, ss : ��
SELECT SYSDATE, TO_CHAR(SYSDATE,'YYYY-MM-DD'), TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS')
FROM DUAL;

--�÷��� �ú��ʸ� ���������ؼ� �ȳ���
SELECT EMP_NAME, TO_CHAR(HIRE_DATE,'YYYY.MM.DD'), TO_CHAR(HIRE_DATE,'YYYY-MM-DD HH24:MI:SS')
FROM EMPLOYEE;

-- ���ڸ� ���������� �����ϱ�
-- ���Ͽ� ���缭 ��ȯ -> �ڸ����� ��� ǥ������ ����
-- 0 :  ��ȯ����� �ڸ����� ������ �ڸ����� ��ġ����������, ���� ���� �ڸ��� 0�� ǥ���ϴ� ����
-- 9 :  ��ȯ����� �ڸ����� ������ �ڸ����� ��ġ����������, ���� ���� �ڸ��� �����ϴ� ���� 
-- ��ȭ�� ǥ���ϰ� �������� L�� ǥ��
-- FM�����̸� ��������
SELECT 1234567,TO_CHAR(1234567,'000,000,000'), TO_CHAR(1234567,'999,999,999'),
TO_CHAR(500,'L999,999')

FROM DUAL;


SELECT 180.5, TO_CHAR(180.5,'000,000.00'), TO_CHAR(180.5,'FM999,999.00') AS Ű
FROM DUAL;

-- ������ ��ȭǥ���ϰ� , �� �����ؼ� ����ϰ� �Ի����� 0000.00.00���� ����ϱ�
SELECT EMP_NAME ,TO_CHAR(SALARY,'FML999,999,999') AS �޿� ,TO_CHAR(HIRE_DATE,'YYYY.MM.DD')AS �Ի���
FROM EMPLOYEE;

-- ���������� �����ϱ�
-- TO_NUMBER�Լ��� �̿�
-- ���ڸ� ���������� �����ϱ�
SELECT 1000000+1000000,TO_NUMBER('1,000,000','999,999,999')+1000000,
TO_CHAR(TO_NUMBER('1,000,000','999,999,999')+1000000,'FML999,999,999')
FROM DUAL;

-- ��¥������ �����ϱ�
-- ���ڸ� ��¥�� ����
-- ���ڿ��� ��¥�� ����
SELECT TO_DATE('23/12/25','YY/MM/DD')-SYSDATE, TO_DATE('241225','YYMMDD'),TO_DATE('25-12-25','YY-MM-DD')
FROM DUAL;

-- ������� ����ҋ� �տ� 000�̺����� �����ؾ��Ѵ� 000�� �����ʱ⶧���̴� �׷��� ���ڿ��� �����ؼ�����Ѵ�.
SELECT TO_DATE(20230405,'YYYY/MM/DD'), TO_DATE(230505,'YYMMDD'), TO_DATE (TO_CHAR(00224,'000000'),'YYMMDD')
FROM DUAL;

--NULL���� ó�����ִ� �Լ�
--NVL�Լ� : NVL(�÷�,��ü��)
--NVL2�Լ� : NVL2(�÷�,NULL�ƴҶ�, NULL�϶�)
SELECT EMP_NAME, DEPT_CODE, NVL(DEPT_CODE,'����'),
NVL2(DEPT_CODE,'����','����')
FROM EMPLOYEE;

-- ���ǿ� ���� ����� ���� �������ִ� �Լ�
-- 1. DECODE
-- DECODE(�÷��� || ���ڿ�, '����','��ü��','����2','��ü��2',.....)
-- �ֹι�ȣ���� 8��°�ڸ� ���� 1�̸� ����, 2�̸� ���ڸ� ����ϴ� �÷��߰��ϱ�
SELECT EMP_NAME, EMP_NO, DECODE(SUBSTR(EMP_NO,8,1),'1','����','2','����') AS GENDER
FROM EMPLOYEE;
--WHERE GENDER = '����';

-- �� ��å�ڵ��� ��Ī�� ����ϱ�
-- J1�� ��ǥ, J2 �λ���, J3 ����, J4 ����
-- �Ǹ��������� ���������Ʈ���̵ȴ�.
SELECT EMP_NAME, DECODE(JOB_CODE,'J1','��ǥ','J2','�λ���','J3','����','J4','����','���') AS ��å
FROM EMPLOYEE;

-- 2. CASE WHEN THEN ELSE 
-- CASE
--             WHEN ���ǽ� THEN ���೻��
--             WHEN ���ǽ� THEN ���೻��
--             WHEN ���ǽ� THEN ���೻��
--             ELSE ���೻�� 
-- END

SELECT EMP_NAME, JOB_CODE,
            CASE
                    WHEN JOB_CODE = 'J1' THEN '��ǥ'
                    WHEN JOB_CODE = 'J2' THEN '�λ���'
                    WHEN JOB_CODE = 'J3' THEN '����'
                    WHEN JOB_CODE = 'J4' THEN '����'
                    ELSE '���'
            END AS ��å,
            CASE JOB_CODE
                    WHEN 'J1' THEN '��ǥ'
                    WHEN 'J2' THEN '�λ���'
            END
FROM EMPLOYEE;

-- ������ �������� ��׿����ڿ� �߰������� �׿ܸ� ������ ����ϱ�
-- ������ 400���� �̻��̸� ���
-- ������ 400�̸� 300�̻��̸� �߰�������
-- �������� �׿ܸ� ����ϴ� �����÷� �����
-- �̸� , ���� ,���

SELECT EMP_NAME, SALARY,
            CASE
                    WHEN SALARY >=4000000 THEN '���'
                    WHEN SALARY <4000000 AND  SALARY >=3000000 THEN '�߰�������'
                    ELSE '�׿�'
                    END AS ���
FROM EMPLOYEE;

-- ������̺��� ���糪�� ���ϱ�
-- YY�������ö� ������ �����⸦ �����´� EX) 2064,, 2085, 2077.....
-- RR �������ö� 
SELECT EMP_NAME, EMP_NO, EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2),'YY')) ||'��' AS YY��,
EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2),'RR')) ||'��' AS RR��,
EXTRACT(YEAR FROM SYSDATE) -(
TO_NUMBER(SUBSTR(EMP_NO,1,2))+
CASE
        WHEN SUBSTR(EMP_NO,8,1)IN (1,2) THEN 1900
        WHEN SUBSTR(EMP_NO,8,1)IN (3,4) THEN 2000
        END
        ) AS ��
FROM EMPLOYEE;

                    
insert into EMPLOYEE (EMP_ID,EMP_NAME,EMP_NO,EMAIL,PHONE,DEPT_CODE,JOB_CODE,SAL_LEVEL,SALARY,BONUS,MANAGER_ID,HIRE_DATE, ENT_DATE,ENT_YN) 
values ('251','������','020808-2123341','go_dm@kh.or.kr',null,'D2','J2','S5',4480000,null,null,to_date('94/01/20','RR/MM/DD'),null,'N');
SELECT * FROM EMPLOYEE;


UPDATE EMPLOYEE SET EMP_NO = '320808-1123341' WHERE EMP_ID = '252';
COMMIT;

-- �׷��Լ� Ȱ���ϱ�
-- ���̺��� �����Ϳ� ���� �����ϴ� �Լ��� �հ�, ���, ����, �ִ밪, �ּҰ��� ���ϴ� �Լ�
-- �׷��Լ��� ����� �⺻������ �Ѱ��� ���� ������
-- �߰� �÷��� �����ϴ°��� ����
-- ����
-- SUM : ���̺��� Ư���÷��� ���� ���� -> SUM(�÷�(NUMBER))
-- AVG :  ���̺��� Ư���÷��� ���� ��� -> AVG(�÷�(NUMBER))
-- COUNT : ���̺��� �����ͼ�(ROW��) -> COUNT(* | | �÷�)
-- MIN :  ���̺��� Ư���÷��� ���� �ּҰ� -> MIN(�÷���)
-- MAX :  ���̺��� Ư���÷��� ���� �ִ밪 -> MAX(�÷���)

-- ����� ������ ���հ踦 ���غ���
SELECT TO_CHAR (SUM(SALARY),'FML999,999,999') FROM EMPLOYEE;

-- D5 �μ��� ������ ���հ踦 ���غ���
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE='D5';

-- ���ڴ� �Ұ���
--SELECT SUM(EMP_NAME)
--FROM EMPLOYEE;

--J3����� �޿� �հ踦 ���ϽÞ�
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE JOB_CODE ='J3';

-- ��ձ��ϱ� AVG�Լ�
-- ��ü����� ���� ��ձ��ϱ�
SELECT AVG(SALARY)FROM EMPLOYEE;
-- D5�� �޿� ����� ���ϱ�
SELECT AVG(SALARY) FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- D5�μ��� �޿��հ�� ��ձ��ϱ�
-- �׷��Լ� ���� �����ü������� �����÷��� �����ü�������.
SELECT SUM(SALARY), AVG(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE='D5';

-- NULL���� ���ؼ��� ��� ó���� �ɱ�?
-- NULL���� �����͸� �����ع�����.
SELECT SUM(BONUS),AVG(BONUS),AVG(NVL(BONUS,0))
FROM EMPLOYEE;

-- ���̺��� �����ͼ� Ȯ���ϱ�
SELECT COUNT(*)
FROM EMPLOYEE;

-- ���̺��� �����ͼ� Ȯ���ϱ�
-- ���̺��մ°� ��� ����
--Ư�����÷��� ����Ѵٸ� NULL���� ���� �����´�.
SELECT COUNT(*),COUNT(DEPT_CODE), COUNT(BONUS)
FROM EMPLOYEE;

-- D6�μ��� �ο� ��ȸ�ϼ���
SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE
WHERE DEPT_CODE='D6';

-- 400���� �̻� ������ �޴� �����
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SALARY>=4000000;

-- D5�μ����� ���ʽ��� �ް� �ִ� ����Ǽ���?
SELECT COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE='D5' AND  BONUS IS NOT NULL ;

-- �μ��� D6, D5, D7�� ����� ��, �޿� �հ�, ����� ��ȸ�ϼ���
SELECT COUNT(*) AS ����Ǽ� ,SUM(SALARY) AS �޿��հ�,AVG(SALARY) AS ���
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D6','D7');

SELECT MAX(SALARY), MIN(SALARY)
FROM EMPLOYEE;

-- GROUP BY �� Ȱ���ϱ�
-- �׷��Լ��� ��������� Ư���������� �÷����� ��� ó���ϴ� �� -> ���� �׷캰 �׷��Լ��� ����� ��µ�.
-- SELECT �÷�
-- FROM ���̺��
-- [WHERE ���ǽ�]
-- [GROUP BY �÷���[,�÷���,�÷���,..... ]]
-- [ORDERY BY �÷���]

-- �μ��� �޿� �հ踦 ���Ͻÿ�
SELECT DEPT_CODE,SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- ��å�� �޿��� �հ�, ����� ���Ͻÿ�
SELECT JOB_CODE,SUM(SALARY),AVG(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- �μ��� ����� ���ϱ�
SELECT DEPT_CODE , COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- GROUP BY ������ �ټ��� �÷��� ���� �� �ִ�.
SELECT DEPT_CODE, JOB_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE;

-- GROUP BY�� ����� ������ WHERE �� ����� �����ϴ�.
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL
GROUP BY DEPT_CODE;

-- �μ��� �ο��� 3���̻��� �μ��� ����ϱ�
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
-- WHERE �� �׷��Լ��� ����Ҽ�������.
--WHERE COUNT(*) >=3
GROUP BY DEPT_CODE
HAVING COUNT(*) >=3;

-- ��å�� �ο����� 3���̻��� ��å ����ϱ�
SELECT JOB_CODE , COUNT(*)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING COUNT(*)>=3;

-- ��� �޿��� 300���� �̻��� �μ�����ϱ�
SELECT DEPT_CODE,AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY)>=3000000 AND COUNT(*)>=4;

-- �Ŵ����� �����ϴ� ����� 2���̻��� �Ŵ��� ���̵� ����ϱ�

SELECT MANAGER_ID , COUNT(*)
FROM EMPLOYEE
GROUP BY MANAGER_ID
HAVING COUNT(*)>=2 AND MANAGER_ID IS NOT NULL;

-- ����, ������ �޿� ����� ���ϰ� �ο����� ���ϱ�
SELECT DECODE(SUBSTR(EMP_NO,8,1),'1','��','3','��','2','��','4','��') AS ����, AVG(SALARY) , COUNT(*)
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO,8,1),'1','��','3','��','2','��','4','��');

-- �� �׷캰 ����� �� ���踦 �ѹ��� ������ִ� �Լ�
-- ROLLUP(), CUBE()
-- GROUP BY ROLLUP(�÷���)
-- GROUP BY CUBE(�÷���)
--�μ��� �޿��հ�� ���հ踦 ��ȸ�ϴ� ����
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

-- ROLLUP, CUBE �Լ��� �μ��� �Ѱ��̻��� �÷��� ���� �� �ִ�.
-- ROLLUP : �ΰ��̻��� �μ��� ���������� �ΰ� �÷��� ����, ù��° �μ��÷��� �Ұ�, ��ü �Ѱ�
-- CUBE : �ΰ��̻� �μ��� ���������� �ΰ� �÷��� ����, ù��° �μ��÷��� �Ұ�, �ι�° �μ��÷��� �Ұ� , ��ü �Ѱ�

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL 
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE);

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL 
GROUP BY CUBE(DEPT_CODE, JOB_CODE);


-- �μ��� , ��å��, �ѻ���� �ѹ��� ��ȸ�ϱ�
SELECT DEPT_CODE,JOB_CODE, COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY CUBE(DEPT_CODE, JOB_CODE);

-- GROUPING�Լ��� �̿��ϸ� ������ ����� ���� �б�ó���� �� �� �ִ�.
-- ROLLUP, CUBE�� ����� ROW�� ���� �б�ó��
-- GROUPING �Լ��� �����ϸ�, ROLLUP, CUBE�� ����� ROW 1�� ��ȯ �ƴϸ� 0�� ��ȯ

SELECT COUNT(*),DEPT_CODE, JOB_CODE,
CASE
WHEN GROUPING(DEPT_CODE)=0 AND GROUPING(JOB_CODE)=1 THEN '�μ����ο�'
WHEN GROUPING(DEPT_CODE)=1 AND GROUPING(JOB_CODE)=0 THEN '��å���ο�'
WHEN GROUPING(DEPT_CODE)=0 AND GROUPING(JOB_CODE)=0 THEN '�μ�_��å�ο�'
WHEN GROUPING(DEPT_CODE)=1 AND GROUPING(JOB_CODE)=1 THEN '���ο�'
END AS ���
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY CUBE(DEPT_CODE, JOB_CODE);

-- ���̺��� ��ȸ�� ������ �����ϱ�
-- ORDER BY ������ �����.
-- SELECT �÷���.....
-- FROM ���̺��
-- [WHERE ���ǽ�]
-- [GROUP BY �÷���]
-- [HAVING ���ǽ�]
-- ���Ĺ���� �������� ����Ʋ������ ���� ����Ʈ�� = ��������
-- [ORDER BY �÷��� ���Ĺ��(DESC(����),ASC(����, DEFAULT)]

-- �̸��� �������� �����ϱ�
--��������
SELECT *
FROM EMPLOYEE
ORDER BY EMP_NAME;

--��������
SELECT *
FROM EMPLOYEE
ORDER BY EMP_NAME DESC;

-- ������ ����������� ����������� �����ϱ�
-- �̸� , �޿�, ���ʽ�
SELECT EMP_NAME, SALARY, NVL(BONUS,0)
FROM EMPLOYEE
ORDER BY SALARY DESC;

-- �μ��ڵ带 �������� �������������ϰ� ���� ������ ������ ������������ �����ϱ�
SELECT *
FROM EMPLOYEE
ORDER BY DEPT_CODE ASC, SALARY DESC, EMP_NAME ASC;

-- ���������� NULL���� ���� ó��
-- BONUS�� ���� �޴� ������� ����ϱ�
SELECT *
FROM EMPLOYEE
--ORDER BY BONUS  DESC; -- NULL�� ���� ���� ����Ѵ�.
--ORDER BY BONUS  ASC; -- NULL�� ���� ���߿� ����Ѵ�.
-- �ɼ��� �����ؼ� NULL�������ġ�� ������ �� �ִ�.
--ORDER BY BONUS ASC NULLS FIRST;
ORDER BY BONUS ASC NULLS LAST;


-- ORDER BY �������� ��Ī�� ����� �� ����
SELECT EMP_NAME, SALARY AS ����, BONUS
FROM EMPLOYEE
-- WHERE ���� �������Ѵ�'����'  FROM������ �״��� ���� �״����� ��Ī�� �ο��ϱ⶧���� �Ұ����ϴ�.
ORDER BY ����;


-- SELECT���� �̿��ؼ� �����͸� ��ȸ�ϸ� RESULT SET �� ��µǴµ�
-- RESULT SET �� ��µǴ� �÷����� �ڵ����� INDEX��ȣ�� 1���� �ο��� �ȴ�.
SELECT *
FROM EMPLOYEE
-- SELECT �� ��½� �÷��� ������� �ε����ο��Ѵ� ���ε�����ȣ�� ����Ҽ��ִ�.
ORDER BY 2;


--  ���տ�����
-- �������� SELECT���� �Ѱ��� ���(RESULT SET)���� ������ִ� ��
-- ù��° SELECT���� �÷����� ���� SELECT���� �÷����� ���ƾ��Ѵ�.
-- �� �÷��� ������ Ÿ�Ե� �����ؾ��Ѵ�.

-- UNION : �ΰ��̻��� SELECT���� ��ġ�� ������
-- SELECT �� UNION SELECT��

-- UNION : �ߺ����� ������ �ϳ��� ��µȴ�.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY>=3000000;

-- UNION ALL :  �ߺ������ִٸ� �ߺ��� ���Խ�Ų��
-- MINUIS : �ߺ��� ���� �����ʴ´�.
-- INTERSECT :  �ߺ����� ��������.
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
-- �� SELECT���� �÷��� ���� �ٸ��� �ȵȴ�.
--SELECT EMP_ID,EMP_NAME,SALARY,BONUS
--FROM EMPLOYEE
--WHERE SALARY>3000000;

-- �ΰ��� SELECT���� �÷��� Ÿ�Ե� ����� �Ѵ�.
SELECT EMP_ID,EMP_NAME,EMP_NO
FROM EMPLOYEE
WHERE SALARY>3000000;

-- �ٸ� ���̺� �ִ� �����͸� ��ġ��
-- �´� �÷��̾������ ������(���ͷ���)�� ���ؼ� ���������ִ�.
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
-- ���� GROUP BY ���� �ִ� ������ �ϳ��� �ۼ��ϰ� ���ִ� ���
-- �μ�, ��å, �Ŵ����� �޿����
SELECT DEPT_CODE, JOB_CODE, MANAGER_ID , AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE,JOB_CODE, MANAGER_ID;
-- �μ�, ��å��, �޿����
SELECT DEPT_CODE, JOB_CODE , AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE,JOB_CODE;
-- �μ�, �Ŵ����� �޿����
SELECT DEPT_CODE,  MANAGER_ID , AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, MANAGER_ID;

-- GROUPING SET �� �̿��ؼ� ��� ������ټ��ִ�.
SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, AVG(SALARY)
FROM EMPLOYEE
GROUP BY GROUPING SETS((DEPT_CODE,JOB_CODE,MANAGER_ID),(DEPT_CODE,JOB_CODE),(DEPT_CODE, MANAGER_ID));


 --  JOIN�� ���� �˾ƺ���
 -- �ΰ��̻��� ���̺��� Ư���÷��� �������� ��������, ���
 -- JOIN�� �� ������ ����
 -- 1. INNER JOIN : ���صǴ� ���� ��ġ�ϴ� ROW�� �������� JOIN
 -- 2. OUTER JOIN :  �����̵Ǵ� ���� ��ġ���� ���� ROW�� �������� JOIN * ������ �ʿ�
 
 -- JOIN�� �ۼ��ϴ� ��� 2����
 -- 1. ����Ŭ ���ι�� :  , �� WHERE�� �ۼ�
 -- 2. ANSI ǥ�� ���ι�� :  JOIN, ON | | USING ���� ����ؼ� �ۼ�
 
 -- EMPLOYEE���̺�� DEPARTMENT���̺� JOIN�ϱ�
 SELECT* FROM EMPLOYEE;
 SELECT* FROM DEPARTMENT;
 
 -- ����Ŭ������� JOIN�ϱ�
 SELECT *
 FROM EMPLOYEE;
 
 SELECT*
 FROM EMPLOYEE, DEPARTMENT
 WHERE EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID;
 
 -- ANSI ǥ������ JOIN�ϱ�
 SELECT *
 FROM EMPLOYEE 
 JOIN DEPARTMENT ON EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID;
 
-- ����� ���� �����, �̸���, ��ȭ��ȣ, �μ����� ��ȸ�ϱ�
SELECT EMP_NAME, EMAIL, PHONE,DEPT_TITLE
FROM EMPLOYEE 
JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID; 

 -- JOIN �������� WHERE�� ����ϱ�
 -- �μ��� �ѹ����� ���  �����, ����, ���ʽ�, �μ��� ��ȸ�ϱ�
 SELECT EMP_NAME, SALARY,BONUS, DEPT_TITLE
 FROM EMPLOYEE
 JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID
 WHERE DEPT_TITLE = '�ѹ���';
 
 -- JOIN ������ GROUP BY �� ����ϱ�
 -- �μ��� ��ձ޿��� ����ϱ� �μ���, ��ձ޿�
 SELECT DEPT_TITLE,AVG(SALARY)
 FROM EMPLOYEE
 JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
 GROUP BY DEPT_TITLE
HAVING AVG(SALARY)>=3000000;

-- JOIN�Ҷ� �����̵Ǵ� �÷����� �ߺ��ȴٸ� �ݵ�� ��Ī�� �ۼ��ؾ��Ѵ�.
-- �����, �޿�, ���ʽ�, ��å���� ��ȸ�ϱ�
-- �ٸ� ���̺������� �÷����� ��������� ���������. 
-- ambiguously ������������ ���̺�տ� ��Ī�� �ο��ϴ� ��Ī�� �ο��ؾ��Ѵ�.
SELECT * --EMP_NAME ,SALARY, BONUS, JOB_NAME
FROM EMPLOYEE E
    JOIN JOB J ON E.JOB_CODE=J.JOB_CODE;

-- �ߺ��Ǵ� �÷������� ������ ���� USING�� �̿��� �� �ִ�.
-- �ߺ��Ǵ� �ڵ尡 �ϳ��� ����̵ȴ�.
-- �ϳ��� ��µǱ⶧���� ��Ī�ο��ؼ� �������ʿ䰡����.
-- USING ������Ҷ� �ĺ���(��Ī)�� �����ʴ´�.
SELECT * --EMP_NAME, SALARY, BONUS, JOB_NAME
FROM EMPLOYEE
    JOIN JOB  USING(JOB_CODE)
WHERE JOB_CODE='J3'; 
SELECT * FROM JOB;

-- ��å�� ������ ����� �̸�, ��å��, ��å�ڵ�, ������ ��ȸ�ϼ���.
SELECT  EMP_NAME, JOB_NAME,JOB_CODE, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����';

-- JOIN �� NULL���� �����Ѵ�.
SELECT COUNT(*)
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID;

SELECT * FROM EMPLOYEE;

-- OUTER JOIN����ϱ�
-- �÷��� ���� ���Ϻ񱳸� ������ ���� ROW�� ������ִ� JOIN
-- ������ �Ǵ� ���̺�(��絥���͸� �����)�� ����������Ѵ�.
-- LEFT OUTER JOIN : JOIN�� �������� ���ʿ� �ִ� ���̺��� �������� ����
-- RIGHT OUTER JOIN : JOIN�� �������� �����ʿ� �ִ� ���̺��� �������� ����
-- ��ġ�Ǵ� ROW�� ���� ��� ��� �÷��� NULL�� ǥ���Ѵ�.
-- OUTER �� �����ص� �������
SELECT *
FROM EMPLOYEE LEFT  JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID;

SELECT *
FROM EMPLOYEE RIGHT OUTER JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID;

-- CROSS JOIN : ��� ROW�� �������ִ� JOIN
-- 
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE CROSS JOIN DEPARTMENT
ORDER BY 1;

-- SELF JOIN : �Ѱ��� ���̺� �ٸ� �÷��� ���� ������ �ִ� �÷��� �ִ� ��� �׵ΰ� �÷��� �̿��ؼ� JOIN
SELECT * FROM EMPLOYEE;
-- MANAGER�� �ִ� ����� �̸�, �Ŵ��� ���̵�, �Ŵ��� �����ȣ, �Ŵ��� �̸� ��ȸ
SELECT E.EMP_NAME,E.MANAGER_ID,M.EMP_ID,M.EMP_NAME
FROM EMPLOYEE E
JOIN EMPLOYEE M ON E.MANAGER_ID=M.EMP_ID;

-- ����̸�, �Ŵ������̵�, �Ŵ��������ȣ, �Ŵ��� �̸� ��ȸ
-- �Ŵ����� ������ ���� ����ϱ�
SELECT E.EMP_NAME,NVL(E.MANAGER_ID,'����'),NVL(M.EMP_ID,'����') ,NVL(M.EMP_NAME,'����')
FROM  EMPLOYEE E
         LEFT   JOIN EMPLOYEE M ON E.MANAGER_ID=M.EMP_ID;

SELECT * FROM EMPLOYEE;


-- �������� ����񱳸� �ؼ� ó����. ON �÷���=�÷���
-- �񵿵����ο� ���� �˾ƺ���
-- ������ ���̺��� �������� �������Ѵ�.
SELECT * FROM SAL_GRADE;
SELECT * 
FROM EMPLOYEE
        JOIN SAL_GRADE ON SALARY BETWEEN MIN_SAL AND  MAX_SAL;
-- ȸ����� ����ư���, ��ǰ���(����) , ��� ���� ���� ȸ�����

-- ���������� �� �� �ִ�.
-- 3���̻��� ���̺��� �����ؼ� ����ϱ�
--����� �����, ��å��, �μ����� ��ȸ�ϱ�
SELECT EMP_NAME,JOB_NAME,DEPT_TITLE
FROM EMPLOYEE
        JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID
        JOIN JOB  USING(JOB_CODE);
        
-- ����� �����, �μ���, ��ì��, �ٹ�����(LOCALNAME)��ȸ�ϱ�
-- �μ����� ������ ���, �ٹ������� ������ ���߷��� ���
SELECT EMP_NAME,NVL(DEPT_TITLE,'���'),JOB_NAME,NVL(LOCAL_NAME,'���߷�')
FROM EMPLOYEE
        LEFT JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID
        LEFT JOIN LOCATION ON LOCATION_ID=LOCAL_CODE
        JOIN JOB USING(JOB_CODE);

-- ��������  : SELECT �� �ȿ� SELECT���� �ϳ� �� �ִ� �������� ����.
-- ���������� �ݵ�� ��ȣ�ȿ� �ۼ��� �ؾ��Ѵ�.
-- ����������� ������ �޿��� �ް��ִ� ����� ��ȸ�ϱ�
SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME='������';
SELECT *
FROM EMPLOYEE
WHERE SALARY = 2000000;

SELECT *
FROM EMPLOYEE
WHERE SALARY = (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '������');

-- D5�μ��� ��ձ޿����� ���� �޴� ������ϱ�
SELECT *
FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEE WHERE DEPT_CODE = 'D5');

-- 1. �����༭������
-- �������� SELECT���� �����  1����, 1������ ��
-- �����մ°͵������� ������ ����������.
-- �÷�(SELECT), WHERE���� �񱳴�� ��
-- ������� �޿� ��պ��� ���� �޿��� �޴� ����� �̸�, �޿� , �μ��ڵ带 ����ϱ�
SELECT EMP_NAME, SALARY, DEPT_CODE,(SELECT AVG(SALARY)FROM EMPLOYEE) AS AVG
FROM EMPLOYEE
WHERE SALARY>=(SELECT AVG(SALARY) FROM EMPLOYEE);
  
  -- �μ��� �ѹ����� ����� ��ȸ�ϱ�
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_ID FROM DEPARTMENT WHERE  DEPT_TITLE='�ѹ���');

-- ������ �����ؼ� ����Ҽ����ִ�.
SELECT *
FROM EMPLOYEE
        JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE = '�ѹ���';

-- ��å�� ������ ����� ��ȸ�ϱ�
SELECT *
FROM EMPLOYEE
WHERE JOB_CODE = (SELECT JOB_CODE FROM JOB WHERE JOB_NAME = '����');

-- 2. ������ ��������
-- ���������� ����� �Ѱ��� �ټ� ��(ROW) �� ���� ��
-- ��å�� ����, ������ ����� ��ȸ�ϱ�
SELECT JOB_CODE
FROM JOB
WHERE JOB_NAME IN('����','����');

-- �������� ������Ҷ� = �� ���Ұ���
-- OR �� IN ���� �����ؼ� ����Ѵ�.
SELECT *
FROM EMPLOYEE
WHERE JOB_CODE IN( SELECT JOB_CODE FROM JOB WHERE JOB_NAME IN ('����','����'));

-- �����࿡ ���� ��Һ��ϱ�
-- >=, >, <, <=
--������ ��Һ��ҋ��� ���¸�ɾ�
-- ANY : OR�� ROW�� ����
-- ALL  :  AND�� ROW�� ����
-- �÷� >(=) ANY(��������) :  ������ ���������� ��� �� �ϳ��� ũ�� �� -> ������ ���������� ����� �ּҰ����� ũ��
-- �÷�<(=) ANY(��������) :  ������ ���������� ��� �� �ϳ��� ������ �� -> ������ ���������� ����� �ִ밪���� ������ ��
SELECT *
FROM EMPLOYEE
WHERE SALARY >=  (SELECT SALARY FROM EMPLOYEE WHERE DEPT_CODE IN('D5','D6'));

SELECT *
FROM EMPLOYEE
WHERE SALARY >= ANY(SELECT SALARY FROM EMPLOYEE WHERE DEPT_CODE IN ('D5','D6'));





