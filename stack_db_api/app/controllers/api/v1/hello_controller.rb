class Api::V1::HelloController < ApplicationController
  def index
    zenn_data = [
      {
        link: "https://zenn.dev/wheatandcat/articles/20220503-memoir",
        title: "【夫婦で開発】1年かけて1週間を振り返えるアプリを本気で開発してみた",
        date: "2022-05-04",
        stock: 2460,
      },
      {
        link: "https://zenn.dev/ryohey/articles/6da216dc43557a",
        title: "5年かけて作ったウェブアプリを Hacker News に投稿し、最初の1ドルを得た話",
        date: "2022-02-12",
        stock: 1850,
      },
      {
        link: "https://zenn.dev/karugamo/articles/bb7477d1e7a648",
        title: "はじめてのReactで都道府県を当てるゲームをつくりました",
        date: "2022-09-28",
        stock: 1685,
      },
    ]
    zenn_articles = zenn_data.map do |data|
      data[:image] = LinkThumbnailer.generate("#{data[:link]}").images.first.src.to_s 
      data
    end

  end
end
