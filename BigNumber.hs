import Data.String
--BigNumber podem ser positivos ou negativos
--O que fiz até agora só tem em conta os números positivos
--2.1) Definição de BigNumber
type BigNumber = [Int]


less :: BigNumber -> BigNumber -> Bool
less a b
      | length a > length b       = less a (utilPad (length a) b)
      | length a < length b       = less (utilPad (length b) a) b
      | (head a) == (head b)      = (<) (tail a) (tail b)
      | (head a) < (head b)       = True
      | (head a) > (head b)       = False 

equal :: BigNumber -> BigNumber -> Bool
equal a b
      | length a /= length b                                                 = False
      | not (any (==False) [ (a !! x) == (b !! x) | x<-[0..(length a - 1)]])     = True
      | otherwise                                                            = False


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
      | (head a) < 0                  = (head a) : [ (a !! x)*(-1) | x<-[1..len]]
      | otherwise                   = a
  where len = length a - 1

utilPad :: Int -> BigNumber -> BigNumber
utilPad n xs = replicate (n - length xs) 0 ++ xs

utilPadR :: Int -> BigNumber -> BigNumber
utilPadR n xs = xs ++ replicate n 0

utilUnpad :: BigNumber -> BigNumber
utilUnpad (x:xs)
      | x == 0 && length (x:xs) /= 1   = utilUnpad (drop 1 (x:xs))
      | otherwise = (x:xs)

utilUnPad' xs = if (length xs /= 1 && head(xs) == 0) then utilUnPad'(drop 1 xs) else xs

toDigits :: Int -> BigNumber
toDigits 0 = [0]
toDigits n = if n<0 then conv(toDigits(div (n*(-1)) 10) ++ [mod (n*(-1)) 10]) else toDigits (div n 10) ++ [mod n 10]

delZero :: BigNumber -> BigNumber
delZero n = if (head(n)==0 && length(n)/=1) then drop 1 n else n

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
      | x < 0 && length l /= 1                     = mod x 10 : utilSub (y - 1:xs)
      | x < 0 && length l == 1                     = mod x 10 : [quot x 10]    
      | x >= 10 && length l /= 1                   = mod x 10 : utilSub (y - 1:xs)
      | x >= 10 && length l == 1                   = mod x 10 : [quot x 10]
      | x >= 0 && x < 10 && length l /= 1          = x : utilSub (y:xs)
      | x >= 0 && x < 10 && length l == 1          = [x]
  where x = head l
        y = head (drop 1 l)
        xs = drop 2 l

utilSig :: BigNumber -> BigNumber
utilSig num
      | any (<0) num == True && head num > 0 = (head num)*(-1) : (map (abs) (tail num))
      | any (<0) num == True && head num < 0 = head num : map (abs) (tail num)
      | otherwise                            = num

processProduct :: BigNumber -> BigNumber
processProduct [] = []
processProduct l
      | abs x >= 10 && length l == 1 && x >= 0         = (mod x 10) : [div x 10]
      | abs x >= 10 && length l == 1 && x < 0          = (rem x 10) : [quot x 10]
      | abs x < 10 && length l == 1                    = [x]
      | abs x >= 10 && length l /= 1 && x >= 0         = (mod x 10) : processProduct (y + (div x 10):xs) 
      | abs x >= 10 && length l /= 1 && x < 0          = (rem x 10) : processProduct (y + (quot x 10):xs)  
      | abs x < 10 && length l /= 1                    = x : processProduct (y:xs)
  where x = head l
        y = head (drop 1 l)
        xs = drop 2 l

utilMul :: Int -> BigNumber -> BigNumber -> BigNumber
utilMul i a b
      | length b > 1           = somaBN currentProduct (utilMul (i + 1) a next)
      | length b == 1          = somaBN currentProduct [0]
      | otherwise              = []
  where currentProduct = utilSig (reverse (processProduct (reverse (utilPadR i (map (*x) a)))))
        x = last b
        next = init b

