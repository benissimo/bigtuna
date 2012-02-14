class BuildsController < ApplicationController
  before_filter :locate_build, :only => [:show, :destroy, :report]
  respond_to :js, :only => :show

  def show
    @show_report_link = show_report_link?
  end

  def destroy
    project = @build.project
    @build.destroy
    redirect_to project_path(project)
  end

  def report
    return render :text => "no report found", :status => 500 unless File.exists?(report_file)
    send_file report_file, :disposition =>'inline', :type => "text/html"
  end

  private
  def locate_build
    @build = Build.find(params[:id])
  end

  def report_file
    "#{@build.build_dir}/marketing/spec/reports/spec_report.html"
  end

  def show_report_link?
    File.exists?(report_file)
  end

end
