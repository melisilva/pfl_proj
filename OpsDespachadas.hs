-- Função útil para operações.
algarismos :: Int -> BigNumber
algarismos 0 = []
algarismos n = if n<0 then conv(algarismos(div (n*(-1)) 10) ++ [mod (n*(-1)) 10]) else algarismos (div n 10) ++ [mod n 10]

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