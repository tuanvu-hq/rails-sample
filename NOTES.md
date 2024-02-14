# Reset

```
rails db:drop
rails db:create
rails db:migrate
rails db:seed
```

or

```
rails db:rollback
rails db:rollback STEP=2
```

# Models

```
rails generate model User first_name:string last_name:string email:string password_digest
rails generate model Note title:string description:string body:text user:references
rails generate model Tag title:string
rails generate model History note:references action:string
rails generate model NoteTag note:references tag:references
```

```ruby
class User < ApplicationRecord
  has_secure_password

  has_many :notes, dependent: :destroy

  validates :first_name, presence: true, length: { in: 6..20 }
  validates :last_name, presence: true, length: { in: 6..20 }
  validates :email, presence: true, length: { maximum: 30 }, uniqueness: true
  normalizes :email, with: -> (email) { email.strip.downcase }
  validates :password, presence: true, length: { in: 6..30 }
end

class Note < ApplicationRecord
  belongs_to :user
  has_many :note_tags, dependent: :destroy
  has_many :tags, through: :note_tags
  has_one :history, as: :trackable

  validates :title, presence: true, length: { in: 2..30 }
  validates :description, presence: true, length: { maximum: 100 }
  validates :body, presence: true, length: { maximum: 1000 }
end

class Tag < ApplicationRecord
  has_many :note_tags, dependent: :destroy
  has_many :notes, through: :note_tags

  validates :title, presence: true, length: { in: 2..30 }
end

class History < ApplicationRecord
  belongs_to :trackable, polymorphic: true
end

class NoteTag < ApplicationRecord
  belongs_to :note
  belongs_to :tag
end
```

**Note**, `has_secure_password` requires `bcrypt` to be enabled in the `Gemfile`.
