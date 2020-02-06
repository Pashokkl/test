
/*
������� �������������, ������� �������� ������������� - ������ �������� ('tutor') 
*/
create view tutor as
select id
FROM    users
WHERE  role = 'tutor'

/* 
1) �������� �� ��������� ������� users, ������������ �������(tutor)-id
2) �� ��������� ����� �� ������� �������� event_id
3) �� ��������� ����� �������� �����(lessons.id) �� ������� lessons, ������
������� - 'phys'
4) ��������� ��������� �� ��������� ������� - #MyTempTable
*/
select lessons.id, participants.user_id, lessons.scheduled_time
into #MyTempTable 
from tutor, participants, lessons
where tutor.id = participants.user_id and lessons.event_id = participants.event_id
and lessons.subject = 'phys'



/*
������� ������� �������������� ������ �� �������� ������� - #MyTempTable(���
� ��� ���� �����, ������� � ����) � ������� quality ��� ������ ���� �
�������
*/
select FORMAT(#MyTempTable.scheduled_time,'yyyy-dd-MM') as date, #MyTempTable.user_id as user_id , round(avg(quality.tech_quality), 2) as Srd_quality
into #MyTempTable2
from quality, #MyTempTable
where quality.lesson_id = #MyTempTable.id
group by FORMAT(#MyTempTable.scheduled_time,'yyyy-dd-MM'), #MyTempTable.user_id
order by FORMAT(#MyTempTable.scheduled_time,'yyyy-dd-MM'), #MyTempTable.user_id


/*
������� ���������� �������� ��. �������������� �� ���� �������� 
������� ���
*/
select date, user_id, min(srd_quality)
from #MyTempTable2
group by date, user_id 
order by date, user_id 




