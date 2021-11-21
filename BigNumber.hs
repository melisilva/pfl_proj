-- Alínea 2
module BigNumber (BigNumber,
                  less, equal, scanner, output, somaBN, subBN, divBN, mulBN, fromBN, safeDivBN) where

import Data.String

-- 2.1) Definição de BigNumber
type BigNumber = [Int]

-- Operadores de comparação
less :: BigNumber -> BigNumber -> Bool
less a b
      | a == b                    = False
      | a == []                   = less [0] b
      | b == []                   = less a [0]
      | a == [0] && head b > 0    = True
      | a == [0] && head b < 0    = False
      | head a > 0 && b == [0]    = False
      | head a < 0 && b == [0]    = True
      | (take 1 a) == [0]         = less (tail a) b
      | (take 1 b) == [0]         = less a (tail b)
      | length a > length b       = False
      | length a < length b       = True
      | (head a) == (head b)      = (<) (tail a) (tail b)
      | (head a) < (head b)       = True
      | (head a) > (head b)       = False

equal :: BigNumber -> BigNumber -> Bool
equal a b
      | a == b                    = True
      | (take 1 a) == [0]         = equal (tail a) b
      | (take 1 b) == [0]         = equal a (tail b)
      | length a /= length b                                                     = False
      | not (any (==False) [ (a !! x) == (b !! x) | x<-[0..(length a - 1)]])     = True
      | otherwise                                                                = False

-- 2.2) Função scanner
toBN :: Int -> BigNumber
toBN 0 = [0]
toBN n
      | abs n >= 10    =  toBN (quot n 10) ++ [rem n 10]
      | otherwise      = [rem n 10]

scanner :: String -> BigNumber
scanner str
      | head str == '-'            = (head treatAsPosRes: map (*(-1)) (tail treatAsPosRes))
      | otherwise                  = treatAsPosRes
 where treatAsPosRes = toBN num
       num = read str :: Int

-- 2.3) Função output
fromBN :: BigNumber -> Int
fromBN xs = if head(xs) < 0 then (-1)*(sum (zipWith (*) (reverse (conv xs)) (iterate (*10) 1))) else sum (zipWith (*) (reverse xs) (iterate (*10) 1))

conv :: BigNumber -> BigNumber
conv xs = ((-1)*head(xs)): drop 1 xs

strinNum :: [String] -> String
strinNum xs = if length(xs) /= 1 then head(xs) ++ strinNum(drop 1 xs) else head(xs)

output :: BigNumber -> String
output xs = strinNum (map show xs)

-- utils
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

utilDiv :: BigNumber -> BigNumber -> BigNumber
utilDiv a b
      | not (less (subBN a b) [0])        = somaBN [1] (utilDiv (subBN a b) b)
      | equal (subBN a b) [0]             = [1]
      | otherwise                         = [0]

-- 2.4 ) somaBN
somaBN :: BigNumber -> BigNumber -> BigNumber
somaBN [0] b = b
somaBN a [0] = a
somaBN a [] = a
somaBN [] b = b
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
subBN a [] = a
subBN [] b = ((head b)*(-1):tail b)
subBN a [0] = a
subBN [0] b = ((head b)*(-1):tail b)
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
mulBN [] b = [0]
mulBN a [] = [0]
mulBN a [0] = [0]
mulBN [0] b = [0]
mulBN a [1] = a
mulBN [1] b = b
mulBN a b
      | (head a) < 0 && (head b) > 0    = utilSig (head aNbP : map (*(-1)) (tail aNbP))
      | (head a) > 0 && (head b) < 0    = utilSig (head aPbN : map (*(-1)) (tail aPbN))
      | (head a) < 0 && (head b) < 0    = utilMul 0 (utilNegative a) (utilNegative b)
      | otherwise                   = utilMul 0 a b
  where aNbP = utilMul 0 (utilNegative a) b
        aPbN = utilMul 0 a (utilNegative b)

-- 2.7) divBN
divBN [] _ = ([], [])
divBN _ [] = error "EMPTY DIVISOR"
divBN [0] _ = ([0], [0])
divBN a b
      | equal a b                       = (one, zero)
      | (head a) < 0 && (head b) < 0    = (negative, subBN a (mulBN negative b))
      | (head a) < 0                    = (mulBN [-1] negative, mulBN [-1] resNegative)
      | (head b) < 0                    = (mulBN [-1] negative, resNegative)
      | less a b                        = (zero, a)
      | otherwise                       = (pos, subBN a (mulBN pos b))
  where negative = utilDiv (utilPositive a) (utilPositive b)
        resNegative = subBN (utilPositive a) (mulBN (utilPositive b) negative)
        pos = utilDiv a b
        one = [1]
        zero = [0]

-- Alínea 5
safeDivBN :: BigNumber -> BigNumber -> Maybe (BigNumber, BigNumber)
safeDivBN a b
      | b == [0]              = Nothing
      | otherwise             = Just (divBN a b)
