# URLにアクセスするためのライブラリの読み込み
require 'open-uri'
# nokogiriの読み込み
require 'nokogiri'

namespace :zenn do
  desc "Zennの個人開発に関連する記事の中から10いいね以上のものを保存するタスク"
  task get_items_regularly: :environment do
    base_url = "https://zenn.dev"
    page = 1
    
    while page < 6
      sleep 1
      # スクレイピング先のURL
      url = "https://zenn.dev/topics/%E5%80%8B%E4%BA%BA%E9%96%8B%E7%99%BA?order=alltime&page=#{page}"
      # urlにアクセスしてhtmlを取得する
      # html = URI.open("#{Rails.root}/app/views/nokogiri_practice.html").read
      html = URI.parse(url).open.read
      doc = Nokogiri::HTML.parse(html)
  
      # 1ページ内の記事情報を取得
      doc.css(".ArticleList_itemContainer__xlBMc").each do |article|
        link = article.at_css(".ArticleList_link__vf_6E").attributes['href'].value
        link_url = "#{base_url}#{link}"
        good = article.at_css(".ArticleList_like__c4148").text.to_i
  
        old_article = Article.find_by(link: link_url)
  
        if good >= 10
          case good
          when 400..999
            good = good * 4.5
          when 300..399
            good = good * 4
          when 200..299, 20..49
            good = good * 3.5
          when 50..199
            good = good * 3
          when 10..19
            good = good * 5
          end
          
          if old_article
            old_article.update!(stock: good) unless old_article["stock"] == good
          else
            title = article.at_css(".ArticleList_title__P6X2G").text
            datetime = article.at_css(".ArticleList_date__L543S").attributes['datetime'].value
            result = LinkThumbnailer.generate(link_url)
            image = result.images.first.src.to_s
            article = Article.create!(
              link: link_url,
              title: title,
              date: datetime,
              stock: good,
              media_name: "zenn.dev",
              media_image: "https://youliangdao.s3.ap-northeast-1.amazonaws.com/logo-only.png",
              image: image
            )
            
            sleep 1
            category_ids = []
            html_child = URI.parse(link_url).open
            doc_child = Nokogiri::HTML.parse(html_child)
            doc_child.css(".View_topicName__rxKth").each do |topic|
              categories = Category.arel_table
              case topic.text
              when "デザイン"
                category = Category.where(categories[:name].matches("%#{topic.text}%"))              
              when "UI/UX"
                category = Category.where(name: "UI")
              when "Figma"
                category = Category.where(name: "デザイン（Design）")
              when "GitHub Actions", "GitHub CLI"
                category = Category.where(name: "GitHub")
              when "Nuxt 3"
                category = Category.where(name: "Nuxt.js")
              when "Vue 3"
                category = Category.where(name: "Vue.js")
              when "Gatsby.js"
                category = Category.where(name: "Gatuby")
              when "起業"
                category = Category.where(name: "スタートアップ")
              when "Chrome"
                category = Category.where(name: "Chrome拡張")
              when "SwiftUI"
                category = Category.where(name: "Swift")
              when "Tailwind CSS"
                category = Category.where(name: "CSS")
              when "threejs"
                category = Category.where(name: "three.js")
              when "LINE Bot"
                category = Category.where(name: "LINE")
              when "CloudflarePages"
                category = Category.where(name: "CloudFlare")
              when "wasm"
                category = Category.where(name: "WebAssembly")
              when "SvelteKit"
                category = Category.where(name: "Svelte")
              when "idea"
                category = Category.where(name: "まとめ")
              else
                category = Category.where(categories[:name].matches("#{topic.text}"))
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
            elsif category_ids.length > 2
              category_ids.delete(12)
            end
  
            category_ids.each do |category_id|
              CategoryMap.create(article_id: article["id"], category_id: category_id)
            end
  
          end
          
        end
      end
      
      page += 1
    end

  end
end
