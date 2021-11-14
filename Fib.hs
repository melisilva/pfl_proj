import BigNumber

--1.1) Função de fibonacci recursiva
fibRec :: (Integral a) => a -> a
--fibRec tem dois casos base: quando a toma o valor de 0 e o valor de 1
fibRec 0 = 0
fibRec 1 = 1
fibRec a | a > 0 = fibRec (a-2) + fibRec (a-1)
         | otherwise = error "Número negativo" --professor disse para não usar error, devemos usar o quê então?

--1.2) Função de fibonacci programação dinâmica
fibLista :: (Integral a) => a -> a
fibLista n = lista !! (fromIntegral n)
  where lista = 0 : 1 : map foo [2..]
        foo n = lista !! (n-1) + lista !! (n-2)

--1.3) Função de fibonacci lista infinita
-- fibListaInfinita :: (Integral a) => a -> a
fibListaInfinita a = lista !! (fromIntegral a)
  where lista = 0 : 1 : [n+b | (n,b)<- zip lista (tail lista)]
--where lista = 0 : 1 : zipWith (+) lista (tail lista)
--where lista = 0 : scanl(+) 1 lista

-- Ex3
-- 3.1
fibRecBN :: BigNumber -> BigNumber
fibRecBN [0] = [0]
fibRecBN [1] = [1]
fibRecBN a | not (less a [0]) = somaBN (fibRecBN (subBN a [2])) (fibRecBN (subBN a [1]))
           | otherwise = error "Número negativo"

-- fibListaBN :: BigNumber -> BigNumber
-- fibListaBN n = lista !! (read (output n) :: Int)
-- where lista = scanner "0" ++ scanner "1" ++ map foo [2..]
--     foo n = somaBN (lista !! (fromBN (subBN n [1]))) (lista !! (fromBN (subBN n [2])))