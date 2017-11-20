module ServicesHelper
  def status_style(status)
    if status == 'enrolled'
      'btn-success'
    elsif status == 'rejected'
      'btn-danger'
    else
      'btn-warning'
    end
  end

  def status_text(status)
    if status == 'enrolled'
      'Approved'
    elsif status == 'rejected'
      'Rejected'
    else
      'Pending'
    end
  end


end
