# the-campus-network-login-script
## 简介
该shell脚本意在解决宿舍夜间断电后，第二天设备上电后需手动登录校园网(含电信网等)的问题。推荐使用openwrt、merlin等Linux内核系统的路由器。

## 使用方法（大致三步）：

#### 1、获取唯一KEY

在登录界面抓包获取包含学号、登录密码的KEY。
详细方法见文件。

#### 2、编辑并测试脚本
第一步、将复制的KEY保存入一个txt文件中以供编辑。
第二步、删除最后两行和开头curl字段，如下：
```
curl
```
```
  --compressed \
  --insecure
```
最终获取的示例为：
```
'http://10.100.1.5/eportal/InterFace.do?method=login' \
  -H 'Connection: keep-alive' \
  -H 'User-Agent: ****' \
  -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' \
  -H 'Accept: */*' \
  -H 'Origin: http://10.100.1.5' \
  -H 'Referer: ********' \
  -H 'Accept-Language: ****' \
  -H 'Cookie:******' \
  --data-raw '************' \
```
第三步、根据脚本模板，在标记位置插入KEY，该脚本核心是利用curl命令上传KEY，例：
```
curl -s -X POST 'http://10.100.1.5/eportal/InterFace.do?method=login'
```

在linux环境下测试脚本
```
sh */auth.sh
```
登录成功示例：
```
START CHECKING
AUTHING
AUTH SUCCESS
```

#### 3、部署到路由器（或设备）

###### 以openwrt为例
小米路由器可通过开启ssh权限后登录路由器后台。小米路由4代前可通过官网工具开启（失去保修），4代后如ac2100、ax1800等可通过命令注入漏洞开启。
```
Connecting to 192.168.31.1:22...
Connection established.
To escape to local shell, press 'Ctrl+Alt+]'.

sh: /usr/bin/xauth: not found


BusyBox v1.25.1 (2020-09-21 11:45:55 UTC) built-in shell (ash)

 -----------------------------------------------------
       Welcome to XiaoQiang!
 -----------------------------------------------------
  $$$$$$\  $$$$$$$\  $$$$$$$$\      $$\      $$\        $$$$$$\  $$\   $$\
 $$  __$$\ $$  __$$\ $$  _____|     $$ |     $$ |      $$  __$$\ $$ | $$  |
 $$ /  $$ |$$ |  $$ |$$ |           $$ |     $$ |      $$ /  $$ |$$ |$$  /
 $$$$$$$$ |$$$$$$$  |$$$$$\         $$ |     $$ |      $$ |  $$ |$$$$$  /
 $$  __$$ |$$  __$$< $$  __|        $$ |     $$ |      $$ |  $$ |$$  $$<
 $$ |  $$ |$$ |  $$ |$$ |           $$ |     $$ |      $$ |  $$ |$$ |\$$\
 $$ |  $$ |$$ |  $$ |$$$$$$$$\       $$$$$$$$$  |       $$$$$$  |$$ | \$$\
 \__|  \__|\__|  \__|\________|      \_________/        \______/ \__|  \__|


root@XiaoQiang:~# cd /etc/init.d

```
第一步、使用winSCP将auth.sh和auth两个文件传入该目录
第二部、使用putty或xshell工具登录，并执行
```
/etc/init.d/auth enable
```

**完成后下线，并重启路由器检查是否自动联网**

###### merlin

1、把auth.sh放入/jffs/scripts目录下，并在第二行添加
```
sleep 5
```
2、在/jffs/scripts/wan-start文件中添加
```
/jffs/scripts/auth.sh start
```


