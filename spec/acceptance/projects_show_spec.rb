require 'spec_helper'
feature "project_show", :type => :feature  do
    given(:status) {["Done", "In Review", "Open", "Closed", "In Progress", "Resolved", "To Do"]}
    given(:test_date) {["2014-01-01", "2014-02-01", "2014-03-01", "2014-04-01", "2014-05-01", "2014-06-01", "2014-07-01"]}
  before(:each) do
    create(:project, id: 11, name: "test_project")
    0.upto(6) do |i|
      create(:task, id: 10 + i,  summary: "test_task #{i}", status: status[i], created_at: test_date[i], project_id: 11)
    end
  end
  scenario "Registered user visit projects page" do
    sigin_in
    visit project_path(11)
    expect(page).to have_content "test_project"
  end
  scenario "Non-registered user visit projects page" do
    visit project_path(11)
    expect(page).to have_content "Авторизация"
  end
  scenario "The user has selected a date from" do
    sigin_in
    visit project_path(11)
    fill_in "from", with: "2014-05-01" 
    click_on "Фильтр"
    expect(page).to have_content "test_task 4"
    expect(page).to have_content "2014-05-01"
    expect(page).to have_content "2016-01-01"
    expect(page).to have_content "test_task 5"
    expect(page).to have_content "test_task 6"
    expect(page).to have_content "6000"
  end
  scenario "The user has selected a date to" do
    sigin_in
    visit project_path(11)
    fill_in "to", with: "2014-03-01" 
    click_on "Фильтр"
    expect(page).to have_content "test_task 0"
    expect(page).to have_content "test_task 1"
    expect(page).to have_content "test_task 2"
  end
  scenario "The user has selected a between date" do
    sigin_in
    visit project_path(11)
    fill_in "from", with: "2014-02-01"
    fill_in "to", with: "2014-04-01" 
    click_on "Фильтр"
    expect(page).to have_content "test_task 1"
    expect(page).to have_content "test_task 2"
    expect(page).to have_content "test_task 3"
  end
  scenario "The user has selected status Done" do
      sigin_in
      visit project_path(11)
      select "Done"
      click_on "Фильтр"
      expect(page).to have_content "test_task 0"
  end  
  scenario "The user has selected status Done, Open" do
      sigin_in
      visit project_path(11)
      select "Done"
      select "Open"
      click_on "Фильтр"
      expect(page).to have_content "test_task 0"
      expect(page).to have_content "test_task 2"
    end
  scenario "The user has selected a between date and status" do
    sigin_in
    visit project_path(11)
    fill_in "from", with: "2014-02-01"
    fill_in "to", with: "2014-04-01" 
    select "Open"
    click_on "Фильтр"
    expect(page).to have_content "test_task 2"
  end
  scenario "The user has selected a from date and status" do
    sigin_in
    visit project_path(11)
    fill_in "from", with: "2014-02-01"
    select "Open"
    click_on "Фильтр"
    expect(page).to have_content "test_task 2"
  end
  scenario "The user has selected a to date and status" do
    sigin_in
    visit project_path(11)
    fill_in "to", with: "2014-03-01"
    select "Open"  
    click_on "Фильтр"
    expect(page).to have_content "test_task 2"
  end
  scenario "The user clicked link task" do
    sigin_in
    visit project_path(11)
    click_on "test_task 0"
    expect(page).to have_content "test_task 0"
  end
  scenario "The user clicked button all tasks" do
    sigin_in
    visit project_path(11)
    click_on "Все задачи"
    expect(page).to have_content "Список всех задач"

  end
  scenario "The user clicked link key" do
    #sigin_in
    #click_on "P0"
    #expect(page).to have_content "/browse/P0"
  end
end  