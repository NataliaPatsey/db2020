use UNIVER2
--- ����������
--- �������� ������� ���������� ���� ��������
--
----��� ������ ����� ��� �������
select stud.last_name, stud.exm from stud where
stud.exm> (select stud.exm from stud where last_name='�������')

----- ��� ������ �� ����� ���������� � ���������
select stud.last_name, hours.faculty_id
from stud
join process on stud.id=process.stud_id and last_name<>'�������'
join hours on hours.id=process.hours_id and hours.faculty_id=
			(select hours.faculty_id
			from stud
			join process on stud.id=process.stud_id and stud.last_name='�������'
			join hours on hours.id=process.hours_id
			)

--- ����� ����������� �������� � ��������
select last_name, hours.course 
from stud 
join process on stud.id=process.stud_id
join hours on process.hours_id=hours.id and hours.course in  
							(select hours.course 
							from hours
							join process on hours.id=process.hours_id
							join stud on process.stud_id=stud.id and last_name in ('�������' , '�������')
							)

--- ����� ��������� ������� ������ ���� ��� ������� ��� �������
select last_name, exm from stud 
where exm < some( select exm from stud where last_name in ('�������','�������'))

--- ����� ��������� ������� ������ ���� ��� ������� � �������
select last_name, exm from stud 
where exm < all ( select exm from stud where last_name in ('�������','�������'))


--����� ��������� ������� ������ �� ����� ��������� � ���������, �� 
--����� ��� ��

select stud.last_name, stud.exm, hours.faculty_id
from stud
join process on stud.id=process.stud_id
join hours on hours.id=process.hours_id 
join (select exm,  hours.faculty_id
	from stud
	join process on stud.id = process.stud_id and stud.last_name='���������'
	join hours on process.hours_id = hours.id) tmp 
					on stud.exm> tmp.exm and hours.faculty_id=tmp.faculty_id

------
--- ����� ��������� ������� ������ ���� �������� �� �� ����������
select stud.last_name, stud.exm, hours.faculty_id
from stud
join  process on stud.id=process.stud_id
join hours on process.hours_id=hours.id
join (Select hours.faculty_id, avg(stud.exm) as avg_exm
	from stud
	join process on stud.id=process.stud_id
	join hours on process.hours_id=hours.id
	group by hours.faculty_id) tmp
			on tmp.faculty_id=hours.faculty_id
				and tmp.avg_exm<stud.exm

-----------------
--min/max �� ����� ������� ��������� ������ ����� �������
-- � 2015
select faculty.faculty_name, count(*)
from stud
join process on stud.id=process.stud_id and year(in_date) = 2015
join hours on process.hours_id=hours.id
join faculty on faculty.id=hours.faculty_id
group by faculty.faculty_name

--- � ������� TOP �������
select top 1 faculty.faculty_name, count(*)
from stud
join process on stud.id=process.stud_id and year(in_date) = 2015
join hours on process.hours_id=hours.id
join faculty on faculty.id=hours.faculty_id
group by faculty.faculty_name
order by count(*) desc
update stud set in_date ='20140901' where id =16
select top 1 with ties  faculty.faculty_name, count(*)
from stud
join process on stud.id=process.stud_id and year(in_date) = 2015
join hours on process.hours_id=hours.id
join faculty on faculty.id=hours.faculty_id
group by faculty.faculty_name
order by count(*) desc

select top 3 with ties * from stud
order by exm desc

---- ��������� (��� ����������)
select t1.faculty_name, t1.stud_2015 from
(select faculty.faculty_name, count(stud.id) as  stud_2015
from stud
join process on stud.id=process.stud_id and year(in_date) = 2015
join hours on process.hours_id=hours.id
join faculty on faculty.id=hours.faculty_id
group by faculty.faculty_name
) t1 where  t1.stud_2015=(select max(stud_2015) 
                       from 
						(select faculty.faculty_name, count(*) stud_2015
						from stud
						join process on stud.id=process.stud_id and year(in_date) = 2015
						join hours on process.hours_id=hours.id
						join faculty on faculty.id=hours.faculty_id
						group by faculty.faculty_name
						) tmp)
 











