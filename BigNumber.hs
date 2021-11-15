module BigNumber (BigNumber,
                  less, equal, scanner, output, somaBN, subBN, divBN, mulBN, fromBN) where

import Data.String

--2.1) Definição de BigNumber
type BigNumber = [Int]

-- Operadores de comparação
less :: BigNumber -> BigNumber -> Bool
less a b
      | length a > length b       = less a (utilPad (length a) b)
      | length a < length b       = less (utilPad (length b) a) b
      | (head a) == (head b)      = (<) (tail a) (tail b)
      | (head a) < (head b)       = True
      | (head a) > (head b)       = False

equal :: BigNumber -> BigNumber -> Bool
equal a b
      | length a /= length b                                                     = False
      | not (any (==False) [ (a !! x) == (b !! x) | x<-[0..(length a - 1)]])     = True
      | otherwise                                                                = False

--2.2) Função scanner
toBN :: Int -> BigNumber
toBN n
      | abs n > 10 && n < 0     = (rem n 10:toBN (quot n 10))
      | otherwise               = [rem n 10]

scanner :: String -> BigNumber
scanner str
      | head str == '-'            = (head treatAsPosRes: map (*(-1)) (tail treatAsPosRes))
      | otherwise                  = treatAsPosRes
 where treatAsPosRes = reverse (toBN num)
       num= read str :: Int

--2.3) Função output
fromBN :: BigNumber -> Int
fromBN xs = if head(xs) < 0 then (-1)*(sum (zipWith (*) (reverse (conv xs)) (iterate (*10) 1))) else sum (zipWith (*) (reverse xs) (iterate (*10) 1))

conv :: BigNumber -> BigNumber
conv xs = ((-1)*head(xs)): drop 1 xs

strinNum :: [String] -> String
strinNum xs = if length(xs) /= 1 then head(xs) ++ strinNum(drop 1 xs) else head(xs)

output :: BigNumber -> String
output xs = strinNum (map show xs)

-- Funções úteis para as operações
utilNegative :: BigNumber -> BigNumber
utilNegative a
      | (head a) < 0                  = (head a) : [ (a !! x)*(-1) | x<-[1..len]]
      | otherwise                     = a
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
      | x >= 10 && length l /= 1           = mod x 10 : utilSoma (y+1:xs) -- [1]
      | x >= 10 && length l == 1           = mod x 10 : [quot x 10] -- [3]
      | x < 10 && length l /= 1            = x : utilSoma (y:xs) -- [1] [2]
      | x < 10 && length l == 1            = [x] -- [2]
  where x = head l
        y = head (drop 1 l)
        xs = drop 2 l

utilSub :: BigNumber -> BigNumber
utilSub [] = []
utilSub l
      | x < 0 && length l /= 1                     = mod x 10 : utilSub (y - 1:xs) -- [1]
      | x < 0 && length l == 1                     = mod x 10 : [quot x 10]
      | x >= 10 && length l /= 1                   = mod x 10 : utilSub (y - 1:xs) -- [1]
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


utilPositive :: BigNumber -> BigNumber
utilPositive a = if head(a)<0 then mulBN [-1] a else a

getLenA :: Int -> BigNumber -> BigNumber -> Int
getLenA i a b
      | less (take i a) b || equal (take i a) b   = getLenA (i + 1) a b
      | otherwise                                 = i

one = [1]

utilDiv :: BigNumber -> BigNumber -> BigNumber -> BigNumber
utilDiv _ [] b = []
utilDiv _ a [] = []
utilDiv _ a [1] = a
utilDiv _ [0] _ = [0]
utilDiv i a b
      | last a == 0 && last b == 0                                                     = (utilDiv i (init a) (init b)) -- para simplificar contas com números grandes, por exemplo divisão por 10
      | last a == 0 && last b == head a && length a > length b + 1                     = somaBN i [0] ++ [0]
      | less quo initA && equal prod initA && divisorRest == [0]                       = somaBN i one ++ [0]
      | less quo initA && equal prod initA                                             = somaBN i one -- este é caso cheguemos ao exato que queremos
      | less quo initA && less prod initA                                              = utilDiv (somaBN i one) a b -- este é para ir subindo o i, quando ainda não chegámos ao melhor
      | less quo initA && not (less prod initA) && divisorRest /= []                   = i ++ utilDiv one (sub ++ divisorRest) b
      | less quo initA && not (less prod initA) && divisorRest == [0]                  = i ++ [0]
      | otherwise                                                                      = i
  where initA = if (getLenA 0 a b) /= length a then take (getLenA 0 a b) a else a
        quo = mulBN i b
        prod = mulBN add1 b
        add1 = somaBN i one
        sub = subBN initA quo
        divisorRest = if length initA /= length a then drop (length initA) a else []

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
      | (head a) >= 0 && (head b) <= 0                              = somaBN a (((head b))*(-1):tail b)
      | (head a) <= 0 && (head b) <= 0                              = subBN (((head b))*(-1):tail b) (((head a))*(-1):tail a)
      | (head a) <= 0 && (head b) >= 0                              = ((head somaNeg)*(-1):tail somaNeg)
      | (head a) >= 0 && (head b) >= 0 && less a b                  = ((head goesNegative)*(-1):tail goesNegative)
      | (head a) >= 0 && (head b) >= 0                              = utilUnpad (reverse (utilSub l))
  where l = zipWith (-) ra rb
        ra = reverse (utilPad len a)
        rb = reverse (utilPad len b)
        len = max (length a) (length b)
        somaNeg = somaBN (((head a))*(-1):tail a) b
        subNewOrder = subBN b a
        goesNegative = subBN b a

-- 2.6) mulBN
mulBN :: BigNumber -> BigNumber -> BigNumber
mulBN a b
      | (head a) < 0 && (head b) > 0    = utilSig (head aNbP : map (*(-1)) (tail aNbP))
      | (head a) > 0 && (head b) < 0    = utilSig (head aPbN : map (*(-1)) (tail aPbN))
      | (head a) < 0 && (head b) < 0    = utilMul 0 (utilNegative a) (utilNegative b)
      | otherwise                   = utilMul 0 a b
  where aNbP = utilMul 0 (utilNegative a) b
        aPbN = utilMul 0 a (utilNegative b)

-- 2.7) divBN
divBN :: BigNumber -> BigNumber -> (BigNumber, BigNumber)
divBN a b
      | (head a) < 0 && (head b) < 0    = (negative, subBN a (mulBN negative b))
      | (head a) < 0 || (head b) < 0    = (mulBN [-1] negative, mulBN [-1] resNegative)
      | less a b                        = ([0], [0])
      | otherwise                       = (pos, subBN a (mulBN pos b))
  where negative = utilDiv one (utilPositive a) (utilPositive b)
        resNegative = subBN (utilPositive a) (mulBN (utilPositive b) negative)
        pos = utilDiv one a b
