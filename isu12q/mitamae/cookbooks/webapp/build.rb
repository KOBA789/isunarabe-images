%w[go python ruby php perl node node/node_modules java rust rust/target rust/registry].each do |d|
  directory "/home/isucon/tmp/#{d}" do
    owner 'isucon'
    group 'isucon'
    mode '1777'
  end
end

execute 'cat /home/isucon/webapp/sql/admin/*.sql | mysql -uroot -proot'
execute '/home/isucon/webapp/sql/init.sh' do
  user 'isucon'
end

execute 'truncate -s 0 /etc/machine-id'
