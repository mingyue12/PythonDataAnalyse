/*
SQL语句介绍：
    概述：
        全程叫Structured Query Language,结构化查询语言，主要是实现用户与数据库交互
    分类：
        DDL：数据定义语言
            实际关键字：creat，drop,alter,alert(),show
        DML：数据操作语言
            涉及关键词：insert，delete，update
        DQL：数据查询语言
            涉及关键字：select，from，where
        DCL：数据控制语言
    通用语法：
        1.可以写一行，也可以写多行。
        2.SQL语句不区分大小写，为了方便阅读，建议关键字大写，其余小写。
        3.注释写法 /星 星/多行注释
                    # 单行注释
                    -- 单行注释

数据类型：
    概述：
        就是用来限定某列值的范围的，必须是：整数，小数，字符串，日期等...
    常用的数据类型：
        整型：      int, smallint, mediumint, bigint
        浮点型：    double, float, decimal(精度,小数位数)
        日期型：    datetime
        时间型：    time
        字符串型：   varchar(长度),char(长度)


约束：
        就是用来限定某列值的范围的，必须是：整数，小数，字符串，日期等...
    常用的约束：
        not null：不能为空
        unique：唯一
        primary key：主键
        foreign key：外键
        check：检查
        default：默认值
        comment：注释
    概述：
        在数据类型的基础上，进一步对该值做限定。
    例如常用分类：
        单表约束：
            primary key：主键约束，特点：不能为空，唯一，不能重复
            not null：   非空约束，即该列值不能为空，但是可以重复
            unique：     唯一约束，即该列值必须是唯一的，不能重复
            default：    默认值约束，即该列值默认值为指定值，不指定时，为null
        多表约束：
            foreign key：外键约束，特点：不能为空，必须是其他表的主键值



*/

# 1.查看本机安装的所有数据库
show DATABASES;
SELECT database();

# ----------------------------------------案例一：DDL语句操作数据库----------------------------------- #
# 1.查看已创建的所有数据库
show DATABASES;

# 2.创建数据库
create DATABASE day01;                      # 以utf-8默认码表创建数据库
create DATABASE day02 character SET 'gbk';  # 以Gbk码表，创建数据库
create DATABASE day01;                      # 会报错，因为day01数据库已存在了
CREATE DATABASE if not exists day01;        # 如果day01数据库不存在，才创建

#  完整建库格式
create DATABASE if not EXISTS day03 charset 'utf-8';      # 以utf-8码表创建数据库

# 3.修改数据库 -> 码表
alter database day02 CHARSET 'utf8';

# 4.删除数据库
drop DATABASE day01;

# 5.查看当前是哪个数据库
SELECT database();

# 6.切换数据库
use day01;

# 7.查看某个已安装的数据库的码表
show create DATABASE day01; # 默认utf-8码表
show create DATABASE day02; # 使用utf-8码表创建


# ----------------------------------------案例二：DDL语句操作数据表（table）----------------------------------- #
# 1.切库
use day01;

# 2.查看（当前数据库中）所有的数据表
show TABLES;

# 3.创建数据表，学生表：student，字段为：sid， 学生id, name,学生姓名，age，学生年龄
/*
格式：
    create table [if not exists] student(
        字段名 数据类型 [约束]，
        字段名 数据类型 [约束]，
        字段名 数据类型 [约束]
    );
 */

Create table if not exists student(
    sid int,            # 学生学号
    name varchar(20),   # 学生姓名
    age int             # 学生年龄
);

# 4.修改数据表名称 student -> stu
# 格式： rename table student to stu
rename table student to stu;

# 5.删除数据表
# 格式： drop table stu;
drop table if exists stu;


# 6.查看表结构
# 格式：desc 数据表名称
DESC stu;



# ----------------------------------------案例三：DDL语句操作数据表（table）----------------------------------- #
# 1.切库
use day01;
show tables;

# 2.查看表结构
desc stu;

# 3.给stu表添加字段address varchar(20)
# 格式：alter table 数据表名称 add 字段名 数据类型 [约束];
alter table stu add address varchar(20) NOT NULL COMMENT '学生地址';


# 4.修改字段，
# 场景1：只修改数据类型和约束
# 格式：alter table 数据表名称 modify 旧列名 新的数据类型 [新的约束];
alter table stu modify address INT ;

# 场景2：修改数据类型，约束，字段名
# 格式：alter table 数据表名称 change 旧列名 新列名 数据类型 [新的约束];
alter table stu change address addr VARCHAR(10) NOT NULL COMMENT '学生地址';

# 5.删除字段
# 格式：alter table 数据表名称 drop 字段名;
alter table stu drop addr;


