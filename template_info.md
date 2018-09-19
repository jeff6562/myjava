# 源码自动生成模板 java-demo

### 概述

* 模板: java-demo
* 模板使用时间: 2018-09-12 11:09:22

### Docker
* Image: aegis-paas.aliyun.com
* Tag: 5000/code_template
* SHA256: 

### 用户输入参数
* repoUrl: "git@192.168.102.34:lz-test001/lz-test001.git" 
* appName: "lz-test001" 
* operator: "internal_000001" 
* appReleaseContent: "# 
* 请参考: 请参考 
* https://help.aliyun.com/document_detail/59293.html: https://help.aliyun.com/document_detail/59293.html 
* 了解更多关于release文件的编写方式: 了解更多关于release文件的编写方式 
* [NEWLINE][NEWLINE]#: [NEWLINE][NEWLINE]# 
* 构建源码语言类型[NEWLINE]code.language: oracle-jdk1.7[NEWLINE][NEWLINE]# 
* 构建打包使用的打包文件[NEWLINE]build.output: target/lz-test001.war[NEWLINE][NEWLINE]# 
* 应用部署脚本[NEWLINE]deploy.appctl.path: deploy.sh" 

### 上下文参数
* appName: lz-test001
* operator: internal_000001
* gitUrl: git@192.168.102.34:lz-test001/lz-test001.git
* branch: master


### 命令行
    sudo docker run --rm -v `pwd`:/workspace -e repoUrl="git@192.168.102.34:lz-test001/lz-test001.git" -e appName="lz-test001" -e operator="internal_000001" -e appReleaseContent="# 请参考 https://help.aliyun.com/document_detail/59293.html 了解更多关于release文件的编写方式 [NEWLINE][NEWLINE]# 构建源码语言类型[NEWLINE]code.language=oracle-jdk1.7[NEWLINE][NEWLINE]# 构建打包使用的打包文件[NEWLINE]build.output=target/lz-test001.war[NEWLINE][NEWLINE]# 应用部署脚本[NEWLINE]deploy.appctl.path=deploy.sh"  aegis-paas.aliyun.com:5000/code_template:java_1.0

