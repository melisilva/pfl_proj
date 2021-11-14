-- Função útil para operações.
algarismos :: Int -> BigNumber
algarismos 0 = []
algarismos n = if n<0 then conv(algarismos(div (n*(-1)) 10) ++ [mod (n*(-1)) 10]) else algarismos (div n 10) ++ [mod n 10]

strinNum xs = if length(xs) /= 1 then head(xs) ++ strinNum(drop 1 xs) else head(xs)

--2.4) Função somaBN
somaBN :: BigNumber -> BigNumber -> BigNumber
somaBN a b = algarismos(fromDigits(a)+fromDigits(b))

--2.5) Função subBN
subBN :: BigNumber -> BigNumber -> BigNumber
subBN a b = algarismos(fromDigits(a)-fromDigits(b))

--2.6) Função mulBN
mulBN :: BigNumber -> BigNumber -> BigNumber
mulBN a b = algarismos(fromDigits(a)*fromDigits(b))

-- 2.7) Função divBN
divBN :: BigNumber -> BigNumber -> (BigNumber, BigNumber)
divBN a b = (algarismos x, algarismos y)
      where x = div (fromDigits a) (fromDigits b)
            y = mod (fromDigits a) (fromDigits b)


-- fibLista 1 pq n tava a compilar
fibLista :: (Integral a) => a -> a
fibLista = (map fib [0..] !!)
  where fib 0 = 0
        fib 1 = 1
        fib a = fibLista (a-2) + fibLista (a-1)