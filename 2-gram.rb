class String
  def to_ngram(n)
    self.each_char
        .each_cons(n)
        .map(&:join)
  end
end

f = File.open("doc1.txt")
str = f.read
2gramstr = str.to_ngram(2)
puts 22gramstr

f.close
