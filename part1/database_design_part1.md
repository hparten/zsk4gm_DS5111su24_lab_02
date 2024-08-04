# Lab: Database Design and Build – Part 1

1. **What tables should you build?** *(3 PTS)*
   - I should build the following tables:
     - **Instructors**
     - **Courses**
     - **Learning Outcomes**
     - **Assignments**
     - **Instructor Assignments**

2. **For each table, what field(s) will you use for primary key?** *(2 PTS)*
   - **Instructors**: Use  `InstructorName`, the name of each instructor
   - **Courses**: Use `CourseMnemonic`, the code abbreviation for each course
   - **Learning Outcomes**: Use `OutcomeDescription`, the text of each learning outcome
   - **Assignments**: Use `AssignmentID`, a unique identifier for each assignment (combination of Course/Term)
   - **Instructor Assignments**: Use `InstructorAssignmentID`, a unique identifier for each instructor assignment

3. **For each table, what foreign keys will you use?** *(2 PTS)*
   - **Instructors**: No foreign keys
   - **Courses**: No foreign keys
   - **Learning Outcomes**: I will use `CourseMnemonic` as a foreign key to reference `Courses`
   - **Assignments**: I will use `CourseMnemonic` as a foreign key to reference `Courses`
   - **Instructor Assignments**: I will use `AssignmentID` to reference `Assignments` and `InstructorName` to reference `Instructors`
 
4. **Learning outcomes, courses, and instructors need a flag to indicate if they are currently active or not. How will your database support this feature?** *(2 PTS)*
   - I will add a Boolean attribute, `IsActive`, to the `Courses`, `Instructors`, and `Learning Outcomes` tables to indicate if the record is active or inactive. This will help in tracking the status of courses, instructors, and learning outcomes.

5. **Is there anything to normalize in the database, and if so, how will you normalize it? Recall the desire to eliminate redundancy.** *(1 PT)*
   - I eliminate redundancy by ensuring that each obseration in each table is unique. I create separate tables for `Instructors` and `Courses`, and reference these in the other tables through foreign keys to avoid storing redudant information.

7. **Are there indexes that you should build? Explain your reasoning.** *(1 PT)*
   - Yes, I will build an index for `AssignmentID` because the primary key that encode unique observations in this table is a combination of `CourseMnemonic` and `Term`, but I will need to reference this key in the `InstructorAssignments` table. I also index the `InstructorAssignments` table with `InstructorAssignmentID` because otherwise the primary key would be a composite of foreign keys.
  
8. **Are there constraints to enforce? Explain your answer and strategy.** *(2 PTS)*
   - To ensure that learning outcomes are only entered for courses offered in the School of Data Science, I would:
     - Add a `School` table to link courses with the schools they are offered in.
     - Use a database trigger to enforce reference checks to ensure learning outcomes are only added for courses from the School of Data Science.
   - To ensure that instructors are not assigned to teach courses they are not qualified for, I would:
     - Add a `Qualifications` table to link instructors with the courses they are qualified to teach.
     - Use a database trigger to enforce qualification checks before assignments are made.

9. **Draw and submit a Relational Model for your project.** *(5 PTS)*
   - For an example, see *Beginning Database Design Solutions* page 115 Figure 5-28. 
![UVA MSDS Relational Database_final](https://github.com/user-attachments/assets/9ee8dce8-dbc2-427e-a074-073c816fc985)

10. **Suppose you were asked if your database could also support the UVA SDS Residential MSDS Program. Explain any issues that might arise, changes to the database structure (schema), and new data that might be needed.** *(2 PTS)*
   - To support the Residential MSDS Program, I would need to update the schema to handle multiple programs. This would likely involve adding a `Program` table to associate courses, instructors, and assignments with each program.
