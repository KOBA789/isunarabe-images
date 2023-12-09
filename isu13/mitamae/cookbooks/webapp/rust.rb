execute "build rust app" do
  user "isucon"
  command "/home/isucon/.x cargo build --release --locked"
  cwd "/home/isucon/webapp/rust"
end

remote_file "/etc/systemd/system/isupipe-rust.service" do
  mode "0644"
end

service "isupipe-rust" do
  action [:enable, :stop]
end
