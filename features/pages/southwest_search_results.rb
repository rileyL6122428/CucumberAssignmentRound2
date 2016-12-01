class SouthWestFlightSearchResults
  include PageObject

  YEAR_MONTH_DAY = "%Y/%m/%d"

  list_item( :highlighted_departure_date, id: "carouselTodayDepart")
  list_item( :highlighted_return_date, id: "carouselTodayReturn")
  list_items(:departure_dates, css: 'div#newDepartDateCarousel > ol > li')

  def highlighted_departure_date
    parse_date_element(highlighted_departure_date_element)
  end

  def highlighted_return_date
    parse_date_element(highlighted_return_date_element)
  end

  def departure_dates
    last_possible_return_date = highlighted_return_date

    dates = []
    departure_dates_elements.each do |date_element|
      next_departure_date = parse_date_element(date_element)
      dates << next_departure_date unless next_departure_date > last_possible_return_date
    end

    dates
  end

  def select_departure_date(date)
    date_str = date.strftime( YEAR_MONTH_DAY)
    element_to_select = departure_dates_elements.find do |date_element|
      date_element.attribute("carouselfulldate") == date_str
    end
    element_to_select.click
  end

  def from_the_past?(date)
    now = Time.now
    date < Time.new(now.year, now.month, now.day).to_date
  end

  private
  def parse_date_element(date_element)
    Date.strptime(
      date_element.attribute("carouselfulldate"),
      YEAR_MONTH_DAY
    )
  end
end
