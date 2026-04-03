# ------------------- 案例1：窗口函数（window function）
/*
 窗口函数解释：
    概述：
        它是MySQL8.0版本新增的函数，用于对数据进行窗口操作。
    格式：
        窗口函数 over([partition by 分组字段] order by 排序字段 [asc|desc] rows between 起始行 and 结束行)
    常用的窗口函数：
        row_number()：行号
        rank()：排名
        dense_rank()：密集排名
    解释：
        row_number()：   1 2 3 4
        rank()：         1 2 2 4
        dense_rank()：   1 2 2 3
    说明：
        1.窗口函数 = 给表新增一列，至于新增的是什么，取决于和什么函数一起使用
        2.如果不写partition by，则默认对所有数据进行分组，如果写了，则对分组后的数据进行操作
        3.rows between 起始行 and 结束行：用于指定窗口的范围，即指定行的起始行和结束行
        4.如果不写order by，则默认对所有数据进行排序，如果写了，则对分组后的数据进行排序
        5.over()还可以结合partition by和order by一起使用，还有count()、sum()、avg()、max()、min()、ntile()、lag()、lead(),first_value()、last_value()、nth_value()、cume_dist()、percent_rank()、last_value()等聚合函数
    总结：关于窗口函数
        1.分组排名
        2.分组排名求TopN
 */
# 准备数据
create database day03;
use day03;
SHOW TABLES;

# 建表，插入数据
create table employee (empid int,ename varchar(20),dept_id int,salary decimal(10,2));
TRUNCATE TABLE employee;
insert into employee values(1,'刘备',10,5500.00);
insert into employee values(2,'赵云',10,4500.00);
insert into employee values(2,'张飞',10,3500.00);
insert into employee values(2,'关羽',10,4500.00);

insert into employee values(3,'曹操',20,1900.00);
insert into employee values(4,'许褚',20,4800.00);
insert into employee values(5,'张辽',20,6500.00);
insert into employee values(6,'徐晃',20,14500.00);

insert into employee values(7,'孙权',30,44500.00);
insert into employee values(8,'周瑜',30,6500.00);
insert into employee values(9,'陆逊',30,7500.00);


# 查看数据
select * from employee;

# 案例一：分组排名
# 需求：按照部门id分组，按照工资（salary）进行排名，降序。
# 场景一：如何给表新增一列
SELECT *, dept_id + 100 from employee;

# 场景二：如何使用窗口函数
SELECT
    *,
    # sum(salary) over(partition by dept_id) as total_sum
    sum(salary) over(partition by dept_id order by salary desc) as total_sum
FROM employee;

# 场景三，分组排名：按照部门id分组，按照工资（salary）进行排名，降序。
select *,
       rank() over(PARTITION BY dept_id ORDER BY salary DESC ) as row_num,
       dense_rank() over(PARTITION BY dept_id ORDER BY salary DESC ) as dense_row_num
FROM employee;

# 场景4：分组排名求TopN，需求找出每组工资最高的2人的信息(考虑并列)
select *,
       rank() over(PARTITION BY dept_id ORDER BY salary DESC ) as row_num
FROM employee
WHERE row_num <= 2;

# 解决方案1：使用子查询

SELECT *
FROM (
         select *,
                rank() over(PARTITION BY dept_id ORDER BY salary DESC ) as row_num
         FROM employee
     ) as t1
where row_num <= 2;

# CTE公共表表达式
with t1 as (
         select *,
                rank() over(PARTITION BY dept_id ORDER BY salary DESC ) as row_num
         FROM employee
     )
select *
from t1
where row_num <= 2;



