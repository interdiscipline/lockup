class Post
  include ActiveModel::Model

  attr_accessor :id, :title, :body

  POSTS = [
    { id: 1, title: 'Title One', body: 'Body One' },
    { id: 2, title: 'Title Two', body: 'Body Two' }
  ]

  def self.all
    POSTS.map { |attrs| new(attrs) }
  end

  def self.find(id)
    all.detect { |post| post.id == id.to_i }
  end

  def to_param
    id
  end
end
