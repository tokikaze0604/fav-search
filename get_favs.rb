require 'twitter'
require 'json'

def get_recent_fav_id
  begin
    res = @client.favorites(:count => 1)

  rescue Twitter::Error::ClientError
    puts 'ClientError'
    sleep(10)
    retry
  end

  if res.empty? then
    puts 'いいねしろよ'
    exit
  end
  return res[0].id
end

def get_favs(n = 200, max_id)
  @client.favorites(:count => n, :max_id => max_id)
end

@client = Twitter::REST::Client.new do |config|
  config.consumer_key = ENV['CONSUMER_KEY']
  config.consumer_secret = ENV['CONSUMER_SECRET']
  config.access_token = ENV['ACCESS_TOKEN']
  config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
end

def append_fav(favs, fav, count)
  data = {
    "tweet_id" => fav.id,
    "text" => fav.text,
    "user_name" => fav.user.screen_name,
    "created_at" => fav.created_at
  }

  tweets.store(count.to_s, data)
end

max_id = get_recent_fav_id() # 最新のいいねから取得開始
count = 0
favs = {}
file_path = './server/public/favorites.txt'
file = File.open(file_path, 'w')

while true do
  begin
    sleep(5)

    res = get_favs(max_id) # max_id以下のidのふぁぼ（ツイート）が取得できる

    if res.empty? then # 何も帰ってこなかったら遡れる限界?
      file.puts tweets.to_json
      puts '終わったよ'
      break
    end

    res.map do |status|
      count = count + 1
      max_id = status.id - 1
      append_fav(favs, status, count) # ふぁぼをハッシュに格納する
    end
    puts count.to_s + 'ふぁぼを取得'

  rescue Twitter::Error::ClientError # 制限に引っかかったら10秒待ってみる
    puts '怒られたっぽい'
    sleep(10)
    retry
  end
end
