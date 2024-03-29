# FROMでベースイメージを設定
# 今回はRubyのバージョン3.0をベースイメージとして設定
FROM ruby:3.0
# nodeやyarn等の必要なライブラリをインストール
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs cron

ENV APP_ROOT /var/www

# Railsアプリを配置するフォルダをコンテナ内に作成
RUN mkdir $APP_ROOT
# 作成したディレクトリをワークディレクトリとして設定
WORKDIR $APP_ROOT

ENV BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3 \
    BUNDLE_PATH=vendor/bundle \
    BUNDLE_APP_CONFIG=$APP_ROOT/.bundle

# アプリディレクトリ配下のGemfileをコンテナ内のRailsアプリの配置場所にコピー
COPY Gemfile ${APP_ROOT}/Gemfile
# Gemfile.lockも同様にコンテナ内にコピーする
COPY Gemfile.lock ${APP_ROOT}/Gemfile.lock
# Gemfileの記述を元にbundle installを実行
RUN bundle install

# 現在のディレクトリをコンテナ内にコピー
# これはスケルトンアプリを作成しGemfile更新後に、
# もう一度ビルドした際にコンテナ内にGemをインストールしてアプリの雛形を作成するため
COPY . $APP_ROOT

# コンテナ起動時に実行させるスクリプトを追加
# アクセス権限を実行可能にしておく
# EXPOSEはドキュメント代わり。コンテナ実行時に指定したポートをコンテナがリッスンするようになる
# EXPOSEだけではポートは公開されず、使用者からコンテナにはアクセスできない。
# 公開用のポートとEXPOSEで指定したポートをPublishにすることで、公開されるようになる。
# そのため、EXPOSEはイメージの作者とコンテナ実行者の両者に対して、ドキュメントのような役割をする。
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Rails サーバ起動
# entrypoint.shでexec "$@"としているためCMDで渡されるオプションが実行されることになる
# docker-compose upはDBコンテナとまとめて起動する用の初期commandが書かれている
# このCMDはrailsサーバーを「単独」で立ち上げて作業したい場合に用いる
CMD ["rails", "server", "-b", "0.0.0.0"]
