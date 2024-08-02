# Lab: Database Design and Build – Part 1

1. **What tables should you build?** *(3 PTS)*
   - I should build the following tables:
     - **Instructors**
     - **Courses**
     - **Learning Outcomes**
     - **Assignments**

2. **For each table, what field(s) will you use for primary key?** *(2 PTS)*
   - **Instructors**: Use `InstructorID`, a unique identifier for each instructor.
   - **Courses**: Use `CourseID`, a unique identifier for each course.
   - **Learning Outcomes**: Use `OutcomeID`, a unique identifier for each learning outcome.
   - **Assignments**: Use `AssignmentID`, a unique identifier for each assignment.

3. **For each table, what foreign keys will you use?** *(2 PTS)*
   - **Instructors**: No foreign keys needed.
   - **Courses**: No foreign keys needed.
   - **Learning Outcomes**: Use `CourseID` to reference the `Courses` table. A course can have multiple learning outcomes.
   - **Assignments**: Use `CourseID` to reference the `Courses` table and `InstructorID` to reference the `Instructors` table. A course and an instructor can have multiple assignments.

4. **Learning outcomes, courses, and instructors need a flag to indicate if they are currently active or not. How will your database support this feature?** *(2 PTS)*
   - I will add a Boolean attribute to the `Courses`, `Instructors`, and `Learning Outcomes` tables to indicate if the record is active or inactive. This will help in tracking the status of courses, instructors, and learning outcomes.

5. **Is there anything to normalize in the database, and if so, how will you normalize it? Recall the desire to eliminate redundancy.** *(1 PT)*
   - Yes, I will want to eliminate the redundancy of course and instructor names. I will do this by storing the names in separate tables and referencing the unique IDs as foreign keys.

6. **Are there indexes that you should build? Explain your reasoning.** *(1 PT)*
   - Yes, I will build indexes for the `CourseID`, `InstructorID`, `OutcomeID`, and `AssignmentID` since they are primary keys in my tables. I will also build indexes on the `CourseID` and `InstructorID` as foreign keys in the `Assignments` and `Learning Outcomes` tables. This will speed up database operations and improve query performance.

7. **Are there constraints to enforce? Explain your answer and strategy.** *(2 PTS)*
   - To ensure that learning outcomes are only entered for courses offered in the School of Data Science, I would:
     - Add a `School` table to link courses with the schools they are offered in.
     - Use a database trigger to enforce reference checks to ensure learning outcomes are only added for courses from the School of Data Science.
   - To ensure that instructors are not assigned to teach courses they are not qualified for, I would:
     - Add a `Qualifications` table to link instructors with the courses they are qualified to teach.
     - Use a database trigger to enforce qualification checks before assignments are made.

8. **Draw and submit a Relational Model for your project.** *(5 PTS)*
   - For an example, see *Beginning Database Design Solutions* page 115 Figure 5-28. 
  ![UVA Online MSDS Relational Model](https://github.com/user-attachments/assets/e3b329ea-b835-494c-bddd-ac6976f48d0e)

9. **Suppose you were asked if your database could also support the UVA SDS Residential MSDS Program. Explain any issues that might arise, changes to the database structure (schema), and new data that might be needed.** *(2 PTS)*
   - To support the Residential MSDS Program, I would need to update the schema to handle multiple programs. This would likely involve adding a `Program` table to associate courses, instructors, and assignments with each program.
