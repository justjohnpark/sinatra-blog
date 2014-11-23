def timestamp_to_s(timestamp)
  year = timestamp.to_s[0..3]
  month = timestamp.to_s[5..6]
  day = timestamp.to_s[8..9]
  "#{month}.#{day}.#{year}"
end