execute "apt update"
package "sqlite3"
package "docker.io"
package "build-essential"

file "/etc/ssh/sshd_config.d/pubkey.conf" do
  owner "root"
  group "root"
  mode "0644"
  content "PubkeyAcceptedAlgorithms=+ssh-rsa
"
end
