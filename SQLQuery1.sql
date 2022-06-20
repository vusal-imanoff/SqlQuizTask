--1. Academy databazasını yaradın - 2 bal

Create database Academy

use Academy

--2. Groups(İd,Name) ve Students(İd,Name,Surname,Groupİd) table-ları yaradın(one-to-many), təkrar qrup adı əlavə etmək olmasın - 5 bal

create table Groups (
	Id int primary key identity(1,1),
	Name nvarchar(255) unique
	)

	create table Students(
	Id int primary key identity(1,1),
	Name nvarchar(255),
	SurName nvarchar (255),
	GroupId int foreign key references Groups(Id)
	)



--3. Students table-na Grade (int) kalonunu əlavə etmək - 3 bal

Alter Table Students Add Grade int

--4. Groups table-na 3 data(P129,P124,P221), Students table-na 4 data əlavə edin(1 tələbə p221 qrupna, 3 tələbə p129 qrupuna aid olsun) - 5 bal


drop table Students
insert into Groups (Name) values('P129'),('P124'),('P21')

insert into Students (Name,SurName,GroupId,Grade) values
('Vusal','Imanov',1,78),
('Ismayil','Bigli',2,55),
('Onur','Ismayilov',2,69),
('Vusal','Aliyev',2,99)
--5. P129 qrupuna aid olan tələbələrin siyahisini gosterin - 10 bal

select * from Students join Groups on Groups.Id=Students.GroupId where Groups.Name='P129'

--6. Her qrupda neçə tələbə olduğunu göstərən siyahı çıxarmaq - 15 bal

select Groups.Name, COUNT(*) from Students join Groups on Groups.id=Students.GroupId 
group by Groups.Name

--7. View yaratmaq - tələbə adını, qrupun adını-qrup kimi , tələbə soyadını, tələbənin balını göstərməli - 20 bal

Create View CreateView 
as
select s.Name,s.SurName,g.Name as 'Group',s.Grade from Students s join Groups g on g.id=s.GroupId 


--8. Procedure yazmalı - göndərilən baldan yüksək bal alan tələbələrin siyahısını göstərməlidir - 20 bal

Create Procedure CheckGrade  @check decimal(5,2) 
as
begin 
select s.Name,s.SurName,g.Name as 'Group',s.Grade from Students s join Groups g on g.Id=s.GroupId where s.Grade>@check
end

--9. Funksiya yazmalı - göndərilən qrup adina uyğun neçə tələbə olduğunu göstərməlidir - 20 bal

create Function @checkgroup nvarchar(255)
as
begin 
select Groups.Name, COUNT(*) from Students join Groups on Groups.id=Students.GroupId where Groups.name like '%'+@checkgroup+'%'
group by Groups.Name
end