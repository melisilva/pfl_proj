-- fibLista 1 pq n tava a compilar
fibLista = (map fib [0..] !!)
  where fib 0 = 0
        fib 1 = 1
        fib a = fibLista (a-2) + fibLista (a-1)

        
fibListaBN :: BigNumber -> BigNumber
fibListaBN [0] = [0]
fibListaBN [1] = [1]
fibListaBN n = lista !! (fromBN n)
 where lista = [zero] ++ [one] ++ [ foo z | z<-[iterate (somaBN [1]) [1]], less z n]
       foo n = somaBN (lista !! (subBN n one)) (lista !! (subBN n two))
       zero = [0]
       one = [1]
       two = [2]

fibListaBN :: BigNumber -> BigNumber
fibListaBN n = lista
  where lista = [zero] ++ [one] ++ [somaBN (last lista) (head (drop 1 (reverse lista))) | z<-[0..intv]]
        foo = somaBN (last lista) (head (drop 1 (reverse lista)))
        intv = length (interval n zero)
        two = [2]
        one = [1]
        zero = [0]

utilUnPad' xs = if (length xs /= 1 && head(xs) == 0) then utilUnPad'(drop 1 xs) else xs