--1.1) Função de fibonacci recursiva
fibRec :: (Integral a) => a -> a
--fibRec tem dois casos base: quando a toma o valor de 0 e o valor de 1
fibRec 0 = 0
fibRec 1 = 1
fibRec a | n > 0 = fibRec (n-2) + fibRec (n-1)
         | otherwise = error "Número negativo" --professor disse para não usar error, devemos usar o quê então?
