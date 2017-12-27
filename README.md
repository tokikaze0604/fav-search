# fav-search

Twitterのいいね（ふぁぼ）を取得して検索しようという何かです．

<a href="https://qiita.com/tokikaze0604/items/f30a7f7c1a33af872932">高知工科大学AdventCalendar2017の22日目の記事</a>として投稿させていただきました．

追記：2017/12/27

gitからgemを取得する際のエラーを修正．


## 使うものと私の環境
- macOS Sierra 10.12.6
- ruby 2.4.3
- Ruby on Rails 5.1.4
- Elasticsearach 6.1.1

## 使い方
1. git clone

```
$ git clone https://github.com/tokikaze0604/fav-search.git
$ cd fav-search
```

2. ふぁぼ（いいね）取得

```
$ ruby get_favs.rb
```
- 直近2ヶ月分しか取得できない?

3. サーバの準備

```
$ cd server
$ bundle install
$ bundle install --jobs=4 --path=vendor/bundle
$ bundle exec rake db:migrate
$ bundle exec rake elasticsearch:create_index
```

4. Elasticsearchの起動

```
$ elasricsearch
```

5. Elasticsearchに取得したいいね（ふぁぼ）を入れる

```
$ bundle exec rake db:seed
$ bundle exec rake elasticsearch:import_article
```

6. Railsサーバを起動

```
$ rails s
```

7. `http://localhost:3000/favorites`にアクセス
