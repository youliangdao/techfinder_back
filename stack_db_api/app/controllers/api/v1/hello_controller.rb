class Api::V1::HelloController < ApplicationController
  def index
    qiita_items_page1 = QiitaApiClient.get_items(1)
    qiita_items_page2 = QiitaApiClient.get_items(2)
    qiita_items_page3 = QiitaApiClient.get_items(3)
    qiita_items = []
    qiita_items.concat(qiita_items_page1, qiita_items_page2, qiita_items_page3)

    # tags = qiita_items.map do |item|
    #   item["tags"].map { |tag| tag["name"] }
    # end

    qiita_items.each_with_index do |item, i|
      array = []
      item["tags"].each do |tag|
        tag_name = tag["name"]
        categories = Category.arel_table
        category = Category.where(categories[:name].matches("%#{tag_name}%"))
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
      puts array
    end


    render json: {status: :ok}
  end
end
