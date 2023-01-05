qiita_items_page1 = QiitaApiClient.get_items(1)
qiita_items_page2 = QiitaApiClient.get_items(2)
qiita_items_page3 = QiitaApiClient.get_items(3)
qiita_items = []
qiita_items.concat(qiita_items_page1, qiita_items_page2, qiita_items_page3)

qiita_items.each_with_index do |article, i|
  result = LinkThumbnailer.generate("#{article["url"]}")
  image = result.images.first.src.to_s  
  QiitaArticle.seed do |s|
    s.id = i + 1
    s.link = article["url"]
    s.title = article["title"]
    s.date = article["created_at"]
    s.stock = article["stocks_count"]
    s.item_id = article["id"]
    s.image = image
  end

  array = []
  article["tags"].each do |tag|
    tag_name = tag["name"]
    categories = Category.arel_table
    if tag_name == "Go"
      category = Category.where(categories[:name].matches("#{tag_name}"))
    else
      category = Category.where(categories[:name].matches("%#{tag_name}%"))
    end
    if category.length == 0
      array.push(64)
    else
      array.push(category[0].id)
    end
  end
  array.uniq!  
  if array.length > 1
    array.delete(64)
  end
    
  array.each do |category_id|
    QiitaCategoryMap.create(qiita_article_id: i + 1, category_id: category_id)
  end
  
end