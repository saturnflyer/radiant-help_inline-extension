module HelpInlineHelper
  def user_needs_help
    current_user.needs_help
  end
  helper :user_needs_help
end