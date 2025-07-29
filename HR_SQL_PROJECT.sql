create database HR;
use HR;

select * from HR2;
drop table HR2;

select * from HR1;

select * from newHR;

create table newHR as
select * 
from HR1
left join
HR2
on HR1.EmployeeNumber= HR2.EmployeeId;

#Q1
alter table newHR add column AttritionNo int;

update newHR set AttritionNo= case
when Attrition="Yes" then 1
else 0
end;

select * from newHR;

select Department, round(avg(AttritionNo)*100,2) as Average_Attrition_Rate, count(*) as Total_Employees, 
count(case when Attrition="Yes" then 1 end) as Employees_Left, count(case when Attrition="No" then 0 end) as Employees_Working
from newHR group by Department;

#Q2
select round(avg(HourlyRate),2), Gender, JobRole from newHR where Gender="Male" and JobRole="Research Scientist";

#Q3
alter table newHR add column MonthlyIncomeBuckets varchar (255);
set sql_safe_updates=0;
update newHR set MonthlyIncomeBuckets = case 
when MonthlyIncome<10000 then "0-10000"
when MonthlyIncome<20000 then "10000-20000"
when MonthlyIncome<30000 then "20000-30000"
when MonthlyIncome<40000 then "30000-40000"
when MonthlyIncome<50000 then "40000-50000"
else "50000+" 
end;

select round(avg(AttritionNo)*100,2), MonthlyIncomeBuckets from newHR group by MonthlyIncomeBuckets order by MonthlyIncomeBuckets;

#Q4
select Department, round(avg(TotalWorkingYears),2) from newHr group by Department;

#Q5
select JobRole, round(avg(WorkLifeBalance),2) from newHR group by JobRole;

#Q6
alter table newHR add column YearsSinceLastPromotionBuckets varchar (255);
set sql_safe_updates=0;
update newHR set YearsSinceLastPromotionBuckets = case 
when YearsSinceLastPromotion<=10 then "0-10"
when YearsSinceLastPromotion<=20 then "11-20"
when YearsSinceLastPromotion<=30 then "21-30"
when YearsSinceLastPromotion<=40 then "31-40"
else "41+" 
end;

select round(avg(AttritionNo)*100,2), YearsSinceLastPromotionBuckets from newHR group by YearsSinceLastPromotionBuckets order by YearsSinceLastPromotionBuckets;
