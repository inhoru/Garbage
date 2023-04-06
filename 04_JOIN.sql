--1. ������� �̸��� , �̸��� ���̸� ����Ͻÿ�
SELECT EMP_NAME AS �̸� ,EMAIL AS �̸��� ,LENGTH(EMAIL) AS �̸��ϱ���
FROM EMPLOYEE;
--3. 60��뿡 �¾ ������� ���, ���ʽ� ���� ����Ͻÿ�. �׶� ���ʽ� ���� null�� ��쿡�� 0 �̶�� ��� �ǰ� ����ÿ�
SELECT EMP_NAME AS ����,TO_CHAR(TO_DATE(SUBSTR(EMP_NO,1,2),'RR'),'RRRR')AS ���,NVL(BONUS,0)AS ���ʽ�
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,1,1)='6';
--4. '010' �ڵ��� ��ȣ�� ���� �ʴ� ����� ���� ����Ͻÿ� (�ڿ� ������ ���� ���̽ÿ�)
SELECT COUNT(*)||'��'AS �ο�
FROM EMPLOYE
WHERE PHONE IS NULL;
-- 5. ������� �Ի����� ����Ͻÿ� 
SELECT EMP_NAME AS ������,EXTRACT(YEAR FROM(HIRE_DATE))||'��'||EXTRACT(MONTH FROM(HIRE_DATE))||'��'AS �Ի���
FROM EMPLOYEE;
-- 6. ������� �ֹι�ȣ�� ��ȸ�Ͻÿ�
SELECT EMP_NAME,RPAD(SUBSTR(EMP_NO,1,7),14,'*')
FROM EMPLOYEE;
--7. ������, �����ڵ�, ����(��) ��ȸ
SELECT EMP_NAME AS ������,DEPT_CODE AS �����ڵ�,TO_CHAR(SALARY*12+ (SALARY * NVL(BONUS, 0)) * 12,'FML900,000,000') AS ����
FROM EMPLOYEE;
--8. �μ��ڵ尡 D5, D9�� ������ �߿��� 2004�⵵�� �Ի��� �����߿� ��ȸ��.
--   ��� ����� �μ��ڵ� �Ի���
SELECT EMP_NO AS ���,EMP_NAME AS �����,DEPT_CODE AS �μ��ڵ�,HIRE_DATE AS �Ի���
FROM EMPLOYEE
WHERE DEPT_CODE IN('D5','D9')AND EXTRACT(YEAR FROM HIRE_DATE) = 2004;
--9. ������, �Ի���, ���ñ����� �ٹ��ϼ� ��ȸ 
--	* �ָ��� ���� , �Ҽ��� �Ʒ��� ����
SELECT EMP_NAME AS ������,HIRE_DATE AS �Ի���,FLOOR(SYSDATE - HIRE_DATE)AS �ٹ��ϼ�
FROM EMPLOYEE;
--11. �������� �Ի��Ϸ� ���� �⵵�� ������, �� �⵵�� �Ի��ο����� ���Ͻÿ�.
--  �Ʒ��� �⵵�� �Ի��� �ο����� ��ȸ�Ͻÿ�. ���������� ��ü�������� ���Ͻÿ�
SELECT COUNT(DECODE(EXTRACT(YEAR FROM(HIRE_DATE)),'1998',1))AS "1998��",
COUNT(DECODE(EXTRACT(YEAR FROM(HIRE_DATE)),'1999',1))AS "1999��",
COUNT(DECODE(EXTRACT(YEAR FROM(HIRE_DATE)),'2000',1))AS "2000��",
COUNT(DECODE(EXTRACT(YEAR FROM(HIRE_DATE)),'2001',1))AS "2001��",
COUNT(DECODE(EXTRACT(YEAR FROM(HIRE_DATE)),'2002',1))AS "2002��",
COUNT(DECODE(EXTRACT(YEAR FROM(HIRE_DATE)),'2003',1))AS "2003��",
COUNT(DECODE(EXTRACT(YEAR FROM(HIRE_DATE)),'2004',1))AS "2004��",
COUNT(*) AS ��ü������
FROM EMPLOYEE;
-- 12. ������, �μ����� ����ϼ���.
-- �μ��ڵ尡 D5�̸� �ѹ���, D6�̸� ��ȹ��, D9�̸� �����η� ó���Ͻÿ�.(case ���)
-- ��, �μ��ڵ尡 D5, D6, D9 �� ������ ������ ��ȸ�ϰ�, �μ��ڵ� �������� �������� ������.
SELECT EMP_NAME,
        CASE
            WHEN DEPT_CODE = 'D5' THEN '�ѹ���'
            WHEN DEPT_CODE = 'D6' THEN '��ȹ��'
            WHEN DEPT_CODE = 'D9' THEN '������'
        END AS �μ���
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D6','D9')
ORDER BY DEPT_CODE;

