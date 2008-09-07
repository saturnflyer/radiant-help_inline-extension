module HelpInline::ApplicationExt
  ApplicationController.methods_after_set_javascripts_and_stylesheets << :add_inline_help_files

  def add_inline_help_files
    @stylesheets << 'admin/help'
  end
end