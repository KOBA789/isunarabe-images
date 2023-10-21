remote_file "/etc/systemd/system/isuports.service" do
  owner "root"
  group "root"
  mode "0644"
  source "isuports.service"
end

execute 'systemctl enable isuports' do
  command 'systemctl daemon-reload && systemctl enable isuports'
end
