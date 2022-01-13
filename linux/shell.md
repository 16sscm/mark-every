$0：输入的命令名
PATH=$(cd `dirname $0`;pwd)
解读 ：$0实际上代表脚本在shell执行的命令名，shell会启动一个子shell，$0其实就是相对路径--父shell从工作目录去找脚本的路径，dirname表示去掉最后一个/和后面的文件名，也就是相对路径的目录，子shellcd到这个目录后，执行pwd，获取脚本所在的绝对路径，保存到变量中，这就保证部署到任何地方都能获取到脚本的绝对路径。分号代表两个命令都执行（另外，&&代表前一个成功执行后一个，||代表前一个失败执行后一个），然后外面再加一层$()（和反引号``一样），表示子命令扩展，意思是获取执行的结果，也就是pwd的输出。

chmod
u      g  o=a(all)
用户 组 其他
421
r   w  x
读 写 执行

Shebang行，指定shell
可移植性:
#!/usr/bin/env
指定：
#!/bin/bash
#!/bin/sh

source命令用于执行一个脚本，通常用于重新加载一个配置文件。
source命令最大的特点是在当前 Shell 执行脚本，不像直接执行脚本时，会新建一个子 Shell。所以，source命令执行脚本时，不需要export变量。
当然source也可以用来加载外部库

[root@centos8 ~]#echo "echo $HOSTNAME"
echo centos8.localdomain
[root@centos8 ~]#echo 'echo $HOSTNAME'
echo $HOSTNAME
[root@centos8 ~]#echo `echo $HOSTNAME`
centos8.localdomain
结论：
单引号：六亲不认，变量和命令都不识别，都当成了普通的字符串 最傻
反向单引号：变量和命令都识别，并且会将反向单引号的内容当成命令进行执行后，再交给调用反向单引号的命令继续 最聪明
双引号：不能识别命令，可以识别变量 介于两者之间