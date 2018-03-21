require 'spec_helper'
feature "project_index", :type => :feature  do
    given(:status) {["Done", "In Review", "Open", "Closed", "In Progress", "Resolved", "To Do"]}
    given(:test_date) {["2014-01-01", "2014-02-01", "2014-03-01", "2014-04-01", "2014-05-01", "2014-06-01", "2014-07-01"]}
    given(:test_date1) {["2015-01-01", "2015-02-01", "2015-03-01", "2015-04-01", "2015-05-01", "2015-06-01", "2015-07-01"]}
  before(:each) do
    0.upto(6) do |i|
      create(:project, id:  i, name: "project #{i}", key: "P#{i}")
      create(:task, id: 10 + i,  summary: "test_task 1", status: status[i], created_at: test_date[i], project_id: i)
      create(:task, id: 20 + i, summary: "test_task 2", status: status[i], created_at: test_date[i], project_id:  i, paid: false)
      create(:task, id: 30 + i, summary:  "test_task 3", status: status[i], created_at: test_date1[i], project_id:  i)
    end
  end
  scenario "Registered user visit projects page" do
    sigin_in
    expect(page).to have_content "Список проектов"
  end
  scenario "Non-registered user visit projects page" do
    visit projects_path
    expect(page).to have_content "Авторизация"
  end
  scenario "The user has selected a date from" do
    sigin_in
    fill_in "from", with: "2015-05-01" 
    click_on "Фильтр"
    expect(page).to have_content "project 4"
    expect(page).to have_content "P4"
    expect(page).to have_content "2000"
    expect(page).to have_content "project 5"
    expect(page).to have_content "project 6"
  end
  scenario "The user has selected a date to" do
    sigin_in
    fill_in "to", with: "2014-03-01" 
    click_on "Фильтр"
    expect(page).to have_content "project 0"
    expect(page).to have_content "P0"
    expect(page).to have_content "2000"
    expect(page).to have_content "project 1"
    expect(page).to have_content "project 2"
  end
  scenario "The user has selected a between date" do
    sigin_in
    fill_in "from", with: "2014-02-01"
    fill_in "to", with: "2014-04-01" 
    click_on "Фильтр"
    expect(page).to have_content "project 1"
    expect(page).to have_content "P1"
    expect(page).to have_content "2000"
    expect(page).to have_content "project 2"
    expect(page).to have_content "project 3"
  end
  scenario "The user has selected status Done" do
      sigin_in
      select "Done"
      click_on "Фильтр"
      expect(page).to have_content "project 0"
      expect(page).to have_content "P0"
      expect(page).to have_content "4000"
  end  
  scenario "The user has selected status Done, Open" do
    sigin_in
    select "Done"
    select "Open"
    click_on "Фильтр"
    expect(page).to have_content "project 0"
    expect(page).to have_content "P0"
    expect(page).to have_content "4000"
    expect(page).to have_content "project 2"
  end
  scenario "The user has selected a between date and status" do
    sigin_in
    fill_in "from", with: "2014-02-01"
    fill_in "to", with: "2014-04-01" 
    select "Open"
    click_on "Фильтр"
    expect(page).to have_content "project 2"
    expect(page).to have_content "P2"
    expect(page).to have_content "2000"
  end
  scenario "The user has selected a from date and status" do
    sigin_in
    fill_in "from", with: "2014-02-01"
    select "Open"
    click_on "Фильтр"
    expect(page).to have_content "project 2"
    expect(page).to have_content "P2"
    expect(page).to have_content "4000"
  end
  scenario "The user has selected a to date and status" do
    sigin_in
    fill_in "to", with: "2014-03-01"
    select "Open"  
    click_on "Фильтр"
    expect(page).to have_content "project 2"
    expect(page).to have_content "P2"
    expect(page).to have_content "2000"
  end
  scenario "The user clicked link project" do
    sigin_in
    click_on "project 0"
    expect(page).to have_content "test_task 1"
    expect(page).to have_content "test_task 2"
    expect(page).to have_content "test_task 3"
  end

end  