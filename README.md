# 基于 **纯真网络(qqwry)** 的 ip 地理查询

## 简介

这是一个基于 qqwry 的 ip 地理查询模块, 采取统一的 http 协议, 返回对应的 ip 信息.
传统的走线上接口,当遇到大量数据需要查询的时候, 接口调用次数就成了瓶颈. 使用自建的服务就可以规避这一风险.
同时, 由于 qqwry 本身数据的不规范性, 导致在获取地理坐标的时候, 由于存在大量类似于
> 湖北省武汉市
> 湖北洪湖市
> 宁夏银川市

所以本服务对省级别命名进行规范,统一成了 "湖北省", "宁夏回族自治区" 等标准称呼.

## 意义

* 本地化查询, 速度快, 无接口访问频率限制
* 规范国内地址
* 微服务化应用, 脱离语言要求
* 更新 ip 库非常简单

## 性能

默认本机查询 4.3 ms / request, 默认使用 puma 的基本配置, 可映射修改 puma.conf 来进行针对本机的性能调优. 

```
Server Software:
Server Hostname:        localhost
Server Port:            3111

Document Path:          /?ip=101.25.25.1
Document Length:        100 bytes

Concurrency Level:      1
Time taken for tests:   4.301 seconds
Complete requests:      1000
Failed requests:        0
Total transferred:      205000 bytes
HTML transferred:       100000 bytes
Requests per second:    232.52 [#/sec] (mean)
Time per request:       4.301 [ms] (mean)
Time per request:       4.301 [ms] (mean, across all concurrent requests)
Transfer rate:          46.55 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.0      0       0
Processing:     3    4   0.8      4       8
Waiting:        2    4   0.8      4       8
Total:          3    4   0.8      4       9
```

## 安装

### 基于 `ruby` 下的安装

- pre: ruby 2.3.0 +
- git clone 
- bundle install
- puma -e production   (或者 -p 3000 端口号3000,  默认 9292)

### 基于 `docker`

```
docker run --rm  -d -p 3000:9292  atpking/tools_ip_convert
```

## ip 库

元数据 https://github.com/xiaosuo/qqwry, 它采集自 http://www.cz88.net

### 更新 ip 库

- 直接替换 qqwry.dat 文件  适用于直接启动
- docker -v 挂载qqwry.dat 到 /home 目录


## 使用方法

get 请求 对应的根目录, 传参 ip 

如 

```
curl http://localhost:9292?ip=8.8.8.8
```

返回对应的json

```

{"answer":true,"main_location":"美国","location_raw":"美国","markup":"加利福尼亚州圣克拉拉县山景市谷歌公司DNS服务器"}

```

json 的含义如下所所示

|key | 意义 | 备注 |
|---|---|---|
| answer | 是否正确返回 | true or false, 查询失败时(ip 格式,或者没查到信息) 返回false |
| main_location | 返回主要地区 | 国内为省级, 国外则返回 qqwry的原始数据
|location_raw| 地点的原始值 | qqwry 的原始值 
| markup | 具体备注 | | 




