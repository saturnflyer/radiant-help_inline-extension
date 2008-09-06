module HelpInline::ApplicationExt
  def self.included(base)
    base.class_eval {
      before_filter :add_inline_help_files
    }
  end
  
  def add_inline_help_files
    @stylesheets ||= []
    @stylesheets << 'admin/help'
  end
end