-- 2.4 ) somaBN
somaBN :: BigNumber -> BigNumber -> BigNumber
somaBN a b
      | (head a) < 0 && (head b) > 0    = subBN b (((head a))*(-1):tail a)
      | (head a) > 0 && (head b) < 0    = subBN a (((head b))*(-1):tail b)
      | (head a) < 0 && (head b) < 0    = ((head sumNeg)*(-1):tail sumNeg)
      | otherwise                   = reverse (utilSoma l)
  where l = zipWith (+) ra rb
        ra = reverse (utilPad len a)
        rb = reverse (utilPad len b)
        len = max (length a) (length b)
        sumNeg = somaBN (((head a))*(-1):tail a) (((head b))*(-1):tail b)

-- 2.5 ) subBN
subBN :: BigNumber -> BigNumber -> BigNumber
subBN a b
      | (head a) < (head b) && last a == 0 && (head b) == 0       = somaBN a (((head b))*(-1):tail b)
      | (head a) < (head b) && (head a) < 0 && (head b) > 0       = somaBN a (((head b))*(-1):tail b)
      | (head a) < (head b) && (head a) > 0 && (head b) > 0       = ((head subNewOrder)*(-1):tail subNewOrder)
      | (head a) > 0 && (head b) < 0                              = somaBN a (((head b))*(-1):tail b)
      | (head a) < 0 && (head b) < 0                              = subBN (((head b))*(-1):tail b) (((head a))*(-1):tail a)
      | (head a) < 0 && (head b) > 0                              = ((head somaNeg)*(-1):tail somaNeg)
      | (head a) > 0 && (head b) > 0                              = utilUnpad (reverse (utilSub l))
  where l = zipWith (-) ra rb
        ra = reverse (utilPad len a)
        rb = reverse (utilPad len b)
        len = max (length a) (length b)
        somaNeg = somaBN (((head a))*(-1):tail a) b
        subNewOrder = subBN b a

-- 2.6) mulBN
mulBN :: BigNumber -> BigNumber -> BigNumber
mulBN a b 
      | (head a) < 0 && (head b) > 0    = utilSig (head aNbP : map (*(-1)) (tail aNbP))
      | (head a) > 0 && (head b) < 0    = utilSig (head aPbN : map (*(-1)) (tail aPbN))
      | (head a) < 0 && (head b) < 0    = utilMul 0 (utilNegative a) (utilNegative b)
      | otherwise                   = utilMul 0 a b
  where aNbP = utilMul 0 (utilNegative a) b
        aPbN = utilMul 0 a (utilNegative b)

utilPositive :: BigNumber -> BigNumber
utilPositive a = mulBN [-1] a

getLenA :: Int -> BigNumber -> BigNumber -> Int
getLenA i a b
      | less (take i a) b     = getLenA (i + 1) a b
      | otherwise             = i

one = [1]

utilDiv :: BigNumber -> BigNumber -> BigNumber -> BigNumber
utilDiv _ [] b = []
utilDiv _ a [] = []
utilDiv _ a [1] = a
utilDiv i a b
      | last a == 0 && last b == 0                                                     = (utilDiv i (init a) (init b)) -- para simplificar contas com números grandes, por exemplo divisão por 10
      | less quo initA && less prod initA                                              = utilDiv (somaBN i one) a b -- este é para ir subindo o i, quando ainda não chegámos ao melhor
      | less quo initA && equal prod initA                                             = somaBN i one -- este é caso cheguemos ao exato que queremos
      | less quo initA && not (less prod initA) && divisorRest /= []                   = i ++ utilDiv one (sub ++ divisorRest) b
      | less a b                                                                       = []
      | otherwise                                                                      = i
  where initA = if (getLenA 0 a b) /= length a then take (getLenA 0 a b) a else a
        quo = mulBN i b
        prod = mulBN add1 b
        add1 = somaBN i one
        sub = subBN initA quo
        divisorRest = if length initA /= length a then drop (length initA) a else []

-- 2.7) divBN
divBN :: BigNumber -> BigNumber -> (BigNumber, BigNumber)
divBN a b
      | (head a) < 0 && (head b) < 0    = (negative, subBN (utilPositive a) (mulBN negative (utilPositive b)))
      | (head a) < 0 || (head b) < 0    = (mulBN [-1] negative, mulBN [-1] resNegative)  
      | less a b                        = ([0], [0])
      | otherwise                       = (pos, subBN a (mulBN pos b))
  where negative = utilDiv one (utilPositive a) (utilPositive b)
        resNegative = subBN (utilPositive a) (mulBN (utilPositive b) negative)
        pos = utilDiv one a b