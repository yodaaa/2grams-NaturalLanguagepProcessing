table = [*'aa'..'ak', *'ba'..'bk', *'ca'..'ck', *'da'..'dk', *'ea'..'ek', *'fa'..'fk', *'ga'..'gk', *'ha'..'hk', *'ia'..'ik', *'ja'..'jk', *'ka'..'kk']
#puts table

#puts 1%11

line = "ます	形容動詞,*,*,*,特殊・マス,基本形,ます,マス,マス"



#品詞抽出
array = line.split
array = array[1].split(",")

puts array[0]
