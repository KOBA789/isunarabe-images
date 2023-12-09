remote_directory '/opt/xbuild' do
  group 'root'
  owner 'root'
  source 'xbuild'
end
execute 'chown -R root:root /opt/xbuild'

directory "/home/isucon/local" do
  group "isucon"
  owner "isucon"
  mode "0755"
end

execute "/opt/xbuild/go-install 1.21.2 /home/isucon/local/golang" do
  user "isucon"
end

remote_file "/home/isucon/.local.env" do
  group "isucon"
  owner "isucon"
end

remote_file "/home/isucon/.x" do
  group "isucon"
  owner "isucon"
  mode "0755"
end

file "/home/isucon/.profile" do
  action :edit
  group "isucon"
  owner "isucon"
  block do |content|
    content << "\nsource /home/isucon/.local.env\n"
  end
end
