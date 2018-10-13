# coding: UTF-8


# 品詞頻度カウント
partof　= Array["動詞","形容詞","形容動詞","名詞","副詞","連体詞","接続詞","感動詞","助詞","助動詞","記号"]
cnt = Array.new(12, 0) # 動詞,形容詞,形容動詞,名詞,副詞,連体詞,接続詞,感動詞,助詞,助動詞,記号

File.open("result.txt", mode = "rt"){|f|
  f.each_line{|line|
    #p line

    ["動詞","形容詞","形容動詞","名詞","副詞","連体詞","接続詞","感動詞","助詞","助動詞","記号"].each_with_index { |i, count|
      if line.slice(i) != nil
        p line.slice(i)
        p count
        cnt[count] = cnt[count] + 1
        count = 0
      end
      count = count +1
    }
  }
  puts "品詞頻度: #{cnt}"
}
