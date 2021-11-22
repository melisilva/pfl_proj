-- Alínea 2
module BigNumber (BigNumber,
                  less, equal, scanner, output, somaBN, subBN, divBN, mulBN, fromBN, safeDivBN, getLenA) where

import Data.String

-- 2.1) Definição de BigNumber
type BigNumber = [Int]

-- Operadores de comparação
-- Corresponde ao operador <.
-- Compara dois valores BigNumber. Não retorna True se forem iguais.
-- Tem em conta operandos vazios, considerando-os iguais a zero.
-- E operandos com zeros desnecessários à esquerda, adicionados em contexto de operações.
-- Se nenhum dos anteriores se verificar, compara número de algarismos.
-- E, nos últimos três casos, compara os números algarismo a algarismo.
-- O primeiro par de algarismos que não seja igual ditará o resultado.
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
      | (head a) == (head b)      = less (tail a) (tail b)
      | (head a) < (head b)       = True
      | (head a) > (head b)       = False


-- Diz se dois valores BigNumber são iguais.
-- Tem conta operandos com zeros à esquerda.
-- Compara comprimentos dos operados.
-- Utiliza a função any para uma comparação mais eficiente.
equal :: BigNumber -> BigNumber -> Bool
equal a b
      | a == b                    = True
      | (take 1 a) == [0]         = equal (tail a) b
      | (take 1 b) == [0]         = equal a (tail b)
      | length a /= length b                                                     = False
      | not (any (==False) [ (a !! x) == (b !! x) | x<-[0..(length a - 1)]])     = True
      | otherwise                                                                = False

-- 2.2) Função scanner
-- Transforma um número inteiro em BigNumber, algarismo a algarismo.
-- Utiliza quot e rem para tal. 
toBN :: Int -> BigNumber
toBN 0 = [0]
toBN n
      | abs n >= 10    =  toBN (quot n 10) ++ [rem n 10]
      | otherwise      = [rem n 10]

-- Transforma uma String em BigNumber.
-- Fá-lo transformando a String em Int e daí usa toBN para passar de Int a BigNumber.
-- Tem em conta Strings com números negativos.
scanner :: String -> BigNumber
scanner str
      | head str == '-'            = (head treatAsPosRes: map (*(-1)) (tail treatAsPosRes))
      | otherwise                  = treatAsPosRes
 where treatAsPosRes = toBN num
       num = read str :: Int

-- 2.3) Função output
-- Transforma uma lista com Strings de algarismos numa String de algarismos.
strinNum :: [String] -> String
strinNum xs = if length(xs) /= 1 then head(xs) ++ strinNum(drop 1 xs) else head(xs)

-- Transforma um BigNumber em String (usa strinNum).
-- Faz o oposto de scanner.
output :: BigNumber -> String
output xs = strinNum (map show xs)

-- utils
-- Converte todos os algarismos de um BigNumber negativo em algarismos negativos.
-- Utilizada em somas e subtrações, sobretudo.
utilNegative :: BigNumber -> BigNumber
utilNegative a
      | (head a) < 0                  = (head a) : [ (a !! x)*(-1) | x<-[1..len]]
      | otherwise                     = a
  where len = length a - 1

-- Adiciona zeros à esquerda de xs até este ter comprimento n.
-- Usada para alinhar corretamente operandos em somas e subtrações.
utilPad :: Int -> BigNumber -> BigNumber
utilPad n xs = replicate (n - length xs) 0 ++ xs

-- Adiciona n zeros à direita de xs.
-- Usada para alinhar corretamente operandos em somas no contexto de multiplicações.
utilPadR :: Int -> BigNumber -> BigNumber
utilPadR n xs = xs ++ replicate n 0

-- Desfaz o que utilPad faz.
utilUnpad :: BigNumber -> BigNumber
utilUnpad (x:xs)
      | x == 0 && length (x:xs) /= 1   = utilUnpad (drop 1 (x:xs))
      | otherwise = (x:xs)

-- Processa o resultado do zipWith feito em somaBN.
-- Emana o processo de uma conta de soma "em pé": sempre que a soma dá
-- mais que dez, "vai um" para o elemento seguinte da lista.
-- Como a lista é dada em ordem contrária, ir para a esquerda (como na
-- conta manual), é seguir para a direita na lista que é argumento desta função.
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

-- Processa o resultado do zipWith feito em subBN.
-- Emana o processo de uma conta de subtração "em pé": sempre que ultrapassarmos
-- os limites 0 ou 10, temos de SUBTRAIR 1 ao elemento seguinte da lista e continuamos.
-- De outra forma, usamos mod e quot ou apenas mantemos o valor inicial na lista l e a conta termina.
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

-- Utilizada para procurar por resultados negativos numa lista resultante
-- do zipWith de mulBN - se um valor for negativo, então o produto será
-- também negativo.
utilSig :: BigNumber -> BigNumber
utilSig num
      | any (<0) num == True && head num > 0 = (head num)*(-1) : (map (abs) (tail num))
      | any (<0) num == True && head num < 0 = head num : map (abs) (tail num)
      | otherwise                            = num

-- Utilizada para processar o resultado de zipWith de mulBN.
-- A lógica é semelhante a utilSoma e utilSub, apenas se lidam só e apenas
-- com quocientes (que podem ser somados ao elemento seguinte, em vez de um
-- "vai 1", pode ser um "vai 3" ou "vai 4", etc...) e restos.
-- De outra forma, é apenas retorna o resultado, caso este seja < 10 em módulo.
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
      
