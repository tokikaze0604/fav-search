module FavoriteSearchable
  extend ActiveSupport::Concern
  included do
    include Elasticsearch::Model
    # インデックスするフィールドの一覧
    INDEX_FIELDS = %w(text user_name).freeze
    # インデックス名
    index_name "es_sample_favorite_#{Rails.env}"
    # マッピング情報
    settings do
      mappings dynamic: 'false' do # 動的にマッピングを生成しない
        indexes :text, analyzer: 'kuromoji', type: 'text'
        indexes :user_name,  analyzer: 'kuromoji', type: 'text'
      end
    end
    # インデックスするデータを生成
    # @return [Hash]
    def as_indexed_json(option = {})
      self.as_json.select { |k, _| INDEX_FIELDS.include?(k) }
    end
  end
  module ClassMethods
    # indexの作成メソッド
    def create_index!
      client = __elasticsearch__.client
      client.indices.delete index: self.index_name rescue nil
      client.indices.create(index: self.index_name,
                            body: {
                                settings: self.settings.to_hash,
                                mappings: self.mappings.to_hash
                            })
    end
  end
end
