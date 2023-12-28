SELECT DISTINCT LOCATION
FROM department_t;


SELECT LOCATION
FROM department_t
GROUP BY LOCATION;

SELECT NAME
  FROM EMPLOYEE_T
WHERE NAME LIKE '구__';

SELECT *
  FROM department_t
WHERE DEPT_NO = 1; -- DEPT_NO 칼럼은 Unique 하므로 조회 결과는 1개 이하이다.

SELECT *
  FROM department_t
WHERE LOCATION = '서울'; -- Location 칼럼은 Unique 하지 않기 때문에 조회 결과는 2개 이상이 가능하다.

--6 사원 테이블에서 급여가
SELECT *
  FROM EMPLOYEE_T
WHERE SALARY >= 3000000;

SELECT *
  FROM EMPLOYEE_T
WHERE SALARY BETWEEN 2000000 AND 3000000;

SELECT *
  FROM EMPLOYEE_T
WHERE POSITION IN ('사원', '과장');

SELECT *
  FROM EMPLOYEE_T
WHERE NAME LIKE '한%';

SELECT *
  FROM EMPLOYEE_T
WHERE HIRE_DATE LIKE '%09%';