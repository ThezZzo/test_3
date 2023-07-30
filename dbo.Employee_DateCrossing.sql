use testing
;with table_cte (
	ID_Employee_1
	,v1_DateBegin
	,v1_DateEnd
	,ID_Employee_2
	,v2_DateBegin
	,v2_DateEnd
) as ( 
		select 
			(select Code from dbo.Employee as e where e.ID = v1.ID_Employee)
			,v1.DateBegin
			,v1.DateEnd
			,(select Code from dbo.Employee as e where e.ID = v2.ID_Employee)
			,v2.DateBegin	
			,v2.DateEnd
		from (
			dbo.Vacation as v1 inner join dbo.Vacation as v2 on v1.ID_Employee < v2.ID_Employee
				and (v1.DateBegin <= v2.DateEnd) 
				and (v1.DateEnd >= v2.DateBegin)
		) 
		where v1.ID_Employee IN (
			select ID_Employee 
			from dbo.Vacation 
			where DateEnd BETWEEN cast('2020-01-01' as date) 
				and cast('2020-12-31' as date)
		)
)

select 
	ID_Employee_1 as КодСотрудника1
	,v1_DateBegin as НачалоОтпуска
	,v1_DateEnd as КонецОтпуска
	,ID_Employee_2 as КодСотрудника2
	,v2_DateBegin as НачалоОтпуска
	,v2_DateEnd as КонецОтпуска
	
from table_cte 
