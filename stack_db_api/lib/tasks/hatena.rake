namespace :hatena do
  desc "はてブの個人開発に関連する記事を保存するタスク"
  task get_items_once: :environment do
    hatena_data = [
      {
        link: "https://crieit.net/posts/100-5fd1a1cdb1827",
        title: "売れるアプリにするコツ100個書きます(吐血)",
        date: "2020-12-10",
        stock: 1443,
        media_name: "creit.net",
        media_image: "https://youliangdao.s3.ap-northeast-1.amazonaws.com/creit.png",
        category_ids: [56, 59, 47, 12]
      },
      {
        link: "https://r7kamura.com/articles/2022-05-07-chrome-extension-dev-2022",
        title: "Chrome拡張 つくりかた 令和最新版",
        media_image: "https://cdn-ak-scissors.favicon.st-hatena.com/image/favicon2/5c0be2e37693018aa8c19ab9f6ba5ad763c46eed/backend=imagemagick;size=64;version=1/https%3A%2F%2Fr7kamura.com%2Ffavicon.ico",
        media_name: "r7kamura.com",
        date: "2022-05-07",
        stock: 998,
        category_ids: [30, 3, 5]
      },
      {
        link: "https://laiso.hatenablog.com/entry/2020/06/22/covid-19radar-and-me",
        title: "個人開発者とCovid-19 Radarプロジェクト",
        media_image: "https://cdn-ak-scissors.favicon.st-hatena.com/image/favicon2/f4deb3f535b9653bf118b10c75a857843842a46f/backend=imagemagick;size=64;version=1/https%3A%2F%2Flaiso.hatenablog.com%2Ficon%2Flink",
        media_name: "laiso.hatenablog.com",
        date: "2020-06-22",
        stock: 975,
        category_ids: [59, 4]
      },
      {
        link: "https://miraku.dev/iniquity/",
        title: "競合アプリを不正に攻撃する犯人の告発と対処",
        media_image: "https://cdn-ak-scissors.favicon.st-hatena.com/image/favicon2/2f405c03563197bc27b5d520f01bbcc42d85227c/backend=imagemagick;size=64;version=1/https%3A%2F%2Fmiraku.dev%2Fwp-content%2Fuploads%2F2019%2F04%2Fcropped-logo_1024-01-1-192x192.png",
        media_name: "miraku.dev",
        stock: 965,
        date: "2020-12-18",
        category_ids: [56, 27, 12]
      },
      {
        link: "https://knqyf263.hatenablog.com/entry/2021/07/29/143500",
        title: "趣味で作ったソフトウェアが海外企業に買われ分野世界一になるまでの話",
        media_image: "https://cdn-ak-scissors.favicon.st-hatena.com/image/favicon2/cef204fce601adfc3de30c6fd057b318060bbe00/backend=imagemagick;size=64;version=1/https%3A%2F%2Fknqyf263.hatenablog.com%2Ficon%2Flink",
        media_name: "knqyf263.hatenablog.com",
        stock: 803,
        date: "2021-07-29",
        category_ids: [27, 12, 4]
      },
      {
        link: "https://blog.craftz.dog/ddos-attack-on-inkdrop-db0af5893186",
        title: "自作サービスがDDoS攻撃された話",
        media_image: "https://cdn-ak-scissors.favicon.st-hatena.com/image/favicon2/8f7a57c8a4054d16c9cc77f945a7cf72137a42af/backend=imagemagick;size=64;version=1/https%3A%2F%2Fmiro.medium.com%2Ffit%2Fc%2F256%2F256%2F1%2Axd2p9N34I7_5xmDgQCZLDQ.png",
        media_name: "blog.craftz.dog/",
        stock: 788,
        date: "2020-06-16",
        category_ids: [7, 40, 27]
      },
      {
        title: "個人開発のコストはDB次第",
        stock: 765,
        media_name: "laiso.hatenablog.com",
        media_image: "https://cdn-ak-scissors.favicon.st-hatena.com/image/favicon2/f4deb3f535b9653bf118b10c75a857843842a46f/backend=imagemagick;size=64;version=1/https%3A%2F%2Flaiso.hatenablog.com%2Ficon%2Flink",
        date: "2022-05-04",
        link: "https://laiso.hatenablog.com/entry/nope-sql",
        category_ids: [60, 34, 7, 58, 66]
      },
      {
        title: "個人開発を黒字にする技術",
        stock: 746,
        media_name: "k0kubun.hatenablog.com",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fk0kubun.hatenablog.com%2Fentry%2Fsurplus",
        date: "2022-05-06",
        link: "https://k0kubun.hatenablog.com/entry/surplus",
        category_ids: [37, 19, 56, 59]
      },
      {
        title: "期限の制約なく無料で使えるクラウド「Free Tier」主要サービスまとめ。2022年版",
        stock: 729,
        media_name: "www.publickey1.jp",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fwww.publickey1.jp%2Fblog%2F22%2Ffree_tier2022.html",
        date: "2022-07-20",
        link: "https://www.publickey1.jp/blog/22/free_tier2022.html",
        category_ids: [7, 44, 34, 60, 19, 14, 67, 4, 49]
      },
      {
        title: "Cloudflare D1 がヤバい",
        stock: 701,
        media_name: "zenn.dev",
        media_image: "https://youliangdao.s3.ap-northeast-1.amazonaws.com/logo-only.png",
        date: "2022-05-11",
        link: "https://zenn.dev/mizchi/articles/cloudflare-d1",
        category_ids: [67]
      },
      {
        title: "10年ぶりに一人でWebサービスを作って思ったこと(エンジニア老人会)",
        stock: 628,
        media_name: "note.com/shi3zblog",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fnote.com%2Fshi3zblog%2Fn%2Fn19824ca4ee8f",
        date: "2022-08-29",
        link: "https://note.com/shi3zblog/n/n19824ca4ee8f",
        category_ids: [60, 37, 40]
      },
      {
        title: "「個人開発」からはじめたサービスで月140万円の売上を達成するまで",
        stock: 611,
        media_name: "note.com/iritec",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fnote.com%2Fshi3zblog%2Fn%2Fn19824ca4ee8f",
        date: "2020-01-27",
        link: "https://note.com/iritec/n/nfc6ca90ca22f",
        category_ids: [27, 12, 47]
      },
      {
        title: "一銭も払わずにクラウド上でWebサービスを公開する(2021/02時点)",
        stock: 592,
        media_name: "qiita.com",
        media_image: "https://youliangdao.s3.ap-northeast-1.amazonaws.com/favicon.png",
        date: "2021-02-22",
        link: "https://qiita.com/okazu_dm/items/87003109067348e9b7bf",
        category_ids: [7, 34]
      },
      {
        title: "ヒット作が出ないまま10年間個人アプリ開発を続けたエンジニアの末路",
        stock: 571,
        media_name: "note.com/dancingpandor",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fnote.com%2Fshi3zblog%2Fn%2Fn19824ca4ee8f",
        date: "2021-12-26",
        link: "https://note.com/dancingpandor/n/n28fbc6ffc4a5",
        category_ids: [59, 46, 40, 47]
      },
      {
        title: "なぜWebサービスはUIの改悪を繰り返すのか",
        stock: 567,
        media_name: "anond.hatelabo.jp",
        media_image: "https://youliangdao.s3.ap-northeast-1.amazonaws.com/hatelabo.gif",
        date: "2020-09-27",
        link: "https://anond.hatelabo.jp/20200927193744",
        category_ids: [1, 2, 12]
      },
      {
        title: "高校生が作った有料サービスがちょっと儲かったのでいろいろ書く",
        stock: 550,
        media_name: "zenn.dev",
        media_image: "https://youliangdao.s3.ap-northeast-1.amazonaws.com/logo-only.png",
        date: "2021-11-11",
        link: "https://zenn.dev/sizumita/articles/b7dcf43d64dead",
        category_ids: [7, 8, 34, 68, 61]
      },
      {
        title: "仕組みから理解する Git 入門 ~ ひとり開発でも便利 ~",
        stock: 534,
        media_name: "speakerdeck.com/mu_zaru",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fspeakerdeck.com%2Fmu_zaru%2Fshi-zu-mikarali-jie-suru-git-ru-men-hitorikai-fa-demobian-li",
        date: "2021-02-12",
        link: "https://speakerdeck.com/mu_zaru/shi-zu-mikarali-jie-suru-git-ru-men-hitorikai-fa-demobian-li",
        category_ids: [4]
      }, 
      {
        title: "話題のStable Diffusionがオープンソース化されたのでローカルで動かしてみる",
        stock: 529,
        media_name: "zenn.dev",
        media_image: "https://youliangdao.s3.ap-northeast-1.amazonaws.com/logo-only.png",
        date: "2022-08-23",
        link: "https://zenn.dev/koyoarai_/articles/02f3ed864c6127bb2049",
        category_ids: [21, 36]
      },
      {
        title: "とりあえずWebサービス作る時の私の技術選定ポイント@2022/02",
        stock: 523,
        media_name: "zenn.dev",
        media_image: "https://youliangdao.s3.ap-northeast-1.amazonaws.com/logo-only.png",
        date: "2022-02-12",
        link: "https://zenn.dev/moya_dev/articles/1c3da5422fb7d0",
        category_ids: [34, 32]
      }, 
      {
        title: "個人でWEB開発を１５年くらいやってる者ですが",
        stock: 519,
        media_name: "anond.hatelabo.jp",
        media_image: "https://youliangdao.s3.ap-northeast-1.amazonaws.com/hatelabo.gif",
        date: "2022-05-04",
        link: "https://anond.hatelabo.jp/20220504211823",
        category_ids: [60, 34, 7, 58, 66, 27]
      },
      {
        title: "スキル0、知識0、人脈0から3ヶ月で開発したサービスが運営2年半で企業に買収されました",
        stock: 466,
        media_name: "www.slideshare.net/yusukebe",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fwww.slideshare.net%2Fyusukebe%2F7048web-239705848",
        date: "2020-12-03",
        link: "https://www.slideshare.net/yusukebe/7048web-239705848",
        category_ids: [42, 12, 27]
      },
      {
        title: "自分プロジェクトを挫折せず続ける技術 - 個人開発をはじめよう！",
        stock: 455,
        media_name: "shinyorke.hatenablog.com",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fshinyorke.hatenablog.com%2Fentry%2Fbotti-development",
        date: "2020-06-07",
        link: "https://shinyorke.hatenablog.com/entry/botti-development",
        category_ids: [12, 42, 27]
      },
      {
        title: "10 年間 1 人で 1 つの iOS アプリを保守してきた話",
        stock: 446,
        media_name: "dev.classmethod.jp",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fdev.classmethod.jp%2Farticles%2Fjust-quick-search%2F",
        date: "2022-02-03",
        link: "https://dev.classmethod.jp/articles/just-quick-search/",
        category_ids: [59]
      },
      {
        title: "ウェブサービスで最初の1000人のユーザーを獲得するために行うべき8つのこと",
        stock: 444,
        media_name: "gigazine.net",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fgigazine.net%2Fnews%2F20210214-get-first-1000-users%2F",
        date: "2021-02-14",
        link: "https://gigazine.net/news/20210214-get-first-1000-users/",
        category_ids: [47, 22, 12]
      },
      {
        title: "なるべくお金をかけずに個人アプリを運用したい",
        stock: 422,
        media_name: "sue445.hatenablog.com",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fsue445.hatenablog.com%2Fentry%2F2022%2F05%2F06%2F170001",
        date: "2022-05-06",
        link: "https://sue445.hatenablog.com/entry/2022/05/06/170001",
        category_ids: [19, 34, 4, 37]
      }, 
      {
        title: "Astroで始める爆速個人サイト開発",
        stock: 395,
        media_name: "speakerdeck.com/takanorip",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fspeakerdeck.com%2Ftakanorip%2Fastroteshi-merubao-su-ge-ren-saitokai-fa",
        date: "2023-01-21",
        link: "https://speakerdeck.com/takanorip/astroteshi-merubao-su-ge-ren-saitokai-fa",
        category_ids: [1, 2, 3, 5]
      },
      {
        title: "Angular と Firebase で月間 3.5億PV になった PWA の収益性改善とコストカット",
        stock: 326,
        media_name: "qiita.com",
        media_image: "https://youliangdao.s3.ap-northeast-1.amazonaws.com/favicon.png",
        date: "2020-12-07",
        link: "https://qiita.com/MasanobuAkiba/items/6f2e02eceaded9664b14",
        category_ids: [48, 37]
      },
      {
        title: "30個以上の個人開発を失敗。そこから自分のサービスで生きていけるようになるまでの話。",
        stock: 386,
        media_name: "note.com/iritec",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fnote.com%2Firitec%2Fn%2Fn17c741c5f02d",
        date: "2021-05-13",
        link: "https://note.com/iritec/n/n17c741c5f02d",
        category_ids: [12, 22, 40, 27]
      },
      {
        title: "小さいプロダクト開発におけるGCP利用の勘どころ - 個人的なプロダクトを三日でローンチした話",
        stock: 355, 
        media_name: "shinyorke.hatenablog.com",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fshinyorke.hatenablog.com%2Fentry%2Fgcp-slack-taida",
        date: "2020-03-15",
        link: "https://shinyorke.hatenablog.com/entry/gcp-slack-taida",
        category_ids: [34, 21, 74]
      },
      {
        title: "Twitterトレンド１位になった個人開発Webサービスの負荷対応記録",
        stock: 349,
        media_name: "blog.p1ass.com",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fblog.p1ass.com%2Fposts%2Fmidare%2F",
        date: "2020-07-06",
        link: "https://blog.p1ass.com/posts/midare/",
        category_ids: [61, 34]
      },
      {
        title: "Herokuの代替サービス30選、使ってみた参考記事リンク付き",
        stock: 387,
        media_name: "qiita.com",
        media_image: "https://youliangdao.s3.ap-northeast-1.amazonaws.com/favicon.png",
        date: "2022-10-24",
        link: "https://qiita.com/rana_kualu/items/f7fc4916b7dc9797839e",
        category_ids: [19]
      },
      {
        title: "WebAPIを構築する際にAPI Gateway+Lambdaを選択するべきか？",
        stock: 337,
        media_name: "zenn.dev",
        media_image: "https://youliangdao.s3.ap-northeast-1.amazonaws.com/logo-only.png",
        date: "2022-07-30",
        link: "https://zenn.dev/intercept6/articles/d63c390c02f436",
        category_ids: [7]
      }, 
      {
        title: "個人開発激安 GCP (にしたい)",
        stock: 332, 
        media_name: "zenn.dev",
        media_image: "https://youliangdao.s3.ap-northeast-1.amazonaws.com/logo-only.png",
        date: "2022-06-02",
        link: "https://zenn.dev/suyaa/articles/93b23462b08e95",
        category_ids: [34]
      }, 
      {
        title: "作者冥利に尽きる",
        stock: 327,
        media_name: "yusukebe.com",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fyusukebe.com%2Fposts%2F2022%2Fcreator%2F",
        date: "2022-10-30",
        link: "https://yusukebe.com/posts/2022/creator/",
        category_ids: [27, 47]
      },
      {
        title: "文化祭で滞在状況記録システムを運用しました",
        stock: 322,
        media_name: "zenn.dev",
        media_image: "https://youliangdao.s3.ap-northeast-1.amazonaws.com/logo-only.png",
        date: "2023-01-06",
        link: "https://zenn.dev/newt_st21/articles/gateway-stay-status-record-system",
        category_ids: [3, 61, 58, 7]
      },
      {
        title: "個人開発の失敗を避けるイケてる考え方 / tips for indie hackers",
        stock: 299,
        media_name: "speakerdeck.com/panda_program",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fspeakerdeck.com%2Fpanda_program%2Ftips-for-indie-hackers-5e33891f-2054-4044-87da-623799f8d8bd",
        date: "2022-11-19",
        link: "https://speakerdeck.com/panda_program/tips-for-indie-hackers-5e33891f-2054-4044-87da-623799f8d8bd",
        category_ids: [12, 40, 47]
      },
      {
        title: "【AWS, GCP, Azure, OracleCloud, Firebase】無料で使えるクラウドのサーバリソースまとめ【2020年1月版】",
        stock: 471,
        media_name: "qiita.com",
        media_image: "https://youliangdao.s3.ap-northeast-1.amazonaws.com/favicon.png",
        date: "2020-01-05",
        link: "https://qiita.com/goyae/items/196221169391dd44125d",
        category_ids: [7, 44, 37]
      }, 
      {
        title: "カナダで自分の会社を作ってみた",
        stock: 284,
        media_name: "blog.riywo.com",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fblog.riywo.com%2F2022%2F10%2Ffounded-my-company-in-canada%2F",
        date: "2022-10-31",
        link: "https://blog.riywo.com/2022/10/founded-my-company-in-canada/",
        category_ids: [3, 28, 22]
      }, 
      {
        title: "【Flutter】アプリ開発_初心者のアプリをプロっぽくする最強のpackageを紹介",
        stock: 932,
        media_name: "qiita.com",
        media_image: "https://youliangdao.s3.ap-northeast-1.amazonaws.com/favicon.png",
        date: "2020-03-04",
        link: "https://qiita.com/kazumaz/items/876e162cf429014661d8",
        category_ids: [18, 59, 56]
      },
      {
        title: "個人開発のサービスをVPSからVercelとCloud Runに移行した話",
        stock: 268,
        media_name: "zenn.dev",
        media_image: "https://youliangdao.s3.ap-northeast-1.amazonaws.com/logo-only.png",
        date: "2022-05-08",
        link: "https://zenn.dev/hokaccha/articles/81d0545c1517f1",
        category_ids: [34, 28, 6, 29]
      },
      {
        title: "ローカルマシンでDocker を動かさないためにBlimp を採用する",
        stock: 265,
        media_name: "y-ohgi.blog",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fy-ohgi.blog%2Fentry%2F2020%2F12%2F15%2F%25E3%2583%25AD%25E3%2583%25BC%25E3%2582%25AB%25E3%2583%25AB%25E3%2583%259E%25E3%2582%25B7%25E3%2583%25B3%25E3%2581%25A7Docker_%25E3%2582%2592%25E5%258B%2595%25E3%2581%258B%25E3%2581%2595%25E3%2581%25AA%25E3%2581%2584%25E3%2581%259F%25E3%2582%2581%25E3%2581%25ABBlimp_%25E3%2582%2592%25E6%258E%25A1%25E7%2594%25A8%25E3%2581%2599%25E3%2582%258B",
        date: "2020-12-15",
        link: "https://y-ohgi.blog/entry/2020/12/15/%E3%83%AD%E3%83%BC%E3%82%AB%E3%83%AB%E3%83%9E%E3%82%B7%E3%83%B3%E3%81%A7Docker_%E3%82%92%E5%8B%95%E3%81%8B%E3%81%95%E3%81%AA%E3%81%84%E3%81%9F%E3%82%81%E3%81%ABBlimp_%E3%82%92%E6%8E%A1%E7%94%A8%E3%81%99%E3%82%8B",
        category_ids: [8]
      },
      {
        title: "サヨナラHeroku 〜アプリケーションの知識だけで本番稼働を実現できる無料のプラットフォームを追い求めて〜",
        stock: 249,
        media_name: "zenn.dev",
        media_image: "https://youliangdao.s3.ap-northeast-1.amazonaws.com/logo-only.png",
        date: "2022-11-02",
        link: "https://zenn.dev/imah/articles/a41e889dbf54da",
        category_ids: [19, 35, 12, 7]
      },
      {
        title: "【個人開発】Flutterで利用者1万人のアプリを作るまでの話",
        stock: 248,
        media_name: "note.com/tanio0125",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fnote.com%2Ftanio0125%2Fn%2Fndbcabba13e3c",
        date: "2021-05-25",
        link: "https://note.com/tanio0125/n/ndbcabba13e3c",
        category_ids: [37, 18]
      },
      {
        title: "趣味プロジェクトをリードする技術 / Technology to lead hobby projects",
        stock: 247,
        media_name: "speakerdeck.com/p1ass",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fspeakerdeck.com%2Fp1ass%2Ftechnology-to-lead-hobby-projects",
        date: "2021-03-27",
        link: "https://speakerdeck.com/p1ass/technology-to-lead-hobby-projects",
        category_ids: [4, 12]
      },
      {
        title: "サーバーレスでclubhouse みたいなボイスチャットサービス「mixroom」を開発しました",
        stock: 242,
        media_name: "y-ohgi.blog",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fy-ohgi.blog%2Fentry%2Fmixroom",
        date: "2021-02-16",
        link: "https://y-ohgi.blog/entry/mixroom",
        category_ids: [37, 34, 28]
      },
      {
        title: "Rustでサイトを再実装",
        stock: 238,
        media_name: "r7kamura.com",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fr7kamura.com%2Farticles%2F2021-11-07-ruby-to-rust-at-this-site",
        date: "2021-11-07",
        link: "https://r7kamura.com/articles/2021-11-07-ruby-to-rust-at-this-site",
        category_ids: [68, 4]
      },
      {
        title: "「まずは小規模なゲームから」に聞き飽きた人のための中規模ゲーム制作手法",
        stock: 236,
        media_name: "note.com/metaformingpro",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fnote.com%2Fmetaformingpro%2Fn%2Fn670863432610",
        date: "2023-01-11",
        link: "https://note.com/metaformingpro/n/n670863432610",
        category_ids: [11, 12, 46]
      },
      {
        title: "個人開発のプロダクトにおけるクラウド料金のはなし - GCPの年間コストをランチ一回分に抑えた話",
        stock: 227,
        media_name: "shinyorke.hatenablog.com",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fshinyorke.hatenablog.com%2Fentry%2Fsolo-project-cost-2020",
        date: "2020-12-25",
        link: "https://shinyorke.hatenablog.com/entry/solo-project-cost-2020",
        category_ids: [34, 7, 44]
      },
      {
        title: "趣味の開発で使えるGitHubのブランチ運用",
        stock: 222,
        media_name: "thom.hateblo.jp",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fthom.hateblo.jp%2Fentry%2F2022%2F01%2F09%2F225345",
        date: "2022-01-10",
        link: "https://thom.hateblo.jp/entry/2022/01/09/225345",
        category_ids: [4, 12]
      },
      {
        title: "プラットフォームが初期ユーザーを集めるための８つの戦略と事例紹介",
        stock: 220,
        media_name: "note.com/kawanjin01",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fnote.com%2Fkawanjin01%2Fn%2Fn05749c1e4c55",
        date: "2023-01-02",
        link: "https://note.com/kawanjin01/n/n05749c1e4c55",
        category_ids: [12, 47]
      },
      {
        title: "個人開発アプリのFirebase費用を30%削減した話",
        stock: 219,
        media_name: "paranishian.hateblo.jp",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fparanishian.hateblo.jp%2Fentry%2F2020%2F05%2F31%2F180000",
        date: "2020-05-31",
        link: "https://paranishian.hateblo.jp/entry/2020/05/31/180000",
        category_ids: [37, 60]
      },
      {
        title: "30サービスを一挙公開！個人開発で使われている技術【特集】",
        stock: 216,
        media_name: "kojinkaihatu.com",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fkojinkaihatu.com%2F%3Fp%3D193",
        date: "2020-01-04",
        link: "https://kojinkaihatu.com/?p=193",
        category_ids: [12]
      },
      {
        title: "ゲームの個人開発者が細かいこと気にせず広告出してみた結果→大赤字になった実録漫画がためになる",
        stock: 196,
        media_name: "nlab.itmedia.co.jp",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fnlab.itmedia.co.jp%2Fnl%2Farticles%2F2106%2F18%2Fnews016.html",
        date: "2021-06-19",
        link: "https://nlab.itmedia.co.jp/nl/articles/2106/18/news016.html",
        category_ids: [47, 40, 11, 27]
      },
      {
        title: "Herokuにあった個人アプリを軒並み対応した",
        stock: 188,
        media_name: "sue445.hatenablog.com",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fsue445.hatenablog.com%2Fentry%2F2022%2F09%2F22%2F095346",
        date: "2022-09-22",
        link: "https://sue445.hatenablog.com/entry/2022/09/22/095346",
        category_ids: [8, 9, 19]
      },
      {
        title: "2020年に作ったソフトウェアや開発技術をふりかえる",
        stock: 177,
        media_name: "laiso.hatenablog.com",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Flaiso.hatenablog.com%2Fentry%2Feveryday-coding-2020",
        date: "2020-12-16",
        link: "https://laiso.hatenablog.com/entry/everyday-coding-2020",
        category_ids: [10, 52, 28, 15, 6, 35]
      },
      {
        title: "Next.js + Vercel + Supabase を用いた高速アプリ開発",
        stock: 176,
        media_name: "tech-blog.rakus.co.jp",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Ftech-blog.rakus.co.jp%2Fentry%2F20220928%2Fvercel",
        date: "2022-09-28",
        link: "https://tech-blog.rakus.co.jp/entry/20220928/vercel",
        category_ids: [28, 29, 66]
      },
      {
        title: "夫婦で結婚式の余興用クイズアプリを作った話",
        stock: 176,
        media_name: "zenn.dev",
        media_image: "https://youliangdao.s3.ap-northeast-1.amazonaws.com/logo-only.png",
        date: "2022-11-19",
        link: "https://zenn.dev/yui/articles/dfab1b18c3f62e",
        category_ids: [7, 21, 3, 32]
      },
      {
        title: "Heroku の無料プランが廃止されるようです",
        stock: 166,
        media_name: "zenn.dev",
        media_image: "https://youliangdao.s3.ap-northeast-1.amazonaws.com/logo-only.png",
        date: "2022-08-27",
        link: "https://zenn.dev/chizu_puzzle/articles/cf3692917fe78d",
        category_ids: [37, 34, 19, 44]
      },
      {
        title: "CloudFront+S3構成だった自分のサイトをCloudflare+R2に移行した",
        stock: 151,
        media_name: "blog.3qe.us",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fblog.3qe.us%2Fentry%2F2023%2F01%2F15%2F015921",
        date: "2023-01-15",
        link: "https://blog.3qe.us/entry/2023/01/15/015921",
        category_ids: [7, 67]
      },
      {
        title: "無料で使えるデータベースUpstashをご存知、ないのですか！？",
        stock: 128,
        media_name: "zenn.dev",
        media_image: "https://youliangdao.s3.ap-northeast-1.amazonaws.com/logo-only.png",
        date: "2022-05-06",
        link: "https://zenn.dev/tkithrta/articles/a56603a37b08f0",
        category_ids: [32, 67]
      },
      {
        title: "年間1000万PV達成までに作ったWebサービスやアプリ36個を、すべて振り返る",
        stock: 126,
        media_name: "note.com/retoruto_carry",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fnote.com%2Fretoruto_carry%2Fn%2Fn76e823abc0e5",
        date: "2020-04-14",
        link: "https://note.com/retoruto_carry/n/n76e823abc0e5",
        category_ids: [12, 27]
      },
      {
        title: "おいでよ 個人開発の沼",
        stock: 125,
        media_name: "note.com/nerd0geek1",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fnote.com%2Fnerd0geek1%2Fn%2Fn7b72fdf7c42d",
        date: "2020-03-23",
        link: "https://note.com/nerd0geek1/n/n7b72fdf7c42d",
        category_ids: [18, 12, 27]
      },
      {
        title: "Nuxt.js + Firebaseで釣具の管理サービスを作った",
        stock: 115,
        media_name: "www.to-r.net",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fwww.to-r.net%2Fmedia%2Fnuxt-firebase%2F",
        date: "2020-04-21",
        link: "https://www.to-r.net/media/nuxt-firebase/",
        category_ids: [10, 14, 37, 5]
      },
      {
        title: "【GAS x Vue.js】JavaScript のみで今、家計簿をつくるとしたら【ハンズオン付き！】",
        stock: 469,
        media_name: "qiita.com",
        media_image: "https://youliangdao.s3.ap-northeast-1.amazonaws.com/favicon.png",
        date: "2020-07-05",
        link: "https://qiita.com/matsu7089/items/6ea7931e97ae703f6607",
        category_ids: [13, 5, 26]
      },
      {
        title: "【OOUI】設計を改善したらユーザー（オカン）が使ってくれるアプリになった話",
        stock: 328,
        media_name: "qiita.com",
        media_image: "https://youliangdao.s3.ap-northeast-1.amazonaws.com/favicon.png",
        date: "2020-07-24",
        link: "https://qiita.com/hara_taku_/items/3b7c583592a11935a8a8",
        category_ids: [1, 18, 2]
      },
      {
        title: "「質問箱」を作った個人開発者・せせりさんの語る、「個人開発はおすすめしない」理由!?",
        stock: 101,
        media_name: "and-engineer.com",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fand-engineer.com%2Farticles%2FXxFL2hAAACQADWgo",
        date: "2020-07-22",
        link: "https://and-engineer.com/articles/XxFL2hAAACQADWgo",
        category_ids: [12, 27, 40, 2, 47]
      },
      {
        title: "僕の個人開発を成功に導いてくれた本たち",
        stock: 101,
        media_name: "blog.craftz.dog",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fblog.craftz.dog%2Fmy-best-book-recommendations-for-solo-developers-42e1acce13aa",
        date: "2022-04-30",
        link: "https://blog.craftz.dog/my-best-book-recommendations-for-solo-developers-42e1acce13aa",
        category_ids: [12, 42, 22, 47]
      },
      {
        title: "2022年版：OGPの正しい設定方法まとめ。確認方法や画像サイズも",
        stock: 95 * 1.5,
        media_name: "webdesign-trends.net",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fwebdesign-trends.net%2Fentry%2F12993",
        date: "2021-08-16",
        link: "https://webdesign-trends.net/entry/12993",
        category_ids: [1, 2]
      },
      {
        title: "Electron製アプリの起動速度を1,000ミリ秒速くする方法",
        stock: 94 * 1.5,
        media_name: "blog.craftz.dog",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fblog.craftz.dog%2Fhow-to-make-your-electron-app-launch-1000ms-faster-bcc2997fa1f7",
        date: "2020-08-12",
        link: "https://blog.craftz.dog/how-to-make-your-electron-app-launch-1000ms-faster-bcc2997fa1f7",
        category_ids: [5, 38]
      },
      {
        title: "10億円買収で話題のSkeb開発者なるがみさんに聞く、「クリエイターファースト」の開発やサービス設計の裏側と、買収の理由",
        stock: 92 * 1.5,
        media_name: "and-engineer.com",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fand-engineer.com%2Farticles%2FYD-X_REAACMAjwUR",
        date: "2021-03-04",
        link: "https://and-engineer.com/articles/YD-X_REAACMAjwUR",
        category_ids: [1, 2, 12, 47]
      },
      {
        title: "書籍『個人開発をはじめよう！』を出版しました",
        stock: 91 * 1.5,
        media_name: "yuzutas0.hatenablog.com",
        media_image:"https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fyuzutas0.hatenablog.com%2Fentry%2F2020%2F04%2F03%2F080000",
        date: "2020-04-03",
        link: "https://yuzutas0.hatenablog.com/entry/2020/04/03/080000",
        category_ids: [12]
      },
      {
        title: "RailsアプリをHerokuから移行するならどれがいいのか比較する",
        stock: 91 * 1.5,
        media_name: "blog.unasuke.com",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fterrateam.io%2Fblog%2Fflying-away-from-aws",
        date: "2022-05-29",
        link: "https://blog.unasuke.com/2022/compare-heroku-alternatives/",
        category_ids: [6, 19, 23]
      },
      {
        title: "Flying away from AWS",
        stock: 91 * 1.5,
        media_name: "terrateam.io",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fterrateam.io%2Fblog%2Fflying-away-from-aws",
        date: "2023-01-04",
        link: "https://terrateam.io/blog/flying-away-from-aws",
        category_ids: [7, 19]
      },
      {
        title: "中国で流行っているミニアプリが日本でも流行り始めているらしい",
        stock: 318,
        media_name: "qiita.com",
        media_image: "https://youliangdao.s3.ap-northeast-1.amazonaws.com/favicon.png",
        date: "2020-10-21",
        link: "https://qiita.com/yagi_eng/items/433fb34d635a454739d7",
        category_ids: [65]
      },
      {
        title: "エンジニアが個人開発したWebサービス・アプリ100個紹介します",
        stock: 86 * 1.5,
        media_name: "note.com/haken_se_30manen",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fnote.com%2Fhaken_se_30manen%2Fn%2Fn4f379cc91f11",
        date: "2020-07-06",
        link: "https://note.com/haken_se_30manen/n/n4f379cc91f11",
        category_ids: [12, 42, 47]
      },
      {
        title: "個人開発の副業にはFlutterが一番。リプレイスのポイントとアプリのグロースの考え方",
        stock: 81 * 1.5,
        media_name: "offers.jp",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Foffers.jp%2Fmedia%2Fsidejob%2Fworkstyle%2Fa_1889",
        date: "2020-11-05",
        link: "https://offers.jp/media/sidejob/workstyle/a_1889",
        category_ids: [18, 59]
      },
      {
        title: "個人開発の雑誌取材がボツになったので供養します",
        stock: 75 * 1.8,
        media_name: "yuzutas0.hatenablog.com",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fyuzutas0.hatenablog.com%2Fentry%2F2020%2F12%2F23%2F091500",
        date: "2020-12-23",
        link: "https://yuzutas0.hatenablog.com/entry/2020/12/23/091500",
        category_ids: [12, 27]
      },
      {
        title: "PMFのはかり方、見つけ方: やや実践編",
        stock: 74 * 1.8,
        media_name: "note.com/kenichiro_hara",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fnote.com%2Fkenichiro_hara%2Fn%2Fnec3b6d791039",
        date: "2020-01-29",
        link: "https://note.com/kenichiro_hara/n/nec3b6d791039",
        category_ids: [12, 47]
      },
      {
        title: "Next.js + Tailwind UI を使うとたった6時間で技術ブログのプロトタイプを作れる",
        stock: 74 * 1.8,
        media_name: "panda-program.com",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fpanda-program.com%2Fposts%2Ffrom-gatsby-to-nextjs",
        date: "2022-02-03",
        link: "https://panda-program.com/posts/from-gatsby-to-nextjs",
        category_ids: [28, 15, 51]
      },
      {
        title: "Herokuの無料枠が廃止になるのでDeta.shへ移行する",
        stock: 348,
        media_name: "qiita.com",
        media_image: "https://youliangdao.s3.ap-northeast-1.amazonaws.com/favicon.png",
        date: "2022-08-29",
        link: "https://qiita.com/namachan/items/b8c1ee89dc091d656d4f",
        category_ids: [21, 19]
      },
      {
        title: "低コストで高可用性を実現する",
        stock: 63 * 2,
        media_name: "voluntas.medium.com",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fvoluntas.medium.com%2F%25E4%25BD%258E%25E3%2582%25B3%25E3%2582%25B9%25E3%2583%2588%25E3%2581%25A7%25E9%25AB%2598%25E5%258F%25AF%25E7%2594%25A8%25E6%2580%25A7%25E3%2582%2592%25E5%25AE%259F%25E7%258F%25BE%25E3%2581%2599%25E3%2582%258B-b43b96caf87",
        date: "2022-06-02",
        link: "https://voluntas.medium.com/%E4%BD%8E%E3%82%B3%E3%82%B9%E3%83%88%E3%81%A7%E9%AB%98%E5%8F%AF%E7%94%A8%E6%80%A7%E3%82%92%E5%AE%9F%E7%8F%BE%E3%81%99%E3%82%8B-b43b96caf87",
        category_ids: [27, 67]
      },
      {
        title: "Cloud Runで手軽にサーバーレス・SSR(サーバーサイドレンダリング)",
        stock: 48 * 3,
        media_name: "tech.dely.jp",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Ftech.dely.jp%2Fentry%2F2020%2F12%2F12%2F132304",
        date: "2020-12-12",
        link: "https://tech.dely.jp/entry/2020/12/12/132304",
        category_ids: [34, 8]
      },
      {
        title: "タグ1つでブログを収益化できる投げ銭サービスを支える技術",
        stock: 166,
        media_name: "qiita.com",
        media_image: "https://youliangdao.s3.ap-northeast-1.amazonaws.com/favicon.png",
        date: "2020-10-19",
        link: "https://qiita.com/yoshinori_hisakawa/items/1359c8f541cc6b7252e4",
        category_ids: [61, 63, 37]
      },
      {
        title: "Meow Attack（ニャー攻撃）で稼働中WebアプリのAWS S3保存画像を全削除されてしまった…",
        stock: 49 * 3,
        media_name: "fuyu.hatenablog.com",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Ffuyu.hatenablog.com%2Fentry%2F2020%2F09%2F21%2F214449",
        date: "2020-09-21",
        link: "https://fuyu.hatenablog.com/entry/2020/09/21/214449",
        category_ids: [7, 40]
      },
      {
        title: "Azure の無料枠のあるサーバーレス系サービスだけで WebSocket (SignalR)",
        stock: 49 * 3,
        media_name: "qiita.com",
        media_image: "https://youliangdao.s3.ap-northeast-1.amazonaws.com/favicon.png",
        date: "2020-03-15",
        link: "https://qiita.com/okazuki/items/8c8e438e88d7da8d14f8",
        category_ids: [44]
      },
      {
        title: "育児とキャリア両立の呪いを解く魔法、それは個人開発",
        stock: 133,
        media_name: "note.com/natsumican63",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fnote.com%2Fnatsumican63%2Fn%2Fne2ce51c129f2",
        date: "2022-12-15",
        link: "https://note.com/natsumican63/n/ne2ce51c129f2",
        category_ids: [27]
      },
      {
        title: "野球ではじめる機械学習 - 特徴量エンジニアリングとPython, Rを用いた成績予測",
        stock: 51 * 2.5,
        media_name: "shinyorke.hatenablog.com",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fshinyorke.hatenablog.com%2Fentry%2Fbaseball-and-ml-with-python",
        date: "2020-08-28",
        link: "https://shinyorke.hatenablog.com/entry/baseball-and-ml-with-python",
        category_ids: [21, 36]
      },
      {
        title: "Next.jsとFirebaseで質問箱のようなサービスを作る",
        stock: 348,
        media_name: "zenn.dev",
        media_image: "https://youliangdao.s3.ap-northeast-1.amazonaws.com/logo-only.png",
        date: "2020-10-14",
        link: "https://zenn.dev/dala/books/nextjs-firebase-service",
        category_ids: [28, 32, 37]
      },
      {
        title: "25名の個人開発者による個人開発のリアルをまとめた本",
        stock: 53 * 2.5, 
        media_name: "www.mojiru.com",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fwww.mojiru.com%2Fentry%2FStart-personal-development",
        date: "2020-04-11",
        link: "https://www.mojiru.com/entry/Start-personal-development",
        category_ids: [12]
      },
      {
        title: "通話サービス「TwiCall」の個人開発者と買収企業、両者が語る開発とスピード事業譲渡の裏側",
        stock: 55 * 2.5,
        media_name: "and-engineer.com",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fand-engineer.com%2Farticles%2FX0XoJREAACMAHGUQ",
        date: "2020-09-09",
        link: "https://and-engineer.com/articles/X0XoJREAACMAHGUQ",
        category_ids: [12, 47]
      },
      {
        title: "サウナー御用達のスタートアップ「サウナイキタイ」が既に黒字化。「趣味で起業する」という選択に、心も整う。",
        stock: 55 * 2.5,
        media_name: "suan.tokyo",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fsuan.tokyo%2Fsuan_sauna%2F",
        date: "2023-01-16",
        link: "https://suan.tokyo/suan_sauna/",
        category_ids: [12, 47, 42]
      },
      {
        title: "metaタグに記述するソーシャルメディアや検索用のコードをまとめて簡単に生成できるオンラインツール -Meta Tags",
        stock: 55 * 2.5,
        media_name: "coliss.com",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fcoliss.com%2Farticles%2Fbuild-websites%2Foperation%2Fwork%2Fmeta-tags-generator.html",
        date: "2020-10-12",
        link: "https://coliss.com/articles/build-websites/operation/work/meta-tags-generator.html",
        category_ids: [73, 64, 1]
      },
      {
        title: "2021年に作ったモノや技術をふりかえる",
        stock: 61 * 2,
        media_name: "laiso.hatenablog.com",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Flaiso.hatenablog.com%2Fentry%2F2021%2F12%2F24%2Ftech2021",
        date: "2021-12-24",
        link: "https://laiso.hatenablog.com/entry/2021/12/24/tech2021",
        category_ids: [12]
      },
      {
        title: "【Flutter】メモアプリ開発で使ったオススメのパッケージを紹介",
        stock: 152,
        media_name: "qiita.com",
        media_image: "https://youliangdao.s3.ap-northeast-1.amazonaws.com/favicon.png",
        date: "2020-07-02",
        link: "https://qiita.com/YuKiO-OO/items/283f44da64d304a6228e",
        category_ids: [59, 18, 37, 56]
      },
      {
        title: "個人開発してるサービスをExpressからNext.jsにしたり、BusBoyを使った話しなど",
        stock: 44 * 3,
        media_name: "blog.h13i32maru.jp",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fblog.h13i32maru.jp%2Fentry%2F2022%2F08%2F15%2F160835",
        date: "2022-08-15",
        link: "https://blog.h13i32maru.jp/entry/2022/08/15/160835",
        category_ids: [3, 28, 34, 37]
      },
      {
        title: "個人開発アプリは戦闘能力に合った課金モデルを決めてから企画しよう",
        stock: 43 * 3,
        media_name: "jabba.cloud",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fjabba.cloud%2F20200227-monetization",
        date: "2020-02-27",
        link: "https://jabba.cloud/20200227-monetization",
        category_ids: [12, 47]
      },
      {
        title: "RustのサーバレスプラットフォームShuttleを使ってみる",
        stock: 35 * 3,
        media_name: "dev.classmethod.jp",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fdev.classmethod.jp%2Farticles%2Frust-shuttle%2F",
        date: "2022-10-11",
        link: "https://dev.classmethod.jp/articles/rust-shuttle/",
        category_ids: [68]
      },
      {
        title: "Cloudflare Workers + KV + honoで簡単なAPIサーバを作る",
        stock: 43 * 3,
        media_name: "zenn.dev",
        media_image: "https://youliangdao.s3.ap-northeast-1.amazonaws.com/logo-only.png",
        date: "2022-05-16",
        link: "https://zenn.dev/razokulover/articles/ac84a141abee86",
        category_ids: [32, 67]
      },
      {
        title: "エンジニアによるラノベ執筆におけるデプロイ",
        stock: 40 * 3,
        media_name: "zenn.dev",
        media_image: "https://youliangdao.s3.ap-northeast-1.amazonaws.com/logo-only.png",
        date: "2021-04-18",
        link: "https://zenn.dev/uakihir0/articles/210418-kakudake-beta",
        category_ids: [28, 57]
      },
      {
        title: "政府の接触確認アプリ(COCOA)の機能を補完するアプリを作ってみた(3密チェッカー)",
        stock: 61,
        media_name: "qiita.com",
        media_image: "https://youliangdao.s3.ap-northeast-1.amazonaws.com/favicon.png",
        date: "2020-07-14",
        link: "https://qiita.com/Rabbit_Program/items/3c1aec6e30eb646d78a1",
        category_ids: [56]
      },
      {
        title: "たった2週間で作ったWebサービスで月11万円の売上を達成した話【個人開発】",
        stock: 15 * 5,
        media_name: "note.com/_hiro_dev",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fnote.com%2F_hiro_dev%2Fn%2Fn3332c056a65a",
        date: "2020-09-26",
        link: "https://note.com/_hiro_dev/n/n3332c056a65a",
        category_ids: [12, 47]
      },
      {
        title: "無料で高速にWeb系個人開発するための技術スタック2022（主観）",
        stock: 15 * 5,
        media_name: "rubiq.vercel.app",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Frubiq.vercel.app%2Fblog%2Findie-hacking-stack",
        date: "2022-08-17",
        link: "https://rubiq.vercel.app/blog/indie-hacking-stack",
        category_ids: [28, 29, 37, 12]
      },
      {
        title: "「コツコツ」は大化けする！力を抜きつつ個人開発を成功させる秘訣",
        stock: 14 * 5,
        media_name: "blog.craftz.dog",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fblog.craftz.dog%2Ffocus-on-the-existing-users-657ad2dde503",
        date: "2020-12-25",
        link: "https://blog.craftz.dog/zero-to-sold-story-of-shingo-irie-f5c045c0d4bb",
        category_ids: [12, 27]
      },
      {
        title: "個人開発アプリで既存ユーザを喜ばせる事に3.5年集中した",
        stock: 14 * 5,
        media_name: "blog.craftz.dog",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fblog.craftz.dog%2Ffocus-on-the-existing-users-657ad2dde503",
        date: "2020-04-02",
        link: "https://blog.craftz.dog/foster-customer-loyalty-3f214a786f9e",
        category_ids: [12, 47]        
      },
      {
        title: "離脱率を下げろ！個人開発でユーザ数１万人を達成する方法",
        stock: 14 * 5,
        media_name: "blog.craftz.dog",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fblog.craftz.dog%2Ffocus-on-the-existing-users-657ad2dde503",
        date: "2020-04-02",
        link: "https://blog.craftz.dog/focus-on-the-existing-users-657ad2dde503",
        category_ids: [12, 47]        
      },
      {
        title: "アイデアだけでイノベーションは起きない。ネゴって結果を出す方法",
        stock: 14 * 5,
        media_name: "www.lifehacker.jp",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fwww.lifehacker.jp%2Farticle%2Fbook_to_read-472%2F",
        date: "2020-02-07",
        link: "https://www.lifehacker.jp/article/book_to_read-472/",
        category_ids: [12, 42]
      },
      {
        title: "イケてる個人開発の進め方",
        stock: 13 * 5, 
        media_name: "www.docswell.com",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fwww.docswell.com%2Fs%2F6649915%2FZG7885-yuno_miyako",
        date: "2022-09-30",
        link: "https://www.docswell.com/s/6649915/ZG7885-yuno_miyako",
        category_ids: [12, 42]
      },
      {
        title: "自分のデータ分析のためにRedashを構築した話 - 個人開発におけるデータ分析環境つくりとコストについて",
        stock: 12 * 5,
        media_name: "shinyorke.hatenablog.com",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fshinyorke.hatenablog.com%2Fentry%2Fpersonal-redash",
        date: "2021-04-11",
        link: "https://shinyorke.hatenablog.com/entry/personal-redash",
        category_ids: [34, 36]
      },
      {
        title: "起動率20%以上！『まりも』の開発者に聞く！長寿アプリの人気の秘訣と個人開発の極意とは？",
        stock: 12 * 5,
        media_name: "magazine.fluct.jp",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fmagazine.fluct.jp%2F2020%2F05%2F20%2F7392",
        date: "2020-05-20",
        link: "https://magazine.fluct.jp/2020/05/20/7392/",
        category_ids: [59, 47, 27]
      },
      {
        title: "「人生の振り返り」から、今回の技術書典で出した「個人Webサービスシステム構成事典」につながるまでの話",
        stock: 8 * 7,
        media_name: "nabettu.com",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fnabettu.com%2F5dc14d0e1de44a81adf274030f94ac18",
        date: "2020-09-15",
        link: "https://nabettu.com/5dc14d0e1de44a81adf274030f94ac18",
        category_ids: [12, 27]
      },
      {
        title: "【誰でも簡単】RailsアプリをRender.comでデプロイする手順まとめ",
        stock: 20 * 3,
        media_name: "qiita.com",
        media_image: "https://youliangdao.s3.ap-northeast-1.amazonaws.com/favicon.png",
        date: "2022-05-04",
        link: "https://qiita.com/koki_73/items/60b327a586129d157f38",
        category_ids: [6, 19]
      },
      {
        title: "個人開発サービスのプラットフォーム選びと宣伝方法についてまとめてみました。",
        stock: 5 * 10,
        media_name: "crieit.net",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fcrieit.net%2Fposts%2Fb5e2706deca4e0ec137d50af81775688",
        date: "2020-12-18",
        link: "https://crieit.net/posts/b5e2706deca4e0ec137d50af81775688",
        category_ids: [12, 47]
      },
      {
        title: "個人でWebサービスやアプリを作っても儲けられませんか？かなり難しいですか？",
        stock: 5 * 10,
        media_name: "jp.quora.com",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fjp.quora.com%2F%25E5%2580%258B%25E4%25BA%25BA%25E3%2581%25A7Web%25E3%2582%25B5%25E3%2583%25BC%25E3%2583%2593%25E3%2582%25B9%25E3%2582%2584%25E3%2582%25A2%25E3%2583%2597%25E3%2583%25AA%25E3%2582%2592%25E4%25BD%259C%25E3%2581%25A3%25E3%2581%25A6%25E3%2582%2582%25E5%2584%25B2%25E3%2581%2591%25E3%2582%2589%25E3%2582%258C%25E3%2581%25BE%25E3%2581%259B%25E3%2582%2593",
        date: "2021-09-09",
        link: "https://jp.quora.com/%E5%80%8B%E4%BA%BA%E3%81%A7Web%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9%E3%82%84%E3%82%A2%E3%83%97%E3%83%AA%E3%82%92%E4%BD%9C%E3%81%A3%E3%81%A6%E3%82%82%E5%84%B2%E3%81%91%E3%82%89%E3%82%8C%E3%81%BE%E3%81%9B%E3%82%93",
        category_ids: [47]
      },
      {
        title: "個人開発しているWebアプリはどれくらい収益があるものでしょうか？月間100万PVのサイトを運営している知人が広告収入だけでサーバー代を払える程度と言っていました。本当ならあまりに夢がないですよね？",
        stock: 7 * 8,
        media_name: "jp.quora.com",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fjp.quora.com%2F%25E5%2580%258B%25E4%25BA%25BA%25E3%2581%25A7Web%25E3%2582%25B5%25E3%2583%25BC%25E3%2583%2593%25E3%2582%25B9%25E3%2582%2584%25E3%2582%25A2%25E3%2583%2597%25E3%2583%25AA%25E3%2582%2592%25E4%25BD%259C%25E3%2581%25A3%25E3%2581%25A6%25E3%2582%2582%25E5%2584%25B2%25E3%2581%2591%25E3%2582%2589%25E3%2582%258C%25E3%2581%25BE%25E3%2581%259B%25E3%2582%2593",
        date: "2020-10-21",
        link: "https://jp.quora.com/%E5%80%8B%E4%BA%BA%E9%96%8B%E7%99%BA%E3%81%97%E3%81%A6%E3%81%84%E3%82%8BWeb%E3%82%A2%E3%83%97%E3%83%AA%E3%81%AF%E3%81%A9%E3%82%8C%E3%81%8F%E3%82%89%E3%81%84%E5%8F%8E%E7%9B%8A%E3%81%8C%E3%81%82%E3%82%8B%E3%82%82",
        category_ids: [27]
      },
      {
        title: "Vercelで無料のError通知サーバーを作ったら便利だった",
        stock: 7 * 8,
        media_name: "blog.ojisan.io",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fblog.ojisan.io%2Ffree-error-notification%2F",
        date: "2021-04-09",
        link: "https://blog.ojisan.io/free-error-notification/",
        category_ids: [29, 74]
      },
      {
        title: "オカンとオトンから学んだOOUIデザイン設計",
        stock: 8 * 7,
        media_name: "speakerdeck.com/takusami",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fspeakerdeck.com%2Ftakusami%2Fokantootonkaraxue-ntaoouitesainshe-ji",
        date: "2020-07-24",
        link: "https://speakerdeck.com/takusami/okantootonkaraxue-ntaoouitesainshe-ji?slide=22",
        category_ids: [1, 2]
      },
      {
        title: "個人開発アプリを有料プレスリリース（3万円）で宣伝してわかったこと",
        stock: 32 * 2,
        media_name: "note.com/studynow",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fnote.com%2Fstudynow%2Fn%2Fn61a81a179ffb",
        date: "2021-03-21",
        link: "https://note.com/studynow/n/n61a81a179ffb",
        category_ids: [12, 27, 47]
      },
      {
        title: "Next.jsとサーバレスAPIで自分のブログを作った話",
        stock: 3 * 17,
        media_name: "blog.hozi.dev",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fblog.hozi.dev%2Fhozi576%2Farticles%2F01f07hctzhjcwtdq4h6ew9stk8",
        date: "2021-03-08",
        link: "https://blog.hozi.dev/hozi576/articles/01f07hctzhjcwtdq4h6ew9stk8",
        category_ids: [28, 37, 4]
      },
      {
        title: "APIを探して、試して、使える - APIbank",
        stock: 3 * 17,
        media_name: "www.apibank.jp",
        media_image: "https://cdn-ak2.favicon.st-hatena.com/64?url=https%3A%2F%2Fwww.apibank.jp%2FApiBank%2Fm%2Fapi%3Fcategory_no%3D0",
        date: "2022-07-18",
        link: "https://www.apibank.jp/ApiBank/api?category_no=0",
        category_ids: [78]
      }
    ]

    hatena_data.each do |hatena_article|
      image = LinkThumbnailer.generate("#{hatena_article[:link]}").images.first.src.to_s 
      article = Article.create!(
        link: hatena_article[:link],
        title: hatena_article[:title],
        date: hatena_article[:date],
        stock: hatena_article[:stock],
        media_name: hatena_article[:media_name],
        media_image: hatena_article[:media_image],
        image: image
      )
      hatena_article[:category_ids].each do |category_id|
        CategoryMap.create(article_id: article["id"], category_id: category_id)
      end
    end
  end

end
