class User < ActiveRecord::Base
  has_merit

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :major, foreign_key: :major_id
  belongs_to :sex, foreign_key: :sex_id
  has_many :microposts, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
          foreign_key: "follower_id",
          dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
           foreign_key: "followed_id",
           dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  #Paperclip
  has_attached_file :avatar,
                    :styles => { :medium => "180x180#", :thumb => "100x100#" },
                    :default_url => ":style/default.gif",
                    :path => ":rails_root/public/uploads/images/:id_:style_:fingerprint.:extension",
                    :url => "/uploads/images/:id_:style_:fingerprint.:extension"

  has_attached_file :cover,
                    :styles => { :medium => "1100x300#", :thumb => "330x90#" },
                    :default_url => ":style/default_cover.jpg",
                    :path => ":rails_root/public/uploads/images/covers/:id_:style_:fingerprint.:extension",
                    :url => "/uploads/images/covers/:id_:style_:fingerprint.:extension"

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_attachment_content_type :cover, :content_type => /\Aimage\/.*\Z/

  # Follows a user.
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  def feed
    Micropost.from_users_followed_by(self)
  end
end
