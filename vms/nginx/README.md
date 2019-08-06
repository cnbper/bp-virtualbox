# nginx

```shell
mkdir -p /usr/local/etc/nginx/key && cd /usr/local/etc/nginx/key

# Openssl 生成https证书
# 创建私钥
openssl genrsa -out sloth.key 1024
# 生成自签证书
openssl req -new -x509 -days 3650 -key sloth.key -out sloth.crt
## CN  TJ  TJ  SLOTH  IT  nginx.sloth.com imbh.zhang@outlook.com

brew install nginx

vi /usr/local/etc/nginx/nginx.conf

nginx

nginx -s reload

cat <<EOF | kubectl -n istio-samples apply -f -
apiVersion: v1
kind: Service
metadata:
  name: bp-boot-https
  labels:
    app: bp-boot-https
    service: bp-boot-https
spec:
  ports:
  - port: 8080
    name: http
  selector:
    app: bp-boot-https
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: bp-boot-https-v1
  labels:
    app: bp-boot-https
    version: v1
spec:
  replicas: 1
  selector:
    matchLabels:
      app: bp-boot-https
      version: v1
  template:
    metadata:
      labels:
        app: bp-boot-https
        version: v1
    spec:
      containers:
      - name: bp-boot-https
        image: registry.sloth.com/ipaas/bp-boot-https
        imagePullPolicy: Always
        ports:
        - containerPort: 8080
---
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: bp-boot-https
spec:
  rules:
  - host: boot.sloth.com
    http:
      paths:
      - path: /
        backend:
          serviceName: bp-boot-https
          servicePort: 8080
EOF

kubectl -n istio-samples get pod

kubectl -n istio-samples exec -it \
  $(kubectl -n istio-samples get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}') -c ratings \
  -- curl https://172.20.10.2/app -X POST -H 'Host:nginx.sloth.com' -v --insecure

kubectl -n istio-samples exec -it bp-boot-https-v1-6fd95cc544-pmbqz /bin/sh
```

<http://boot.sloth.com>

## 测试

<https://istio.io/zh/docs/tasks/traffic-management/egress/>

```shell
# 创建一个 ServiceEntry 以允许访问外部 HTTPS 服务。 对于 TLS 协议（包括 HTTPS），除了 ServiceEntry 之外，还需要 VirtualService。 没有 VirtualService, ServiceEntry 所暴露的服务将不被定义。VirtualService 必须在 match 子句中包含 tls 规则和 sni_hosts 以启用 SNI 路由。
$ kubectl apply -f - <<EOF
apiVersion: networking.istio.io/v1alpha3
kind: ServiceEntry
metadata:
  name: google
spec:
  hosts:
  - www.google.com
  ports:
  - number: 443
    name: https
    protocol: HTTPS
  resolution: DNS
  location: MESH_EXTERNAL
---
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: google
spec:
  hosts:
  - www.google.com
  tls:
  - match:
    - port: 443
      sni_hosts:
      - www.google.com
    route:
    - destination:
        host: www.google.com
        port:
          number: 443
      weight: 100
EOF
```
