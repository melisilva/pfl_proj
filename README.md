# Projeto de PFL em Haskell

## Autores

Mateus Silva (up201906232)

Melissa Silva (up201905076)

## **Casos de Teste**

Apresentamos aqui alguns casos de teste para todas as funções pedidas (não incluímos funções auxiliares).

![image-20211119184937869](L:\COLLEGE\A3\SEM1\PFL\pfl_proj\image-20211119184937869.png)

<center><b>Imagem 1</b> - Casos de Teste para <i>fibRec</i>.</center>

![image-20211119185100817](L:\COLLEGE\A3\SEM1\PFL\pfl_proj\image-20211119185100817.png)

<center><b>Imagem 2</b> - Casos de Teste para <i>fibLista</i>.</center>

![image-20211119185322181](L:\COLLEGE\A3\SEM1\PFL\pfl_proj\image-20211119185322181.png)

<center><b>Imagem 3</b> - Casos de Teste para <i>fibListaInfinita</i>.</center>

![image-20211119185456253](L:\COLLEGE\A3\SEM1\PFL\pfl_proj\image-20211119185456253.png)

<center><b>Imagem 4</b> - Casos de Teste para <i>fibRecBN</i>.</center>

![image-20211119185617430](L:\COLLEGE\A3\SEM1\PFL\pfl_proj\image-20211119185617430.png)

<center><b>Imagem 5</b> - Casos de Teste para <i>fibListaBN</i>.</center>

![image-20211119185758710](L:\COLLEGE\A3\SEM1\PFL\pfl_proj\image-20211119185758710.png)

<center><b>Imagem 6</b> - Casos de Teste para <i>fibListaInfinitaBN</i>.</center>

![image-20211119185948686](L:\COLLEGE\A3\SEM1\PFL\pfl_proj\image-20211119185948686.png)

<center><b>Imagem 7</b> - Casos de Teste para <i>scanner</i> e <i>output</i>.</center>

![image-20211119190303302](L:\COLLEGE\A3\SEM1\PFL\pfl_proj\image-20211119190303302.png)

<center><b>Imagem 7</b> - Casos de Teste para <i>somaBN</i> e <i>subBN</i>.</center>

![image-20211119193309288](L:\COLLEGE\A3\SEM1\PFL\pfl_proj\image-20211119193309288.png)

<center><b>Imagem 8</b> - Casos de Teste para <i>mulBN</i>.</center>

![image-20211122153028932](L:\COLLEGE\A3\SEM1\PFL\pfl_proj\image-20211122153028932.png)

![image-20211122153601322](L:\COLLEGE\A3\SEM1\PFL\pfl_proj\image-20211122153601322.png)

![image-20211122153749781](L:\COLLEGE\A3\SEM1\PFL\pfl_proj\image-20211122153749781.png)

<center><b>Imagem 9</b> - Casos de Teste para <i>divBN</i>.</center>

![image-20211119193706552](L:\COLLEGE\A3\SEM1\PFL\pfl_proj\image-20211119193706552.png)

<center><b>Imagem 10</b> - Casos de Teste para funções de <i>Fibonacci</i> com <i>Integer</i>.</center>



<center><b>Imagem 11</b> - Casos de Teste para funções de <i>Fibonacci</i> com <i>Int</i>.</center>

![image-20211119194132741](L:\COLLEGE\A3\SEM1\PFL\pfl_proj\image-20211119194132741.png)

<center><b>Imagem 12</b> - Casos de Teste para função <i>safeDivBN</i>.</center>

## Funcionamento

### **Alínea 1**

#### FibRec

Esta função calcula o número de Fibonacci de ordem *n* através de uma definição *naïve* recursiva, que se chama a si própria recursivamente para obter os dois números de Fibonacci anteriores a *n* e efetuar a sua soma.

#### FibLista

Esta função utiliza uma lista para o cálculo do número de Fibonacci de ordem *n*, que limita o número de elementos calculados. Retorna-se o último elemento da lista para dar o número pedido.

#### FibListaInfinita

Esta função é muito semelhante à anterior, mas utiliza antes uma lista infinita.

### Alínea 2

