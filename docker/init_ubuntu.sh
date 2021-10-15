set -x
set -e

# 软件源
perl -pi.bak -e "s/archive\.ubuntu\.com/mirrors.aliyun.com/g" /etc/apt/sources.list
apt update
apt upgrade -y

# my_env
printf '%s\n' \
'# ---- my_env -----------------------------------------' \
'if [ -f /etc/profile.d/my_env.sh ]; then' \
'   . /etc/profile.d/my_env.sh' \
'fi' \
>> /etc/bash.bashrc

printf '%s\n' \
'if [ ${B1F89D1E_E51F_4BA3_8382_A3749DEE2E4A} ] ; then' \
'    return 0' \
'fi' \
'export B1F89D1E_E51F_4BA3_8382_A3749DEE2E4A=1' \
'' \
> /etc/profile.d/my_env.sh

# 时区
printf '%d\n' 6 70 > /tmp/a.txt
apt install -y tzdata < /tmp/a.txt
rm -rf /tmp/a.txt

# 基本工具
apt install -y bash-completion less file zip unzip vim ttf-bitstream-vera bc

# 开发工具
apt install -y autoconf automake make libtool pkg-config gcc g++ gdbserver nasm ninja-build diffutils patchelf
apt install -y clang lld lldb llvm-dev libomp-dev clang-format clang-tidy 
ln -s `which lld` /usr/local/bin/ld

# 远程工具
apt install -y net-tools openssh-server openssh-sftp-server
perl -pi -e 's/#(PermitRootLogin).*/$1 yes/g' /etc/ssh/sshd_config
/etc/init.d/ssh start #启动一次，自动准备好运行环境

# python
apt install -y python3 python3-dev python3-pip
mkdir -p ~/.pip
printf '%s\n' \
'[global]' \
'index-url=https://mirrors.aliyun.com/pypi/simple/' \
> ~/.pip/pip.conf
pip3 install -U setuptools wheel
pip3 install -U numpy aiohttp uvloop aiomysql colorama

# ---- 运维配置 --------------------------------------------------------
# 必须放最后，避免apt安装时遇到配置冲突问题

printf '%s\n' \
'fs.file-max=524288' \
'fs.inotify.max_user_watches=524288' \
>> /etc/sysctl.conf
# sysctl -p

perl -pi -e 's/.*(DefaultLimitNOFILE).*/$1=524288/g' /etc/systemd/user.conf
perl -pi -e 's/.*(DefaultLimitNOFILE).*/$1=524288/g' /etc/systemd/system.conf

printf '%s\n' \
'* soft nofile 524288' \
'* hard nofile 524288' \
>> /etc/security/limits.conf

# bash常用设置
printf '%s\n' \
'' \
'if ! shopt -oq posix; then' \
'    if [ -f /usr/share/bash-completion/bash_completion ]; then' \
'        . /usr/share/bash-completion/bash_completion' \
'    elif [ -f /etc/bash_completion ]; then' \
'        . /etc/bash_completion' \
'    fi' \
'fi' \
'' \
'# enable color support of ls and also add handy aliases' \
'if [ -x /usr/bin/dircolors ]; then' \
'    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"' \
'    alias ls="ls --color=auto"' \
'    alias dir="dir --color=auto"' \
'    alias vdir="vdir --color=auto"' \
'' \
'    alias grep="grep --color=auto"' \
'    alias fgrep="fgrep --color=auto"' \
'    alias egrep="egrep --color=auto"' \
'fi' \
'' \
'# colored GCC warnings and errors' \
'export GCC_COLORS="error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"' \
'' \
'# some more ls aliases' \
'alias ll="ls -l"' \
'alias la="ls -A"' \
'alias l="ls -CF"' \
'' \
'if [ -z "${B1F89D1E_E51F_4BA3_8382_A3749DEE2E4A}" ] ; then' \
'    export B1F89D1E_E51F_4BA3_8382_A3749DEE2E4A=1' \
'    # 只执行一次的命令' \
'    ' \
'fi' \
>> /etc/bash.bashrc
