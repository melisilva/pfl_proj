import BigNumber
import GHC.Num

-- Alínea 1
fibRec :: (Integral a) => a -> a
fibRec 0 = 0
fibRec 1 = 1
fibRec a | a > 0 = fibRec (a-2) + fibRec (a-1)
         | otherwise = error "Número negativo"

fibLista :: (Integral a) => a -> a
fibLista n = lista !! (fromIntegral n)
  where lista = 0 : 1 : map foo [2..(fromIntegral n)]
        foo n = lista !! (n-1) + lista !! (n-2)

fibListaInfinita :: (Integral a) => a -> a
fibListaInfinita a = lista !! (fromIntegral a)
  where lista = 0 : 1 : zipWith (+) lista (drop 1 lista)

-- Alínea 3
fibRecBN :: BigNumber -> BigNumber
fibRecBN [0] = [0]
fibRecBN [1] = [1]
fibRecBN a | not (less a zero) = somaBN (fibRecBN (subBN a two)) (fibRecBN (subBN a one))
           | otherwise = error "Número negativo"
  where zero = [0]
        one = [1]
        two = [2]

fibListaBNAux:: BigNumber -> BigNumber -> BigNumber -> BigNumber
fibListaBNAux [0] fib0 fib1 = fib0
fibListaBNAux n fib0 fib1 = fibListaBNAux (subBN n [1]) fib1 (somaBN fib0 fib1) 

fibListaBN :: BigNumber -> BigNumber
fibListaBN n = fibListaBNAux n [0] [1]

fibListaInfinitaBN :: BigNumber -> BigNumber
fibListaInfinitaBN n = head (drop (fromBN n) lista)
  where lista = [zero] ++ [one] ++ [somaBN a b | (a, b)<- zip lista (tail lista)]
        zero = [0]
        one = [1]
        two = [2]

-- Estas funções só foram elaboradas no contexto da Alínea 4
fibRecInteger :: Integer -> Integer
fibRecInteger 0 = 0
fibRecInteger 1 = 1
fibRecInteger a | a > 0 = fibRecInteger (a - 2) + fibRecInteger (a - 1)
                | otherwise = error "Número negativo"

fibListaInteger :: Integer -> Integer
fibListaInteger n = lista !! (fromIntegral n)
  where lista = 0 : 1 : map foo [2..(fromIntegral n)]
        foo n = lista !! (n-1) + lista !! (n-2)

fibListaInfinitaInteger :: Integer -> Integer
fibListaInfinitaInteger a = lista !! (fromIntegral a)
  where lista = 0 : 1 : zipWith (+) lista (drop 1 lista)