#### **Definição do Tipo BigNumber**

Definimos o tipo *BigNumber* como uma lista de valores *Int*. Números negativos são denotados com o primeiro algarismo negativo (ex.: *[-1, 0]* é -10). A lista vazia é tratada como [0] em padrões das operações aritméticas.

#### Scanner

Esta função transforma uma *String* de um número numa instância de *BigNumber*. Utiliza uma função auxiliar *toBN* que calcula os seus dígitos através das operações *rem* e *quot*.

#### Output

Esta função converte um *BigNumber* numa *String* do número que o primeiro representa. Utiliza a função *show* para converter a lista de *Int* (isto é, um *BigNumber*) em *String* e procede à concatenação dos seus elementos para uma única cadeia de carateres.

#### somaBN

Esta função efetua a soma de dois valores *BigNumber*. O seu funcionamento é explicado em maior detalhe na secção ***Implementação das Operações Aritméticas para BigNumber***.

#### subBN

Esta função efetua a subtração entre dois valores *BigNumber*. O seu funcionamento é explicado em maior detalhe na secção ***Implementação das Operações Aritméticas para BigNumber***.

#### mulBN

Esta função retorna o produto entre dois valores *BigNumber*. O seu funcionamento é explicado em maior detalhe na secção ***Implementação das Operações Aritméticas para BigNumber***.

#### divBN

Esta função retorna o quociente e resto da operação de divisão entre dois valores *BigNumber*. O seu funcionamento é explicado em maior detalhe na secção ***Implementação das Operações Aritméticas para BigNumber***.

### **Alínea 3**

#### FibRecBN

Esta função segue a mesma lógica da sua correspondente na alínea 1, contudo, retorna o resultado obtido num valor *BigNumber*.

#### FibListaBN

Esta função segue a premissa por detrás da sua correspondente na alínea 1, contudo, utiliza recursão como meio de efetuar iteração e, assim, calcular apenas tantos elementos quantos necessários. A recursão utiliza nomes 

#### FibListaInfinitaBN

Esta função segue a mesma lógica da sua correspondente na alínea 1, contudo, retorna o resultado obtido num valor *BigNumber*.

### **Alínea 5**

#### safeDivBN

Esta função implementa uma divisão segura por [0], impedindo quaisquer cálculos se o divisor for este. De outra forma, chama a função ***divBN*** para efetuar a divisão. Serve-se do *Monad* *Maybe*, tal como é pedido.

## Implementação das Operações Aritméticas para *BigNumber*

Como pedido, procederemos à explicação do raciocínio por detrás de cada uma das operações aritméticas para valores *BigNumber*. 

#### somaBN e subBN

Estas duas funções estão fortemente interligadas, procurando fazer com que todas as potenciais operações sejam encaminhadas para a função que corresponde à operação correta. Com isto queremos dizer que, por exemplo, a soma entre [1, 0] e [-1] é passada para a função de subtração como *subBN [1, 0] [1]*.

Cada uma das funções tem o seu conjunto de funções auxiliares, normalmente começadas com o sufixo *util*. Antes de nos debruçarmos sobre a lógica por detrás das duas operações aritméticas em si, iremos listar estas funções auxiliares relevantes mas de menor importância, o que ajudará a perceber a lógica por detrás das operações:

- *utilPad* acrescenta algarismos 0 a um *BigNumber*, pela esquerda - desta forma, números de diferentes comprimentos em algarismos podem ser corretamente alinhados;
- *utilUnpad* reverte o que é feito pela função *utilPad*;
- *toDigits* converte um número *Int* para *BigNumber*;
- *delZero* ajuda a função *toDigits* a converter *Int* para *BigNumber*.

Sobram apenas as funções *utilSoma* e *utilSub*, que já explicaremos. Para começar, falaremos da lógica nas próprias funções *somaBN* e *subBN*: cada uma destas determina qual os sinais dos seus operandos, retornando algo diferente para cada um dos casos possíveis: ambos positivos, um positivo e um negativo e ambos negativos. Claramente, cada um segue uma lógica diferente que acreditamos ser fácil de induzir: *somaBN* apenas chama *utilSoma* com dois operandos positivos e o mesmo se aplica a *subBN* mas com *utilSub* - os casos restantes são apenas passos recursivos ou chamadas da operação contrária que aproximem a operação de uma com ambos os operandos positivos.

