require 'page-object'
include PageObject::PageFactory

browser = Watir::Browser.new :chrome
Before { @browser = browser }
at_exit { browser.close }
