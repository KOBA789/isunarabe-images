remote_file '/dev/shm/initial_data.tar.gz' do
  group 'isucon'
  owner 'isucon'
  mode '0644'
  source 'initial_data.tar.gz'
end

remote_directory '/home/isucon/webapp' do
  group 'isucon'
  owner 'isucon'
  source 'webapp'
end
execute 'chown -R isucon:isucon /home/isucon/webapp'

remote_directory '/home/isucon/public' do
  group 'isucon'
  owner 'isucon'
  source 'public'
end
execute 'chown -R isucon:isucon /home/isucon/public'

execute 'ln -sf /opt/bench /home/isucon/bench' do
  user 'isucon'
end
execute 'tar xvf /dev/shm/initial_data.tar.gz -C /home/isucon' do
  user 'isucon'
  not_if { File.exist?('/home/isucon/initial_data') }
end
execute 'rm /home/isucon/bench' do
  user 'isucon'
end
