--1.1) Função de fibonacci recursiva
fibRec :: (Integral a) => a -> a
--fibRec tem dois casos base: quando a toma o valor de 0 e o valor de 1
fibRec 0 = 0
fibRec 1 = 1
fibRec a | a > 0 = fibRec (a-2) + fibRec (a-1)
         | otherwise = error "Número negativo" --professor disse para não usar error, devemos usar o quê então?

--1.2) Função de fibonacci programação dinâmica
--Penso que como argumento devemos dar um integer e calcular a sequência de fibonacci até esse Número
--ex n=10-->[0,1,1,2,3,5,8,13,21,34,55]
--if you do [0,1,1,2,3,5,8,13,21,34,55] !! 10, you get 10-->as it's asked
fibLista :: (Integral a) => a -> [a]
fibLista a = (map fibRec[0..a])

--1.3) Função de fibonacci lista infinita
fibListaInfinita :: [Integer]
fibListaInfinita = 0 : 1 : [a+b | (a,b)<- zip fibListaInfinita (tail fibListaInfinita)]
fibListaInfinita = 0 : 1 : zipWith (+) fibListaInfinita (tail fibListaInfinita)
fibListaInfinita = 0 : 1 : [ a | b <-[2..], let a = ((fibListaInfinita !! (b-1)) + (fibListaInfinita !! (b-2)))]
