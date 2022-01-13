#part1 分词
例子
abc
acd
正排索引：
1.传统b+树，对完整内容按字典序排序，速度n->logn
abc index1
acd index2
倒排索引：
1.分词
a b c index1
a c d index2
2.建立字典map
a
b
c
d
3.建立倒排链
a index1 index2
b index1
c index1 index2
d index2
例如搜索a，得到index1，index2，去获取正排索引的值。本质上是讲文件id到关键字的映射转换为关键字到文件id的映射