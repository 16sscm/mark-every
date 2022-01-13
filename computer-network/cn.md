mac:media access control address，媒体存取控制地址
nic：network interface card，网卡，网络适配器
arp缓存表：address resulution protocol，地址解析协议
路由寻址步骤
1.本机ip子网掩码与运算与目标主机ip与本机子网掩码与运算，判断是否在同一个网络
2.查路由表，查看是否存在目标主机的条目entry，不存在走默认网关。
3.arp
