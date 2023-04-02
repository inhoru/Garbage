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

-- BASICSELECT
--JOB���̺��� JOB_NAME�� ������ ��µǵ��� �Ͻÿ�
SELECT JOB_NAME
FROM JOB;
--DEPARTMENT���̺��� ���� ��ü�� ����ϴ� SELECT���� �ۼ��Ͻÿ�
SELECT *
FROM DEPARTMENT;
--EMPLOYEE ���̺��� �̸�(EMP_NAME),�̸���(EMAIL),��ȭ��ȣ(PHONE),�����(HIRE_DATE)�� ����Ͻÿ�
SELECT EMP_NAME,EMAIL,PHONE,HIRE_DATE
FROM EMPLOYEE;
--EMPLOYEE ���̺��� �����(HIRE_DATE) �̸�(EMP_NAME),����(SALARY)�� ����Ͻÿ�
SELECT HIRE_DATE, EMP_NAME,SALARY
FROM EMPLOYEE;
--EMPLOYEE ���̺��� ����(SALARY)�� 2,500,000���̻��� ����� EMP_NAME �� SAL_LEVEL�� ����Ͻÿ� 
SELECT EMP_NAME,SAL_LEVEL
FROM EMPLOYEE
WHERE SALARY>=2500000;
--EMPLOYEE ���̺��� ����(SALARY)�� 350���� �̻��̸鼭 
--JOB_CODE�� 'J3' �� ����� �̸�(EMP_NAME)�� ��ȭ��ȣ(PHONE)�� ����Ͻÿ�
SELECT EMP_NAME,PHONE
FROM EMPLOYEE
WHERE SALARY>=3500000 AND JOB_CODE='J3';
--EMPLOYEE ���̺��� �̸�, ����, �Ѽ��ɾ�(���ʽ�����), �Ǽ��ɾ�(�� ���ɾ�-(����*���� 3%))�� ��µǵ��� �Ͻÿ�
SELECT EMP_NAME AS �̸�,SALARY*12 AS ����,(SALARY+(SALARY*NVL(BONUS,0)))*12 AS �Ѽ��ɾ�,(SALARY+(SALARY*NVL(BONUS,0)))*12-((SALARY*0.03)*12) AS �Ǽ��ɾ�
FROM EMPLOYEE;
--EMPLOYEE ���̺��� �̸�, �ٹ� �ϼ�(�Ի����� �����ΰ�)�� ����غ��ÿ�. (��¥�� ������갡����.)
SELECT EMP_NAME AS �̸�,SYSDATE - HIRE_DATE AS �ٹ��ϼ�
FROM EMPLOYEE;
--EMPLOYEE ���̺��� 20�� �̻� �ټ����� �̸�,����,���ʽ����� ����Ͻÿ�
SELECT EMP_NAME AS �̸�, SALARY AS ����, NVL(BONUS,0) AS ���ʽ�
FROM EMPLOYEE
WHERE SYSDATE - HIRE_DATE>=365*20;
--EMPLOYEE ���̺��� ������� 90/01/01 ~ 01/01/01 �� ����� ��ü ������ ����Ͻÿ�
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';
--�̸��� '��'�� ���� ����� ��� ����ϼ���.
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%';
--EMPLOYEE ���̺��� �̸� ���� ������ ������ ����� �̸��� ����Ͻÿ�
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';
--EMPLOYEE ���̺��� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ����� �̸�, ��ȭ��ȣ�� ����Ͻÿ�
SELECT EMP_NAME,PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';
--EMPLOYEE ���̺��� �����ּ� '_'�� ���� 4���̸鼭, DEPT_CODE�� D9 �Ǵ� D6�̰� 
--������� 90/01/01 ~ 00/12/01�̸鼭, ������ 270�����̻��� ����� ��ü ������ ����Ͻÿ�
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '____*_%' ESCAPE '*' AND DEPT_CODE = 'D9' OR DEPT_CODE = 'D6' AND HIRE_DATE BETWEEN '09/01/01' AND '00/12/01' AND SALARY>=2700000;
--�μ� ��ġ�� ���� �ʾ����� ���ʽ��� �����ϴ� ���� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;
--�����ڵ� ���� �μ� ��ġ�� ���� ���� ���� �̸� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;




