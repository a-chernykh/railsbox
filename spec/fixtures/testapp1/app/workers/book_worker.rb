class BookWorker
  include Sidekiq::Worker

  def perform(book_id)
    Book.find(book_id).update_attributes title: 'ok'
  end
end