-- 13.EMPLOYEE ���̺��� ������ J1�� �����ϰ�, ���޺� ����� �� ��ձ޿��� ����ϼ���
SELECT JOB_CODE AS ����,COUNT(*)AS ���޺������,AVG(SALARY)AS ��ձ޿�
FROM EMPLOYEE
WHERE JOB_CODE !='J1'
GROUP BY JOB_CODE;

-- 14.EMPLOYEE���̺��� ������ J1�� �����ϰ�,  �Ի�⵵�� �ο����� ��ȸ�ؼ�, �Ի�� �������� �������� �����ϼ���.
SELECT EXTRACT(YEAR FROM HIRE_DATE)AS �Ի�⵵,COUNT(*)
FROM EMPLOYEE
WHERE JOB_CODE !='J1'
GROUP BY HIRE_DATE
ORDER BY HIRE_DATE;
-- 14.[EMPLOYEE] ���̺��� EMP_NO�� 8��° �ڸ��� 1, 3 �̸� '��', 2, 4 �̸� '��'�� ����� ��ȸ�ϰ�,
-- ������ �޿��� ���(����ó��), �޿��� �հ�, �ο����� ��ȸ�� �� �ο����� ���������� ���� �Ͻÿ�
SELECT 
    CASE
        WHEN SUBSTR(EMP_NO,8,1) ='1' THEN '��'
        WHEN SUBSTR(EMP_NO,8,1) = '3' THEN '��'
        WHEN SUBSTR(EMP_NO,8,1) ='2' THEN '��'
        WHEN SUBSTR(EMP_NO,8,1) ='4' THEN '��'
        END AS ����,FLOOR(AVG(SALARY))AS ���,SUM(SALARY)AS �հ�,COUNT(*)AS �ο���
FROM EMPLOYEE
GROUP BY 
    CASE
        WHEN SUBSTR(EMP_NO,8,1) ='1' THEN '��'
        WHEN SUBSTR(EMP_NO,8,1) = '3' THEN '��'
        WHEN SUBSTR(EMP_NO,8,1) ='2' THEN '��'
        WHEN SUBSTR(EMP_NO,8,1) ='4' THEN '��'
        END
ORDER BY �ο���;
-- 15.�μ��� ���� �ο����� ���ϼ���.
SELECT  DEPT_CODE,
    CASE
        WHEN SUBSTR(EMP_NO,8,1) ='1' THEN '��'
        WHEN SUBSTR(EMP_NO,8,1) = '3' THEN '��'
        WHEN SUBSTR(EMP_NO,8,1) ='2' THEN '��'
        WHEN SUBSTR(EMP_NO,8,1) ='4' THEN '��'
        END AS ����,COUNT(*) AS �ο���
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY DEPT_CODE,
    CASE
        WHEN SUBSTR(EMP_NO,8,1) ='1' THEN '��'
        WHEN SUBSTR(EMP_NO,8,1) = '3' THEN '��'
        WHEN SUBSTR(EMP_NO,8,1) ='2' THEN '��'
        WHEN SUBSTR(EMP_NO,8,1) ='4' THEN '��'
        END
ORDER BY DEPT_CODE;
-- 16.�μ��� �ο��� 3���� ���� �μ��� �ο����� ����ϼ���.
SELECT DEPT_CODE AS �μ�,COUNT(*)AS �ο���
FROM EMPLOYEE 
WHERE DEPT_CODE IS NOT NULL
GROUP BY DEPT_CODE
HAVING COUNT(*)>3;
-- 17.�μ��� ���޺� �ο����� 3���̻��� ������ �μ��ڵ�, �����ڵ�, �ο����� ����ϼ���.
SELECT DEPT_CODE, JOB_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY (DEPT_CODE, JOB_CODE)
HAVING COUNT(*) >= 3;
-- 18.�Ŵ����� �����ϴ� ����� 2���̻��� �Ŵ������̵�� �����ϴ� ������� ����ϼ���.
SELECT MANAGER_ID,COUNT(*)
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL
GROUP BY MANAGER_ID
HAVING COUNT(*)>=2;
--  19.�μ���� �������� ����ϼ���. DEPARTMENT, LOCATION ���̺� �̿�.
SELECT DEPT_TITLE,LOCAL_NAME
FROM DEPARTMENT
        JOIN LOCATION ON LOCATION_ID=LOCAL_CODE;
-- 20.������� �������� ����ϼ���. LOCATION, NATION ���̺�
SELECT LOCAL_NAME,NATIONAL_NAME
FROM LOCATION L
    JOIN NATIONAL N ON L.NATIONAL_CODE=N.NATIONAL_CODE;
-- 21.������� �������� ����ϼ���. LOCATION, NATION ���̺��� �����ϵ� USING�� ����Ұ�
SELECT LOCAL_NAME,NATIONAL_NAME
FROM LOCATION L
    JOIN NATIONAL USING(NATIONAL_CODE); 


        