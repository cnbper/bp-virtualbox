# Harbor镜像仓库安装

Harbor是一个用于存储和分发Docker镜像的企业级Registry服务器，通过添加一些企业必需的功能特性，例如安全、标识和管理等，扩展了开源Docker Distribution。作为一个企业级私有Registry服务器，Harbor提供了更好的性能和安全。提升用户使用Registry构建和运行环境传输镜像的效率。Harbor支持安装在多个Registry节点的镜像资源复制，镜像全部保存在私有Registry中，确保数据和知识产权在公司内部网络中管控。另外，Harbor也提供了高级的安全特性，诸如用户管理，访问控制和活动审计等。

## 参考文档

- <https://github.com/goharbor/harbor/blob/master/docs/installation_guide.md>

## 安装包准备

- 下载以下安装包并放到downloads文件夹

```shell
wget https://codeload.github.com/goharbor/harbor/tar.gz/v1.8.1
```
