ENV['DEBIAN_FRONTEND'] = 'noninteractive'
include_recipe '../cookbooks/common/default.rb'
include_recipe '../cookbooks/users/isucon.rb'
include_recipe '../cookbooks/bench/default.rb'
