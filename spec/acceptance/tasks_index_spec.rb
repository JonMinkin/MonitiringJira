require 'spec_helper'
feature "tasks_index", :type => :feature  do
    given(:status) {["Done", "In Review", "Open", "Closed", "In Progress", "Resolved", "To Do"]}
    given(:test_date) {["2014-01-01", "2014-02-01", "2014-03-01", "2014-04-01", "2014-05-01", "2014-06-01", "2014-07-01"]}
    given(:assignee) {["Женя", "Володя", "Стас", "Миша", "Саша", "Виктор", "Коля"]}
  before(:each) do
    0.upto(6) do |i|
      create(:task, id: 10 + i, assignee: "#{assignee[i]}", summary: "test_task #{i}", key: "task_#{i}", status: status[i], created_at: test_date[i], due_date: test_date[i])
    end
  end
  scenario "Registered user visit tasks page" do
    sigin_in
    visit tasks_path
    expect(page).to have_content "Список всех задач"
    expect(page).to have_content "test_task 0"
    expect(page).to have_content "task_0"
    expect(page).to have_content "Женя"
    expect(page).to have_content "Володя"
    expect(page).to have_content "2014-01-01"
    expect(page).to have_content "2014-01-01"
    expect(page).to have_content "Done"
    expect(page).to have_content "2000.0"
  end
  scenario "Non-registered user visit tasks page" do
    visit tasks_path
    expect(page).to have_content "Авторизация"
  end
  scenario "The user has selected a date from" do
    sigin_in
    visit tasks_path
    fill_in "from", with: "2014-05-01" 
    click_on "Фильтр"
    expect(page).to have_content "test_task 4"
    expect(page).to have_content "test_task 5"
    expect(page).to have_content "test_task 6"
  end
  scenario "The user has selected a date to" do
    sigin_in
    visit tasks_path
    fill_in "to", with: "2014-03-01" 
    click_on "Фильтр"
    expect(page).to have_content "test_task 0"
    expect(page).to have_content "test_task 1"
    expect(page).to have_content "test_task 2"
  end
  scenario "The user has selected a between date" do
    sigin_in
    visit tasks_path
    fill_in "from", with: "2014-02-01"
    fill_in "to", with: "2014-04-01" 
    click_on "Фильтр"
    expect(page).to have_content "test_task 1"
    expect(page).to have_content "test_task 2"
    expect(page).to have_content "test_task 3"
  end
  scenario "The user has selected status Done" do
      sigin_in
      visit tasks_path
      select "Done"
      click_on "Фильтр"
      expect(page).to have_content "test_task 0"
    end
  scenario "The user has selected assignee Женя" do
      sigin_in
      visit tasks_path
      select "Женя"
      click_on "Фильтр"
      expect(page).to have_content "test_task 0"
    end
   
  scenario "The user has selected status Done, Open" do
      sigin_in
      visit tasks_path
      select "Done"
      select "Open"
      click_on "Фильтр"
      expect(page).to have_content "test_task 0"
      expect(page).to have_content "test_task 2"
    end
  scenario "The user has selected a between date and status" do
    sigin_in
    visit tasks_path
    fill_in "from", with: "2014-02-01"
    fill_in "to", with: "2014-04-01" 
    select "Open"
    click_on "Фильтр"
    expect(page).to have_content "test_task 2"
  end
  scenario "The user has selected a from date and status" do
    sigin_in
    visit tasks_path
    fill_in "from", with: "2014-02-01"
    select "Open"
    click_on "Фильтр"
    expect(page).to have_content "test_task 2"
  end
  scenario "The user has selected a to date and status" do
    sigin_in
    visit tasks_path
    fill_in "to", with: "2014-03-01"
    select "Open"  
    click_on "Фильтр"
    expect(page).to have_content "test_task 2"
  end
  scenario "The user clicked link task" do
    sigin_in
    visit tasks_path
    click_on "test_task 0"
    expect(page).to have_content "test_task 0"
  end
  scenario "The user clicked button all projects" do
    sigin_in
    visit tasks_path
    click_on "Все проекты"
    expect(page).to have_content "Список проектов"
  end
  scenario "The user has selected a date to and clicked clear" do
    sigin_in
    visit tasks_path
    fill_in "to", with: "2014-03-01" 
    click_on "Фильтр"
    click_on "Сбросить"
    expect(page).to have_content "test_task 0"
    expect(page).to have_content "test_task 1"
    expect(page).to have_content "test_task 2"
    expect(page).to have_content "test_task 3"
    expect(page).to have_content "test_task 4"
    expect(page).to have_content "test_task 5"
    expect(page).to have_content "test_task 6"
  end
  scenario "The user has selected assignee" do
    sigin_in
    visit tasks_path
    select "Женя" 
    expect(page).to have_content "test_task 0"
  end
  scenario "The user has multi-selected assignee" do
    sigin_in
    visit tasks_path
    select "Женя" 
    select "Стас"
    expect(page).to have_content "test_task 0"
    expect(page).to have_content "test_task 2"
  end

  scenario "The user clicked link key" do
    sigin_in
    visit tasks_path
  #  click_on "task_0"
   # expect(page).to have_content "/browse/P0"
  end

end  