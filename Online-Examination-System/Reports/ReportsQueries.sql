create proc Course_With_Topics_Report  @Course_ID INTEGER
AS
BEGIN
	select Topic_Name from ExamSystem.Topic where Course_ID=@Course_ID
END

GO
------------------------------------------------------
create proc Student_Info_Report @track_No integer
as
begin
  select * from ExamSystem.Student
  where Track_ID=@track_No
end
go
--------------------------------------------------------
create proc Course_With_Its_Students @instructor_ID integer
as
begin
select c.Course_Name,count(sc.Student_ID) as No_Of_Students
from [ExamSystem].[Course] c,[ExamSystem].[Student_Courses] sc,[ExamSystem].[Instructor] i
where c.Instructor_ID=i.Instructor_ID and sc.Course_ID=c.Course_ID and i.Instructor_ID=@instructor_ID
group by c.Course_Name 
end
go
---------------------------------------------------------

create proc Exam_With_Questions_Report @exam_id integer
as
begin
select q.Question_Text , q.Choise1 ,q.Choise2,q.Choise3,q.Choise4
from ExamSystem.Question q ,ExamSystem.Exam_Questions eq
where q.Question_ID=eq.Question_ID and eq.Exam_ID=@exam_id
end
go
----------------------------------------------------------
create proc Student_Grads_Report @Studnet_ID integer
as
begin
select c.Course_Name,e.Total_Grade 
from ExamSystem.Exam e,ExamSystem.Student s ,ExamSystem.Course c
where e.Std_ID=s.Std_ID and e.Course_ID=c.Course_ID and e.Total_Grade is not null 
end
go
-----------------------------------------------------------
create proc Student_Grades_Report @Student_ID integer
as
begin
select * from 
(select  c.Course_Name,e.Total_Grade,row_number() over (partition by e.Course_ID order by e.Exam_DateTime  desc )  as r
from ExamSystem.exam e , ExamSystem.Course c 
where e.Course_ID = c.Course_ID and e.Std_ID=@student_ID
 ) as newtable 
where r=1
end

-----------------------------------------------------------
--for testing:
--generate_Exam_check 2,2,1,'2020-01-02 04:08:00',60,6,4
--Exam_Correction 1,1
--Student_Grades_Report 1
-----------------------
--Exam_Answers 1,1
--Student_Grads_Report 1
----------------------------------------------------------------
--procdure for student to answer the exam:
create proc Exam_Answer_For_Student @Std_Id int ,@Exam_Id int,@Quest_Id int,@quest_Ans nvarchar(200)
as
begin
update [ExamSystem].[Stud_Exam_Quest]  
set [Question_Answer]= @quest_Ans
where [ExamSystem].[Stud_Exam_Quest].[Std_ID]=@Std_Id and [ExamSystem].[Stud_Exam_Quest].[Exam_ID]=@Exam_Id and  [ExamSystem].[Stud_Exam_Quest].[Question_ID]=@Quest_Id
end
go

--test
--  Exam_Answer_For_Student 1,2,47,'yes'
--Exam_Correction 2,1
---------------------------------------------------
--test
--generate_Exam_check 3,1,1,'2020-01-04 05:08:00',60,4,6
--Exam_Answer_For_Student 1,3,11,'f'
--Exam_Answer_For_Student 1,3,16,'t'
--Exam_Correction 3,1
------------------------------------------------
--generate_Exam_check 4,2,2,'2020-01-01 05:08:00',60,7,3
--Exam_Answer_For_Student 2,4,33,'f'
--Exam_Answer_For_Student 2,4,47,'yes'
--Exam_Correction 4,2
-----------------------------------------
--generate_Exam_check 5,1,2,'2020-01-08 05:08:00',60,5,5
--Exam_Answer_For_Student 2,5,11,'f'
--Exam_Answer_For_Student 2,5,15,'t'
--Exam_Correction 5,2