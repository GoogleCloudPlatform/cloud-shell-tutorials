# Turn on IAP for GCE/GKE

Identity-Aware Proxy (IAP) only secures traffic that passes through the load
balancer. Follow these steps to protect your app from unauthorized attacks.

[Learn more](https://cloud.google.com/iap/docs/)

## Here are the steps you will be completing:

### Review network configuration

If the load balancer IPs, `130.211.0.0/22` and `35.191.0.0/16`, can't reach your
backends, IAP **won't work**.

If any other IPs can access your backends, that traffic will bypass your IAP
access policy. In some cases, this can be useful, such as to allow for
monitoring systems to connect to backends.

### Monitor your network configuration

If your configuration changes after enabling IAP, it could become insecure.
Deploy [Forseti Security][forseti-security], an open-source tool maintained by
Google to continously monitor project configuration and send notifications.

### Implement signed header check

[Learn how](https://cloud.google.com/iap/docs/signed-headers-howto) to protect
your app from IAP access policy bypass, such as:

  *  A project admin accedentially disabling IAP
  *  Network configuration errors
  *  A user logging into the VM and connecting to the webserver via localhost

### Assert configuration

Agree that you have read and configured the GCE/GKE resource according to the
documentation.

[Show me how][spotlight-config-reviewed]

[forseti-security]: https://opensource.google.com/projects/forseti-security
[spotlight-config-reviewed]: walkthrough://spotlight-pointer?spotlightId=iap-network-config-reviewed
