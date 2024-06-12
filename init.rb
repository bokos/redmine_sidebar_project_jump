Redmine::Plugin.register :redmine_sidebar_project_jump do
  name 'Sidebar Project Jump'
  author 'bokos'
  description 'Puts a second Project Jump Field into sidebar'
  version '0.0.1'
  url 'https://github.com/bokos/redmine_sidebar_project_jump'

  RedmineApp::Application.config.after_initialize do
    ApplicationHelper.include ApplicationHelperPatch
  end
end
