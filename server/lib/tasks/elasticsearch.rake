namespace :elasticsearch do
  desc 'Elasticsearch のindexの作成'
  task :create_index => :environment do
    Favorite.create_index!
  end

  desc 'Favorite を Elasticsearch に登録'
  task :import_favorite => :environment do
    Favorite.import
  end
end
