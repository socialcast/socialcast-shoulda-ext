require 'logger'
config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")
ActiveRecord::Base.establish_connection(config[ENV['DB'] || 'sqlite'])

ActiveRecord::Schema.define(:version => 1) do
  create_table :blogs, :force => true do |t|
    t.column :title, :string
  end
  create_table :comments, :force => true do |t|
    t.column :blog_id, :integer
    t.column :text, :string
  end
end

class Blog < ActiveRecord::Base
  has_many :comments, :dependent => :destroy
  attr_accessible :title
end

class Comment < ActiveRecord::Base
  attr_accessible :text
  belongs_to :blog
end