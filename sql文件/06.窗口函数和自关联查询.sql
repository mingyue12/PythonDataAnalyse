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
 */















