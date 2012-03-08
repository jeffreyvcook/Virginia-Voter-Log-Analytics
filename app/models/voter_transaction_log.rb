class VoterTransactionLog < ActiveRecord::Base
  validates_presence_of :origin
  validates_presence_of :datime
  validates_presence_of :locale
  validates_uniqueness_of :origin, :scope => [:datime, :origin_uniq],
                                   :message => "and date/time are exact duplicates of pre-existing log"
  belongs_to :election
  has_many :voter_transaction_records, :dependent => :destroy
end
