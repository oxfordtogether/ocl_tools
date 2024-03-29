day_long = ->(date) { date.strftime("%a #{date.day.ordinalize} %b, %Y") }
day_short = ->(date) { date.strftime("%a #{date.day.ordinalize} %b") }
ord_long = ->(date) { date.strftime("#{date.day.ordinalize} %b, %Y") }
ord_short = ->(date) { date.strftime("#{date.day.ordinalize} %b") }

relative = lambda do |date|
  if date.today? && date.to_date != date
    # we don't want to display 00:00 when it's a date or a time that was converted from a date
    # date.to_date != date is true if and only if the time part is non-zero
    date.strftime('%H:%M')
  elsif date.year == Date.today.year
    date.strftime("#{date.day.ordinalize} %b")
  else
    date.strftime("#{date.day.ordinalize} %b %Y")
  end
end

am_pm = '%l:%M%P'

days_since = lambda do |date|
  if date.today?
    'today'
  elsif (date + 1.day).today?
    'yesterday'
  else
    "#{(Date.today - date.to_date).to_i} days ago"
  end
end

Time::DATE_FORMATS[:day_long] = Date::DATE_FORMATS[:day_long] = day_long
Time::DATE_FORMATS[:day_short] = Date::DATE_FORMATS[:day_short] = day_short
Time::DATE_FORMATS[:ord_long] = Date::DATE_FORMATS[:ord_long] = ord_long
Time::DATE_FORMATS[:ord_short] = Date::DATE_FORMATS[:ord_short] = ord_short
Time::DATE_FORMATS[:relative] = Date::DATE_FORMATS[:relative] = relative
Time::DATE_FORMATS[:days_since] = Date::DATE_FORMATS[:days_since] = days_since

Time::DATE_FORMATS[:am_pm] = am_pm
