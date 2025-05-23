# frozen_string_literal: true

module DateHelper
  def date(date)
    date.strftime('%d/%m/%Y') # 31/12/2023
  end

  def datetime(date)
    date.strftime('%d/%m/%Y %H:%M:%S') # 31/12/2023 17:30:03
  end

  def datetimezone(datetime)
    datetime(Time.strptime(datetime.to_s, '%Y-%m-%dT%H:%M:%S%z').in_time_zone(Time.zone))
  end
end