Ambas as funções trabalham com *zipWith*, fazendo portanto a operação aritmética respetiva *algarismo a algarismo*. Isto facilita imenso a operação no geral. Para melhor visualização, aqui fica um exemplo, para *somaBN [1, 0] [1, 2, 3]*

```
zipWith (+) [0, 1, 0] [3, 2, 1] =
= [3, 3, 1]
```

Os operandos são revertidos para se emular aquilo que se faz com contas realizadas manualmente - como se aprende na escola primária, as *"contas em pé"* - e o resultado desta chamada a *zipWith* apenas nos deixa com o processamento de resultados maiores ou iguais a dez (*somaBN*) ou resultados maiores ou iguais a dez ou menores que zero (*subBN*).

*utilSoma* processa o resultado da chamada lidando com números maiores ou iguais a dez. A lógica é como aquela usada em contas manuais: sempre que um resultado é maior que dez, mantemos o algarismo das unidades e somamos 1 à próxima coluna à esquerda da atual, continuando e seguindo para a esquerda. Andar para a esquerda equivale a uma chamada recursiva de *utilSoma*.<sup>[1]</sup>

Por sua vez, os casos que acabam a execução da função são então um resultado menor que 10, o que apenas obriga a que se retorne esse resultado<sup>[2]</sup>, ou um resultado maior ou igual a dez, que aumenta o comprimento do resultado em 1 por uma última vez.

![1](1.png)

Já *utilSub* lida com mais casos: se um componente da lista for negativo, precisamos de fazer o seu *mod 10* para obter o seu algarismo das unidades, após o que **subtraímos** 1 à próxima coluna à esquerda <sup>[1]</sup>. De outra forma, repete-se o que se faz com números menores que 10 em *utilSoma*.

![2](2.png)

Não há mais nada de muito importante a falar, visto acharmos que a forma como *somaBN* e *subBN* estão estruturadas em si é muito transparente - em ambas apenas efetuamos alinhamentos dos operadores adicionando zeros, revertemos os operadores para que as funções *utilSoma* e *utilSub* possam iterá-las de início ao fim seguindo a ordem direita-esquerda que se seguiria ao fazer a conta manualmente e revertemos o resultado do processamento da lista resultante da chamada a *zipWith* para obtermos o resultado.

#### **mulBN**

Esta função segue um raciocínio semelhante às duas anteriores: utiliza *zipWith* com o operador de multiplicação entre os dois operandos, mas possui mais funções *util* devido à divisão que criámos na sua execução. Como sabemos, uma operação de multiplicação feita à mão recorre à soma sempre que o operador que se coloca em baixo tem dois algarismos, como no exemplo abaixo.

