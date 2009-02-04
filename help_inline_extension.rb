class HelpInlineExtension < Radiant::Extension
  version "1.0"
  description "Adds inline Help to the Radiant interface"
  url "http://saturnflyer.com"
  
  define_routes do |map|
    map.admin_user_toggle_inline_help 'admin/users/:id/toggle_inline_help', :controller => 'admin/users', :action => 'toggle_inline_help', :conditions => {:method => :put}
  end
  
  def activate
    Admin::UsersController.class_eval {
      def toggle_inline_help
        current_user.update_attribute(:needs_help, !current_user.needs_help)
        redirect_to :back
      end
    }
    ApplicationController.class_eval{ include HelpInline::ApplicationExt }
    admin.page.index.add :top, 'help_instructions'
    admin.page.index.add :top, 'index_instructions'
    admin.user.index.add :top, 'index_instructions'
    admin.user.edit.add :form_top, 'edit_instructions'
    admin.user.edit.add :form, 'needs_help', :after => 'edit_notes'
    admin.user.preferences.add :form, 'admin/users/needs_help'
    admin.extension.index.add :top, 'index_instructions'
    
    if admin.snippet.index.respond_to?(:replace)
      admin.snippet.index.replace :top, 'index_instructions'
    else
      admin.snippet.index.add :top, 'index_instructions'
    end
    
    if admin.respond_to?(:dashboard)
      admin.dashboard.index.add :main, 'dashboard_instructions', :before => 'draft_pages'
    end
  end
  
  def deactivate
  end
  
end