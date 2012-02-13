class BuildsController < ApplicationController
  before_filter :locate_build, :only => [:show, :destroy, :report]
  respond_to :js, :only => :show

  def show

  end

  def destroy
    project = @build.project
    @build.destroy
    redirect_to project_path(project)
  end

  def report
    send_file "#{@build.build_dir}/marketing/spec/reports/spec_report.html", :disposition =>'inline', :type => "text/html"
  end

  private
  def locate_build
    @build = Build.find(params[:id])
  end
end
