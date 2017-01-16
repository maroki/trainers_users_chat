module ApplicationHelper
  def gravatar_for(user, opts = {})
    opts[:alt] = user.name
    image_tag "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}?s=#{opts.delete(:size) { 40 }}",
              opts
  end

  def format_time(time)
    time.strftime('%H:%M %d %B') if ((Time.now - 3.days).beginning_of_day .. (Time.now + 3.days).end_of_day).include?(time)
    time.strftime('%d %B') if (Time.now.beginning_of_year .. Time.now.end_of_year).include?(time)
    time.strftime('%d %B %Y')
  end

  def client_collector_array(clients)
    clients.map { |c| [ "#{c.name} (#{c.role.humanize})", c.id] }
  end

  def clients_names(clients)
    clients.map(&:name).join(', ')
  end
end
