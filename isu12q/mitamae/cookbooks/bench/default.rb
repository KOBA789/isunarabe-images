directory "/opt/bench" do
  group "isucon"
  owner "isucon"
end

remote_file "/opt/bench/bench.sh" do
  group "isucon"
  owner "isucon"
  mode "755"
end

remote_file "/opt/bench/bootstrap.sh" do
  group "isucon"
  owner "isucon"
  mode "755"
end

remote_file "/opt/bench/bench" do
  group "isucon"
  owner "isucon"
  mode "755"
end

remote_file "/opt/bench/benchwarmer" do
  group "isucon"
  owner "isucon"
  mode "755"
end

remote_file "/opt/bench/isuports.pem" do
  group "isucon"
  owner "isucon"
  mode "644"
end

remote_file "/etc/systemd/system/benchwarmer.service" do
  owner "root"
  group "root"
  mode "644"
end

execute "ln -fs /home/isucon/public /opt/public"
