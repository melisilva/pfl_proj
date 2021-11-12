--1.1) Função de fibonacci recursiva
fibRec :: (Integral a) => a -> a
--fibRec tem dois casos base: quando a toma o valor de 0 e o valor de 1
fibRec 0 = 0
fibRec 1 = 1
fibRec a | a > 0 = fibRec (a-2) + fibRec (a-1)
         | otherwise = error "Número negativo" --professor disse para não usar error, devemos usar o quê então?

--1.2) Função de fibonacci programação dinâmica
fibLista :: Int->Int
fibLista = (map fib [0..] !!)
  where fib 0 = 0
        fib 1 = 1
        fib a = fibLista (a-2) + fibLista (a-1)
--this uses memoization which is a dynamic programming techique

fibLista2 :: (Integral a) => a -> a
fibLista2 n = lista !! (fromIntegral n)
  where lista = 0 : 1 : map foo [2..]
        foo n = lista !! (n-1) + lista !! (n-2)

--1.3) Função de fibonacci lista infinita
fibListaInfinita :: (Integral a) => a -> a
fibListaInfinita a = lista !! (fromIntegral a)
  where lista = 0 : 1 : [n+b | (n,b)<- zip lista (tail lista)]
--where lista = 0 : 1 : zipWith (+) lista (tail lista)
--where lista = 0 : scanl(+) 1 lista
