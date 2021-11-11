--BigNumber podem ser positivos ou negativos
--O que fiz até agora só tem em conta os números positivos
--2.1) Definição de BigNumber
type BigNumber = [Int]

--2.2) Função scanner--->folha 1 1.16 reverse
--scanner :: String->BigNumber
--Centro e trinta == [1,3,0]

--2.3) Função output-->folha 1 1.16 but with lists
converte :: Int -> String
cv1 :: Int -> Int -> String
cv2 :: Int -> String
cv3 :: Int -> String
cv4 :: Int -> String
centenas :: Int -> String
dezenas :: Int -> String
unidades :: Int -> String
offsets :: Int -> String
fromDigits :: BigNumber->Int
output :: BigNumber->String

output xs = converte(fromDigits xs)

fromDigits xs = sum (zipWith (*) (reverse xs) (iterate (*10) 1))

converte x | x < 0 || x > 999999 = "invalido"
           | otherwise = cv1 mil cent ++ cv2 cent
           where mil = x `div` 1000
                 cent = x `mod` 1000

cv1 x y | x == 0 = ""
        | x == 1 && (c == 0 || d2 == 0) = "mil e "
        | x == 1 = "mil "
        | c == 0 || d2 == 0 = cv2 x ++ " mil e "
        | otherwise = cv2 x ++ " mil "
         where c = y `div` 100
               d = (y `div` 10) `mod` 10
               d2 = y `mod` 100

cv2 x | c == 0 = cv3 x
      | x == 100 = "cem"
      | offs == 0 = centenas c
      | otherwise = centenas c ++ " e " ++ cv3 x
      where offs = x `mod` 100
            c = x `div` 100

cv3 x | offs > 10 && offs < 20 = offsets u
      | d == 0 = cv4 x
      | u == 0 = dezenas d
      | otherwise = dezenas d ++ " e " ++ cv4 x
      where offs = x `mod` 100
            d = (x `div` 10) `mod` 10
            u = x `mod` 10

cv4 x | u == 0 = ""
      | otherwise = unidades u
      where u = x `mod` 10

centenas x = ["cento", "duzentos", "trezentos", "quatrocentos", "quinhentos", "seiscentos", "setecentos", "oitocentos", "novecentos"]!!(x-1)

dezenas x = ["dez", "vinte", "trinta", "quarenta", "cinquenta", "sessenta", "setenta", "oitenta", "noventa"]!!(x-1)

unidades x = ["um", "dois", "tres", "quatro", "cinco", "seis", "sete", "oito", "nove"]!!(x-1)

offsets x = ["onze", "doze", "treze", "catorze", "quinze", "dezasseis", "dezassete", "dezoito", "dezanove"]!!(x-1)
