#!/bin/bash
cd openwrt
rm -rf package/lean/luci-theme-argon  #删除源码自带的argon主题，因为最下面一个链接是增加了其他作者制作的argon主题
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# 说明：
# 除了第一行的#!/bin/bash不要动，其他的设置，前面带#表示不起作用，不带的表示起作用了（根据你自己需要打开或者关闭）
#

# 修改openwrt登陆地址,把下面的192.168.2.2修改成你想要的就可以了，其他的不要动
sed -i 's/192.168.1.1/192.168.2.2/g' package/base-files/files/bin/config_generate


sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' package/lean/default-settings/files/zzz-default-settings  #设置密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）


#内核版本是会随着源码更新而改变的，在coolsnowwolf/lede的源码查看最好，以X86机型为例，源码的target/linux/x86文件夹可以看到有几个内核版本，x86文件夹里Makefile就可以查看源码正在使用什么内核
#修改版本内核（下面两行代码前面有#为源码默认最新5.4内核,没#为4.19内核,默认修改X86的，其他机型L大源码那里target/linux查看，对应修改下面的路径就好）
#sed -i 's/KERNEL_PATCHVER:=5.4/KERNEL_PATCHVER:=4.19/g' ./target/linux/x86/Makefile  #修改内核版本
#sed -i 's/KERNEL_TESTING_PATCHVER:=5.4/KERNEL_TESTING_PATCHVER:=4.19/g' ./target/linux/x86/Makefile  #修改内核版本


#取消掉feeds.conf.default文件里面的helloworld的#注释
sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default  #使用源码自带ShadowSocksR Plus+出国软件

#添加r2s oled插件，和luci-app-beardropper防火墙自定义限速规则插件 
echo "src-git natelol https://github.com/natelol/natelol.git" >> feeds.conf.default

#添加自定义插件链接（自己想要什么就github里面搜索然后添加）
#git clone https://github.com/kenzok8/openwrt-packages opks
#mv opks/* package/
#rm -rf opks/
git clone -b 18.06 https://github.com/garypang13/luci-theme-edge package/luci-theme-edge  #主题-edge-动态登陆界面
git clone https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom package/luci-theme-infinityfreedom  #透明主题
git clone -b master https://github.com/vernesong/OpenClash.git package/luci-app-openclash  #openclash出国软件
git clone https://github.com/frainzy1477/luci-app-clash package/luci-app-clash  #clash出国软件
git clone https://github.com/tty228/luci-app-serverchan package/luci-app-serverchan  #微信推送
git clone -b lede https://github.com/pymumu/luci-app-smartdns.git package/luci-app-smartdns  #smartdns DNS加速
#git clone https://github.com/garypang13/luci-app-eqos package/luci-app-eqos  #内网IP限速工具
git clone https://github.com/yangsongli/luci-theme-atmaterial.git package/luci-theme-atmaterial #atmaterial主题
#luci-app-compressed-memory 
git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter #应用过滤/家长控制

#passwall出国软件
git clone https://github.com/xiaorouji/openwrt-passwall package/luci-app-passwall


#Hello World
git clone https://github.com/jerrykuku/lua-maxminddb.git  package/lua-maxminddb #git lua-maxminddb 依赖
git clone https://github.com/jerrykuku/luci-app-vssr.git  package/luci-app-vssr

#xray
git clone https://github.com/yichya/luci-app-xray package/luci-app-xray

git clone https://github.com/jerrykuku/node-request.git package/node-request  #京东签到依赖
git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git package/luci-app-jd-dailybonus  #luci-app-jd-dailybonus[京东签到]


git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon  #argon-主题
#全新的[argon-主题]登录界面,图片背景跟随Bing.com，每天自动切换
#增加可自定义登录背景功能，请自行将文件上传到/www/luci-static/argon/background 目录下，支持jpg png gif格式图片，主题将会优先显示自定义背景，多个背景为随机显示，系统默认依然为从bing获取
#增加了可以强制锁定暗色模式的功能，如果需要，请登录ssh 输入：touch /etc/dark 即可开启，关闭请输入：rm -rf /etc/dark，关闭后颜色模式为跟随系统
