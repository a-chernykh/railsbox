class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def test
    book = Book.create! title: 'Rails'
    BookTitleJob.perform_later book.id
    sleep 10
    render text: book.reload.title
  end
end
