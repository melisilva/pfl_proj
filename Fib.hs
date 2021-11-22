import BigNumber
import GHC.Num

-- Alínea 1
-- Utiliza recursão direta para o cálculo de números de Fibonacci: fibRec(n) = fibRec(n-1) + fibRec(n - 2).
fibRec :: (Integral a) => a -> a
fibRec 0 = 0
fibRec 1 = 1
fibRec a | a > 0 = fibRec (a-2) + fibRec (a-1)
         | otherwise = error "Número negativo"

-- Utiliza uma lista de tamanho finito para o cálculo de números de Fibonacci: a função map é utilizada em conjunto com uma
-- função auxiliar (para as somas) que é definida dentro de fibLista - esta é aplicada sobre um intervalo de 2 até à ordem
-- desejada, impedindo cálculos desnecessários.
fibLista :: (Integral a) => a -> a
fibLista n = last lista
  where lista = 0 : 1 : map foo [2..(fromIntegral n)]
        foo n = lista !! (n-1) + lista !! (n-2)


-- Utiliza uma lista infinita para o cálculo de números de Fibonacci.
-- Usa-se indexação para se obter a ordem pretendida e zipWith para as somas.
fibListaInfinita :: (Integral a) => a -> a
fibListaInfinita a = lista !! (fromIntegral a)
  where lista = 0 : 1 : zipWith (+) lista (drop 1 lista)

-- Alínea 3
-- Segue a mesma lógica que a correspondente da alínea 1,
-- apenas usa as funções do módulo BigNumber para tal.
fibRecBN :: BigNumber -> BigNumber
fibRecBN [0] = [0]
fibRecBN [1] = [1]
fibRecBN a | not (less a zero) = somaBN (fibRecBN (subBN a two)) (fibRecBN (subBN a one))
           | otherwise = error "Número negativo"
  where zero = [0]
        one = [1]
        two = [2]

-- Função auxiliar que vai recursivamente preenchendo uma lista
-- com números de Fibonacci até à ordem n.
fibListaBNAux:: BigNumber -> BigNumber -> BigNumber -> BigNumber
fibListaBNAux [0] fib0 fib1 = fib0
fibListaBNAux n fib0 fib1 = fibListaBNAux (subBN n [1]) fib1 (somaBN fib0 fib1) 

-- Usa uma lista finita para o cálculo de números de Fibonacci com o módulo BigNumber. 
fibListaBN :: BigNumber -> BigNumber
fibListaBN n = fibListaBNAux n [0] [1]

-- Segue a mesma lógica que a correspondente da alínea 1,
-- apenas usa as funções do módulo BigNumber para tal.
fibListaInfinitaBN :: BigNumber -> BigNumber
fibListaInfinitaBN n = head (drop (fromBN n) lista)
  where lista = [zero] ++ [one] ++ [somaBN a b | (a, b)<- zip lista (tail lista)]
        zero = [0]
        one = [1]
        two = [2]

-- Estas funções só foram elaboradas no contexto da Alínea 4
-- Seguem a mesma lógica das funções da alínea 1, apenas foi mudado o tipo,
-- tendo-se em conta alterações necessárias através de fromIntegral.
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