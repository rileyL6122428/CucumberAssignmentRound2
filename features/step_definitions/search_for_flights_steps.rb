When(/^I search for a flight using the default dates$/) do
  visit_page SouthWestHome
  on_page SouthWestHome do |page|
    @default_departure_date = page.departure_date
    @default_return_date = page.return_date

    page.departure_airport = 'CMH'
    page.arrival_airport = 'MCO'

    page.search
  end
end

Then(/^the dates I searched for are highlighted in the search results$/) do
  on_page SouthWestFlightSearchResults do |page|
    highlighted_departure_date = page.highlighted_departure_date
    highlighted_return_date = page.highlighted_return_date

    expect(highlighted_departure_date).to eq @default_departure_date
    expect(highlighted_return_date).to eq @default_return_date
  end
end

Then(/^I can't choose a departure date from the past$/) do
  on_page SouthWestFlightSearchResults do |page|
    page.departure_dates.each do |date|
      page.select_departure_date(date)

      expect(page.highlighted_departure_date).not_to eq date if page.date_already_passed?(date)
      expect(page.highlighted_departure_date).to eq date if !page.date_already_passed?(date)
    end
  end
end
