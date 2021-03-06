# -*- coding: utf-8 -*-
class Admin::AdminController < ApplicationController
  layout 'admin'
  before_filter :admin_login_required, :except => [:login, :logout]

  def login
    if request.post?
      if params[:admin][:login] == ADMINPAGE_LOGIN && params[:admin][:password] == ADMINPAGE_PASSWD
        session[:admin] = true
        flash[:notice] = 'ログインしました。'
        redirect_to :controller => 'admin/black_word'
        return
      else
        flash.now[:error] = 'ログイン情報が誤っています。'
      end
    end
    render :layout => false
  end

  def logout
    session[:admin] = nil
    flash[:notice] = 'ログアウトしました。'
    redirect_to :action => 'login'
  end

  protected
  def admin_login_required
    return if session[:admin]
    redirect_to :controller => '/admin/admin', :action => 'login'
    return false
  end
end
