require 'active_support'
require 'active_support/core_ext/time'

# 日本時間に変更
def jst(time)
  Time.zone = 'Asia/Tokyo'
  Time.zone.parse(time).localtime($system_utc_offset)
end

# Rails.rootを使用するために必要
require File.expand_path(File.dirname(__FILE__) + '/environment')
# cronを実行する環境変数
rails_env = ENV['RAILS_ENV'] || :development
# cronを実行する環境変数をセット
set :environment, rails_env
# cronのログの吐き出し場所
set :output, "#{Rails.root}/log/cron.log"

# 3日ごとにarticlesテーブルを更新
every 3.days, at: '3:00 am' do
  rake 'qiita:get_items_regularly'
  rake 'zenn:get_items_regularly'
end