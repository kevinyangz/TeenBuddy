module PostApplicationsHelper


  def app_inv_status_style(status)
    if status == 'Approved'
      'btn-success'
    elsif status == 'Rejected'
      'btn-danger'
    else
      'btn-warning'
    end
  end
end
