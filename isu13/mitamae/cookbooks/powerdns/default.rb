remote_file "/etc/apt/sources.list.d/pdns.list" do
  mode "0644"
end

remote_file "/etc/apt/preferences.d/auth-48" do
  mode "0644"
end

directory "/etc/apt/keyrings" do
  mode "0755"
end

remote_file "/etc/apt/keyrings/auth-48-pub.asc" do
  mode "0644"
end

execute "apt update"

package "pdns-server"
package "pdns-backend-mysql"

execute "create isudns db" do
  command %q{mysql -uroot -e "
    DROP DATABASE IF EXISTS isudns;
    CREATE DATABASE IF NOT EXISTS isudns;
  "}
end

execute "create tables on isudns" do
  command "cat /usr/share/doc/pdns-backend-mysql/schema.mysql.sql | mysql -uroot isudns"
end

file "/etc/powerdns/pdns.d/bind.conf" do
  action :delete
end

file "/etc/powerdns/pdns.d/mysql.conf" do
  action :delete
end

remote_file "/etc/powerdns/pdns.d/gmysql-host.conf" do
  mode "0644"
end

remote_file "/etc/powerdns/pdns.conf" do
  mode "0644"
end

remote_file "/etc/systemd/resolved.conf" do
  mode "0644"
end

link "/etc/resolv.conf" do
  to "/run/systemd/resolve/resolv.conf"
  force true
  # In docker, /etc/resolv.conf is read-only
  not_if "test -e /.dockerenv"
end

execute "cat /run/systemd/resolve/resolv.conf > /etc/resolv.conf" do
  only_if "test -e /.dockerenv"
end

service "systemd-resolved" do
  action [:enable, :restart]
end

# ssm-agent continues to use the old resolv.conf which points to systemd-resolved
# but systemd-resolved does no longer provide DNS stub resolver.
# So we need to restart ssm-agent to make it use the new resolv.conf.
service "snap.amazon-ssm-agent.amazon-ssm-agent" do
  action [:restart]
  only_if "systemctl status snap.amazon-ssm-agent.amazon-ssm-agent"
end

remote_file "/opt/init_zone_once.sh" do
  mode "0755"
end

directory "/etc/systemd/system/pdns.service.d/" do
  mode "0755"
end

remote_file "/etc/systemd/system/pdns.service.d/isudns.conf" do
  mode "0644"
end

execute "systemctl daemon-reload"

service "pdns" do
  action [:enable, :stop]
end
