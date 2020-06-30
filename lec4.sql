------Inner Join
-- ���������� �� ����� ����� ����� ���������� ������ ��������
select *
from stud
join process on stud.id=process.stud_id 
join hours on process.hours_id=hours.id
join faculty on hours.faculty_id=faculty.id
join form on hours.form_id=form.id


---- ��� ������ �� ����
select *
from stud,process,hours,faculty ,form 
where stud.id=process.stud_id
and  process.hours_id=hours.id
and  hours.form_id=form.id

---- ��� ������ ���������
select *
from stud
join process on stud.id=process.stud_id and stud.last_name='���������'
join hours on process.hours_id=hours.id
join faculty on hours.faculty_id=faculty.id
join form on hours.form_id=form.id

----- ��������� ���������� ����� �� ����������

select faculty.faculty_name,count(distinct hours.form_id)
from hours 
join faculty on hours.faculty_id=faculty.id
group by faculty.faculty_name

----- ������� ���������� � ���������, ������� ���� ������� ������
--- 6.5
select *
from stud
inner join process on stud.id=process.stud_id and stud.exm>6.5
join hours on process.hours_id=hours.id
join faculty on hours.faculty_id=faculty.id
join form on hours.form_id=form.id

-------------------------------------------
--LEFT , RIGHT Join
--������� ���������� ��������� �� ���� (!!!!) ����� 
select hours.course, count(process.stud_id)
from hours left join process on process.hours_id=hours.id  
group by hours.course

select hours.course, count(process.stud_id)
from process right join hours  on process.hours_id=hours.id  
group by hours.course

----- ��������� ��������� �������� �� ������� ������ > 6 �� 
---���� ������

select hours.course, count(stud.id), count(process.stud_id)
from hours
left join process on process.hours_id=hours.id 
left join stud on process.stud_id=stud.id and stud.exm>6
group by hours.course

------������� ���������� � ���� ��������� � ���� ������ ��������,
---��� ���� ��� ��������� � ������� ������ 6 ��������� �� ��� �����
--- ��� ���������
select distinct  hours.course, stud.last_name, stud.exm
from hours
full join process on process.hours_id=hours.id 
full join stud on process.stud_id=stud.id and stud.exm>6
----
--CROSS JOIN

select *
from stud
cross join process
cross join hours
cross join faculty
cross join form 
















 