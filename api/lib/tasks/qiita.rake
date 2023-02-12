namespace :qiita do
  desc "Qiitaの個人開発に関連する記事の中から50ストック以上のものを保存するタスク"
  task get_items_regularly: :environment do
    page = 1
    qiita_items = []

    while QiitaApiClient.get_items(page).length > 0
      qiita_items.concat(QiitaApiClient.get_items(page))
      page += 1
    end

    qiita_items.each do |qiita_item|
      if Article.find_by(link: qiita_item["url"])
        # ストック数を更新する
        article = Article.find_by(link: qiita_item["url"])
        article.update!(stock: qiita_item["stocks_count"])
      else
        # 新しく追加されたQiita記事をarticlesテーブルに保存する
        result = LinkThumbnailer.generate("#{qiita_item["url"]}")
        image = result.images.first.src.to_s          
        article = Article.create!(
          link: qiita_item["url"],
          title: qiita_item["title"],
          date: qiita_item["created_at"],
          stock: qiita_item["stocks_count"],
          item_id: qiita_item["id"],
          media_name: "qiita.com",
          media_image: "https://youliangdao.s3.ap-northeast-1.amazonaws.com/favicon.png",
          image: image
        )

        # カテゴリーとのマッピング
        category_ids = []
        qiita_item["tags"].each do |tag|
          tag_name = tag["name"]
          categories = Category.arel_table

          case tag_name
          when "Nuxt", "デザイン", "Design"
            category = Category.where(categories[:name].matches("%#{tag_name}%"))
            
          when "chrome-extension"
            category = Category.where(name: "Chrome拡張")
          when "ゲーム制作"
            category = Category.where(name: "ゲーム")
          when "linebot"
            category = Category.where(name: "LINE")
          when "SvelteKit"
            category = Category.where(name: "Svelte")
          when "リーンスタートアップ"
            category = Category.where(name: "スタートアップ")            
          else
            category = Category.where(categories[:name].matches("#{tag_name}"))
          end

          if category.length == 0
            category_ids.push(64)
          else
            category_ids.push(category[0].id)
          end
        end
        category_ids.uniq!  
        if category_ids.length > 1
          category_ids.delete(64)
        end
          
        category_ids.each do |category_id|
          CategoryMap.create(article_id: article["id"], category_id: category_id)
        end        
      end
    end
  end
end
