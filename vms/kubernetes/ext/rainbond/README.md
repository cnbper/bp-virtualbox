# 附加服务 Rainbond

<https://www.rainbond.com/docs/user-operations/install/minimal_install/>

```shell
wget https://rainbond-pkg.oss-cn-shanghai.aliyuncs.com/offline/5.2/rainbond-operator-chart-v5.2.0-release.tgz

tar xvf rainbond-operator-chart-v5.2.0-release.tgz


#通过helm安装operator到指定namespace
helm template --name=rainbond-operator --namespace rbd-system \
  --set rainbondOperator.image.repository=registry.sloth.com/goodrain/rainbond-operator \
  --set openapi.image.repository=registry.sloth.com/goodrain/rbd-op-ui \
  chart > yaml/rainbond-operator.yaml

#创建所需namespace
kubectl create namespace rbd-system

kubectl -n rbd-system apply -f chart/crds
kubectl -n rbd-system apply -f yaml/rainbond-operator.yaml

kubectl -n rbd-system get pod
kubectl -n rbd-system exec -it rainbond-operator-0 -c openapi /bin/sh
#************************************************************************************
/ # ping www.baidu.com
ping: bad address 'www.baidu.com'
#************************************************************************************

# http://172.17.8.102:30008/
```
