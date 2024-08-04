-- 1. Which courses are currently included (active) in the program? Include the course mnemonic and course name for each.
SELECT
    CourseMnemonic,
    CourseName
FROM
    DS5111_SU24.ZSK4GM.COURSES
WHERE
    IsActive = TRUE;
-- 2. Which courses were included in the program, but are no longer active? Include the course mnemonic and course name for each.
SELECT
    CourseMnemonic,
    CourseName
FROM
    DS5111_SU24.ZSK4GM.COURSES
WHERE
    IsActive = FALSE;
-- 3. Which instructors are not current employees?
SELECT
    InstructorName
FROM
    DS5111_SU24.ZSK4GM.INSTRUCTORS
WHERE
    IsActive = FALSE;
-- 4.4. For each course (active and inactive), how many learning outcomes are there?
SELECT
    c.CourseMnemonic,
    COUNT(l.OutcomeDescription) AS LearningOutcomeCount
FROM
    DS5111_SU24.ZSK4GM.COURSES c
    LEFT JOIN DS5111_SU24.ZSK4GM.LEARNINGOUTCOMES l ON c.CourseMnemonic = l.CourseMnemonic
GROUP BY
    c.CourseMnemonic;
-- 5. Are there any courses with no learning outcomes? If so, provide their mnemonics and names.
SELECT
    c.CourseMnemonic,
    c.CourseName
FROM
    DS5111_SU24.ZSK4GM.COURSES c
    LEFT JOIN DS5111_SU24.ZSK4GM.LEARNINGOUTCOMES l ON c.CourseMnemonic = l.CourseMnemonic
WHERE
    l.OutcomeDescription IS NULL;
-- 6. Which courses include SQL as a learning outcome? Include the learning outcome descriptions, course mnemonics, and course names in your solution.
SELECT
    l.OutcomeDescription,
    c.CourseMnemonic,
    c.CourseName
FROM
    DS5111_SU24.ZSK4GM.LEARNINGOUTCOMES l
    JOIN DS5111_SU24.ZSK4GM.COURSES c ON l.CourseMnemonic = c.CourseMnemonic
WHERE
    l.OutcomeDescription LIKE '%SQL%';
-- 7. Who taught course ds5100 in Summer 2021?
SELECT
    i.InstructorName
FROM
    DS5111_SU24.ZSK4GM.INSTRUCTORS i
    JOIN DS5111_SU24.ZSK4GM.INSTRUCTORASSIGNMENTS ia ON i.InstructorName = ia.InstructorName
    JOIN DS5111_SU24.ZSK4GM.ASSIGNMENTS a ON ia.AssignmentID = a.AssignmentID
WHERE
    a.CourseMnemonic = 'ds5100'
    AND a.Term = 'summer2021';
-- 8. Which instructors taught in Fall 2021? Order their names alphabetically, making sure the names are unique.
SELECT
    DISTINCT i.InstructorName
FROM
    DS5111_SU24.ZSK4GM.INSTRUCTORS i
    JOIN DS5111_SU24.ZSK4GM.INSTRUCTORASSIGNMENTS ia ON i.InstructorName = ia.InstructorName
    JOIN DS5111_SU24.ZSK4GM.ASSIGNMENTS a ON ia.AssignmentID = a.AssignmentID
WHERE
    a.Term = 'fall2021'
ORDER BY
    i.InstructorName;
-- 9. How many courses did each instructor teach in each term? Order your results by term and then instructor.
SELECT
    a.Term,
    i.InstructorName,
    COUNT(DISTINCT a.CourseMnemonic) AS CoursesTaught
FROM
    DS5111_SU24.ZSK4GM.INSTRUCTORS i
    JOIN DS5111_SU24.ZSK4GM.INSTRUCTORASSIGNMENTS ia ON i.InstructorName = ia.InstructorName
    JOIN DS5111_SU24.ZSK4GM.ASSIGNMENTS a ON ia.AssignmentID = a.AssignmentID
GROUP BY
    a.Term,
    i.InstructorName
ORDER BY
    a.Term,
    i.InstructorName;
-- 10a. Which courses had more than one instructor for the same term? Provide the mnemonic and term for each. Note this occurs in courses with multiple sections.
SELECT
    a.CourseMnemonic,
    a.Term
FROM
    DS5111_SU24.ZSK4GM.ASSIGNMENTS a
    JOIN DS5111_SU24.ZSK4GM.INSTRUCTORASSIGNMENTS ia ON a.AssignmentID = ia.AssignmentID
GROUP BY
    a.CourseMnemonic,
    a.Term
HAVING
    COUNT(DISTINCT ia.InstructorName) > 1;
-- 10b. For courses with multiple sections, provide the term, course mnemonic, and instructor name for each. Hint: You can use your result from 10a in a subquery or WITH clause.
    WITH MultiInstructorCourses AS (
        SELECT
            a.CourseMnemonic,
            a.Term
        FROM
            DS5111_SU24.ZSK4GM.ASSIGNMENTS a
            JOIN DS5111_SU24.ZSK4GM.INSTRUCTORASSIGNMENTS ia ON a.AssignmentID = ia.AssignmentID
        GROUP BY
            a.CourseMnemonic,
            a.Term
        HAVING
            COUNT(DISTINCT ia.InstructorName) > 1
    )
SELECT
    a.Term,
    a.CourseMnemonic,
    i.InstructorName
FROM
    DS5111_SU24.ZSK4GM.INSTRUCTORS i
    JOIN DS5111_SU24.ZSK4GM.INSTRUCTORASSIGNMENTS ia ON i.InstructorName = ia.InstructorName
    JOIN DS5111_SU24.ZSK4GM.ASSIGNMENTS a ON ia.AssignmentID = a.AssignmentID
    JOIN MultiInstructorCourses mic ON a.CourseMnemonic = mic.CourseMnemonic
    AND a.Term = mic.Term
ORDER BY
    a.Term,
    a.CourseMnemonic,
    i.InstructorName;
