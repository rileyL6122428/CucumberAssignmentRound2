class SouthWestHome
  include PageObject

  MONTH_DAY_YEAR = "%m/%d/%Y"

  page_url "https://www.southwest.com/"

  element(:departure_date, :input, name: "outboundDateString")
  element(:return_date, :input, name: "returnDateString")

  text_field(:departure_airport, id: "air-city-departure")
  text_field(:arrival_airport, id: "air-city-arrival")

  button(:search, id: "jb-booking-form-submit-button")

  def departure_date
    Date.strptime(departure_date_element.value, MONTH_DAY_YEAR)
  end

  def return_date
    Date.strptime(return_date_element.value, MONTH_DAY_YEAR)
  end
end
