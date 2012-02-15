module Paranoia
  def destroy
    _run_destroy_callbacks
    self.update_attribute(:deleted_at, Time.now) if self[:deleted_at].blank?
  end    
  alias :delete :destroy

  def destroyed?
    !self[:deleted_at].nil?
  end
  alias :deleted? :destroyed?
end

class ActiveRecord::Base
  def self.acts_as_paranoid
    self.send(:include, Paranoia)
    default_scope :conditions => { :deleted_at => nil }
  end
end
