################################
# calculate average time to release
# from initial commit, assuming tag
# time is same as release
#
# call this script like:
#  git log --decorate --tags --pretty=format:'%ai|%h|%ae|%d' -n 30 | ruby /c/c ode/git.enova.com/lwalters/notes/git_time_to_value.rb
#
############################

require 'date'
DELIMITER = '|'
tag_date = nil
commit_count = 0
commit_days = 0
ARGF.each_line do |e|
  e.strip!
  commit = e.split(DELIMITER)
  if commit.length == 4 && commit[3].length > 0
    tag_date = DateTime.parse(commit[0])
    puts "New tag_date: #{tag_date.strftime('%h-%m-%d')}"
  end
  
  commit_date = DateTime.parse(commit[0])
  days = (tag_date - commit_date).to_f.round(1)
  puts "  #{days} days (committed #{commit_date.strftime('%h-%m-%d')})"
  commit_count = commit_count + 1
  commit_days = commit_days + days
end
puts '------------'
puts "Total commits: #{commit_count}  Average time to release: #{(commit_days / commit_count).to_f.round(1)} days"