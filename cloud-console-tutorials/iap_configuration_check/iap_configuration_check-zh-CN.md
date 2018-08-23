# 为 GCE/GKE 开启 IAP

身份识别代理 (IAP) 只保护流经负载平衡器的流量。请按照以下步骤操作以保护您的应用免受未经授权访问攻击。

[了解详情](https://cloud.google.com/iap/docs/)

## 以下是您将要完成的步骤：

### 查看网络配置

如果负载平衡器 IP（`130.211.0.0/22` 和 `35.191.0.0/16`）无法访问您的后端，IAP **将不起作用**。

如果任何其他 IP 可以访问您的后端，该流量将绕过您的 IAP 访问权限政策。在某些情况下，例如想要允许监控系统连接到后端时，这可能会非常有用。

### 监控您的网络配置

如果在启用 IAP 后您的配置发生了变化，则系统可能会变得不安全。部署 [Forseti Security][forseti-security]（由 Google 维护的一款开源工具）可以持续监控项目配置并发送通知。

### 执行签名标头检查

[了解如何](https://cloud.google.com/iap/docs/signed-headers-howto)保护您的应用以避免所有绕过 IAP 访问权限政策的行为，例如：

  *  项目管理员意外停用了 IAP
  *  网络配置错误
  *  用户登录到 VM 并通过 localhost 连接到网页服务器

### 声明配置

确认您已阅读文档并根据文档配置了 GCE/GKE 资源。

[显示具体方法][spotlight-config-reviewed]

[forseti-security]: https://opensource.google.com/projects/forseti-security
[spotlight-config-reviewed]: walkthrough://spotlight-pointer?spotlightId=iap-network-config-reviewed
