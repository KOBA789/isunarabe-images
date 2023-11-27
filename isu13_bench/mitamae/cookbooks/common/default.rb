file "/etc/ssh/sshd_config.d/pubkey.conf" do
  owner "root"
  group "root"
  mode "0644"
  content "PubkeyAcceptedAlgorithms=+ssh-rsa\n"
end

execute "sysctl --system" do
  command "sysctl --system"
  action :nothing
end

file "/etc/sysctl.d/99-isu.conf" do
  owner "root"
  group "root"
  mode "0644"
  content "net.ipv4.ip_local_port_range = 10000 65535\n"
  notifies :run, "execute[sysctl --system]"
end
