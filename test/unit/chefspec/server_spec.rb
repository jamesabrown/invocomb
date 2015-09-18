#
# invocomb::server.rb
#
require_relative 'spec_helper'

describe 'invocomb::server' do
  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      env = Chef::Environment.new
      env.name 'test'

      allow(node).to receive(:chef_environment).and_return(env.name)
      allow(Chef::Environment).to receive(:load).and_return(env)
    end.converge(described_recipe)
  end

  before do
    allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).and_return(true)
  end

it 'creates invocomb directory' do
  expect(chef_run).to create_directory('/srv/invocomb').with(
    :user => 'invocomb',
    :group => 'invocomb',
    :mode => '00755'
)
end

it 'creates invocomb group' do
  expect(chef_run).to create_group('invocomb')
end  

it 'creates invocomb user' do
  expect(chef_run).to create_user('invocomb').with(
    :home => '/srv/invocomb',
    :shell => '/bin/false'
)
end

it 'checks out invocomb repo' do
  expect(chef_run).to sync_git('/srv/invocomb').with(
    :repository => 'https://github.com/Invoca/Invocomb.git',
    :revision => 'master'
)
end

it 'installs invocomb gem' do
  expect(chef_run).to install_gem_package('invocomb')
end

end