![img](https://www.ducksters.com/kidsmath/multiplication_example4.gif)

O resultado da multiplicação *469x32* é igual à soma do resultado de dois produtos, um deles com zero(s) adicionado(s) à direita. Para criar este mecanismo em *mulBN*, dividimos então a multiplicação em casos em que o operador que ficaria em baixo na conta manual só tem 1 algarismo e casos em que esse operador teria 2 ou mais algarismos.

As novas funções *util* são:

- *utilPadR* que faz o mesmo que *utilPad*, contudo, adiciona zeros *à direta* e não à esquerda;
- *utilMul*, que faz a separação mencionada após a última imagem;
- *utilNegative* transforma *BigNumber* negativos, colocando todos os seus algarismos negativos;
- *processProduct*, que faz o mesmo processamento que *utilSub* e *utilSoma* adaptado à multiplicação;
- *utilSig*, que faz um último processamento do produto, verificando se este é negativo ou não - segue a regra de que caso algum algarismo seja menor que zero, então é porque o número de que faz parte é negativo;

![3](3.png)

*mulBN*, tal como as operações explicadas anteriormente, lida sobretudo com os tipos de operandos que recebe, estando preparada para interpretar os resultados de forma correta: se apenas um dos operandos for negativo, o resultado terá de ser negativo; se ambos os operandos forem positivos ou negativos, o resultado terá de ser positivo.

*utilMul* lida então com a separação de operações com segundos operandos de dois ou mais algarismos, mais uma vez efetuando *reverse* dos operandos para que *processProduct* lide com uma lista onde avançar significaria andar para a esquerda numa conta manual. Tirando isso, há a função de *utilPadR* que, com a variável de *utilMul* ***i*** que serve de iterador, indica quantos 0 é preciso adicionar a uma lista.

![image-20211115155058819](7.png)

Voltando ao exemplo dado com *469x32*, há que perceber que para cada linha adicionada àquela que será a operação de soma final na conta manual (no exemplo dado, esta soma é 930 + 14070), junta-se mais um 0 do que na linha anterior. Portanto, se a conta fosse *469x132*, a linha com o produto de 469 por 1 iria ter 2 zeros à direita.

![img](https://www.ducksters.com/kidsmath/multiplication_example4.gif)

Assim sendo, sempre que se chama *utilMul* recursivamente, é adicionado 1 à variável ***i***, para ter em conta esta lógica. 

Por fim, *processProduct* é muito semelhante a *utilSoma* e *utilSub*, mas enquanto estas duas funções apenas lidam com, no máximo, números inteiros no intervalo [-19, 19], com a multiplicação, podemos lidar com números em [-100, 100]. Isto significa que não basta *somar 1* à próxima coluna, mas sim somar-lhe o algarismo das dezenas, que obtivemos fazendo a divisão inteira com *quot* (números negativos) ou *div* (números positivos). Ao mesmo tempo, para que não haja erros na multiplicação e *utilSig* funcione corretamente, sempre que o número com que estamos a lidar seja negativo, utilizamos a função *rem* para obter o algarismo das unidades *negativo*.

![4](4.png)

#### **divBN**

A função de divisão para *BigNumber* é a única que não usa *zipWith* de todas as operações aritméticas. Ao invés disso, adotamos um raciocínio baseado na subtração, tal como se faz com as contas manuais de divisão, com quociente e resto. A lóggica desta função assemelha-se ao raciocínio desse processo manual, e, para isso, criámos duas funções de comparação entre *BigNumber* (*less* para <, *equal* para ==), por ser necessário para definirmos a nossa janela de divisão. Vejamos o exemplo abaixo.

![5](L:\COLLEGE\A3\SEM1\PFL\pfl_proj\5-16375958318795.png)

Com *janela de divisão*, referimo-nos à parte do dividendo de menor comprimento possível que é maior que o divisor, por exemplo, a primeira janela de divisão de *1234 / 13* não pode ser *1* nem *12*, apenas *123*, pois só 123 > 13. Daqui, é efetuada a divisão entre a primeira janela e o divisor, que nos dá um primeiro resultado que será concatenado àqueles que se lhe seguirem, com a janela de divisão a mudar.

A próxima janela de divisão é igual à concatenação do resultado da subtração entre a janela de divisão anterior (123) e o produto entre o quociente e o divisor (123 - 117 = 6) com o que quer que sobre do dividendo após selecionar a janela de divisão anterior (4). Após a primeira janela, apenas resta 6, logo a divisão passa a ser *64 / 13*. Se não houver mais algarismos do dividendo a concatenar, obtivemos o resto da divisão, que, no caso dado, é *12*.

Este mecanismo é seguido para *divBN*, sendo levado a cabo por *utilDiv*.

*utilDiv* procura, utilizando a variável ***i*** como iterador, o maior valor para ***i*** que verifique que
$$
i*b <= initA
$$
onde *initA* é a nossa janela de divisão atual, de comprimento calculado pela função auxiliar *getLenA*. Sempre que encontramos o maior possível ou a correspondência perfeita para ***i*** (ou seja, que reduza a janela de divisão a 0), preparamos a concatenação de ***i*** com o resultado de uma chamada recursiva a *utilDiv* que irá efetuar a próxima divisão. Isto é feito estudando quer o produto de *i* por *b*, quer o produto de *i + 1* por b, o que diminui o número de chamadas recursivas à função.

Estes são os casos abrangidos por *utilDiv*:

- quando 
  $$
  b * 10 = a
  $$
  aplicar a lógica da divisão manual torna-se mais complicado - simplificamos isto retornando, imediatamente, o quociente [1, 0] - este é um caso base;

- quando é possível simplificar os operandos **dividindo-os por 10**/**tirando-lhes um zero do final**, tal é feito numa chamada recursiva à própria *utilDiv*;

- se *a < b*, o primeiro algarismo de *a* for 0 e o comprimento de *a* for 1, retornamos lista vazia, pois não há mais nada a adicionar ao quociente - este é outro caso base;

- se a subtração entre a janela de divisão e um produto de um potencial quociente (**(i + 1)*b** ou **i * b**) e do divisor der zero, apenas há concatenações ao quociente e não à próxima janela de divisão:

  - quando o primeiro algarismo do resto do dividendo (*divRest*, em *utilDiv*) for 0 e for diferente de zero ([0]), teremos de concatenar dois zeros ao quociente esperado - isto porque <u>a janela de divisão tem de ser maior que o divisor</u>;
  - quando o resto do dividendo for [0], adicionamos ao quociente um só 0 e a divisão termina - outro caso base;

- se a subtração entre a janela de divisão e **(i + 1)*b** der maior que a janela de divisão) e o resto do dividendo não for vazio:

  - se a subtração entre a janela de divisão e **i*b** não der zero, temos de concatenar o resultado dessa subtração ao resto do dividendo, formando a nossa nova janela de divisão que é passada numa chamada recursiva a *utilDiv*;
  - se a subtração entre a janela de divisão e **i*b** der zero, então o quociente será *i* concatenado ao resultado da chamada recursiva com o resto do dividendo no lugar do segundo argumento de *utilDiv* (a);

- Em qualquer outro caso, temos o último caso base, que retorna *i* como o quociente.

Gostaríamos de mencionar que a nossa implementação de *divBN* também lida com números negativos e calcula os restos e quociente de forma correta - emanando os resultados de *quot* e *rem*.

## **Alínea 4**

Esta alínea pedia que se efetuasse a comparação entre as funções para cálculo de números de Fibonacci feitas nas alíneas 1 e 3. Para efetuar esta comparação, servimo-nos do comando *:set +s* para efetuar a contagem dos tempos de execução. Com isto, fomos aumentando em ordem de grandeza.

Para que os resultados fossem viáveis, todas as contagens de tempo foram obtidas a partir do mesmo computador, além de que estabelecemos que esperaríamos apenas até 60 segundos no máximo à espera de um resultado. Marcámos estas ocorrências na tabela abaixo com *TIMEOUT* e, à primeira ocorrência deste, todas as ordens maiores foram marcadas igualmente.

| ***n***  | *fibRecInt*  | *fibListaInt* | *fibListaInfinitaInt* |
| :------: | :----------: | :-----------: | :-------------------: |
|    1     |    0.00s     |     0.00s     |         0.00s         |
|    10    |    0.00s     |     0.00s     |         0.00s         |
|   100    | *INVÁLIDO* * | *INVÁLIDO* *  |     *INVÁLIDO* *      |
|   1000   |  *INVÁLIDO*  |  *INVÁLIDO*   |      *INVÁLIDO*       |
|  10000   |  *INVÁLIDO*  |  *INVÁLIDO*   |      *INVÁLIDO*       |
|  100000  |  *INVÁLIDO*  |  *INVÁLIDO*   |      *INVÁLIDO*       |
| 1000000  |  *INVÁLIDO*  |  *INVÁLIDO*   |      *INVÁLIDO*       |
| 10000000 |  *INVÁLIDO*  |  *INVÁLIDO*   |      *INVÁLIDO*       |

<sup>*</sup> Ocorreu overflow. Resultado inválido. Todos os seguintes também.

<center><b>Tabela 1</b> - Tempos de Execução para funções da Alínea 4 (<i>Int</i>)</center>

| ***n*** | *fibRecInteger* | *fibListaInteger* | *fibListaInfinitaInteger* |
| :-----: | :-------------: | :---------------: | :-----------------------: |
|    1    |      0.00s      |       0.00s       |           0.00s           |
|   10    |      0.00s      |       0.00s       |           0.00s           |
|   100   |    *TIMEOUT*    |       0.01s       |           0.00s           |
|  1000   |    *TIMEOUT*    |       0.05s       |           0.01s           |
|  10000  |    *TIMEOUT*    |       0.60s       |           0.09s           |
| 100000  |    *TIMEOUT*    |     *TIMEOUT*     |           1.42s           |
| 1000000 |    *TIMEOUT*    |     *TIMEOUT*     |         *TIMEOUT*         |

<center><b>Tabela 2</b> - Tempos de Execução para funções da Alínea 4 com <i>Integer</i>.</center>

Logo, só com estes resultados, podemos ver que as implementações com lista infinita são as mais eficientes e eficazes implementações do cálculo de números de Fibonacci, por ser a mais rápida quando a ordem de *n* é maior e também por ser a que, nas condições utilizadas, é a que sofre *TIMEOUT* em último lugar. Por outro lado, descobrimos que logo a partir de *n = 100*, a representação com números *Int* sofre *overflow*, pelo que todos os resultados obtidos se tornam inválidos.

As funções feitas na alínea 1 não sofrem *overflow*. Podemos então assumir que estão a lidar com *Integer* e não com *Int*.

Façamos o mesmo para as funções com *BigNumber*.

| ***n*** | *fibRecBN* | *fibListaBN* | *fibListaInfinitaIntegerBN* |
| :-----: | :--------: | :----------: | :-------------------------: |
|    1    |   0.00s    |    0.00s     |            0.00s            |
|   10    |   0.00s    |    0.00s     |            0.00s            |
|   100   | *TIMEOUT*  |    0.00s     |            0.01s            |
|  1000   | *TIMEOUT*  |    0.64s     |            0.01s            |
|  10000  | *TIMEOUT*  | *TIMEOUT* *  |            0.08s            |
| 100000  | *TIMEOUT*  |  *TIMEOUT*   |          *TIMEOUT*          |
| 1000000 | *TIMEOUT*  |  *TIMEOUT*   |          *TIMEOUT*          |

<center><b>Tabela 3</b> - Tempos de Execução para funções da Alínea 3.</center>

<sup>*</sup> 84.34 segundos. Corremos por curiosidade.

As conclusões não são diferentes daquelas obtidas a com as funções que utilizam *Integer*. Contudo, podemos dizer que o *TIMEOUT* ocorre em ordens menores para *fibListaBN* e *fibListaInfinitaBN*, o que pode ser explicado com o facto de embora *BigNumber* permitir a representação de números de maior grandeza, o seu processamento é mais demorado.

Há que notar, contudo, que consoante o nosso estudo de ir aumentando a ordem multiplicando *n* por dez, a perda de um só "nível" quando comparada com os resultados da tabela anteriores pode ser visto como algo positivo.

Põe-se então a questão: se o processamento é mais demorado, qual será a vantagem de utilizar *BigNumber* como forma de representar números? Ao contrário da representação numérica *Int*, *Integer* e *BigNumber* não possuem um limites impostos pela sua própria representação no contexto de uma computação: a uma dada ordem de grandeza, o computador perde a capacidade de lidar com números *Int* de forma válida por ocorrência de *overflow*. De facto, o intervalo de números suportados por *Int* está bem definido: [-2<sup>29</sup>, 2<sup>29</sup> - 1] - o número de ordem *n = 100* é bem maior que o limite máximo, o que explica os resultados inválidos na **Tabela 1**. Já *Integer* e *BigNumber* só possuem limites impostos pela memória que ocupam, pelo que podemos representar números tão grandes quanto a memória de um computador suporte.

Tal como podemos ver comparando as duas últimas tabelas, *BigNumber* assemelha-se a *Integer*: representamos números de ordem de grande tão grande quanto a memória do nosso computador permita, mas "pagamos o preço" em tempo de execução - quando os números são maiores, operações sobre estes serão naturalmente mais demoradas.
