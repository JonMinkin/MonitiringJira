require 'spec_helper'
feature "tasks_show", :type => :feature  do
  before(:each) do
    create(:task)
  end
  scenario "Registered user visit task page" do
    sigin_in
    visit task_path(1)
    expect(page).to have_content "test_task"
    expect(page).to have_content "key: task_1"
    expect(page).to have_content "Оплата: 2000.0"
    expect(page).to have_content "Дата создания: 2016-01-01"
    expect(page).to have_content "Дата закрытия: 2016-01-01"
    expect(page).to have_content "Описание задачи"
  end
  scenario "Non-registered user visit task page" do
    visit task_path(1)
    expect(page).to have_content "Авторизация"
  end
  scenario "Page not faund" do
    sigin_in
    visit task_path(0)
    expect(page).to have_content "Page not faund"
  end
  scenario "User clicked all projects" do
    sigin_in
    visit task_path(1)
    click_on "Все проекты"
    expect(page).to have_content "Список проектов"
  end
  scenario "User clicked all tasks" do
    sigin_in
    visit task_path(1)
    click_on "Все задачи"
    expect(page).to have_content "Список всех задач"
  end
  scenario "User clicked link key" do
    sigin_in
    visit task_path(1)
    #click_on "task_1"
    #expect(page).to has_link?("http://jira.rubyruby.ru/browse/task_1")
  end
end