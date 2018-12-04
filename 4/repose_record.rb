id = nil
time_fell_asleep = nil
guards = {}
guards_minutes = {}
File.readlines('input.txt').sort.each do |line|
  id = line.scan(/Guard #(\d+)/)&.last&.first || id
  guards[id] ||= {}

  month = line.split(/[\[\]-]/)[2]
  day = line.split(/[\[\]-]/)[3].split(' ')[0]
  date = "#{month}-#{day}"
  guards[id][date] ||= Array.new(60, true)

  action = line.split(/[\[\]-]/)[4].strip
  if action == 'falls asleep'
    time_fell_asleep = line.split(/[\[\]-]/)[3].split(' ')[1]
  end

  next unless action == 'wakes up'
  time_woke_up = line.split(/[\[\]-]/)[3].split(' ')[1]
  (time_fell_asleep.split(':')[1].to_i..(time_woke_up.split(':')[1].to_i - 1)).each do |index|
    guards_minutes[id] ||= Array.new(60, 0)
    guards_minutes[id][index] += 1
    guards[id][date][index] = false
    time_fell_asleep = nil
  end
end

minutes_asleep = {}
ids = guards.keys
ids.each do |id|
  dates = guards[id].keys
  dates.each do |date|
    minutes = guards[id][date]
    minutes_asleep[id] ||= 0
    minutes_asleep[id] += minutes.count(false)
  end
end
sleepiest_id = minutes_asleep.max_by { |_k, v| v }[0]
sleepiest_minute = guards_minutes[sleepiest_id].each_with_index.max[1]
answer = sleepiest_id.to_i * sleepiest_minute
puts "Guard #{sleepiest_id} slept the most"
puts "He was mostly asleep in minute #{sleepiest_minute}"
puts "Multiplied we get #{answer}"

sm_guard_id = nil
sm_minute = nil
sm_occurrences = 0
guards_minutes.keys.each do |id|
  guards_minutes[id].each_with_index do |occurrences, minute|
    next unless occurrences > sm_occurrences
    sm_guard_id = id
    sm_minute = minute
    sm_occurrences = occurrences
  end
end

puts "#{sm_guard_id} * #{sm_minute} = #{sm_guard_id.to_i * sm_minute}"
