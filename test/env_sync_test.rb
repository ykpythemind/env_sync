require "test_helper"
require 'fileutils'

class EnvSyncTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::EnvSync::VERSION
  end

  def setup
    FileUtils.mkdir_p('/tmp/env_sync_tmp/hoge')
    FileUtils.mkdir_p('/tmp/env_sync_tmp/hoge2')
    FileUtils.mkdir_p('/tmp/env_sync_tmp/hoge3')

    File.open('/tmp/env_sync_tmp/hoge3/.env', 'w') do |file|
      file.puts "FUGA=fuga"
    end
  end

  def teardown
    FileUtils.rm_rf('/tmp/env_sync_tmp')
  end

  def test_sync
    syncer = EnvSync::Syncer.new({basic_envfile: File.expand_path('fixtures/env.yaml', __dir__)})

    syncer.sync!

    assert_equal "HOGE=fuga\nFOO=bar\n", File.read("/tmp/env_sync_tmp/hoge/.env")
    assert_equal "PIYO=piyo2\n", File.read("/tmp/env_sync_tmp/hoge2/.env.development")
    assert_equal "PIYO=piyo\n", File.read("/tmp/env_sync_tmp/hoge3/.env") # not FUGA=fuga
  end
end