-- Utilizada para processar a soma de todos os subprodutos realizados
-- em mulBN. Utiliza utilPadR para alinhar corretamente os subprodutos
-- para a soma final.
utilMul :: Int -> BigNumber -> BigNumber -> BigNumber
utilMul i a b
      | length b > 1           = somaBN currentProduct (utilMul (i + 1) a next)
      | length b == 1          = somaBN currentProduct [0]
      | otherwise              = []
  where currentProduct = utilSig (reverse (processProduct (reverse (utilPadR i (map (*x) a)))))
        x = last b
        next = init b

-- Troca o sinal de um BigNumber negativo para positivo.
-- De outra forma, mantém o sinal positivo.
utilPositive :: BigNumber -> BigNumber
utilPositive a = if head(a)<0 then mulBN [-1] a else a

-- Determina o comprimento de uma janela de divisão válida para utilDiv.
getLenA :: Int -> BigNumber -> BigNumber -> Int
getLenA i a b
      | less a b                                  = 0
      | length a == length b                      = length a
      | head a == 0                               = 1 + getLenA 1 (tail a) b
      | less (take i a) b                         = getLenA (i + 1) a b
      | otherwise                                 = i

-- Processa a divisão como a operação manual.
-- Lida com operandos vazios ou iguais a 0 e com divisor igual a 1.
-- Ver explicação no README na explicação da Implementação de divBN.
utilDiv :: BigNumber -> BigNumber -> BigNumber -> BigNumber
utilDiv _ [] _ = []
utilDiv _ _ [] = []
utilDiv _ [0] b = [0]
utilDiv _ a [0] = [0]
utilDiv _ a [1] = a
utilDiv i a b
      | mulBN b ten == a                                                                          = ten
      | (drop (length a - 1) a) == zero && (drop (length b - 1) b) == zero                        = (utilDiv zero (take (length a - 1) a) (take (length b - 1) b))
      | less a b && take 1 a == zero && length a == 1                                             = []
      | take 1 a == zero                                                                          = zero ++ utilDiv zero (drop 1 initA) b
      | less quo initA && less prod initA && not (equal prod initA)                               = utilDiv (somaBN i one) a b
      | less quo initA && equal prod initA && divRest == []                                       = somaBN i one
      | less quo initA && equal prod initA && (take 1 divRest) == zero && divRest /= zero         = somaBN i one ++ zero ++ utilDiv zero (divRest) b
      | less quo initA && equal prod initA && (take 1 divRest) == zero && divRest == zero         = somaBN i one ++ zero ++ utilDiv zero (divRest) b
      | less quo initA && equal prod initA && divRest /= []                                       = somaBN i one ++ utilDiv zero (divRest) b
      | less quo initA && not (less prod initA) && divRest /= [] && sub /= zero                   = i ++ utilDiv zero (sub ++ divRest) b
      | less quo initA && not (less prod initA) && divRest /= [] && sub == zero                   = i ++ utilDiv zero divRest b
      | otherwise                                                                                 = i
  where initA = if (getLenA 1 a b) /= length a then take (getLenA 1 a b) a else a
        quo = mulBN i b
        prod = mulBN add1 b
        add1 = somaBN i one
        sub = subBN initA quo
        divRest = if length initA /= length a then drop (length initA) a else []
        one = [1]
        zero = [0]
        ten = one ++ zero

-- 2.4 ) somaBN
-- Efetua a soma de dois BigNumber. Tem em conta operandos negativos, fazendo chamada a subBN.
-- Apenas soma, realmente, operandos positivos. Todos os outros casos são reduzidos a subtrações.
-- Tem em conta o elemento neutro da adição.
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
-- Efetua a subtração entre dois BigNumber.
-- Subtrações que igualem somas são entregues a somaBN (por exemplo, quando b for negativo).
-- Tem em conta o elemento neutro da subtração.
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
-- Efetua o produto entre dois BigNumber.
-- Tem em conta números negativos e produtos pelos elementos absorvente e neutro da multiplicação.
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
-- Efetua a divisão entre dois BigNumber.
-- Operandos negativos são considerados e lidados de forma adequada.
-- Tem em conta números negativos e retorna resultados iguais a quot e rem.
-- A divisão manual encontra-se em utilDiv, que só recebe operandos positivos ou [0], no caso do seu primeiro argumento..
divBN :: BigNumber -> BigNumber -> (BigNumber, BigNumber)
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
  where negative = utilDiv zero (utilPositive a) (utilPositive b)
        resNegative = subBN (utilPositive a) (mulBN (utilPositive b) negative)
        pos = utilDiv zero a b
        one = [1]
        zero = [0]

-- Alínea 4 (funções auxiliares)
-- Faz o inverso de toBN, utilizando sum, zipWith, conv e iterate com produto por 10.
fromBN :: BigNumber -> Int
fromBN xs = if head(xs) < 0 then (-1)*(sum (zipWith (*) (reverse (conv xs)) (iterate (*10) 1))) else sum (zipWith (*) (reverse xs) (iterate (*10) 1))

-- Inverte o sinal de um BigNumber.
conv :: BigNumber -> BigNumber
conv xs = ((-1)*head(xs)): drop 1 xs

-- Alínea 5
-- Usa a Monad Maybe para implementar uma divisão segura, que considera
-- que o divisor fornecido pode ser zero. Nesse caso, retorna Nothing.
-- De outra forma, retorna o resultado da divisão encapsulado em Just.
safeDivBN :: BigNumber -> BigNumber -> Maybe (BigNumber, BigNumber)
safeDivBN a b
      | b == [0]              = Nothing
      | otherwise             = Just (divBN a b)
