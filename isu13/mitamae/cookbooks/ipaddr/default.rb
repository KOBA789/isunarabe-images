remote_file "/etc/systemd/system/isunarabe-env-ipaddr.service" do
  mode "0644"
end

remote_file "/opt/isunarabe-env-ipaddr.sh" do
  mode "0755"
end

execute "systemctl daemon-reload"

service "isunarabe-env-ipaddr" do
  action [:enable, :stop]
end
