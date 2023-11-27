group "isucon" do
  gid 1100
end

user "isucon" do
  uid 1100
  gid 1100
  create_home true
  shell "/bin/bash"
end

directory "/home/isucon" do
  owner "isucon"
  group "isucon"
  mode "0755"
end

directory "/home/isucon/.ssh" do
  owner "isucon"
  group "isucon"
  mode "0700"
end

file "/etc/sudoers.d/99-isucon-user" do
  owner "root"
  group "root"
  mode "0440"
  content "isucon ALL=(ALL) NOPASSWD:ALL\n"
end
