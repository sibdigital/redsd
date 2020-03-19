class DropboxController < ApplicationController
  PLUGIN_BASE = "redmine_dropbox_attachments"

  def authorize
    if settings.nil?
      flash[:warning] = l(:warning_settings_unsaved)
      redirect_to "/settings/plugin/#{PLUGIN_BASE}"
    elsif !params[:code]
      redirect_to authenticator.authorize_url(:redirect_uri => url_for(:action => 'authorize'))
    else
      auth_bearer = authenticator.get_token(params[:code], :redirect_uri => url_for(:action => 'authorize'))

      tmp = settings.value
      tmp["DROPBOX_OAUTH_TOKEN"] = auth_bearer.token

      settings.value = tmp
      settings.save

      flash[:notice] = l(:dropbox_authorization_successful)
      redirect_to "/settings/plugin/#{PLUGIN_BASE}"
    end
  end

  private
  def authenticator
    @authenticator ||= DropboxApi::Authenticator.new(settings.value["DROPBOX_TOKEN"], settings.value["DROPBOX_SECRET"])
  end

  def settings
    @settings ||= Setting.find_by_name("plugin_#{PLUGIN_BASE}")
  end
end
