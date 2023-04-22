# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# db/seeds.rb

# ジャンルのデータを配列で定義
genres_data = [
  { name: '名詞' },
  { name: '代名詞' },
  { name: '動詞' },
  { name: '助動詞' },
  { name: '形容詞' },
  { name: '副詞' },
  { name: '前置詞' },
  { name: '接続詞' },
  { name: '冠詞' },
  { name: '間投詞' },
  { name: 'TOEIC' },
  { name: '英検' },
  { name: '日常生活' },
  { name: '生物(動物・植物など)' },
  { name: '食品・飲み物' },
  { name: '色' },
  { name: '数字・日付' },
  { name: '家族・人間関係' },
  { name: '服装・ファッション' },
  { name: '旅行' },
  { name: 'スポーツ・運動' },
  { name: '趣味・娯楽' },
  { name: '職業・ビジネス' },
  { name: '学業・教育' },
  { name: '自然・環境' },
  { name: '文化・芸術' },
  { name: '音楽・映画・メディア' },
  { name: '文学・歴史' },
  { name: '宗教・哲学' },
  { name: 'コンピュータ・IT' },
  { name: '健康・美容' },
  { name: '社会問題・政治' },
  { name: '社交・イベント' },
  { name: '住まい・家具' },
  { name: 'スキル・能力' },
  { name: 'SNS' },
  { name: 'その他' },
]

# ジャンルレコードを作成
genres_data.each do |genre_data|
  Genre.find_or_create_by!(genre_data)
end
