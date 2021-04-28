class Link < ApplicationRecord
  before_create :set_short_url
  validates :url, presence: true
  validates :url, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])

  has_many :visits, dependent: :destroy

  private

  def set_short_url
    self.short_url = uniq_short_url
  end

  def uniq_short_url
    loop do
      generated_url = SecureRandom.uuid.delete('-')[0..rand(10..20)]
      return generated_url unless Link.find_by(short_url: generated_url)
    end
  end
end
