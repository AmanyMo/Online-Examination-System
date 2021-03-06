USE [master]
GO
/****** Object:  Database [OnlineExamDB]    Script Date: 3/1/2020 6:06:20 PM ******/
CREATE DATABASE [OnlineExamDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'OnlineExamDB', FILENAME = N'D:\setup programs\sql\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\OnlineExamDB.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'OnlineExamDB_log', FILENAME = N'D:\setup programs\sql\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\OnlineExamDB_log.ldf' , SIZE = 5696KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [OnlineExamDB] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [OnlineExamDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [OnlineExamDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [OnlineExamDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [OnlineExamDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [OnlineExamDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [OnlineExamDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [OnlineExamDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [OnlineExamDB] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [OnlineExamDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [OnlineExamDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [OnlineExamDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [OnlineExamDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [OnlineExamDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [OnlineExamDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [OnlineExamDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [OnlineExamDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [OnlineExamDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [OnlineExamDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [OnlineExamDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [OnlineExamDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [OnlineExamDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [OnlineExamDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [OnlineExamDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [OnlineExamDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [OnlineExamDB] SET RECOVERY FULL 
GO
ALTER DATABASE [OnlineExamDB] SET  MULTI_USER 
GO
ALTER DATABASE [OnlineExamDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [OnlineExamDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [OnlineExamDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [OnlineExamDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [OnlineExamDB]
GO
/****** Object:  Schema [ExamSystem]    Script Date: 3/1/2020 6:06:20 PM ******/
CREATE SCHEMA [ExamSystem]
GO
/****** Object:  StoredProcedure [dbo].[Course_With_Its_Students]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Course_With_Its_Students] @instructor_ID integer
as
begin
select c.Course_Name,count(sc.Student_ID) as No_Of_Students
from [ExamSystem].[Course] c,[ExamSystem].[Student_Courses] sc,[ExamSystem].[Instructor] i
where c.Instructor_ID=i.Instructor_ID and sc.Course_ID=c.Course_ID and i.Instructor_ID=@instructor_ID
group by c.Course_Name 
end
GO
/****** Object:  StoredProcedure [dbo].[Course_With_Topics_Report]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Course_With_Topics_Report]  @Course_ID INTEGER
AS
BEGIN
	select Topic_Name from ExamSystem.Topic where Course_ID=@Course_ID
END

GO
/****** Object:  StoredProcedure [dbo].[Delete_Course]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Delete_Course]  @id int
AS
BEGIN
	delete from ExamSystem.Course where Course_ID=@id
END

GO
/****** Object:  StoredProcedure [dbo].[Delete_Exam]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  procedure [dbo].[Delete_Exam] ( @Exam_ID INTEGER)
		as
		BEGIN  
            DELETE FROM ExamSystem.Exam   
            WHERE  Exam_ID = @Exam_ID 
        END
GO
/****** Object:  StoredProcedure [dbo].[Delete_Instructor]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Delete_Instructor]  @id int
AS
BEGIN
	delete from ExamSystem.Instructor where Instructor_ID=@id
END

GO
/****** Object:  StoredProcedure [dbo].[Delete_Question]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  procedure [dbo].[Delete_Question] ( @Question_ID INTEGER)
		as
		BEGIN  
            DELETE FROM ExamSystem.Question   
            WHERE  Question_ID = @Question_ID 
        END
GO
/****** Object:  StoredProcedure [dbo].[Delete_Stud_Exam_Quest]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	create  procedure [dbo].[Delete_Stud_Exam_Quest] ( @Std_ID INTEGER ,@Exam_ID INTEGER, @Question_ID INTEGER)
		as
		BEGIN  
            DELETE FROM ExamSystem.Stud_Exam_Quest   
            WHERE  Std_ID = @Std_ID
			AND    Exam_ID=@Exam_ID 
			AND    Question_ID=@Question_ID
        END
GO
/****** Object:  StoredProcedure [dbo].[Delete_Student]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----------------------------------
--delete student
CREATE PROCEDURE [dbo].[Delete_Student]  @id int
AS
BEGIN
	delete from ExamSystem.Student where Std_ID=@id
END
BEGIN
	update ExamSystem.Track set  No_Of_Stud-=1	where Track_ID=1(select s.Track_ID from ExamSystem.Student s where s.Std_ID=17)
END

GO
/****** Object:  StoredProcedure [dbo].[Delete_Student_Courses]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Delete_Student_Courses]  @id int
AS
BEGIN
	delete from ExamSystem.Student_Courses where Student_ID=@id
END
GO
/****** Object:  StoredProcedure [dbo].[Delete_Topic]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  procedure [dbo].[Delete_Topic] ( @Topic_ID INTEGER)
		as
		BEGIN  
            DELETE FROM ExamSystem.Topic   
            WHERE  Topic_ID = @Topic_ID 
        END
GO
/****** Object:  StoredProcedure [dbo].[Delete_Track]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Delete_Track]  @id int
AS
BEGIN
	delete from ExamSystem.Track where Track_ID=@id
END

GO
/****** Object:  StoredProcedure [dbo].[Delete_Track_Courses]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Delete_Track_Courses]  @id int
AS
BEGIN
	delete from SystemExam.Track_Courses where Track_ID=@id
END
GO
/****** Object:  StoredProcedure [dbo].[Exam_Answer_For_Student]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Exam_Answer_For_Student] @Std_Id int ,@Exam_Id int,@Quest_Id int,@quest_Ans nvarchar(200)
as
begin
update [ExamSystem].[Stud_Exam_Quest]  
set [Question_Answer]= @quest_Ans
where [ExamSystem].[Stud_Exam_Quest].[Std_ID]=@Std_Id and [ExamSystem].[Stud_Exam_Quest].[Exam_ID]=@Exam_Id and  [ExamSystem].[Stud_Exam_Quest].[Question_ID]=@Quest_Id
end
GO
/****** Object:  StoredProcedure [dbo].[Exam_Answers]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Exam_Answers] @Exam_ID int, @Student_ID int
As
	select Q.Question_Text,Q.Model_Answer,STQ.Question_Answer
	from ExamSystem.Question Q,ExamSystem.Exam_Questions EQ,ExamSystem.Stud_Exam_Quest STQ
	where EQ.Exam_ID = @Exam_ID
	And Q.Question_ID = EQ.Question_ID
	And STQ.Std_ID = @Student_ID
	And STQ.Question_ID = Q.Question_ID
	And STQ.Exam_ID = @Exam_ID
GO
/****** Object:  StoredProcedure [dbo].[Exam_Correction]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Exam_Correction] @Exam_ID int,@Studnet_ID int
AS
begin
	if(@Exam_ID is null or @Studnet_ID is null)
		select 'Exam or Student not Exist'
	else
		begin
			Declare c1 cursor
			for
				select top(10) STQ.Question_ID,STQ.Question_Answer,Q.Model_Answer
				from ExamSystem.Stud_Exam_Quest STQ,ExamSystem.Question Q
				where STQ.Exam_ID=@Exam_ID
				And STQ.Std_ID = @Studnet_ID
				And q.Question_ID=STQ.Question_ID
				
			for update
				Declare @Ques_ID int,@Stud_Ans nvarchar(max),@Ques_Ans nvarchar(max)
				open c1
				fetch c1 into @Ques_ID,@Stud_Ans,@Ques_Ans
				while @@FETCH_STATUS=0
				begin
					if @Stud_Ans = @Ques_Ans
						update ExamSystem.Stud_Exam_Quest
						set Question_Grade = 1
						where Exam_ID=@Exam_ID
						And Std_ID=@Studnet_ID
						And Question_ID=@Ques_ID
					else
						update ExamSystem.Stud_Exam_Quest
						set Question_Grade = 0
						where Exam_ID=@Exam_ID
						And Std_ID=@Studnet_ID
						And Question_ID=@Ques_ID
					fetch c1 into @Ques_ID,@Stud_Ans,@Ques_Ans
					end
				End
				Close c1
				Deallocate c1
			update ExamSystem.Exam
			set Total_Grade = (select sum(Question_Grade)
								from ExamSystem.Stud_Exam_Quest
								where Exam_ID = @Exam_ID
								And Std_ID = @Studnet_ID)
								where Exam.Exam_ID=@Exam_ID
								And Exam.Std_ID = @Studnet_ID
		End
GO
/****** Object:  StoredProcedure [dbo].[Exam_With_Questions_Report]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Exam_With_Questions_Report] @exam_id integer
as
begin
select q.Question_Text , q.Choise1 ,q.Choise2,q.Choise3,q.Choise4
from ExamSystem.Question q ,ExamSystem.Exam_Questions eq
where q.Question_ID=eq.Question_ID and eq.Exam_ID=@exam_id
end

GO
/****** Object:  StoredProcedure [dbo].[generate_Exam_check]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[generate_Exam_check] @Ex_ID INTEGER,@course_id INTEGER,@Student_id INTEGER,@Exam_DateTime  Datetime,@Exam_Duration INTEGER,@MCQ INTEGER,@TF INTEGER
as
if(@course_id is null or @student_id is null)
select 'please enter course_number and sudent_number'
else
INSERT  INTO ExamSystem.Exam  
                        (  Exam_ID,              
						   Std_ID   ,  
                                         Course_ID,
                                         Exam_Duration,  
                                         Exam_DateTime , 
										 Total_Grade )   

            VALUES      (        @Ex_ID,        
			                        @Student_id   ,  
                                         @course_id,
                                         @Exam_Duration,  
                                         @Exam_DateTime , 
										 null)  

Declare @course_name nvarchar(50)
SET
@course_name=( select Course_Name from ExamSystem.Course c where c.Course_ID=@course_id)

 --Declare @last_Exam_id INTEGER
--SET
--@last_Exam_id=(select max(Exam_ID) from ExamSystem.Exam)+1
 --Declare @last_Exam_id INTEGER
 --SET
 --@last_Exam_id=0;

--declare @n  INTEGER
--set @n=0;

--declare @m   INTEGER
--set @m=0;
-----------------------------------------------------------------------------
begin


DECLARE @TF_question_cursor CURSOR

SET 
@TF_question_cursor = CURSOR FOR    --course _id

SELECT Top(@TF) Question_ID ,
Question_Text ,
Choise1 ,
Choise2 ,
Choise3 ,
Choise4,
Question_Type 
 FROM ExamSystem.Question Q
 where Question_Type='T/F'
 AND Course_ID=@course_id
 ORDER BY RAND()                               --select random rows from questions 

 

 Declare @Question_Text nvarchar(MAX),@Question_Type nvarchar(50),@Choise1 nvarchar(MAX),@Choise2 nvarchar(MAX) ,@Choise3 nvarchar(MAX),
@Choise4 nvarchar(MAX),@Question_ID INTEGER

open @TF_question_cursor
fetch next from @TF_question_cursor into @Question_ID ,
@Question_Text,
@Choise1 ,
@Choise2 ,
@Choise3 ,
@Choise4 ,
@Question_Type  

print 'Exam: '+cast(@course_id as nvarchar)+' '+@course_name      --اسم الكورس والرقم فاول هيدر التيبل

WHILE @@FETCH_STATUS = 0
BEGIN
PRINT cast(@Question_ID as nvarchar) + '-' + @Question_Text + CHAR(13)  + 'a-'+@Choise1+CHAR(9)+'b-'+@Choise2


INSERT INTO ExamSystem.Exam_Questions  (Exam_ID,Question_ID)   

            VALUES      (@Ex_ID,@Question_ID ) 

Insert into ExamSystem.Stud_Exam_Quest (Std_ID,Exam_ID,Question_ID)
values(@Student_id,@Ex_ID,@Question_ID)

fetch next from @TF_question_cursor into @Question_ID ,
@Question_Text,
@Choise1 ,
@Choise2 ,
@Choise3 ,
@Choise4 ,
@Question_Type 



--set @last_Exam_id =@last_Exam_id+1;
                


			 										                                              
end
print 'TF end'


end

CLOSE @TF_question_cursor
DEALLOCATE @TF_question_cursor

----------------------------------------------------------------------------------------
begin
DECLARE @MCQ_question_cursor CURSOR
SET 
@MCQ_question_cursor = CURSOR FOR    --course _id

SELECT Top(@MCQ) Question_ID ,
Question_Text ,
Choise1 ,
Choise2 ,
Choise3 ,
Choise4,
Question_Type 
 FROM ExamSystem.Question Q
 where Question_Type='MCQ'
 AND Course_ID=@course_id
 ORDER BY RAND()                               --select random rows from questions 

 

open @MCQ_question_cursor
fetch next from @MCQ_question_cursor into @Question_ID ,
@Question_Text,
@Choise1 ,
@Choise2 ,
@Choise3 ,
@Choise4 ,
@Question_Type  

print 'Exam: '+cast(@course_id as nvarchar)+' '+@course_name      --اسم الكورس والرقم فاول هيدر التيبل

WHILE @@FETCH_STATUS = 0
BEGIN

PRINT cast(@Question_ID as nvarchar) + '-' + @Question_Text + CHAR(13)  + 'a-'+@Choise1 +CHAR(9)+'b-'+@Choise2 +CHAR(9)+'c-'+@Choise3+CHAR(9)+'d-'+@Choise4




INSERT INTO ExamSystem.Exam_Questions  (Exam_ID,Question_ID)   

            VALUES      (@Ex_ID,@Question_ID ) 

Insert into ExamSystem.Stud_Exam_Quest (Std_ID,Exam_ID,Question_ID)
values(@Student_id,@Ex_ID,@Question_ID)

fetch next from @MCQ_question_cursor into @Question_ID ,
@Question_Text,
@Choise1 ,
@Choise2 ,
@Choise3 ,
@Choise4 ,
@Question_Type 


--set @last_Exam_id =@last_Exam_id+1;
                


			 										                                              
end
print 'MCQ end'
print 'Exam page end'


end

CLOSE @MCQ_question_cursor
DEALLOCATE @MCQ_question_cursor
GO
/****** Object:  StoredProcedure [dbo].[Insert_Course]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_Course]  @name nvarchar(50),@instructor_id int=1
AS
BEGIN 
	insert into ExamSystem.Course values(@name,@instructor_id)
END

GO
/****** Object:  StoredProcedure [dbo].[Insert_Exam]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Insert_Exam]            @Std_ID        INTEGER,  
                                         @Course_ID      INTEGER,
                                         @Exam_Duration    INTEGER,  
                                         @Exam_DateTime     datetime, 
										 @Total_Grade     INTEGER
										  
AS  
   
        BEGIN  
            INSERT INTO ExamSystem.Exam  
                        (                Std_ID   ,  
                                         Course_ID,
                                         Exam_Duration,  
                                         Exam_DateTime , 
										 Total_Grade )   

            VALUES      (                @Std_ID   ,  
                                         @Course_ID,
                                         @Exam_Duration,  
                                         @Exam_DateTime , 
										 @Total_Grade )     
        END  
GO
/****** Object:  StoredProcedure [dbo].[Insert_Instructor]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_Instructor]  @name nvarchar(50)
AS
BEGIN
	insert into ExamSystem.Instructor values(@name)
END

GO
/****** Object:  StoredProcedure [dbo].[Insert_Question]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Insert_Question]        
                                        @Question_Text     nvarchar(Max),  
                                         @Model_Answer     nvarchar(Max),
										 @Choise1           nvarchar(Max),
										 @Choise2           nvarchar(Max),
                                         @Choise3           nvarchar(Max),
										 @Choise4           nvarchar(Max),
										 @Question_Type     nvarchar(50),
                                         @Course_ID    INTEGER  
                                          
AS  
   
        BEGIN  
            INSERT INTO ExamSystem.Question  
                        (               
                                         Question_Text ,  
                                         Model_Answer ,
										 Choise1      ,
										 Choise2      ,
                                         Choise3      ,
										 Choise4      ,
										 Question_Type,
                                         Course_ID)   

            VALUES      (               @Question_Text ,  
                                         @Model_Answer ,
										 @Choise1      ,
										 @Choise2      ,
                                         @Choise3      ,
										 @Choise4      ,
										 @Question_Type,
                                         @Course_ID)     
        END  

GO
/****** Object:  StoredProcedure [dbo].[Insert_Stud_Exam_Quest]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Insert_Stud_Exam_Quest]       
                                         @Std_ID       INTEGER,
                                         @Exam_ID     INTEGER,  
                                         @Question_ID    INTEGER,  
                                         @Question_Answer nvarchar(max),
										 @Question_grade  INTEGER
                                          
AS  
   
        BEGIN  
            INSERT INTO ExamSystem.Stud_Exam_Quest  
                        (        Std_ID,  
								 Exam_ID,  
								 Question_ID,   
                                         Question_Answer ,
										 Question_grade   )   

            VALUES      (           @Std_ID,
									@Exam_ID,
									@Question_ID,
									@Question_Answer ,
										 @Question_grade  )     
        END  
GO
/****** Object:  StoredProcedure [dbo].[Insert_Student]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_Student]  @fname nvarchar(50),@lname nvarchar(50),
                                  @address nvarchar(max)='unknown'  ,@age int=22 , @track_id int=1
AS
BEGIN
	insert into ExamSystem.Student values(@fname,@lname,@address,@age,@track_id)
	--update num of student in this track
	update ExamSystem.Track
	set No_Of_Stud+=1
	where ExamSystem.Track.Track_ID=@track_id
END

GO
/****** Object:  StoredProcedure [dbo].[Insert_Student_Courses]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_Student_Courses]  @Student_id int ,@course_id int
AS
BEGIN
	insert into ExamSystem.Student_Courses(Student_ID,Course_ID) values(@Student_id,@course_id)
END
GO
/****** Object:  StoredProcedure [dbo].[Insert_Topic]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Insert_Topic]       
                                       
                                         @Topic_Name     nvarchar(50),  
                                         @Course_ID    INTEGER  
                                          
AS  
   
        BEGIN  
            INSERT INTO ExamSystem.Topic  
                        (               
                                        
                                         Topic_Name     ,  
                                         Course_ID  )   

            VALUES      (             
                                        @Topic_Name     ,  
                                        @Course_ID  )     
        END  

GO
/****** Object:  StoredProcedure [dbo].[Insert_Track]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_Track]  @name nvarchar(50),@manager nvarchar(50)='ANON',@duration int=3,@num int=0
AS
BEGIN 
	insert into ExamSystem.Track values(@name,@manager,@duration,@num)
END

GO
/****** Object:  StoredProcedure [dbo].[Insert_Track_Courses]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----------------------------------
--insert track_course
CREATE PROCEDURE [dbo].[Insert_Track_Courses]  @track_id int=1 ,@course_id int=5
AS
BEGIN
	insert into ExamSystem.Track_Courses(Track_ID,Course_ID) values(@track_id,@course_id)
END

GO
/****** Object:  StoredProcedure [dbo].[Select_Course]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Select_Course]  @id int
AS
BEGIN
	select * from ExamSystem.Course where Course_ID=@id
END

GO
/****** Object:  StoredProcedure [dbo].[Select_Exam]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Select_Exam]  @id int
AS
SELECT * FROM ExamSystem.Exam  WHERE Exam_ID=@id
GO
/****** Object:  StoredProcedure [dbo].[Select_Instructor]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Select_Instructor]  @id int
AS
BEGIN
	select * from ExamSystem.Instructor where Instructor_ID=@id
END

GO
/****** Object:  StoredProcedure [dbo].[Select_Question]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Select_Question] @id int
AS
SELECT * FROM ExamSystem.Question  WHERE Question_ID=@id

GO
/****** Object:  StoredProcedure [dbo].[Select_Stud_Exam_Quest]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Select_Stud_Exam_Quest] @stu_id INT ,@exam_id INT 
AS
SELECT * FROM ExamSystem.Stud_Exam_Quest WHERE Std_ID=@stu_id AND Exam_ID=@exam_id

GO
/****** Object:  StoredProcedure [dbo].[Select_Student]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Select_Student] @id int
AS
SELECT * FROM ExamSystem.Student WHERE Std_ID=@id

GO
/****** Object:  StoredProcedure [dbo].[Select_Student_Courses]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Select_Student_Courses]  @id int
AS
BEGIN
	select * from ExamSystem.Student_Courses where Student_ID=@id
END
GO
/****** Object:  StoredProcedure [dbo].[Select_Topic]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Select_Topic] @id INT
AS
SELECT * FROM ExamSystem.Topic WHERE Topic_ID=@id

GO
/****** Object:  StoredProcedure [dbo].[Select_Track]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Select_Track]  @id int
AS
BEGIN
	select * from ExamSystem.Track where Track_ID=@id
END

GO
/****** Object:  StoredProcedure [dbo].[Select_Track_Courses]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------
--create proc to select track_course
CREATE PROCEDURE [dbo].[Select_Track_Courses]  @id int
AS
BEGIN
	select * from ExamSystem.Track_Courses where Track_ID=@id
END

GO
/****** Object:  StoredProcedure [dbo].[Student_Grades_Report]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Student_Grades_Report] @Student_ID integer
as
begin
select * from 
(select  c.Course_Name,e.Total_Grade,row_number() over (partition by e.Course_ID order by e.Exam_DateTime  desc )  as r
from ExamSystem.exam e , ExamSystem.Course c 
where e.Course_ID = c.Course_ID and e.Std_ID=@student_ID
 ) as newtable 
where r=1
end

GO
/****** Object:  StoredProcedure [dbo].[Student_Info_Report]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Student_Info_Report] @track_No integer
as
begin
  select * from ExamSystem.Student
  where Track_ID=@track_No
end
GO
/****** Object:  StoredProcedure [dbo].[Update_Course]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Update_Course]  @id int,@name nvarchar(50),@instructor_id int =1  
AS
BEGIN
	update ExamSystem.Course 
	set Course_Name=@name ,Instructor_ID=@instructor_id
	where Course_ID=@id
END

GO
/****** Object:  StoredProcedure [dbo].[Update_Exam]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Update_Exam]    @Exam_ID        INTEGER,
                                 @Std_ID        INTEGER,  
                                 @Course_ID      INTEGER,
                                 @Exam_Duration    INTEGER,  
                                 @Exam_DateTime     datetime,  
                                   @Total_Grade     INTEGER
                                   
As
		 BEGIN  
            UPDATE ExamSystem.Exam  
            SET    Std_ID = @Std_ID,  
                   Course_ID=@Course_ID, 
                   Exam_Duration = @Exam_Duration ,
				   Exam_DateTime=@Exam_DateTime,
				   Total_Grade = @Total_Grade
            WHERE  Exam_ID = @Exam_ID  
        END  

GO
/****** Object:  StoredProcedure [dbo].[Update_Instructor]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Update_Instructor]  @id int,@name nvarchar(50)
AS
BEGIN
	update ExamSystem.Instructor 
	set Instructor_Name=@name
	where Instructor_ID=@id
END

GO
/****** Object:  StoredProcedure [dbo].[Update_Question]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Update_Question]    @Question_ID        INTEGER,
                                        @Question_Text     nvarchar(Max),  
                                         @Model_Answer     nvarchar(Max),
										 @Choise1           nvarchar(Max),
										 @Choise2           nvarchar(Max),
                                         @Choise3           nvarchar(Max),
										 @Choise4           nvarchar(Max),
										 @Question_Type     nvarchar(50),
                                         @Course_ID    INTEGER  
                                   
                                   
As
		 BEGIN  
            UPDATE ExamSystem.Question  
            SET Question_Text =@Question_Text,     
                Model_Answer=@Model_Answer,     
				Choise1=@Choise1,           
				Choise2=@Choise2,           
                Choise3=@Choise3,          
				Choise4=@Choise4,          
				Question_Type=@Question_Type,     
                Course_ID=@Course_ID     
            WHERE  Question_ID = @Question_ID  
        END  
GO
/****** Object:  StoredProcedure [dbo].[Update_Stud_Exam_Quest]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Update_Stud_Exam_Quest]  @Std_ID       INTEGER,
                                         @Exam_ID     INTEGER,  
                                         @Question_ID    INTEGER,  
                                         @Question_Answer nvarchar(max),
										 @Question_grade  INTEGER 
                                   
As
		 BEGIN  
            UPDATE   ExamSystem.Stud_Exam_Quest 
            SET                          
                                         Question_Answer=@Question_Answer ,
										 Question_grade=@Question_grade   
            WHERE  Std_ID = @Std_ID
			AND    Exam_ID=@Exam_ID 
			AND    Question_ID=@Question_ID 
        END  
GO
/****** Object:  StoredProcedure [dbo].[Update_Student]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--update student
CREATE PROCEDURE [dbo].[Update_Student]  @id int , @fname nvarchar(50)='ANON',@lname nvarchar(50)='ANON',
                                  @address nvarchar(max)='unknown'  ,@age int=22 , @track_id int=1

AS

BEGIN
	--select current track_id of this student who will update his data
	declare @current_track_id int
	set @current_track_id=(
	                        select s.Track_ID
						    from ExamSystem.Student s
						    where s.Std_ID=@id
						   ) 

END
BEGIN
	update ExamSystem.Student 
	set Std_FName= @fname , Std_LName=@lname , Std_Address=@address , Std_Age=@age , Track_ID=@track_id
	where Std_ID=@id
END

	--//if track_id != current track_is of student
 if(@track_id!=@current_track_id )
  BEGIN
		update ExamSystem.Track set No_Of_Stud+=1 where Track.Track_ID=@track_id
		update ExamSystem.Track set No_Of_Stud-=1 where Track.Track_ID=@current_track_id
	
  END

GO
/****** Object:  StoredProcedure [dbo].[Update_Student_Courses]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Update_Student_Courses]  @id int,@course_id int
AS
BEGIN
	update ExamSystem.Student_Courses 
	set Course_ID=@course_id
	where Student_ID=@id
END
GO
/****** Object:  StoredProcedure [dbo].[Update_Topic]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Update_Topic]         @Topic_ID       INTEGER,
                                         @Topic_Name     nvarchar(50),  
                                         @Course_ID    INTEGER  
                                   
                                   
As
		 BEGIN  
            UPDATE ExamSystem.Topic 
            set
                Topic_Name= @Topic_Name   ,  
                Course_ID=  @Course_ID  
            WHERE  Topic_ID = @Topic_ID  
        END  

GO
/****** Object:  StoredProcedure [dbo].[Update_Track]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Update_Track]  @id int,@name nvarchar(50)--,@manager nvarchar(50)='Anon'
AS
BEGIN
	update ExamSystem.Track 
	set Track_Name=@name
	where Track_ID=@id
END

GO
/****** Object:  StoredProcedure [dbo].[Update_Track_Courses]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----------------------------------
--update track_course
CREATE PROCEDURE [dbo].[Update_Track_Courses]  @id int,@course_id int
AS
BEGIN
	update ExamSystem.Track_Courses 
	set Course_ID=@course_id
	where Track_ID=@id
END

GO
/****** Object:  Table [ExamSystem].[Course]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ExamSystem].[Course](
	[Course_ID] [int] IDENTITY(1,1) NOT NULL,
	[Course_Name] [nvarchar](50) NULL,
	[Instructor_ID] [int] NULL,
 CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
	[Course_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [ExamSystem].[Exam]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ExamSystem].[Exam](
	[Exam_ID] [int] NOT NULL,
	[Exam_Duration] [int] NULL,
	[Exam_DateTime] [datetime] NULL,
	[Std_ID] [int] NULL,
	[Course_ID] [int] NULL,
	[Total_Grade] [int] NULL,
 CONSTRAINT [PK_Exam] PRIMARY KEY CLUSTERED 
(
	[Exam_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [ExamSystem].[Exam_Questions]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ExamSystem].[Exam_Questions](
	[Exam_ID] [int] NOT NULL,
	[Question_ID] [int] NOT NULL,
 CONSTRAINT [PK_Exam_Questions] PRIMARY KEY CLUSTERED 
(
	[Exam_ID] ASC,
	[Question_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [ExamSystem].[Instructor]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ExamSystem].[Instructor](
	[Instructor_ID] [int] IDENTITY(1,1) NOT NULL,
	[Instructor_Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Instructor] PRIMARY KEY CLUSTERED 
(
	[Instructor_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [ExamSystem].[Question]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ExamSystem].[Question](
	[Question_ID] [int] IDENTITY(1,1) NOT NULL,
	[Question_Text] [nvarchar](max) NULL,
	[Model_Answer] [nvarchar](max) NULL,
	[Choise1] [nvarchar](max) NOT NULL,
	[Choise2] [nvarchar](max) NOT NULL,
	[Choise3] [nvarchar](max) NULL,
	[Choise4] [nvarchar](max) NULL,
	[Question_Type] [nvarchar](50) NULL,
	[Course_ID] [int] NULL,
 CONSTRAINT [PK_Question] PRIMARY KEY CLUSTERED 
(
	[Question_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [ExamSystem].[Stud_Exam_Quest]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ExamSystem].[Stud_Exam_Quest](
	[Std_ID] [int] NOT NULL,
	[Exam_ID] [int] NOT NULL,
	[Question_ID] [int] NOT NULL,
	[Question_Answer] [nvarchar](max) NULL,
	[Question_Grade] [int] NULL,
 CONSTRAINT [PK_Stud_Exam_Quest] PRIMARY KEY CLUSTERED 
(
	[Std_ID] ASC,
	[Exam_ID] ASC,
	[Question_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [ExamSystem].[Student]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ExamSystem].[Student](
	[Std_ID] [int] IDENTITY(1,1) NOT NULL,
	[Std_FName] [nvarchar](50) NULL,
	[Std_LName] [nvarchar](50) NULL,
	[Std_Address] [nvarchar](max) NULL,
	[Std_Age] [int] NULL,
	[Track_ID] [int] NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[Std_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [ExamSystem].[Student_Courses]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ExamSystem].[Student_Courses](
	[Student_ID] [int] NOT NULL,
	[Course_ID] [int] NOT NULL,
 CONSTRAINT [PK_Student_Courses] PRIMARY KEY CLUSTERED 
(
	[Student_ID] ASC,
	[Course_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [ExamSystem].[Topic]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ExamSystem].[Topic](
	[Topic_ID] [int] IDENTITY(1,1) NOT NULL,
	[Topic_Name] [nvarchar](50) NULL,
	[Course_ID] [int] NULL,
 CONSTRAINT [PK_Topic] PRIMARY KEY CLUSTERED 
(
	[Topic_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [ExamSystem].[Track]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ExamSystem].[Track](
	[Track_ID] [int] IDENTITY(1,1) NOT NULL,
	[Track_Name] [nvarchar](50) NULL,
	[Track_Manager] [nvarchar](50) NULL,
	[Track_Duration] [int] NULL,
	[No_Of_Stud] [int] NULL,
 CONSTRAINT [PK_Track] PRIMARY KEY CLUSTERED 
(
	[Track_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [ExamSystem].[Track_Courses]    Script Date: 3/1/2020 6:06:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ExamSystem].[Track_Courses](
	[Track_ID] [int] NOT NULL,
	[Course_ID] [int] NOT NULL,
 CONSTRAINT [PK_Track_Courses] PRIMARY KEY CLUSTERED 
(
	[Track_ID] ASC,
	[Course_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [ExamSystem].[Stud_Exam_Quest] ADD  CONSTRAINT [DF_Stud_Exam_Quest_Question_Grade]  DEFAULT ((0)) FOR [Question_Grade]
GO
ALTER TABLE [ExamSystem].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Course_Instructor] FOREIGN KEY([Instructor_ID])
REFERENCES [ExamSystem].[Instructor] ([Instructor_ID])
ON UPDATE SET NULL
ON DELETE SET NULL
GO
ALTER TABLE [ExamSystem].[Course] CHECK CONSTRAINT [FK_Course_Instructor]
GO
ALTER TABLE [ExamSystem].[Exam]  WITH CHECK ADD  CONSTRAINT [FK_Exam_Course] FOREIGN KEY([Course_ID])
REFERENCES [ExamSystem].[Course] ([Course_ID])
ON UPDATE SET NULL
ON DELETE SET NULL
GO
ALTER TABLE [ExamSystem].[Exam] CHECK CONSTRAINT [FK_Exam_Course]
GO
ALTER TABLE [ExamSystem].[Exam]  WITH CHECK ADD  CONSTRAINT [FK_Exam_Student] FOREIGN KEY([Std_ID])
REFERENCES [ExamSystem].[Student] ([Std_ID])
ON UPDATE SET NULL
ON DELETE SET NULL
GO
ALTER TABLE [ExamSystem].[Exam] CHECK CONSTRAINT [FK_Exam_Student]
GO
ALTER TABLE [ExamSystem].[Exam_Questions]  WITH CHECK ADD  CONSTRAINT [FK_Exam_Questions_Exam] FOREIGN KEY([Exam_ID])
REFERENCES [ExamSystem].[Exam] ([Exam_ID])
GO
ALTER TABLE [ExamSystem].[Exam_Questions] CHECK CONSTRAINT [FK_Exam_Questions_Exam]
GO
ALTER TABLE [ExamSystem].[Exam_Questions]  WITH CHECK ADD  CONSTRAINT [FK_Exam_Questions_Question] FOREIGN KEY([Question_ID])
REFERENCES [ExamSystem].[Question] ([Question_ID])
GO
ALTER TABLE [ExamSystem].[Exam_Questions] CHECK CONSTRAINT [FK_Exam_Questions_Question]
GO
ALTER TABLE [ExamSystem].[Question]  WITH CHECK ADD  CONSTRAINT [FK_Question_Course] FOREIGN KEY([Course_ID])
REFERENCES [ExamSystem].[Course] ([Course_ID])
ON UPDATE SET NULL
ON DELETE SET NULL
GO
ALTER TABLE [ExamSystem].[Question] CHECK CONSTRAINT [FK_Question_Course]
GO
ALTER TABLE [ExamSystem].[Stud_Exam_Quest]  WITH CHECK ADD  CONSTRAINT [FK_Stud_Exam_Quest_Exam] FOREIGN KEY([Exam_ID])
REFERENCES [ExamSystem].[Exam] ([Exam_ID])
GO
ALTER TABLE [ExamSystem].[Stud_Exam_Quest] CHECK CONSTRAINT [FK_Stud_Exam_Quest_Exam]
GO
ALTER TABLE [ExamSystem].[Stud_Exam_Quest]  WITH CHECK ADD  CONSTRAINT [FK_Stud_Exam_Quest_Question] FOREIGN KEY([Question_ID])
REFERENCES [ExamSystem].[Question] ([Question_ID])
GO
ALTER TABLE [ExamSystem].[Stud_Exam_Quest] CHECK CONSTRAINT [FK_Stud_Exam_Quest_Question]
GO
ALTER TABLE [ExamSystem].[Stud_Exam_Quest]  WITH CHECK ADD  CONSTRAINT [FK_Stud_Exam_Quest_Student] FOREIGN KEY([Std_ID])
REFERENCES [ExamSystem].[Student] ([Std_ID])
GO
ALTER TABLE [ExamSystem].[Stud_Exam_Quest] CHECK CONSTRAINT [FK_Stud_Exam_Quest_Student]
GO
ALTER TABLE [ExamSystem].[Student_Courses]  WITH CHECK ADD  CONSTRAINT [FK_Student_Courses_Course] FOREIGN KEY([Course_ID])
REFERENCES [ExamSystem].[Course] ([Course_ID])
GO
ALTER TABLE [ExamSystem].[Student_Courses] CHECK CONSTRAINT [FK_Student_Courses_Course]
GO
ALTER TABLE [ExamSystem].[Student_Courses]  WITH CHECK ADD  CONSTRAINT [FK_Student_Courses_Student] FOREIGN KEY([Student_ID])
REFERENCES [ExamSystem].[Student] ([Std_ID])
GO
ALTER TABLE [ExamSystem].[Student_Courses] CHECK CONSTRAINT [FK_Student_Courses_Student]
GO
ALTER TABLE [ExamSystem].[Topic]  WITH CHECK ADD  CONSTRAINT [FK_Topic_Course] FOREIGN KEY([Course_ID])
REFERENCES [ExamSystem].[Course] ([Course_ID])
ON UPDATE SET NULL
ON DELETE SET NULL
GO
ALTER TABLE [ExamSystem].[Topic] CHECK CONSTRAINT [FK_Topic_Course]
GO
ALTER TABLE [ExamSystem].[Track_Courses]  WITH CHECK ADD  CONSTRAINT [FK_Track_Courses_Course] FOREIGN KEY([Course_ID])
REFERENCES [ExamSystem].[Course] ([Course_ID])
GO
ALTER TABLE [ExamSystem].[Track_Courses] CHECK CONSTRAINT [FK_Track_Courses_Course]
GO
ALTER TABLE [ExamSystem].[Track_Courses]  WITH CHECK ADD  CONSTRAINT [FK_Track_Courses_Track] FOREIGN KEY([Track_ID])
REFERENCES [ExamSystem].[Track] ([Track_ID])
GO
ALTER TABLE [ExamSystem].[Track_Courses] CHECK CONSTRAINT [FK_Track_Courses_Track]
GO
USE [master]
GO
ALTER DATABASE [OnlineExamDB] SET  READ_WRITE 
GO
