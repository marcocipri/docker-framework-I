## consul-template configuration

max_stale = "10m"

wait {
  min = "5s"
  max = "20s"
}

template {
  source = "/usr/local/etc/consul/haproxy.template"
  destination = "/usr/local/etc/haproxy/haproxy.cfg"
  command = "/hap.sh"
  perms = 0600
}