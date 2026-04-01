# -------------------- 案例1: 多表建表之一对多（理解） --------------------#
# 需求：新建部门表（dept，department）、员工表（emp，employee））, 员工表和部门表之间是一对多的关系
# 请用外键约束完成限定
# 细节：实际开发中，外键约束相对用的少一点，而是通过代码层面，对表数据进行限定
# 记忆：多表关系中，有外键列的表->从表，无外键列的表->主表,外表的外键列不能出现主表主键列没有的值
# 回顾：一对多建表原则，在多的一方新建1列，外键列，去关联一的一方的主键列
# 格式：constraint 约束名 foreign key (外键列) references 主表(主键列)
# 1.切库，查表
use day02;
show tables;

# 2.创建主表->部门表
create table dept(
    id int primary key auto_increment,  # 部门id
    name varchar(10)                    # 部门名称
);

# 3.创建从表->员工表
CREATE TABLE emp(
    id int primary key auto_increment,  # 员工id
    name varchar(10),                    # 员工名称
    salary DOUBLE,                         # 员工工资
    dept_id int,                         # 部门id，外键列
    CONSTRAINT fk_dept_id foreign key (dept_id) references dept(id)
);
drop table emp;
# 4.给部门表中添加数据
insert into dept values(null, '人事部');
insert into dept values(null, '财务部');
insert into dept values(null, '研发部');
insert into dept values(null, '行政部');
DELETE FROM dept WHERE id >= 5;

# 5.给员工表中添加数据
INSERT into emp VALUES (null, '胡歌', 33333, 1);
INSERT into emp VALUES (null, '刘亦菲', 22222, 2);
INSERT into emp VALUES (null, '迪丽热巴', 11111, 2);
INSERT into emp VALUES (null, '水冷哥', 11.1, 3);
SELECT * FROM emp;





# 6.查看表数据
SELECT *
FROM dept;

# 7.删除外键约束
# alter table 表名 drop foreign key 约束名;
alter table emp drop foreign key fk_dept_id;

# 8.建表后添加外键约束
# 表数据必须是合法的
alter table emp add constraint fk_dept_id foreign key (dept_id) references dept(id);

#------------------------案例2: 多表查询-准备数据------------------------#
# 1. 创建hero表
create table hero(
                     hid int primary key auto_increment, # 英雄id
                     hname varchar(255), # 英雄名
                     kongfu_id int # 功夫id
);

# 2. 创建kongfu表
create table kongfu(
                       kid int primary key auto_increment, # 功夫id
                       kname varchar(255) # 功夫名
);

# 3. 添加表数据.
# 插入hero数据
insert into hero values(1,'鸠摩智',9),(3,'乔峰',1),(4,'虚竹',4),(5,'段誉',12);
# 插入kongfu数据
insert into kongfu values(1,'降龙十八掌'),(2,'乾坤大挪移'),(3,'猴子偷桃'),(4,'天山折梅手');

# 4. 查看表数据.
select * from hero;
select * from kongfu;

#------------------------案例3: 多表查询-交叉连接（cross join）------------------------#
# 格式1：select 列名 from 表1 cross join 表2;
# 格式2：select 列名 from 表1, 表2;
# 查询结果等于两张表的笛卡尔积，即所有可能的组合。例如，表1有m行，表2有n行，则查询结果有m*n行。
# 实际开发一般不用
select * from hero, kongfu;
select * from hero cross join kongfu;
SELECT * FROM hero, kongfu;

# 格式1显示链接：select 列名 from 表1 inner join 表2 on 表1.列名=表2.列名;
select * from hero inner join kongfu on hero.kongfu_id=kongfu.kid; # 查询结果等于两张表的笛卡尔积，即所有可能的组合。例如，表1有m行，表2有n行，则查询结果有m*n行。
# 格式2隐式链接（推荐）：select 列名 from 表1, 表2 where 表1.列名=表2.列名;
SELECT * FROM hero, kongfu WHERE hero.kongfu_id = kongfu.kid;

#------------------------案例5: 多表查询-外连接（outer join）------------------------#
# 场景1：左外链接，查询结果等于左表所有数据，以及右表中满足条件的数据（交集）
# 格式：select 列名 from 表1 left outer join 表2 on 表1.列名=表2.列名;
SELECT  * from hero as h left outer join kongfu as k on h.kongfu_id = k.kid;

# 场景2：右外链接，查询结果等于右表所有数据，以及左表中满足条件的数据（交集）
# 格式：select 列名 from 表1 right outer join 表2 on 表1.列名=表2.列名;
SELECT * from hero as h right outer join kongfu as k on h.kongfu_id = k.kid;

# 场景3：全外链接，查询结果等于左表所有数据，以及右表中满足条件的数据（交集），同时包含右表所有数据，以及左表中满足条件的数据（交集）
# 格式：select 列名 from 表1 full outer join 表2 on 表1.列名=表2.列名;
# 但是MySQL不支持full outer join，可以使用union实现
# 原理：full outer join等于left outer join和right outer join的并集
SELECT * from hero as h left outer join kongfu as k on h.kongfu_id = k.kid
UNION DISTINCT  # 合并并去重，union all合并不去重
SELECT * from hero as h right outer join kongfu as k on h.kongfu_id = k.kid;

#------------------------案例6: 多表查询-子查询（subquery）------------------------#
/*
 概述：
    子查询：就是在某个SQL语句中嵌套另一个SQL语句，被嵌套的SQL语句称为子查询，也称为内层查询或内部查询，外层查询调用内层查询的结果。
 写法：
    1. 子查询可以作为查询条件，也可以作为查询结果。
    2. 子查询可以作为插入、更新、删除的值。
    3. 子查询可以作为表名、列名。
 */

# 需求：查询价格最高的商品信息，只要商品名，价格，分类id即可。
SELECT * from product;
select pname, price, category_id from product WHERE price = (select max(price) from product);
# 实际开发写法，连接查询
SELECT
    *
FROM
    product
JOIN
    (select max(price) as price from product) t1
ON
    product.price = t1.price;

# case when语法
# c001 -> 电脑，c002 -> 服装，c003 -> 化妆品，c004 -> 零食，c005->饮料，null -> 未知
SELECT * from product;

/*
    case when语法：
    格式1：通用写法，
        case
            when 条件1 then 结果1
            when 条件2 then 结果2
            ...
            else 结果n
        end [as 别名]
    格式2：针对于格式1的语法糖要满足两点 -》 1.都是操作同一个字段 2.都是等于判断
        case 字段
            when 值1 then 结果1
            when 值2 then 结果2
            ...
            else 结果n
        end [as 别名]
 */

SELECT
    *,
    case
        when category_id = 'c001' then '电脑'
        when category_id = 'c002' then '服装'
        when category_id = 'c003' then '化妆品'
        when category_id = 'c004' then '零食'
        when category_id = 'c005' then '饮料'
        else '未知'
    END as categrory_name
from product;

# 上述格式可以简化为
SELECT
    *,
    case category_id
        when 'c001' then '电脑'
        when 'c002' then '服装'
        when 'c003' then '化妆品'
        when 'c004' then '零食'
        when 'c005' then '饮料'
        else '未知'
    END as categrory_name
from product;






