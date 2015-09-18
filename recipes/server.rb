#
# server.rb
#

directory '/srv/invocomb' do
  owner 'invocomb'
  group 'invocomb'
  mode '00755'
end

group 'invocomb' do
end

user 'invocomb' do
  comment 'invocomb user'
  uid 1337
  gid 'invocomb'
  home '/srv/invocomb'
  shell '/bin/false'
end

git '/srv/invocomb' do
  repository  node['invocomb']['git_repository']
  revision    node['invocomb']['git_revision']
  action      :sync
end
