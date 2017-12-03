module ConversationsHelper

  def mailbox_section(title, current_box, opts = {})
    opts[:class] = opts.fetch(:class, '')
    opts[:class] += ' active' if title.downcase == current_box
    content_tag :li, link_to(title.capitalize, conversations_path(box: title.downcase)), opts
  end

  def conv_section(conversation, opts={})
    opts[:class] = opts.fetch(:class, '')


    participants = conversation.participants
    if current_user == participants.first
      other_person = participants.second
    else
      other_person = participants.first
    end
    content_tag :li, link_to(conversation.subject, conversations_path(conv: conversation.id)), opts

  end
end
