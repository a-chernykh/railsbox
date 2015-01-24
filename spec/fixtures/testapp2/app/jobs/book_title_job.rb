class BookTitleJob < ActiveJob::Base
  queue_as :default

  def perform(book_id)
    Book.find(book_id).update_attributes title: 'ok'
  end
end
