module ServicesHelper
  def status_style(status)

    if status == 'applied' || status == 'beingInvited'
      'btn-warning'
    elsif status == 'rejected'
      'btn-danger'
    else
      'btn-success'
    end
  end

  def status_text(status)
    if status == 'applied' || status == 'beingInvited'
      'Pending'
    elsif status == 'rejected'
      'Rejected'
    else
      'Approved'
    end
  end

  def status_style2(status)

    if status == 'enrolled'
      'btn-primary'
    elsif status == 'confirmed'
      'btn-success'
    else
      'btn-success'
    end
  end

  def status_text2(status)
    if status == 'enrolled'
      'In progress'
    elsif status == 'confirmed'
      'Confirmed'
    else
      'Finished, waiting client to confirm'
    end
  end

end
