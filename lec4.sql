------Inner Join
-- определить на каком форме курсе факультете учатся студенты
select *
from stud
join process on stud.id=process.stud_id 
join hours on process.hours_id=hours.id
join faculty on hours.faculty_id=faculty.id
join form on hours.form_id=form.id


---- так делать не надо
select *
from stud,process,hours,faculty ,form 
where stud.id=process.stud_id
and  process.hours_id=hours.id
and  hours.form_id=form.id

---- где учится Стрынгель
select *
from stud
join process on stud.id=process.stud_id and stud.last_name='Стрынгель'
join hours on process.hours_id=hours.id
join faculty on hours.faculty_id=faculty.id
join form on hours.form_id=form.id

----- посчитать количество форма на факультете

select faculty.faculty_name,count(distinct hours.form_id)
from hours 
join faculty on hours.faculty_id=faculty.id
group by faculty.faculty_name

----- выбрать информацию о студентах, средний балл которых больше
--- 6.5
select *
from stud
inner join process on stud.id=process.stud_id and stud.exm>6.5
join hours on process.hours_id=hours.id
join faculty on hours.faculty_id=faculty.id
join form on hours.form_id=form.id

-------------------------------------------
--LEFT , RIGHT Join
--вывести количество студентов на ВСЕХ (!!!!) курсе 
select hours.course, count(process.stud_id)
from hours left join process on process.hours_id=hours.id  
group by hours.course

select hours.course, count(process.stud_id)
from process right join hours  on process.hours_id=hours.id  
group by hours.course

----- посчитать кличество студнтов со средним баллом > 6 на 
---всех курсах

select hours.course, count(stud.id), count(process.stud_id)
from hours
left join process on process.hours_id=hours.id 
left join stud on process.stud_id=stud.id and stud.exm>6
group by hours.course

------вывести информацию о всех студентах и всех курсах обучения,
---при этом для студентов с оценкой больше 6 отобрзить на ком курсе
--- они обучаются
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
















 