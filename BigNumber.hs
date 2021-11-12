import Data.String

--BigNumber podem ser positivos ou negativos
--O que fiz até agora só tem em conta os números positivos
--2.1) Definição de BigNumber
type BigNumber = [Int]

--2.2) Função scanner--->folha 1 1.16 reverse
utilClean :: String -> [String]
utilClean str = [ new !! x | x<-[0..(length new - 1)], mod x 2 == 0]
      where new = words str

-- scanner :: String -> BigNumber
-- where l = utilClean str

--Centro e trinta == [1,3,0]

--2.3) Função output
--This exercise was done using 1.16 as a basis
--It accepts negative and positive numbers lower than 1 million (like 1.16)
converte :: Int -> String
cv1 :: Int -> Int -> String
cv2 :: Int -> String
cv3 :: Int -> String
cv4 :: Int -> String
centenas :: Int -> String
dezenas :: Int -> String
unidades :: Int -> String
offsets :: Int -> String
fromDigits :: BigNumber -> Int
output :: BigNumber -> String
conv :: BigNumber -> BigNumber
convInt :: Int -> Int

convInt x = (-1)*x

conv xs = ((-1)*head(xs)): drop 1 xs

output xs = converte(fromDigits xs)

fromDigits xs = if head(xs) < 0 then (-1)*(sum (zipWith (*) (reverse (conv xs)) (iterate (*10) 1))) else sum (zipWith (*) (reverse xs) (iterate (*10) 1))

converte x | x < 0 = "menos " ++ cv1 millie centie ++ cv2 centie
           | otherwise = cv1 mil cent ++ cv2 cent
           where mil = x `div` 1000
                 cent = x `mod` 1000
                 millie = (convInt x)`div`1000
                 centie = (convInt x)`mod`1000

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

-- Funções úteis para as operações
utilNegative :: BigNumber -> BigNumber
utilNegative a
      | head a < 0  = head a : [ (a !! x)*(-1) | x<-[1..len]]
      | otherwise   = a
  where len = length a - 1

utilPad :: Int -> BigNumber -> BigNumber
utilPad n xs = replicate (n - length xs) 0 ++ xs

utilUnpad :: BigNumber -> BigNumber
utilUnpad (x:xs)
      | x == 0 && length (x:xs) /= 1   = utilUnpad (drop 1 (x:xs))
      | otherwise = (x:xs)

utilUnPad' xs = if (length xs /= 1 && head(xs) == 0) then utilUnPad'(drop 1 xs) else xs

utilSoma :: BigNumber -> BigNumber
utilSoma [] = []
utilSoma l
      | x >= 10 && length l /= 1           = mod x 10 : utilSoma (y+1:xs)
      | x >= 10 && length l == 1           = mod x 10 : [quot x 10]
      | x < 10 && length l /= 1            = x : utilSoma (y:xs)
      | x < 10 && length l == 1            = [x]
  where x = head l
        y = head (drop 1 l)
        xs = drop 2 l

utilSub :: BigNumber -> BigNumber
utilSub [] = []
utilSub l
      | x <= 0 && length l /= 1                   = mod x 10 : utilSub (y - 1:xs)
      | x <= 0 && length l == 1                   = mod x 10 : [quot x 10]
      | x >= 10 && length l /= 1                  = mod x 10 : utilSub (y - 1:xs)
      | x >= 10 && length l == 1                  = mod x 10 : [quot x 10]
      | x > 0 && x < 10 && length l /= 1          = x : utilSub (y:xs)
      | x > 0 && x < 10 && length l == 1          = [x]
  where x = head l
        y = head (drop 1 l)
        xs = drop 2 l

-- 2.4 ) somaBN
somaBN :: BigNumber -> BigNumber -> BigNumber
somaBN a b
      | head a < 0 && head b > 0    = subBN b ((head a)*(-1):tail a)
      | head a > 0 && head b < 0    = subBN a ((head b)*(-1):tail b)
      | head a < 0 && head b < 0    = ((head sumNeg)*(-1):tail sumNeg)
      | otherwise                   = reverse (utilSoma l)
  where l = zipWith (+) ra rb
        ra = reverse (utilPad len a)
        rb = reverse (utilPad len b)
        len = max (length a) (length b)
        sumNeg = somaBN ((head a)*(-1):tail a) ((head b)*(-1):tail b)


-- 2.5 ) subBN
subBN :: BigNumber -> BigNumber -> BigNumber
subBN a b
      | head a < head b            = ((head subNewOrder)*(-1):tail subNewOrder)
      | head a > 0 && head b < 0   = somaBN a ((head b)*(-1):tail b)
      | head a < 0 && head b < 0   = subBN ((head b)*(-1):tail b) ((head a)*(-1):tail a)
      | head a < 0 && head b > 0   = ((head somaNeg)*(-1):tail somaNeg)
      | head a > 0 && head b > 0   = utilUnpad (reverse (utilSub l))
  where l = zipWith (-) ra rb
        ra = reverse (utilPad len a)
        rb = reverse (utilPad len b)
        len = max (length a) (length b)
        somaNeg = somaBN ((head a)*(-1):tail a) b
        subNewOrder = subBN b a