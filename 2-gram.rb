class String
  def to_ngram(n)
    self.each_char
        .each_cons(n)
        .map(&:join)
  end
end



f = File.open("doc1.txt")
str = f.read
gramstr = str.to_ngram(2)
#puts 2gramstr
#puts "t".ord
f.close

table = [*'aa'..'zz']
#puts table[675] # table[0] => aa  table[26] => ba fin[675]
num = 0
gramtable = Array.new(676)
gramtable.map!(&:to_i)

table.each do |i|
  gramstr.each do |j|
    if i == j
      gramtable[num] = gramtable[num] + 1
    end
  end
  num = num +1
end

num =1
gramtable.each do |i|
  print sprintf("%03d, ",i)

  if num % 26 == 0
    puts
  end
  num = num +1
end
