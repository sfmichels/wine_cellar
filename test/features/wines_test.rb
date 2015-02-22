require "test_helper"

feature "Wines" do
  scenario "displays a list of wines" do
    visit root_path
    page.must_have_content "Wines"
    page.must_have_content "Winery"
    page.must_have_content "Variety"
    page.must_have_content "Appellation"
    page.must_have_content "Vineyard"
    page.wont_have_content "Dog"
  end
end
