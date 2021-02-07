# operator
docker pull registry.cn-hangzhou.aliyuncs.com/goodrain/rainbond-operator:v1.0.0
docker tag registry.cn-hangzhou.aliyuncs.com/goodrain/rainbond-operator:v1.0.0 registry.sloth.com/goodrain/rainbond-operator:v1.0.0
docker push registry.sloth.com/goodrain/rainbond-operator:v1.0.0
docker rmi registry.sloth.com/goodrain/rainbond-operator:v1.0.0

docker pull registry.cn-hangzhou.aliyuncs.com/goodrain/rbd-op-ui:v1.0.0
docker tag registry.cn-hangzhou.aliyuncs.com/goodrain/rbd-op-ui:v1.0.0 registry.sloth.com/goodrain/rbd-op-ui:v1.0.0
docker push registry.sloth.com/goodrain/rbd-op-ui:v1.0.0
docker rmi registry.sloth.com/goodrain/rbd-op-ui:v1.0.0

# 镜像仓库
docker pull registry.cn-hangzhou.aliyuncs.com/goodrain/nfs-provisioner:v2.3.0
docker tag registry.cn-hangzhou.aliyuncs.com/goodrain/nfs-provisioner:v2.3.0 registry.sloth.com/goodrain/nfs-provisioner:v2.3.0
docker push registry.sloth.com/goodrain/nfs-provisioner:v2.3.0
docker rmi registry.sloth.com/goodrain/nfs-provisioner:v2.3.0

docker pull registry.cn-hangzhou.aliyuncs.com/goodrain/etcd:v3.3.18
docker tag registry.cn-hangzhou.aliyuncs.com/goodrain/etcd:v3.3.18 registry.sloth.com/goodrain/etcd:v3.3.18
docker push registry.sloth.com/goodrain/etcd:v3.3.18
docker rmi registry.sloth.com/goodrain/etcd:v3.3.18

docker pull registry.cn-hangzhou.aliyuncs.com/goodrain/rbd-gateway:v5.2.0-release
docker tag registry.cn-hangzhou.aliyuncs.com/goodrain/rbd-gateway:v5.2.0-release registry.sloth.com/goodrain/rbd-gateway:v5.2.0-release
docker push registry.sloth.com/goodrain/rbd-gateway:v5.2.0-release
docker rmi registry.sloth.com/goodrain/rbd-gateway:v5.2.0-release

docker pull registry.cn-hangzhou.aliyuncs.com/goodrain/registry:2.6.2
docker tag registry.cn-hangzhou.aliyuncs.com/goodrain/registry:2.6.2 registry.sloth.com/goodrain/registry:2.6.2
docker push registry.sloth.com/goodrain/registry:2.6.2
docker rmi registry.sloth.com/goodrain/registry:2.6.2

docker pull registry.cn-hangzhou.aliyuncs.com/goodrain/rbd-node:v5.2.0-release
docker tag registry.cn-hangzhou.aliyuncs.com/goodrain/rbd-node:v5.2.0-release registry.sloth.com/goodrain/rbd-node:v5.2.0-release
docker push registry.sloth.com/goodrain/rbd-node:v5.2.0-release
docker rmi registry.sloth.com/goodrain/rbd-node:v5.2.0-release







