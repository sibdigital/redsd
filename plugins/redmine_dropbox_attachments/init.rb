require 'redmine_dropbox'

Redmine::Plugin.register :redmine_dropbox_attachments do
  name        "Dropbox Attachment Storage - API v2"
  author      "Alex Bevilacqua"
  description "Use Dropbox for attachment storage"
  url         "https://github.com/alexbevi/redmine_dropbox_attachments"
  author_url  "mailto:alexbevi@gmail.com"
  version     "2.2.1"

  requires_redmine :version_or_higher => '2.0.0'

  raise "redmine_dropbox_attachments plugin requires ruby 1.9 or higher" unless RUBY_VERSION > "1.8.7"

  settings :default => {
    'DROPBOX_SESSION' => nil,
  }, :partial => 'settings/dropbox_settings'

end

