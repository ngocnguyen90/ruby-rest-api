class Pagination < ApplicationService
  def initialize(collection)
    @collection = collection
  end

  def call
    {
      current_page: @collection.current_page,
      next_page: @collection.next_page,
      prev_page: @collection.previous_page,
      total_pages: @collection.total_pages,
      total_entries: @collection.total_entries
    }
  end
end
