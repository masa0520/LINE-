class LinePost < ApplicationRecord
  after_commit :update_cron

  belongs_to :user
  belongs_to :post

  validates :user_id, uniqueness: { scope: :post_id }

  def update_cron
    system("bundle exec whenever --update-crontab")
  end
end
