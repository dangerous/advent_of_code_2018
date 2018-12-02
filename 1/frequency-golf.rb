p eval(File.read(?i).tr("\n",''))
*a=0;loop{File.foreach(?i).map{|l|b=a[-1]+l.to_i;(p b;exit)if a.include?b;a<<b}}

# part 1 is only safe because I control input.txt
# to make it safe for any input:
# eval(File.read(?i).gsub(/[^\d+-]/, '')

# there are shorter ways to do the a.include?b in part 2, e.g.
# a=[0];loop{File.readlines(?i).map{|l|b=a[-1]+l.to_i;(p b;exit)if a-[b]!=a;a<<b}}
# a=[0];loop{File.readlines(?i).map{|l|b=a[-1]+l.to_i;a<<b;(p b;exit)if a.uniq!}}
# however these are inefficient, especially the uniq option
