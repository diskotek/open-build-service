class SiteConfigsController < ApplicationController
  # Site configuration is insensitive information, no login needed therefore
  skip_before_filter :extract_user, :only => [:show]

  # GET /site_config
  # GET /site_config.json
  # GET /site_config.xml
  def show
    @site_config = SiteConfig.first

    respond_to do |format|
      format.xml  { render :xml => @site_config }
      format.html # show.html.erb
      format.json { render :json => @site_config }
    end
  end

  # GET /site_config/edit
  def edit
    @site_config = SiteConfig.first
  end

  # PUT /site_config
  # PUT /site_config.json
  # PUT /site_config.xml
  def update
    unless @http_user.is_admin?
      render_error :status => 403, :errorcode => "put_request_no_permission", :message => "PUT on requests currently requires admin privileges" and return
    end
    @site_config = SiteConfig.first

    respond_to do |format|
      if @site_config.update_attributes(request.request_parameters)
        format.xml  { head :ok }
        format.html { redirect_to(@site_config, :notice => 'SiteConfig was successfully updated.') }
        format.json { head :ok }
      else
        format.xml  { render :xml => @site_config.errors, :status => :unprocessable_entity }
        format.html { render :action => "edit" }
        format.json { render :json => @site_config.errors, :status => :unprocessable_entity }
      end
    end
  end
end
