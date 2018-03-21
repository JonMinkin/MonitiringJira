namespace :permission do
  desc "destroy"
  task :write => :environment do

    def setup_actions_controllers_db
      model_class ={}
      models = Dir.new("#{Rails.root}/app/models").entries
      models.each do |model|
        if model =~ /.rb/ and model != "ability.rb"
          fo_bar = model.camelize.gsub(".rb","").constantize.new
          model_class[fo_bar.class.to_s] = true
        end
      end
      controllers = Dir.new("#{Rails.root}/app/controllers").entries
      controllers.each do |controller|
        if controller =~ /_controller/
          foo_bar = controller.camelize.gsub(".rb","").constantize.new
          class_controller = foo_bar.class.to_s
          class_controller = class_controller[0, class_controller.length - 11]
          if model_class[class_controller]
            foo_bar.action_methods.each do |action|
              action = eval_cancan_action(action)
              if action.present?
                write_permission(class_controller, action)
              end
            end
          end
        end
      end
    end

  def eval_cancan_action(action)
    case action.to_s
    when "index", "show", "search"
      cancan_action = "read"
    when "create", "new"
      cancan_action = "create"
    when "edit", "update"
      cancan_action = "update"
    when "delete", "destroy"
      cancan_action = "delete"
    else
      #cancan_action = action.to_s
    end
    return  cancan_action
  end

  def write_permission(class_name, cancan_action, force_id_1 = false)
    permission  = Permission.where(klass: class_name, action: cancan_action).first
    if not permission
      permission = Permission.new
      permission.id = 1 if force_id_1
      permission.klass =  class_name
      permission.action = cancan_action
      permission.save
    end
  end
  setup_actions_controllers_db
  end
end