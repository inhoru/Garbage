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
--�����ڵ� ���� �μ� ��ġ�� ���� ���� ���� �̸� ��ȸ..
SELECT *
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;