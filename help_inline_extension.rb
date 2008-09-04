# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class HelpInlineExtension < Radiant::Extension
  version "1.0"
  description "Adds inline Help to the Radiant interface"
  url "http://saturnflyer.com"
  
  define_routes do |map|
    map.admin_user_toggle_inline_help 'admin/users/:id/toggle_inline_help', :controller => 'admin/user', :action => 'toggle_inline_help', :conditions => {:method => :put}
  end
  
  def activate
    Admin::UserController.class_eval {
      def toggle_inline_help
        current_user.update_attribute(:needs_help, !current_user.needs_help)
        redirect_to :back
      end
    }
    admin.page.edit.add :main, 'help_instructions', :before => 'edit_header'
    admin.user.edit.add :form, 'needs_help', :after => 'edit_notes'
  end
  
  def deactivate
    # admin.tabs.remove "Help Inline"
  end
  
end