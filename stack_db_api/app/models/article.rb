# == Schema Information
#
# Table name: articles
#
#  id          :bigint           not null, primary key
#  date        :string           not null
#  image       :string           not null
#  link        :string           not null
#  media_image :string           not null
#  media_name  :string           not null
#  stock       :integer          not null
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  item_id     :string
#
# Indexes
#
#  index_articles_on_link  (link) UNIQUE
#
class Article < ApplicationRecord
  has_many :category_maps, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :categories, through: :category_maps, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  scope :popular, -> { where("stock > ?", 100).order(stock: :desc) }
  scope :recent, -> { order(date: :desc) }

  validates :link,    presence: true, uniqueness: true
  validates :title,   presence: true
  validates :date,    presence: true
  validates :stock,   presence: true

  def self.genre(genre_name)
    articles = case genre_name
    when "beginner"
      links = [
        "https://qiita.com/terubooon/items/08c145aac0dd10ea8cbc",
        "https://qiita.com/shinshin86/items/9ddf658b7f12060bb883",
        "https://qiita.com/himatani/items/3b8301da2e889e962e5e",
        "https://qiita.com/asdfasdfkjlfas/items/e7d60859a4d1b4c0658f",
        "https://qiita.com/jabba/items/1a49e860a09a613b09d4",
        "https://qiita.com/nuko-suke/items/652366597ce2ce0a91f9",
        "https://qiita.com/yuno_miyako/items/d6595719ae7065927499",
        "https://qiita.com/masaibar/items/fdc1a7ee46de0edcd612",
        "https://zenn.dev/kazuwombat/articles/c1bc244f2cc803",
        "https://qiita.com/eri/items/d8e16aa5ad11a9bbcaef",
        "https://zenn.dev/takuho/articles/3390a9ba28b325",
        "https://qiita.com/isotai/items/5a054bf766532c3ed375",
        "https://qiita.com/igz0/items/9f09aa6f61c1eeb808f7",
        "https://qiita.com/UTOG/items/9aac4880463df5ac9d4d",
        "https://qiita.com/PonPon3/items/5ccfb487c6f49e438d63",
        "https://zenn.dev/imaginelab/articles/9100213e2a6987",
        "https://zenn.dev/nameless_sn/articles/awesome_personal_devlopment",
        "https://qiita.com/yuno_miyako/items/03371e4af95d6fc56a12",
        "https://qiita.com/z_ohnami/items/17d58bb05fd1c5ffa4fc",
        "https://zenn.dev/nobezawa/articles/knowledge-personal-developer",
        "https://qiita.com/naruqiita/items/f8b11b7d062effb2cc3c",
        "https://qiita.com/raajia_zerusen/items/7b60cb0034ad3b8c1161",
        "https://zenn.dev/cococig/articles/41a180beca5e99",
        "https://zenn.dev/h_sakano/articles/eaec32b780685e",
        "https://qiita.com/noranuk0/items/96e83cee1e448cd57569",
        "https://qiita.com/smak0412/items/18fe54661ad70ba96d3c",
        "https://qiita.com/satouta310ta/items/79407647a6405be969e8",
        "https://qiita.com/yoshinori_hisakawa/items/caaf6acd7d979b7d7c01",
        "https://qiita.com/alclimb/items/a2a3fcfed921697fe68b",
        "https://qiita.com/Ken227/items/822851aaca0fd9b3cf72",
        "https://zenn.dev/manalink_dev/articles/5ae6cf3ad6fae4",
        "https://qiita.com/okmttdhr/items/6a3e4ff989604129324d",
        "https://qiita.com/damuha/items/907f1ec24fa0ca96d3ff",
      ]
      Article.where(link: links)
    when "idea"
      Article.where(link: [
        "https://qiita.com/asdfasdfkjlfas/items/e7d60859a4d1b4c0658f",
        "https://qiita.com/ampersand-dev/items/f20e78896b868e9f2eb1",
        "https://qiita.com/MasatoraAtarashi/items/eec4642fe1e6ce79304d",
        "https://qiita.com/svfreerider/items/9f2718fb573cf35dff93",
        "https://qiita.com/yassun-youtube/items/fb65540922900898e074",
        "https://zenn.dev/hal1986/articles/20201208-consideration-for-app-creating",
        "https://qiita.com/naruqiita/items/77e5cf5dd84d5e6a82fd",
        "https://qiita.com/naruqiita/items/f87aa7781b311682df87",
        "https://qiita.com/naruqiita/items/65d3560e3bf8a88e80ac",
        "https://qiita.com/naruqiita/items/f8773efc49651c457cb3",
        "https://qiita.com/taqro/items/a8e2b4a2508ed6d4ff1d",
        "https://qiita.com/aiandrox/items/20973aa7f65662579105",
        "https://zenn.dev/naruhiro/articles/0dde2b2a195d8b",
        "https://zenn.dev/retoruto_carry/articles/eaef7a95125586",
        "https://zenn.dev/yui/articles/e5a5cf7b63e373",
        "https://zenn.dev/nameless_sn/articles/programming-idea",
        "https://zenn.dev/7oh/articles/dbed51c8a6462e"
      ])
    when "design"
      Article.where(link: [
        "https://qiita.com/aiandrox/items/4196c8f5b564d29fdce7",
        "https://qiita.com/tkdayo/items/5701013735c667d4cf03",
        "https://qiita.com/KNR109/items/78b3ca7cae7615dac0b0",
        "https://qiita.com/bo_zu_/items/88f45b132c8293dcd9b1",
        "https://qiita.com/bo_zu_/items/0c09f789c5804132f1ad",
        "https://zenn.dev/nameless_sn/articles/awesome_sites_for_development",
        "https://zenn.dev/herishiro/articles/77646de287f88b",
        "https://qiita.com/herishiro/items/1f595fcd19e369c5895c",
        "https://zenn.dev/hiromu617/articles/c03fef6f4d6c6e"
      ])
    when "architecture"
      Article.where(link: [
        "https://qiita.com/you8/items/670bfa6573cec2494c96",
        "https://zenn.dev/kazu777/articles/7b01cb8cec08fb",
        "https://qiita.com/yuno_miyako/items/fad33456d9c32d8f4483",
        "https://qiita.com/Shogo1222/items/8b8fc4c65632844a453f",
        "https://qiita.com/howdy39/items/ac4c19dd36cd182841bc",
        "https://zenn.dev/shwld/articles/e624486c2a1208",
        "https://zenn.dev/imah/articles/3c587fb6d29eb7",
        "https://qiita.com/kobayashi-m42/items/fbacb46f7603e5a014d7",
        "https://qiita.com/43z708/items/b56a4f30e337c708e387",
        "https://qiita.com/kurawo___D/items/f2dc43f4541b8abf576c",
        "https://qiita.com/aki0151/items/f39ef43c9d9fc1b87d9a",
        "https://qiita.com/tomoya_sakusaku/items/49043ee7a5d5707d219d",
        "https://qiita.com/yamadagenki/items/f2f294aa3e4cb9c19c03",
        "https://qiita.com/hirohero/items/1eaa22b7f87eb66b2f2d",
        "https://qiita.com/nh321/items/0373a740e56fad6a49d8",
        "https://qiita.com/nh321/items/e8c63b02e3fa9c28837f",
        "https://qiita.com/hassoubeat/items/b91e24fc249497ea8582",
        "https://qiita.com/hassoubeat/items/aaf9a8041fee7bcfbffc",
        "https://qiita.com/y_kawase/items/fb9f747d88af151f981a",
        "https://qiita.com/kobayashi-m42/items/ebc399df258a69b8c76b",
        "https://qiita.com/kyogom/items/89eb60c3c98a3087df4a",
        "https://qiita.com/maru401/items/8e7d32a8baded045adb2",
        "https://zenn.dev/foxtail88/articles/7ea20168cc597d",
        "https://qiita.com/wonderglot/items/cf0d4faa77b925960802",
        "https://qiita.com/naruqiita/items/f9b36a2d910812d3f160",
        "https://zenn.dev/at946/articles/8bfe9768393b64",
        "https://zenn.dev/eringiv3/articles/c44d5400e5603e",
        "https://zenn.dev/teasy/articles/tcpexposer-tech",
        "https://qiita.com/mycndev/items/fc7a8fecd7d0b0d09828",
        "https://zenn.dev/nameless_sn/articles/web_selection",
        "https://zenn.dev/eternaleight/articles/8f802e58aa9d04",
        "https://zenn.dev/hand_dot/articles/63b56496671cc0"
      ])
    when "release"
      Article.where(link: [
        "https://qiita.com/freelance-jak/items/2348d0e52ce2eb8ef47c",
        "https://qiita.com/ikuosaito1989/items/61b285ce200257047cef",
        "https://qiita.com/UTOG/items/c77c75a6aa61ee93fc6d",
        "https://qiita.com/ShotaroHirose59/items/62714bb684cf499059a1",
        "https://zenn.dev/amakawa_yuki/articles/1a37cbfa01b1ab",
        "https://zenn.dev/hyodoblog/articles/559d5e59dd37b8",
        "https://zenn.dev/manalink_dev/articles/5ae6cf3ad6fae4",
        "https://zenn.dev/cococig/articles/41a180beca5e99",
        "https://qiita.com/Tyamamoto1007/items/fc06004938cc1e761d96",
        "https://zenn.dev/sabigara/articles/4a4866fece771d",
        "https://zenn.dev/h_sakano/articles/eaec32b780685e",
        "https://qiita.com/yuno_miyako/items/6e5ffa31800e05781e7c",
        "https://zenn.dev/yamatake/articles/b93d87ed134f31",
        "https://qiita.com/Tyamamoto1007/items/050a1d42c18541de1a83",
        "https://qiita.com/yuno_miyako/items/54d3c57775e9310a3745",
        "https://qiita.com/nasuB7373/items/e2c5e16a824b11610b7e",
        "https://qiita.com/PonPon3/items/5ccfb487c6f49e438d63",
        "https://zenn.dev/nice2have/articles/120b1df8fcea2a",
        "https://qiita.com/UTOG/items/995b7caa50b0f8475951",
        "https://qiita.com/satouta310ta/items/79407647a6405be969e8",
        "https://qiita.com/nasuB7373/items/10bebd8e9f0b3331f348",
        "https://qiita.com/maKunugi/items/86afc7e12fc96c709c84",
        "https://qiita.com/asdfasdfkjlfas/items/e7d60859a4d1b4c0658f",
        "https://qiita.com/yoshinori_hisakawa/items/caaf6acd7d979b7d7c01",
        "https://qiita.com/terubooon/items/08c145aac0dd10ea8cbc",
        "https://qiita.com/aiiro_swift/items/fe27eae6e708b187d341",
        "https://qiita.com/kinmi/items/ce39b52ff712098431c4",
        "https://qiita.com/shinshin86/items/9ddf658b7f12060bb883",
        "https://qiita.com/aocory/items/133c569e99f3890647bd",
        "https://qiita.com/appxxx77/items/e8b5796cfdd27104e345",
        "https://qiita.com/jabba/items/1a49e860a09a613b09d4",
        "https://qiita.com/you8/items/f943b324f966ff01214e",
        "https://qiita.com/eri/items/d8e16aa5ad11a9bbcaef"
      ])
    when "backend"
      Article.where(link: [
        'https://qiita.com/aki0151/items/f39ef43c9d9fc1b87d9a',
        'https://qiita.com/ddpmntcpbr/items/739dbb992b5ffac3fc2f',
        'https://qiita.com/ryamate/items/c3b4f63f8d94ab090bf8',
        'https://qiita.com/nasuB7373/items/0e507abad2017976c407',
        'https://qiita.com/yoshi_yast/items/3c381099aeb7ee001054',
        'https://qiita.com/an_riri88/items/ba8220234ab2da7d3787',
        "https://qiita.com/shuhei_m/items/292699e76dbd206a2462",
        "https://qiita.com/yukiHaga/items/8ef2051036e126eb00c6",
        "https://qiita.com/taku99/items/a489ae43afc231bc4a8e",
        "https://qiita.com/ashketcham/items/8ab3626feb9b4228f358",
        "https://qiita.com/kuromitsu0104/items/dc0021a20100e11f2f7d",
        "https://qiita.com/momonga11/items/a1ec7f1e876c7f448db7",
        "https://qiita.com/kapureka6174/items/0e84fd6cfb09ddccc71f",
        "https://qiita.com/shimotaroo/items/409e77dfb121dd40ac1d",
        "https://qiita.com/nakaji0210/items/fdbde62df4394ddcaf11",
        "https://qiita.com/43z708/items/b56a4f30e337c708e387",
        "https://qiita.com/Hizuraky/items/0b4e4e7daf595326e006",
        "https://qiita.com/uichi/items/5473e22a5faee86fd5e5",
        "https://zenn.dev/nameless_sn/articles/why_django_development",
        "https://qiita.com/eJkn6IQUjtHGVdb/items/9f6fb2b8718c56b73938",
        "https://qiita.com/tf0101/items/c63157435ae1eebeb8bc",
        "https://qiita.com/mtitg/items/420c357168fb9db44b4d",
        "https://qiita.com/choo/items/2efacb2f94f6c9c46417",
        "https://zenn.dev/kangetsu_121/articles/d99e8306c0d895",
        "https://zenn.dev/keinstn/articles/gotoawaji-architecture",
        "https://zenn.dev/7oh/articles/dbed51c8a6462e",
        "https://zenn.dev/wheatandcat/articles/20220503-memoir",
        "https://zenn.dev/mrasu/articles/1cd771c09f29ef",
        "https://qiita.com/jindotjp/items/5156117a9a1695a7d54f",
        "https://qiita.com/kata-n/items/a8ba0a7ad6fe8ac36347",
        "https://qiita.com/kumaGoro_95/items/ad561e3e93ad61b2e63c",
        "https://qiita.com/YumNumm/items/32ffcced7193e11930d9",
        "https://qiita.com/kira_puka/items/ef7dd47519403cd9bcf2"
      ])
    when "frontend"
      Article.where(link: [
        "https://zenn.dev/meijin/articles/personal-development-release-and-paid-story",
        "https://zenn.dev/takuho/articles/3390a9ba28b325",
        "https://zenn.dev/karugamo/articles/bb7477d1e7a648",
        "https://qiita.com/freelance-jak/items/2348d0e52ce2eb8ef47c",
        "https://qiita.com/ddpmntcpbr/items/739dbb992b5ffac3fc2f",
        "https://qiita.com/poly_soft/items/d19f877583c424d07696",
        "https://qiita.com/howdy39/items/ac4c19dd36cd182841bc",
        "https://qiita.com/ok-bokujou/items/38393da89bc14eaa5c34",
        "https://zenn.dev/karugamo/articles/8ff8ecabebc602",
        "https://qiita.com/Hizuraky/items/57b9dceaeb2cad9a4d7a",
        "https://qiita.com/Yuhsak/items/03967437b8a6438eb625",
        "https://zenn.dev/cp20/articles/no-log-chat-app",
        "https://qiita.com/smak0412/items/18fe54661ad70ba96d3c",
        "https://zenn.dev/sukesan0720/articles/d7b1bb2ca7bdf1",
        "https://qiita.com/mycndev/items/757cf6932b8687a06e36",
        "https://zenn.dev/hand12/articles/cda94bd738fb0c",
        "https://zenn.dev/syu/articles/d42276d106e07f",
        "https://zenn.dev/steelydylan/articles/blog-friends",
        "https://qiita.com/nuko-suke/items/22702472543bfd3e585f",
        "https://qiita.com/y_kawase/items/fb9f747d88af151f981a",
        "https://qiita.com/yuneco/items/b14a695a060c96309239",
        "https://zenn.dev/mirumi/articles/how-far-can-i-go",
        "https://qiita.com/p1ass/items/a01578b782f17f573510",
        "https://qiita.com/KenRoda/items/87bff03e4c4b9470e6a8",
        "https://qiita.com/kobayashi-m42/items/14e137727ffda3bf79e7",
        "https://qiita.com/KIYS/items/8035763122a790e093e6",
        "https://qiita.com/yoshi_yast/items/3c381099aeb7ee001054",
        "https://qiita.com/retoruto_carry/items/0d427e24ed7ba6d4d6e7",
        "https://qiita.com/Yuta_Fujiwara/items/473a79ea2d0fb68d1642",
        "https://qiita.com/ok-bokujou/items/a0c3c5233749e6e32abc",
        "https://qiita.com/hand12/items/2ea01a99b44a43235bb4",
        "https://qiita.com/HYuta999/items/28f1526447637ad87941",
        "https://zenn.dev/mirumi/articles/sluuuuug-slaaaaag",
        "https://qiita.com/43z708/items/b56a4f30e337c708e387",
        "https://qiita.com/aki0151/items/f39ef43c9d9fc1b87d9a",
        "https://qiita.com/bonji/items/dab124e871a1a154beb6",
        "https://qiita.com/yuneco/items/444abd3f40d53ce7d078",
        "https://qiita.com/retoruto_carry/items/62b890341c25ef514d90",
        "https://qiita.com/alclimb/items/a2a3fcfed921697fe68b",
        "https://zenn.dev/praha/articles/encouragement-trpc",
        "https://zenn.dev/cococig/articles/41a180beca5e99",
        "https://zenn.dev/ddpn08/articles/aivy-run-release",
        "https://zenn.dev/shelfy/articles/52f91c920e986d"
      ])
    else
      nil
    end    
  end
end
