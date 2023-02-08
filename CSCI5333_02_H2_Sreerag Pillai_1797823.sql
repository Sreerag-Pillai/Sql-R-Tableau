-- MySQL 1/30/2023
-- mysql -u sree -p
-- use toyu
-- tee hw.txt

-- [1] List information of all classes of CSCI and CINF courses in the following manner.

SELECT DISTINCT co.rubric, co.number, co.title, cl.classID, cl.facId, cl.year, cl.semester
FROM Course AS co
	inner join Class As cl on cl.courseId = co.courseId
WHERE co.rubric = 'CSCI' OR co.rubric = 'CINF';
-----------------------------------------------------------------------------
-- [2] List information of all classes taught by a CSCI faculty in the following manner.

SELECT DISTINCT CONCAT ( co.rubric,' ', co.number) AS course, co.title,  cl.classId, fa.facId, fa.deptcode AS "instructor dept"
FROM Course AS co
	inner join class as cl on cl.courseId = co.courseId
	inner join faculty as fa on fa.facId = cl.facID
WHERE fa.deptcode = 'CSCI';
----------------------------------------------------------------------------- 
-- [3] Show the information of students who are majoring or minoring in CSCI in thefollowing manner. 
--     The status of a student is dependent on the number of ach
--     credits:
--    1. 0-60: lower
--    2. 61-90: junior
--    3. >90: seni

SELECT DISTINCT s.stuId, s.fname, s.lname, s.major, s.minor, s.ach AS 'Accumulated credits',
       (IF(s.ach > 90, 'senior', 
           IF(s.ach >= 61 AND s.ach <= 90, 'junior', 
               'lower'))) AS status
FROM student AS s
WHERE s.minor = 'CSCI' OR s.major = 'CSCI';
------------------------------------------------------------------------------

-- [4] List the information about the class every student taken without a grade in the
--     following manner

SELECT DISTINCT s.stuId, s.fname, s.lname, e.classID, e.grade
FROM student AS s INNER JOIN enroll AS e ON e.stuId = s.stuId
WHERE e.grade IS NULL;
------------------------------------------------------------------------------
-- [ 5] List the information about the class every student taken without a passing
--      grade (either no grade, or a grade below C-, that is a grade point of the course is
--      below 1.5.)

SELECT DISTINCT s.stuId, s.fname, s.lname, e.classID, e.grade
FROM student AS s INNER JOIN enroll AS e ON e.stuId = s.stuId
WHERE e.grade IS NULL OR e.grade = 'D' OR e.grade = 'D+' OR e.grade = 'D-' OR e.grade = 'F'
ORDER BY S.stuId ASC;
--------------------------------------------------------------------------------
-- [6] List the students and the courses they enrolled into in the following manner.
--     List only students with both declared major and minor.

SELECT DISTINCT s.stuId, s.major, s.minor, cl.classID, co.title AS 'course', d.deptName AS 'offered by', e.grade
FROM student AS s
	INNER JOIN enroll  AS e ON e.stuId = s.stuId
	INNER JOIN class AS cl ON cl.classID = e.classID
	INNER JOIN course AS co ON co.courseId = cl.courseId
	INNER JOIN department AS d ON d.deptcode = co.rubric
WHERE s.major IS NOT NULL AND s.minor IS NOT NULL;