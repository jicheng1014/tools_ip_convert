# 基于 *纯真网络(qqwry)* 的 ip 地理查询

## 简介

这是一个基于 qqwry 的 ip 地理查询模块, 采取统一的 http 协议, 返回对应的 ip 信息.

## 意义

* 本地化查询, 速度快
* 规范国内地址
* 微服务化应用, 脱离语言要求
* 更新 ip 库非常简单

## 安装

### 基于 `ruby` 下的安装

- pre: ruby 2.3.0 +
- git clone 
- bundle install
- puma -e production

### 基于 `docker`

``

## ip 库

元数据 https://github.com/xiaosuo/qqwry, 它采集自 http://www.cz88.net

## 使用方法

get 请求 对应的根目录, 传参 ip 如 

`curl http://localhost:4567?ip=8.8.8.8`

返回对应的json

```

{"answer":true,"main_location":"美国","location_raw":"美国","markup":"加利福尼亚州圣克拉拉县山景市谷歌公司DNS服务器"}

```

json 的含义如下所所示

|key | 意义 | 备注 |
|---|---|---|
| answer | 是否正确返回 | true or false, 查询失败时(ip 格式,或者没查到信息) 返回false |
| main_location | 返回主要地区 | 国内为省级, 国外则返回 qqwry的原始数据



