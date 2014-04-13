class DelayedJobsController < ApplicationController

  def get_status
		job = Delayed::Job.find_by_id(params[:id])
		@status = job && job.failed_at.nil? && job.status_code != "end" ? job.status : ""
	end

end
