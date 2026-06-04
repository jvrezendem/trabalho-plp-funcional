# Tutorial completo de Haskell do zero

**Objetivo:** aprender Haskell a partir do ponto de vista de quem já conhece programação imperativa, mas ainda não conhece programação funcional.

Este tutorial foi montado com base nos arquivos:

- `programacao_funcional.md`
- `codigos_haskell_imagens.md`
- `trabalho_haskell_funcoes.md`

O foco é dar o conhecimento necessário para desenvolver as funções pedidas no trabalho de Haskell, sem depender simplesmente de funções prontas da biblioteca padrão.

---

## Como estudar este material

Cada módulo segue a estrutura pedida:

1. **Explicação do conteúdo**
2. **Exemplos de códigos**
3. **Exercícios**
4. **Respostas comentadas dos exercícios**

No final, há um **apêndice com respostas comentadas de alguns exercícios do trabalho**, escolhidas para cobrir os padrões mais importantes: listas, recursão, filtros, ordenação, strings, estatística, números e conjuntos.

---

# Módulo 1 — A mudança de mentalidade: de imperativo para funcional

## 1. Explicação do conteúdo

Quando você programa em C, C++, Java ou Python de forma imperativa, normalmente pensa assim:

> “Primeiro faço isso, depois faço aquilo, atualizo uma variável, repito enquanto uma condição for verdadeira e no final retorno o resultado.”

Em Haskell, a ideia muda. Você passa a pensar mais assim:

> “O resultado desse problema é definido por estes casos.”

Ou seja, Haskell não é focado em **sequência de comandos**, mas em **definição de funções**.

Na programação imperativa, você costuma usar:

- variáveis que mudam de valor;
- laços `for` e `while`;
- comandos em sequência;
- atribuições como `x = x + 1`;
- estados intermediários.

Na programação funcional, principalmente em Haskell, você usa:

- funções;
- recursão;
- listas;
- casamento de padrões;
- guardas;
- expressões;
- valores imutáveis.

A frase mais importante é:

> Em Haskell, você não descreve passo a passo como a máquina deve fazer. Você descreve o que cada caso da função significa.

### Exemplo mental

Em C, para somar uma lista, você poderia pensar:

```c
int soma = 0;
for(int i = 0; i < n; i++){
    soma = soma + v[i];
}
```

Em Haskell, você pensa:

- a soma da lista vazia é `0`;
- a soma de uma lista com cabeça `c` e resto `r` é `c + soma r`.

```haskell
somatorio :: Num t => [t] -> t
somatorio [] = 0
somatorio (c:r) = c + somatorio r
```

Perceba que não existe variável sendo atualizada. Existe uma definição matemática.

### O que substitui o `for` e o `while`?

A recursão.

Uma lista em Haskell pode ser vista assim:

```haskell
[1,2,3]
```

Mas internamente podemos pensar nela como:

```haskell
1 : (2 : (3 : []))
```

Ou seja:

- `[]` é a lista vazia;
- `c:r` separa a lista em cabeça e resto;
- `c` é o primeiro elemento;
- `r` é o restante da lista.

Esse padrão aparece em praticamente todos os exercícios do trabalho.

---

## 2. Exemplos de códigos

### Menor entre dois valores

```haskell
menorDeDois :: Ord t => t -> t -> t
menorDeDois a b
    | a < b = a
    | otherwise = b
```

Leitura:

- a função recebe dois valores do mesmo tipo `t`;
- esse tipo precisa pertencer à classe `Ord`, porque usamos `<`;
- se `a < b`, o resultado é `a`;
- caso contrário, o resultado é `b`.

### Menor entre três valores

```haskell
menorDeTres :: Ord t => t -> t -> t -> t
menorDeTres a b c = menorDeDois (menorDeDois a b) c
```

Aqui usamos reutilização. Em vez de comparar tudo de novo, usamos a função `menorDeDois` duas vezes.

### Fatorial

```haskell
fatorial :: Integral t => t -> t
fatorial 0 = 1
fatorial n = n * fatorial (n - 1)
```

Leitura:

- o fatorial de `0` é `1`;
- o fatorial de `n` é `n * fatorial (n - 1)`.

Isso substitui um laço.

---

## 3. Exercícios

1. Explique com suas palavras por que Haskell não usa `for` e `while` como em C.
2. Faça uma função `dobro` que recebe um número e retorna o dobro dele.
3. Faça uma função `maiorDeDois` que recebe dois valores ordenáveis e retorna o maior.
4. Faça uma função `triploMenosUm` que recebe um número `x` e retorna `3*x - 1`.

---

## 4. Respostas comentadas

### Exercício 1

Haskell não usa `for` e `while` como elementos centrais porque a repetição é expressa por recursão. Em vez de alterar variáveis dentro de um laço, a função chama a si mesma com uma parte menor do problema.

### Exercício 2

```haskell
dobro :: Num t => t -> t
dobro x = 2 * x
```

Comentário: usamos `Num t` porque a função funciona com qualquer tipo numérico.

### Exercício 3

```haskell
maiorDeDois :: Ord t => t -> t -> t
maiorDeDois a b
    | a >= b = a
    | otherwise = b
```

Comentário: usamos `Ord t` porque precisamos comparar `a` e `b`.

### Exercício 4

```haskell
triploMenosUm :: Num t => t -> t
triploMenosUm x = 3 * x - 1
```

Comentário: não precisamos criar variável auxiliar. A expressão já descreve o resultado.

---

# Módulo 2 — Sintaxe básica de Haskell

## 1. Explicação do conteúdo

Uma função em Haskell normalmente tem duas partes:

```haskell
nomeDaFuncao :: Tipo
nomeDaFuncao parametros = resultado
```

Exemplo:

```haskell
quadrado :: Num t => t -> t
quadrado x = x * x
```

A primeira linha é a **assinatura de tipo**. Ela diz:

```haskell
quadrado :: Num t => t -> t
```

Leitura:

- `quadrado` é uma função;
- recebe um valor de tipo `t`;
- retorna um valor de tipo `t`;
- `t` precisa ser numérico, por isso `Num t =>`.

A segunda linha é a definição:

```haskell
quadrado x = x * x
```

### O operador `->`

Em Haskell, o operador `->` separa entradas e saída.

```haskell
soma :: Num t => t -> t -> t
```

Isso significa:

- recebe um primeiro `t`;
- recebe um segundo `t`;
- retorna um `t`.

Em uma visão imperativa, você leria como:

```c
int soma(int a, int b)
```

Em Haskell:

```haskell
soma :: Num t => t -> t -> t
soma a b = a + b
```

### Comentários

Comentários de uma linha começam com `--`:

```haskell
-- Esta função calcula o dobro de um número
dobro :: Num t => t -> t
dobro x = 2 * x
```

Para o trabalho, isso é importante porque o enunciado pede comentários indicando o número da função.

Exemplo:

```haskell
-- 14. somatorio
somatorio :: Num t => [t] -> t
somatorio [] = 0
somatorio (c:r) = c + somatorio r
```

### Nomes em Haskell

- funções e variáveis começam com letra minúscula;
- tipos começam com letra maiúscula;
- Haskell diferencia maiúsculas de minúsculas;
- pode usar apóstrofo no final de nomes auxiliares, como `fatorial'`;
- `_` significa “não me importo com esse valor”.

Exemplo:

```haskell
pertence :: Eq t => t -> [t] -> Bool
pertence _ [] = False
pertence e (c:r)
    | e == c = True
    | otherwise = pertence e r
```

Na linha `pertence _ [] = False`, o primeiro parâmetro não importa, porque uma lista vazia não contém nenhum elemento.

---

## 2. Exemplos de códigos

### Soma de dois números

```haskell
soma :: Num t => t -> t -> t
soma a b = a + b
```

### Valor absoluto com guardas

```haskell
valorAbsoluto :: (Num t, Ord t) => t -> t
valorAbsoluto x
    | x < 0 = -x
    | otherwise = x
```

Aqui precisamos de:

- `Num t`, porque usamos números e sinal negativo;
- `Ord t`, porque usamos `<`.

### Verificar se um número é par

```haskell
ehPar :: Integral t => t -> Bool
ehPar n = mod n 2 == 0
```

Usamos `Integral` porque `mod` trabalha com números inteiros.

---

## 3. Exercícios

1. Faça uma função `ehZero` que verifica se um número é igual a zero.
2. Faça uma função `ehPositivo` que verifica se um número é maior que zero.
3. Faça uma função `mediaDois` que recebe dois números e retorna a média entre eles.
4. Escreva a assinatura de tipo de uma função que recebe dois elementos comparáveis e retorna um `Bool`.

---

## 4. Respostas comentadas

### Exercício 1

```haskell
ehZero :: (Num t, Eq t) => t -> Bool
ehZero x = x == 0
```

Comentário: usamos `Eq` porque comparamos igualdade.

### Exercício 2

```haskell
ehPositivo :: (Num t, Ord t) => t -> Bool
ehPositivo x = x > 0
```

Comentário: usamos `Ord` porque usamos `>`.

### Exercício 3

```haskell
mediaDois :: Fractional t => t -> t -> t
mediaDois a b = (a + b) / 2
```

Comentário: usamos `Fractional`, pois a divisão `/` é divisão real.

### Exercício 4

```haskell
comparaAlgumaCoisa :: Ord t => t -> t -> Bool
```

Comentário: se a função compara grandeza, geralmente precisa de `Ord`.

---

# Módulo 3 — Tipos e classes de tipos

## 1. Explicação do conteúdo

Em Haskell, os tipos são muito importantes. Mesmo que a linguagem consiga inferir tipos, no trabalho será importante declarar os tipos das funções principais.

Tipos comuns:

| Tipo | Significado |
|---|---|
| `Int` | inteiro comum, limitado |
| `Integer` | inteiro sem limite prático de tamanho |
| `Bool` | `True` ou `False` |
| `Char` | caractere, como `'a'` |
| `Float` | real de precisão simples |
| `Double` | real de precisão dupla |
| `[t]` | lista de elementos do tipo `t` |
| `(a,b)` | tupla com dois valores |

### Classes de tipos

As classes de tipos indicam quais operações um tipo permite.

| Classe | Quando usar |
|---|---|
| `Eq` | quando usa `==` ou `/=` |
| `Ord` | quando usa `<`, `>`, `<=`, `>=` |
| `Num` | quando usa `+`, `-`, `*` |
| `Integral` | quando usa inteiros, `mod`, `div`, `quot` |
| `Fractional` | quando usa `/` |
| `Show` | quando converte para texto com `show` |
| `Read` | quando converte texto para valor com `read` |

### Exemplo importante

```haskell
pertence :: Eq t => t -> [t] -> Bool
```

A função `pertence` não precisa saber se a lista é de `Int`, `Char`, `String`, `Bool` etc. Ela só precisa comparar igualdade. Por isso, a restrição correta é `Eq t`.

Isso é importante no trabalho porque o enunciado diz para não restringir demais os tipos. Ou seja, evite escrever:

```haskell
pertence :: Int -> [Int] -> Bool
```

se a função poderia funcionar com qualquer tipo comparável.

Melhor:

```haskell
pertence :: Eq t => t -> [t] -> Bool
```

---

## 2. Exemplos de códigos

### Pertence

```haskell
pertence :: Eq t => t -> [t] -> Bool
pertence _ [] = False
pertence e (c:r)
    | e == c = True
    | otherwise = pertence e r
```

### Maior elemento de uma lista não vazia

```haskell
maior :: Ord t => [t] -> t
maior [e] = e
maior (c:r) = maiorDeDois c (maior r)

maiorDeDois :: Ord t => t -> t -> t
maiorDeDois a b
    | a >= b = a
    | otherwise = b
```

Comentário: para comparar grandeza, usamos `Ord`.

### Número de elementos

```haskell
nroElementos :: [t] -> Int
nroElementos [] = 0
nroElementos (_:r) = 1 + nroElementos r
```

Comentário: não precisamos saber o tipo dos elementos. Por isso a assinatura é `[t] -> Int`, sem `Eq`, `Ord` ou `Num` para `t`.

---

## 3. Exercícios

1. Qual classe de tipos você usaria para uma função que compara igualdade?
2. Qual classe de tipos você usaria para uma função que ordena uma lista?
3. Faça uma função `diferente` que recebe dois valores e verifica se eles são diferentes.
4. Faça uma função `menorOuIgual` que recebe dois valores ordenáveis e retorna se o primeiro é menor ou igual ao segundo.

---

## 4. Respostas comentadas

### Exercício 1

Usaria `Eq`, porque igualdade usa `==` ou `/=`.

### Exercício 2

Usaria `Ord`, porque ordenar exige comparação de grandeza.

### Exercício 3

```haskell
diferente :: Eq t => t -> t -> Bool
diferente a b = a /= b
```

### Exercício 4

```haskell
menorOuIgual :: Ord t => t -> t -> Bool
menorOuIgual a b = a <= b
```

---

# Módulo 4 — Guardas, casamento de padrões e casos base

## 1. Explicação do conteúdo

Em Haskell, você define funções por casos. Existem duas formas muito usadas:

1. **Casamento de padrões**
2. **Guardas**

### Casamento de padrões

Casamento de padrões é quando você escreve uma definição específica para um formato de entrada.

Exemplo:

```haskell
fatorial 0 = 1
fatorial n = n * fatorial (n - 1)
```

O primeiro caso só vale quando o argumento é `0`.

Outro exemplo:

```haskell
nroElementos [] = 0
nroElementos (_:r) = 1 + nroElementos r
```

O primeiro caso vale para lista vazia. O segundo vale para uma lista com cabeça e resto.

### Guardas

Guardas são condições usando `|`.

```haskell
valorAbsoluto x
    | x < 0 = -x
    | otherwise = x
```

Use guardas quando os casos dependem de uma condição lógica.

### Quando usar cada um?

Use casamento de padrões quando o formato da entrada é importante:

```haskell
[]
[e]
(c:r)
(x:y:xs)
```

Use guardas quando você precisa testar uma condição:

```haskell
x > 0
x == c
n == 0
a <= b
```

### O caso base

Toda recursão precisa de um caso base. Sem caso base, a função chama a si mesma para sempre.

Exemplo errado:

```haskell
fatorial n = n * fatorial (n - 1)
```

Para `fatorial 3`:

```text
3 * fatorial 2
3 * 2 * fatorial 1
3 * 2 * 1 * fatorial 0
3 * 2 * 1 * 0 * fatorial (-1)
...
```

Não para.

Exemplo correto:

```haskell
fatorial 0 = 1
fatorial n = n * fatorial (n - 1)
```

---

## 2. Exemplos de códigos

### Fibonacci simples

```haskell
fibonacci :: Int -> Integer
fibonacci 1 = 1
fibonacci 2 = 1
fibonacci n = fibonacci (n - 1) + fibonacci (n - 2)
```

Comentário: essa versão é simples, mas não é eficiente para valores grandes, porque recalcula muitos resultados.

### Elemento de uma lista por posição

```haskell
elemento :: Int -> [t] -> t
elemento 1 (c:_) = c
elemento pos (_:r) = elemento (pos - 1) r
```

A posição aqui começa em `1`, como no enunciado do trabalho em funções como `seleciona`.

### Remover último elemento

```haskell
removerUltimoExemplo :: [t] -> [t]
removerUltimoExemplo [_] = []
removerUltimoExemplo (c:r) = c : removerUltimoExemplo r
```

Observe o padrão:

- se a lista tem só um elemento, remover o último gera `[]`;
- se tem cabeça e resto, mantemos a cabeça e removemos o último do resto.

---

## 3. Exercícios

1. Faça uma função `primeiro` que retorna o primeiro elemento de uma lista não vazia.
2. Faça uma função `segundo` que retorna o segundo elemento de uma lista com pelo menos dois elementos.
3. Faça uma função `ehListaVazia` que retorna `True` se a lista é vazia.
4. Faça uma função `fatorialSeguro` que retorna `1` para `0` e calcula o fatorial para números positivos.

---

## 4. Respostas comentadas

### Exercício 1

```haskell
primeiro :: [t] -> t
primeiro (c:_) = c
```

Comentário: usamos `_` para ignorar o resto.

### Exercício 2

```haskell
segundo :: [t] -> t
segundo (_:x:_) = x
```

Comentário: ignoramos o primeiro e pegamos o segundo.

### Exercício 3

```haskell
ehListaVazia :: [t] -> Bool
ehListaVazia [] = True
ehListaVazia _ = False
```

Comentário: o segundo caso pega qualquer outra lista.

### Exercício 4

```haskell
fatorialSeguro :: Integral t => t -> t
fatorialSeguro 0 = 1
fatorialSeguro n = n * fatorialSeguro (n - 1)
```

Comentário: o exercício pressupõe número natural. Se fossem permitidos negativos, seria necessário decidir como tratar esse caso.

---

# Módulo 5 — Listas: a base do trabalho

## 1. Explicação do conteúdo

Quase todo o trabalho gira em torno de listas. Em Haskell, lista é uma estrutura recursiva:

```haskell
[]
```

ou

```haskell
c:r
```

A lista vazia é o caso base. A lista com cabeça e resto é o caso recursivo.

### O operador `:`

O operador `:` coloca um elemento no início de uma lista.

```haskell
1 : [2,3]
```

Resultado:

```haskell
[1,2,3]
```

Esse operador é muito importante porque é eficiente e natural em listas.

### O operador `++`

O operador `++` concatena listas.

```haskell
[1,2] ++ [3,4]
```

Resultado:

```haskell
[1,2,3,4]
```

Mas atenção: em muitos exercícios, é melhor usar `:` quando possível. Por exemplo, para manter a cabeça e continuar processando o resto:

```haskell
c : funcao r
```

é melhor do que:

```haskell
[c] ++ funcao r
```

### Padrões comuns com listas

#### Percorrer uma lista

```haskell
funcao [] = casoBase
funcao (c:r) = usa c e chama funcao r
```

#### Filtrar elementos

```haskell
filtro [] = []
filtro (c:r)
    | condicao c = c : filtro r
    | otherwise = filtro r
```

#### Transformar elementos

```haskell
transforma [] = []
transforma (c:r) = novoValor c : transforma r
```

#### Comparar elementos vizinhos

```haskell
vizinhos [] = []
vizinhos [_] = []
vizinhos (a:b:r) = usa a b : vizinhos (b:r)
```

Esse padrão é essencial para `variacoes`, `ordenada` e parte de `picos`.

---

## 2. Exemplos de códigos

### Contar elementos

```haskell
nroElementos :: [t] -> Int
nroElementos [] = 0
nroElementos (_:r) = 1 + nroElementos r
```

### Verificar pertencimento

```haskell
pertence :: Eq t => t -> [t] -> Bool
pertence _ [] = False
pertence e (c:r)
    | e == c = True
    | otherwise = pertence e r
```

### Filtrar maiores que um valor

```haskell
maioresQueExemplo :: Ord t => t -> [t] -> [t]
maioresQueExemplo _ [] = []
maioresQueExemplo x (c:r)
    | c > x = c : maioresQueExemplo x r
    | otherwise = maioresQueExemplo x r
```

### Concatenar listas sem usar `++`

```haskell
concatenaExemplo :: [t] -> [t] -> [t]
concatenaExemplo [] lista = lista
concatenaExemplo (c:r) lista = c : concatenaExemplo r lista
```

Leitura:

- concatenar lista vazia com `lista` resulta em `lista`;
- concatenar `(c:r)` com `lista` é colocar `c` na frente da concatenação de `r` com `lista`.

---

## 3. Exercícios

1. Faça uma função `contaPares` que conta quantos números pares existem em uma lista.
2. Faça uma função `soPares` que retorna apenas os números pares de uma lista.
3. Faça uma função `multiplicaTodos` que multiplica todos os elementos de uma lista por um número.
4. Faça uma função `existeMaiorQue` que verifica se existe algum valor maior que `x` em uma lista.

---

## 4. Respostas comentadas

### Exercício 1

```haskell
contaPares :: Integral t => [t] -> Int
contaPares [] = 0
contaPares (c:r)
    | mod c 2 == 0 = 1 + contaPares r
    | otherwise = contaPares r
```

Comentário: se `c` é par, contamos `1` e continuamos no resto.

### Exercício 2

```haskell
soPares :: Integral t => [t] -> [t]
soPares [] = []
soPares (c:r)
    | mod c 2 == 0 = c : soPares r
    | otherwise = soPares r
```

Comentário: esse é o mesmo padrão de `maiores_que`.

### Exercício 3

```haskell
multiplicaTodos :: Num t => t -> [t] -> [t]
multiplicaTodos _ [] = []
multiplicaTodos n (c:r) = n * c : multiplicaTodos n r
```

Comentário: transformamos cada elemento.

### Exercício 4

```haskell
existeMaiorQue :: Ord t => t -> [t] -> Bool
existeMaiorQue _ [] = False
existeMaiorQue x (c:r)
    | c > x = True
    | otherwise = existeMaiorQue x r
```

Comentário: quando encontramos o primeiro maior que `x`, já podemos retornar `True`.

---

# Módulo 6 — Recursão em listas

## 1. Explicação do conteúdo

A recursão em lista geralmente segue três perguntas:

1. Qual é o resultado para lista vazia?
2. O que faço com a cabeça da lista?
3. Como continuo com o resto?

Exemplo: somar uma lista.

```haskell
somatorio [] = 0
somatorio (c:r) = c + somatorio r
```

- lista vazia: soma é `0`;
- cabeça `c`: entra na soma;
- resto `r`: será somado recursivamente.

### Recursão que reduz número

Algumas funções reduzem um número até zero.

Exemplo:

```haskell
sequencia 0 m = []
sequencia n m = m : sequencia (n - 1) (m + 1)
```

Aqui o caso base é `n == 0`.

### Recursão com duas listas

Em funções com duas listas, podem existir vários casos:

```haskell
intercala [] lista = lista
intercala lista [] = lista
intercala (a:as) (b:bs) = a : b : intercala as bs
```

Isso é necessário porque uma lista pode acabar antes da outra.

### Recursão com elementos vizinhos

Funções como `variacoes` precisam olhar dois elementos por vez:

```haskell
variacoes [1,3,3,7]
```

Deve calcular:

```text
3 - 1 = 2
3 - 3 = 0
7 - 3 = 4
```

Padrão:

```haskell
variacoes [] = []
variacoes [_] = []
variacoes (a:b:r) = (b - a) : variacoes (b:r)
```

Note que a próxima chamada usa `(b:r)`, porque `b` precisa ser comparado com o próximo.

---

## 2. Exemplos de códigos

### Gerar sequência de `m` com `n` elementos

```haskell
sequenciaExemplo :: (Num t, Eq n, Num n) => n -> t -> [t]
sequenciaExemplo 0 _ = []
sequenciaExemplo n m = m : sequenciaExemplo (n - 1) (m + 1)
```

Uma assinatura mais prática para o trabalho:

```haskell
sequenciaExemplo2 :: Int -> Int -> [Int]
sequenciaExemplo2 0 _ = []
sequenciaExemplo2 n m = m : sequenciaExemplo2 (n - 1) (m + 1)
```

### Intercalar duas listas

```haskell
intercalaExemplo :: [t] -> [t] -> [t]
intercalaExemplo [] ys = ys
intercalaExemplo xs [] = xs
intercalaExemplo (x:xs) (y:ys) = x : y : intercalaExemplo xs ys
```

### Variações

```haskell
variacoesExemplo :: Num t => [t] -> [t]
variacoesExemplo [] = []
variacoesExemplo [_] = []
variacoesExemplo (a:b:r) = (b - a) : variacoesExemplo (b:r)
```

---

## 3. Exercícios

1. Faça uma função `repete` que recebe um número `n` e um valor `x`, retornando uma lista com `x` repetido `n` vezes.
2. Faça uma função `decrescente` que recebe `n` e retorna `[n,n-1,...,1]`.
3. Faça uma função `somaVizinhos` que recebe uma lista e retorna a soma de cada par vizinho.
4. Faça uma função `intercalaSoma` que recebe duas listas numéricas e soma os elementos da mesma posição até uma das listas acabar.

---

## 4. Respostas comentadas

### Exercício 1

```haskell
repete :: Int -> t -> [t]
repete 0 _ = []
repete n x = x : repete (n - 1) x
```

Comentário: quando `n` chega a zero, paramos.

### Exercício 2

```haskell
decrescente :: Int -> [Int]
decrescente 0 = []
decrescente n = n : decrescente (n - 1)
```

### Exercício 3

```haskell
somaVizinhos :: Num t => [t] -> [t]
somaVizinhos [] = []
somaVizinhos [_] = []
somaVizinhos (a:b:r) = (a + b) : somaVizinhos (b:r)
```

Comentário: o próximo par começa em `b`.

### Exercício 4

```haskell
intercalaSoma :: Num t => [t] -> [t] -> [t]
intercalaSoma [] _ = []
intercalaSoma _ [] = []
intercalaSoma (a:as) (b:bs) = (a + b) : intercalaSoma as bs
```

Comentário: se uma lista acaba, não existe mais par de soma.

---

# Módulo 7 — Funções auxiliares, `where` e `let`

## 1. Explicação do conteúdo

No trabalho, o enunciado pede atenção à reusabilidade e às funções auxiliares. A regra prática é:

- se a função auxiliar é útil para vários problemas, pode ficar exposta;
- se ela só serve para uma função específica, esconda com `where`.

### `where`

`where` cria nomes auxiliares depois da expressão principal.

```haskell
media :: [Double] -> Double
media lista = soma / quantidade
    where
        soma = somatorio lista
        quantidade = fromIntegral (nroElementos lista)
```

### `let`

`let` cria nomes antes da expressão final.

```haskell
media lista =
    let soma = somatorio lista
        quantidade = fromIntegral (nroElementos lista)
    in soma / quantidade
```

Para iniciantes, `where` costuma ficar mais legível.

### Função auxiliar escondida

Exemplo: verificar se um número é primo.

A função principal é `primo`. A função auxiliar `temDivisor` só serve para ela.

```haskell
primo :: Integral t => t -> Bool
primo n
    | n < 2 = False
    | otherwise = not (temDivisor 2)
    where
        temDivisor d
            | d * d > n = False
            | mod n d == 0 = True
            | otherwise = temDivisor (d + 1)
```

---

## 2. Exemplos de códigos

### Média usando auxiliares

```haskell
somatorioExemplo :: Num t => [t] -> t
somatorioExemplo [] = 0
somatorioExemplo (c:r) = c + somatorioExemplo r

nroElementosExemplo :: [t] -> Int
nroElementosExemplo [] = 0
nroElementosExemplo (_:r) = 1 + nroElementosExemplo r

mediaExemplo :: Fractional t => [t] -> t
mediaExemplo lista = somatorioExemplo lista / fromIntegral (nroElementosExemplo lista)
```

### Quadrado perfeito sem raiz quadrada

```haskell
quadradoPerfeitoExemplo :: Integral t => t -> Bool
quadradoPerfeitoExemplo n
    | n < 0 = False
    | otherwise = testa 0
    where
        testa x
            | x * x == n = True
            | x * x > n = False
            | otherwise = testa (x + 1)
```

---

## 3. Exercícios

1. Faça uma função `dobroDaSoma` usando `where`, que recebe dois números e retorna o dobro da soma deles.
2. Faça uma função `areaTriangulo` usando `let`, que recebe base e altura e retorna a área.
3. Faça uma função `potencia2` que verifica se um número é potência de 2, usando uma auxiliar escondida.

---

## 4. Respostas comentadas

### Exercício 1

```haskell
dobroDaSoma :: Num t => t -> t -> t
dobroDaSoma a b = 2 * soma
    where
        soma = a + b
```

### Exercício 2

```haskell
areaTriangulo :: Fractional t => t -> t -> t
areaTriangulo base altura =
    let produto = base * altura
    in produto / 2
```

### Exercício 3

```haskell
potencia2 :: Integral t => t -> Bool
potencia2 n
    | n < 1 = False
    | otherwise = testa 1
    where
        testa x
            | x == n = True
            | x > n = False
            | otherwise = testa (x * 2)
```

Comentário: a função `testa` não precisa ficar disponível fora de `potencia2`.

---

# Módulo 8 — Tuplas e retorno de mais de um valor

## 1. Explicação do conteúdo

Tuplas agrupam valores. Diferente de listas, tuplas podem ter tipos diferentes.

Exemplos:

```haskell
(1,2)
("Joao", 10)
(True, [1,2,3])
```

Uma função que retorna dois valores pode retornar uma tupla.

No trabalho, isso aparece em `divide`, que retorna:

```haskell
([primeiros], [resto])
```

Exemplo:

```haskell
divide [1,2,3,4] 2
```

Resultado:

```haskell
([1,2],[3,4])
```

### Como construir tuplas recursivamente

A dificuldade de `divide` é que a chamada recursiva retorna uma tupla. Então precisamos desmontar essa tupla.

```haskell
divide (c:r) n = (c:inicio, fim)
    where
        (inicio, fim) = divide r (n - 1)
```

Leitura:

- divido o resto da lista;
- pego o resultado como `(inicio, fim)`;
- coloco `c` na frente de `inicio`.

---

## 2. Exemplos de códigos

### Primeiro e segundo de uma tupla

```haskell
primeiroTupla :: (a,b) -> a
primeiroTupla (x,_) = x

segundoTupla :: (a,b) -> b
segundoTupla (_,y) = y
```

### Dividir uma lista

```haskell
divideExemplo :: [t] -> Int -> ([t],[t])
divideExemplo lista 0 = ([], lista)
divideExemplo [] _ = ([], [])
divideExemplo (c:r) n = (c:inicio, fim)
    where
        (inicio, fim) = divideExemplo r (n - 1)
```

---

## 3. Exercícios

1. Faça uma função `troca` que recebe uma tupla `(a,b)` e retorna `(b,a)`.
2. Faça uma função `somaTupla` que recebe `(a,b)` e retorna `a+b`.
3. Faça uma função `pegaDois` que recebe uma lista com pelo menos dois elementos e retorna uma tupla com os dois primeiros.

---

## 4. Respostas comentadas

### Exercício 1

```haskell
troca :: (a,b) -> (b,a)
troca (x,y) = (y,x)
```

### Exercício 2

```haskell
somaTupla :: Num t => (t,t) -> t
somaTupla (a,b) = a + b
```

### Exercício 3

```haskell
pegaDois :: [t] -> (t,t)
pegaDois (a:b:_) = (a,b)
```

Comentário: esse padrão exige uma lista com pelo menos dois elementos.

---

# Módulo 9 — Strings e caracteres

## 1. Explicação do conteúdo

Em Haskell, `String` é apenas uma lista de caracteres.

```haskell
String == [Char]
```

Então uma função para string geralmente é uma função para lista.

Exemplo:

```haskell
"abc"
```

é parecido com:

```haskell
['a','b','c']
```

Isso é importante para:

- `todas_maiusculas`;
- `primeiras_maiusculas`;
- `muda_base`.

### Códigos de caracteres

O enunciado informa códigos como:

| Caractere | Código |
|---|---:|
| `a` | 97 |
| `z` | 122 |
| `A` | 65 |
| `Z` | 90 |
| `0` | 48 |
| `9` | 57 |
| espaço | 32 |

Em Haskell, podemos converter:

```haskell
fromEnum 'a'
```

Resultado:

```haskell
97
```

E podemos voltar:

```haskell
toEnum 65 :: Char
```

Resultado:

```haskell
'A'
```

### Converter minúscula para maiúscula

A diferença entre `'a'` e `'A'` é:

```text
97 - 65 = 32
```

Então, se um caractere está entre `'a'` e `'z'`, basta subtrair 32 do código.

```haskell
maiusculaChar :: Char -> Char
maiusculaChar c
    | c >= 'a' && c <= 'z' = toEnum (fromEnum c - 32)
    | otherwise = c
```

### Primeira letra maiúscula e resto minúsculo

Para `primeiras_maiusculas`, é útil ter:

- uma função que transforma caractere em maiúsculo;
- uma função que transforma caractere em minúsculo;
- uma função recursiva que sabe se está no começo de uma palavra.

---

## 2. Exemplos de códigos

### Caractere para maiúsculo

```haskell
maiusculaChar :: Char -> Char
maiusculaChar c
    | c >= 'a' && c <= 'z' = toEnum (fromEnum c - 32)
    | otherwise = c
```

### Caractere para minúsculo

```haskell
minusculaChar :: Char -> Char
minusculaChar c
    | c >= 'A' && c <= 'Z' = toEnum (fromEnum c + 32)
    | otherwise = c
```

### Todas maiúsculas

```haskell
todasMaiusculasExemplo :: String -> String
todasMaiusculasExemplo [] = []
todasMaiusculasExemplo (c:r) = maiusculaChar c : todasMaiusculasExemplo r
```

---

## 3. Exercícios

1. Faça uma função `todasMinusculas`.
2. Faça uma função `ehDigito` que verifica se um caractere está entre `'0'` e `'9'`.
3. Faça uma função `contaEspacos` que conta os espaços em uma string.
4. Faça uma função `removeEspacos` que remove os espaços de uma string.

---

## 4. Respostas comentadas

### Exercício 1

```haskell
todasMinusculas :: String -> String
todasMinusculas [] = []
todasMinusculas (c:r) = minusculaChar c : todasMinusculas r
```

### Exercício 2

```haskell
ehDigito :: Char -> Bool
ehDigito c = c >= '0' && c <= '9'
```

### Exercício 3

```haskell
contaEspacos :: String -> Int
contaEspacos [] = 0
contaEspacos (c:r)
    | c == ' ' = 1 + contaEspacos r
    | otherwise = contaEspacos r
```

### Exercício 4

```haskell
removeEspacos :: String -> String
removeEspacos [] = []
removeEspacos (c:r)
    | c == ' ' = removeEspacos r
    | otherwise = c : removeEspacos r
```

---

# Módulo 10 — Ordenação, inserção ordenada e bolha

## 1. Explicação do conteúdo

Alguns exercícios exigem ordenação:

- `insere_ordenado`;
- `ordenada`;
- `ordena`;
- `bolha`;
- `mediana`, porque a mediana normalmente exige a lista ordenada.

### Inserção ordenada

Se a lista já está em ordem crescente, inserir um elemento é simples:

- se a lista está vazia, o resultado é `[x]`;
- se `x <= c`, colocamos `x` antes de `c`;
- caso contrário, mantemos `c` e inserimos `x` no resto.

```haskell
insere_ordenado x [] = [x]
insere_ordenado x (c:r)
    | x <= c = x : c : r
    | otherwise = c : insere_ordenado x r
```

### Ordenação por inserção

Para ordenar uma lista:

- ordene o resto;
- insira a cabeça no resto já ordenado.

```haskell
ordena [] = []
ordena (c:r) = insere_ordenado c (ordena r)
```

Esse padrão é simples e combina bem com Haskell.

### Verificar se uma lista está ordenada

Você compara vizinhos:

```haskell
ordenada [] = True
ordenada [_] = True
ordenada (a:b:r)
    | a <= b = ordenada (b:r)
    | otherwise = False
```

### Bolha burra

O método da bolha faz várias passagens pela lista, trocando vizinhos fora de ordem.

Uma passagem transforma:

```haskell
[7,3,5]
```

em:

```haskell
[3,5,7]
```

A versão “burra” não verifica se houve troca para parar antes. Ela faz um número fixo de passagens.

---

## 2. Exemplos de códigos

### Inserir ordenado

```haskell
insereOrdenadoExemplo :: Ord t => t -> [t] -> [t]
insereOrdenadoExemplo x [] = [x]
insereOrdenadoExemplo x (c:r)
    | x <= c = x : c : r
    | otherwise = c : insereOrdenadoExemplo x r
```

### Ordenar

```haskell
ordenaExemplo :: Ord t => [t] -> [t]
ordenaExemplo [] = []
ordenaExemplo (c:r) = insereOrdenadoExemplo c (ordenaExemplo r)
```

### Passagem da bolha

```haskell
passagemBolha :: Ord t => [t] -> [t]
passagemBolha [] = []
passagemBolha [x] = [x]
passagemBolha (a:b:r)
    | a > b = b : passagemBolha (a:r)
    | otherwise = a : passagemBolha (b:r)
```

---

## 3. Exercícios

1. Faça uma função `menorLista` que retorna o menor valor de uma lista não vazia.
2. Faça uma função `removePrimeiroMenor` que remove a primeira ocorrência do menor valor de uma lista.
3. Faça uma função `ordenaSelecao` usando a ideia de escolher o menor e ordenar o resto.
4. Faça uma função `passagensBolha` que aplica a passagem da bolha `n` vezes.

---

## 4. Respostas comentadas

### Exercício 1

```haskell
menorLista :: Ord t => [t] -> t
menorLista [x] = x
menorLista (c:r)
    | c <= menorResto = c
    | otherwise = menorResto
    where
        menorResto = menorLista r
```

Comentário: usamos `where` para não calcular `menorLista r` duas vezes.

### Exercício 2

```haskell
removePrimeiroMenor :: Ord t => [t] -> [t]
removePrimeiroMenor lista = removeAux menor lista
    where
        menor = menorLista lista
        removeAux _ [] = []
        removeAux x (c:r)
            | x == c = r
            | otherwise = c : removeAux x r
```

### Exercício 3

```haskell
ordenaSelecao :: Ord t => [t] -> [t]
ordenaSelecao [] = []
ordenaSelecao lista = menor : ordenaSelecao (removePrimeiroMenor lista)
    where
        menor = menorLista lista
```

### Exercício 4

```haskell
passagensBolha :: Ord t => Int -> [t] -> [t]
passagensBolha 0 lista = lista
passagensBolha n lista = passagensBolha (n - 1) (passagemBolha lista)
```

---

# Módulo 11 — Conjuntos, repetidos, união e interseção

## 1. Explicação do conteúdo

Algumas funções tratam listas como se fossem conjuntos:

- `remover_repetidos`;
- `uniao`;
- `interseccao`;
- `mesmos_elementos`;
- `partes`.

Em um conjunto, a repetição não importa.

Exemplo:

```haskell
[2,4,2,1]
```

tem os mesmos elementos de:

```haskell
[1,2,4]
```

porque os repetidos são ignorados.

### Remover repetidos preservando a primeira ocorrência

O exemplo do trabalho:

```haskell
remover_repetidos [7,4,3,5,7,4,4,6,4,1,2]
```

Resultado:

```haskell
[7,4,3,5,6,1,2]
```

Isso preserva a primeira vez que cada elemento apareceu.

Ideia:

- se a cabeça aparece no resto, ainda assim queremos mantê-la;
- mas precisamos remover as próximas ocorrências dela do resto.

Uma estratégia:

```haskell
remover_repetidos [] = []
remover_repetidos (c:r) = c : remover_repetidos (removeTodos c r)
```

### União

Se as listas de entrada não têm repetidos, a união pode manter toda a primeira lista e adicionar da segunda apenas o que ainda não pertence à primeira.

### Interseção

Para cada elemento da primeira lista:

- se pertence à segunda, entra na resposta;
- caso contrário, não entra.

---

## 2. Exemplos de códigos

### Remover todas as ocorrências

```haskell
removeTodos :: Eq t => t -> [t] -> [t]
removeTodos _ [] = []
removeTodos x (c:r)
    | x == c = removeTodos x r
    | otherwise = c : removeTodos x r
```

### Remover repetidos

```haskell
removerRepetidosExemplo :: Eq t => [t] -> [t]
removerRepetidosExemplo [] = []
removerRepetidosExemplo (c:r) = c : removerRepetidosExemplo (removeTodos c r)
```

### União

```haskell
uniaoExemplo :: Eq t => [t] -> [t] -> [t]
uniaoExemplo xs [] = xs
uniaoExemplo xs (y:ys)
    | pertence y xs = uniaoExemplo xs ys
    | otherwise = uniaoExemplo (insereNoFimExemplo y xs) ys
```

---

## 3. Exercícios

1. Faça uma função `removeTodosExercicio` que remove todas as ocorrências de um valor.
2. Faça uma função `contido` que verifica se todos os elementos da primeira lista pertencem à segunda.
3. Faça uma função `diferenca` que retorna os elementos da primeira lista que não pertencem à segunda.
4. Faça uma função `temRepetido` que verifica se uma lista possui algum elemento repetido.

---

## 4. Respostas comentadas

### Exercício 1

```haskell
removeTodosExercicio :: Eq t => t -> [t] -> [t]
removeTodosExercicio _ [] = []
removeTodosExercicio x (c:r)
    | x == c = removeTodosExercicio x r
    | otherwise = c : removeTodosExercicio x r
```

### Exercício 2

```haskell
contido :: Eq t => [t] -> [t] -> Bool
contido [] _ = True
contido (c:r) lista
    | pertence c lista = contido r lista
    | otherwise = False
```

### Exercício 3

```haskell
diferenca :: Eq t => [t] -> [t] -> [t]
diferenca [] _ = []
diferenca (c:r) lista
    | pertence c lista = diferenca r lista
    | otherwise = c : diferenca r lista
```

### Exercício 4

```haskell
temRepetido :: Eq t => [t] -> Bool
temRepetido [] = False
temRepetido (c:r)
    | pertence c r = True
    | otherwise = temRepetido r
```

---

# Módulo 12 — Estatística: média, variância e mediana

## 1. Explicação do conteúdo

As funções `media`, `variancia` e `mediana` exigem cuidado com tipos numéricos.

### Média

A média é:

```text
soma dos valores / quantidade de valores
```

Em Haskell, a quantidade geralmente é `Int`, mas a divisão `/` precisa de tipo fracionário. Por isso usamos `fromIntegral`.

```haskell
fromIntegral :: (Integral a, Num b) => a -> b
```

Na prática:

```haskell
fromIntegral (nroElementos lista)
```

converte `Int` para um tipo numérico compatível com `/`.

### Variância populacional

A variância populacional é:

```text
soma((x - média)^2) / quantidade
```

Exemplo:

```haskell
variancia [6,2,9,0,8,3,0,2]
```

Resultado esperado:

```haskell
10.6875
```

### Mediana

Para calcular a mediana:

1. ordenar a lista;
2. contar o número de elementos;
3. se a quantidade for ímpar, pegar o elemento do meio;
4. se for par, tirar a média dos dois elementos centrais.

Como as posições do trabalho costumam começar em `1`, podemos usar `elemento` com posição `1`.

Para uma lista com `n` elementos:

- se `n` é ímpar, posição do meio: `n div 2 + 1`;
- se `n` é par, posições centrais: `n div 2` e `n div 2 + 1`.

---

## 2. Exemplos de códigos

### Soma dos quadrados das diferenças

```haskell
somaQuadradosDif :: Fractional t => t -> [t] -> t
somaQuadradosDif _ [] = 0
somaQuadradosDif m (c:r) = (c - m) * (c - m) + somaQuadradosDif m r
```

### Média

```haskell
mediaExemplo2 :: Fractional t => [t] -> t
mediaExemplo2 lista = somatorioExemplo lista / fromIntegral (nroElementosExemplo lista)
```

### Elemento por posição

```haskell
elementoExemplo :: Int -> [t] -> t
elementoExemplo 1 (c:_) = c
elementoExemplo n (_:r) = elementoExemplo (n - 1) r
```

---

## 3. Exercícios

1. Calcule manualmente a média de `[2,4,6]`.
2. Faça uma função `quadrados` que transforma `[2,3,4]` em `[4,9,16]`.
3. Faça uma função `somaQuadrados` que soma os quadrados dos elementos.
4. Explique por que `media` precisa de `Fractional` e não apenas de `Num`.

---

## 4. Respostas comentadas

### Exercício 1

```text
(2 + 4 + 6) / 3 = 12 / 3 = 4
```

### Exercício 2

```haskell
quadrados :: Num t => [t] -> [t]
quadrados [] = []
quadrados (c:r) = c * c : quadrados r
```

### Exercício 3

```haskell
somaQuadrados :: Num t => [t] -> t
somaQuadrados [] = 0
somaQuadrados (c:r) = c * c + somaQuadrados r
```

### Exercício 4

Porque a média usa divisão real com `/`. Em Haskell, `/` não funciona para qualquer `Num`; ela exige tipos fracionários, como `Float`, `Double` ou outros tipos da classe `Fractional`.

---

# Módulo 13 — Listas circulares, rotações e picos

## 1. Explicação do conteúdo

Algumas funções exigem pensar na posição dos elementos:

- `rodar_esquerda`;
- `rodar_direita`;
- `picos`.

### Rodar à esquerda

Rodar uma lista à esquerda uma vez:

```haskell
[1,2,3,4,5]
```

vira:

```haskell
[2,3,4,5,1]
```

Ideia:

- tirar o primeiro elemento;
- colocá-lo no fim.

### Rodar à direita

Rodar uma lista à direita uma vez:

```haskell
[1,2,3,4,5]
```

vira:

```haskell
[5,1,2,3,4]
```

Ideia:

- pegar o último elemento;
- colocá-lo no início;
- remover o último da posição original.

### Rotações maiores que o tamanho da lista

O exemplo do trabalho mostra:

```haskell
rodar_esquerda 9 [1,2,3,4,5] => [5,1,2,3,4]
```

Como a lista tem tamanho 5:

```text
9 mod 5 = 4
```

Rodar 9 vezes é igual a rodar 4 vezes.

### Picos em lista circular

Um pico é um elemento maior que seus dois vizinhos.

Na lista circular:

- o vizinho anterior do primeiro é o último;
- o vizinho seguinte do último é o primeiro.

Exemplo:

```haskell
[2,3,5,10,5,5,6,2,3]
```

O `10` é pico porque é maior que `5` e `5`.
O `6` é pico porque é maior que `5` e `2`.
O último `3` é pico porque é maior que `2` e também maior que o primeiro `2`.

---

## 2. Exemplos de códigos

### Inserir no fim

```haskell
insereNoFimExemplo :: t -> [t] -> [t]
insereNoFimExemplo x [] = [x]
insereNoFimExemplo x (c:r) = c : insereNoFimExemplo x r
```

### Rodar à esquerda uma vez

```haskell
rodaEsqUma :: [t] -> [t]
rodaEsqUma [] = []
rodaEsqUma (c:r) = insereNoFimExemplo c r
```

### Último elemento

```haskell
ultimoExemplo :: [t] -> t
ultimoExemplo [x] = x
ultimoExemplo (_:r) = ultimoExemplo r
```

---

## 3. Exercícios

1. Faça uma função `rodaDireitaUma`.
2. Faça uma função `rodarEsquerdaN` sem usar `mod`, apenas repetindo `n` vezes.
3. Faça uma função `maiorQueVizinhos` que recebe três valores `a b c` e verifica se `b` é maior que `a` e `c`.
4. Para a lista `[4,1,3]`, diga quais elementos são picos considerando a lista circular.

---

## 4. Respostas comentadas

### Exercício 1

```haskell
rodaDireitaUma :: [t] -> [t]
rodaDireitaUma [] = []
rodaDireitaUma lista = ultimoExemplo lista : removerUltimoExemplo lista
```

Comentário: colocamos o último na frente e removemos o último da posição original.

### Exercício 2

```haskell
rodarEsquerdaN :: Int -> [t] -> [t]
rodarEsquerdaN 0 lista = lista
rodarEsquerdaN n lista = rodarEsquerdaN (n - 1) (rodaEsqUma lista)
```

### Exercício 3

```haskell
maiorQueVizinhos :: Ord t => t -> t -> t -> Bool
maiorQueVizinhos a b c = b > a && b > c
```

### Exercício 4

Lista circular: `[4,1,3]`.

- `4` tem vizinhos `3` e `1`; é maior que ambos, então é pico;
- `1` não é pico;
- `3` não é maior que `4`, então não é pico.

Resposta: `[4]`.

---

# Módulo 14 — Compreensão de listas, funções lambda e alta ordem

## 1. Explicação do conteúdo

O trabalho pode ser resolvido só com recursão, mas é importante entender recursos funcionais modernos.

### Compreensão de listas

Compreensão de listas cria listas a partir de uma regra.

```haskell
[2*x | x <- [1,2,3,4]]
```

Resultado:

```haskell
[2,4,6,8]
```

Com filtro:

```haskell
[x | x <- [1,2,3,4,5,6], mod x 2 == 0]
```

Resultado:

```haskell
[2,4,6]
```

### Funções lambda

Função lambda é uma função sem nome.

```haskell
\x -> x * x
```

Pode ser usada em funções de alta ordem, como `map`.

```haskell
map (\x -> x * x) [1,2,3]
```

Resultado:

```haskell
[1,4,9]
```

### Funções de alta ordem

São funções que recebem outras funções.

Exemplos comuns:

```haskell
map
filter
foldr
```

Porém, no trabalho, se o professor espera implementação manual, use recursão para mostrar domínio.

---

## 2. Exemplos de códigos

### Maiores que usando compreensão

```haskell
maioresQueCompreensao :: Ord t => t -> [t] -> [t]
maioresQueCompreensao x lista = [e | e <- lista, e > x]
```

### Dobrar todos usando recursão

```haskell
dobraTodos :: Num t => [t] -> [t]
dobraTodos [] = []
dobraTodos (c:r) = 2*c : dobraTodos r
```

### Dobrar todos usando `map`

```haskell
dobraTodosMap :: Num t => [t] -> [t]
dobraTodosMap lista = map (\x -> 2*x) lista
```

---

## 3. Exercícios

1. Reescreva `soPares` usando compreensão de listas.
2. Reescreva `quadrados` usando compreensão de listas.
3. Explique por que, no trabalho, pode ser melhor implementar com recursão em vez de usar `map` e `filter`.

---

## 4. Respostas comentadas

### Exercício 1

```haskell
soParesComp :: Integral t => [t] -> [t]
soParesComp lista = [x | x <- lista, mod x 2 == 0]
```

### Exercício 2

```haskell
quadradosComp :: Num t => [t] -> [t]
quadradosComp lista = [x*x | x <- lista]
```

### Exercício 3

Porque várias funções pedidas no trabalho já existem na biblioteca padrão ou poderiam ser resolvidas por funções prontas. O objetivo da atividade é mostrar que você sabe construir a lógica, especialmente com recursão, tipos, listas, funções auxiliares e polimorfismo.

---

# Módulo 15 — Como organizar o arquivo final do trabalho

## 1. Explicação do conteúdo

O arquivo entregue deve ser um código-fonte Haskell. Uma boa estrutura seria:

```haskell
-- Trabalho de Haskell - Lista de Funcoes
-- Grupo: X
-- Nome: Nome Completo - Matricula: 000000
-- Nome: Nome Completo - Matricula: 000000

-- 1. ultimo
ultimo :: [t] -> t
ultimo [x] = x
ultimo (_:r) = ultimo r

-- 2. insere_no_fim
insere_no_fim :: t -> [t] -> [t]
insere_no_fim x [] = [x]
insere_no_fim x (c:r) = c : insere_no_fim x r
```

### Boas práticas

1. Declare tipo das funções principais.
2. Use nomes significativos.
3. Use comentários com o número do exercício.
4. Evite restringir demais os tipos.
5. Não use função pronta quando o exercício pede para implementá-la.
6. Use `where` para auxiliares específicas.
7. Teste cada função no interpretador.

### Como testar

Salve o arquivo como:

```text
trabalho.hs
```

No interpretador:

```haskell
:load trabalho.hs
```

Depois teste:

```haskell
ultimo [1,2,3]
insere_no_fim 3 [1,2]
unica_ocorrencia 2 [2]
```

---

## 2. Exemplos de códigos

### Exemplo de organização com auxiliar escondida

```haskell
-- 34. primo
primo :: Integral t => t -> Bool
primo n
    | n < 2 = False
    | otherwise = not (temDivisor 2)
    where
        temDivisor d
            | d * d > n = False
            | mod n d == 0 = True
            | otherwise = temDivisor (d + 1)
```

### Exemplo de organização com auxiliar reaproveitável

```haskell
pertence :: Eq t => t -> [t] -> Bool
pertence _ [] = False
pertence x (c:r)
    | x == c = True
    | otherwise = pertence x r

-- 17. uniao
uniao :: Eq t => [t] -> [t] -> [t]
uniao xs [] = xs
uniao xs (y:ys)
    | pertence y xs = uniao xs ys
    | otherwise = uniao (insere_no_fim y xs) ys
```

---

## 3. Exercícios

1. Escreva o cabeçalho inicial do seu arquivo `trabalho.hs`.
2. Explique quando uma função auxiliar deve ficar dentro de `where`.
3. Explique por que `ultimo :: [Int] -> Int` é pior do que `ultimo :: [t] -> t`.

---

## 4. Respostas comentadas

### Exercício 1

```haskell
-- Trabalho de Haskell - Lista de Funcoes
-- Grupo: X
-- Nome: Seu Nome Completo - Matricula: 000000
-- Nome: Nome do Colega - Matricula: 000000
```

### Exercício 2

Uma função auxiliar deve ficar dentro de `where` quando ela só faz sentido para aquela função principal e não deve ser usada por outras funções do programa.

### Exercício 3

Porque `ultimo` funciona para qualquer lista não vazia, não apenas listas de inteiros. A assinatura `[t] -> t` é mais genérica e mostra melhor o uso de polimorfismo.

---

# Mapa do trabalho: que conhecimento usar em cada função

| Função | Conteúdo principal necessário |
|---:|---|
| 1. `ultimo` | recursão em lista, padrão `[x]` e `(_:r)` |
| 2. `insere_no_fim` | recursão e operador `:` |
| 3. `unica_ocorrencia` | contagem, igualdade, lista |
| 4. `maiores_que` | filtro recursivo, `Ord` |
| 5. `concatena` | recursão entre duas listas |
| 6. `remove` | parar na primeira ocorrência |
| 7. `remover_ultimo` | padrão `[x]` |
| 8. `remover_repetidos` | pertencimento, remoção, conjuntos |
| 9. `gera_sequencia` | recursão numérica e lista |
| 10. `variacoes` | comparação de vizinhos `(a:b:r)` |
| 11. `reverso` | inserir no fim ou acumulador |
| 12. `divide` | tupla e recursão |
| 13. `sequencia` | recursão com contador |
| 14. `somatorio` | recursão acumulando soma |
| 15. `maiores` | ordenação auxiliar ou seleção por maiores |
| 16. `intercala` | recursão com duas listas |
| 17. `uniao` | pertencimento e listas sem repetição |
| 18. `interseccao` | filtro por pertencimento |
| 19. `mesmos_elementos` | remover repetidos, contido nos dois sentidos |
| 20. `insere_ordenado` | comparação e lista ordenada |
| 21. `ordenada` | vizinhos |
| 22. `ordena` | inserção ordenada |
| 23. `picos` | vizinhos e circularidade |
| 24. `rodar_esquerda` | dividir, concatenar, módulo |
| 25. `rodar_direita` | último, remover último ou rotação esquerda equivalente |
| 26. `todas_maiusculas` | string como `[Char]`, ASCII |
| 27. `primeiras_maiusculas` | estado de início de palavra |
| 28. `media` | soma, quantidade, `fromIntegral` |
| 29. `variancia` | média, soma de quadrados |
| 30. `mediana` | ordenação, elemento por posição |
| 31. `seleciona` | elemento por posição, recursão em lista de posições |
| 32. `separa` | acumular sublistas entre zeros |
| 33. `palindromo` | reverso e igualdade |
| 34. `primo` | divisores, `mod`, auxiliar |
| 35. `soma_digitos` | `mod`, `div`, recursão numérica |
| 36. `bolha` | passagem de bolha repetida |
| 37. `compactar` | contar repetições consecutivas |
| 38. quadrado perfeito | testar `x*x` sem raiz |
| 39. `muda_base` | divisão inteira, resto, caracteres |
| 40. `partes` | recursão combinatória, subconjuntos |

---

# Apêndice — Respostas comentadas de alguns exercícios do trabalho

As soluções abaixo não cobrem todas as 40 funções, mas cobrem os principais padrões necessários para você conseguir desenvolver as restantes.

> Observação importante: no arquivo final do trabalho, mantenha os nomes exatamente como o professor pediu.

---

## 1. `ultimo`

```haskell
-- 1. ultimo
ultimo :: [t] -> t
ultimo [x] = x
ultimo (_:r) = ultimo r
```

Comentário:

- se a lista tem um único elemento, ele é o último;
- caso contrário, ignoramos a cabeça e procuramos o último no resto.

---

## 2. `insere_no_fim`

```haskell
-- 2. insere_no_fim
insere_no_fim :: t -> [t] -> [t]
insere_no_fim x [] = [x]
insere_no_fim x (c:r) = c : insere_no_fim x r
```

Comentário:

- inserir no fim de uma lista vazia gera uma lista com o elemento;
- em lista não vazia, mantemos a cabeça e inserimos no fim do resto.

---

## 3. `unica_ocorrencia`

```haskell
-- 3. unica_ocorrencia
unica_ocorrencia :: Eq t => t -> [t] -> Bool
unica_ocorrencia x lista = conta x lista == 1
    where
        conta _ [] = 0
        conta e (c:r)
            | e == c = 1 + conta e r
            | otherwise = conta e r
```

Comentário:

- usamos uma auxiliar escondida porque `conta` só serve para essa solução;
- `Eq t` é necessário porque usamos `==`.

---

## 4. `maiores_que`

```haskell
-- 4. maiores_que
maiores_que :: Ord t => t -> [t] -> [t]
maiores_que _ [] = []
maiores_que x (c:r)
    | c > x = c : maiores_que x r
    | otherwise = maiores_que x r
```

Comentário:

- é um filtro recursivo;
- se o elemento atual é maior, entra na resposta;
- se não é, é ignorado.

---

## 5. `concatena`

```haskell
-- 5. concatena
concatena :: [t] -> [t] -> [t]
concatena [] ys = ys
concatena (x:xs) ys = x : concatena xs ys
```

Comentário:

- não usamos `++`, porque a função pedida é justamente implementar a concatenação;
- preservamos os elementos da primeira lista e, ao final, encaixamos a segunda.

---

## 6. `remove`

```haskell
-- 6. remove
remove :: Eq t => t -> [t] -> [t]
remove x (c:r)
    | x == c = r
    | otherwise = c : remove x r
```

Comentário:

- o enunciado diz que se o elemento não estiver na lista, não há resposta possível;
- por isso, não precisamos tratar `remove x []`;
- ao encontrar a primeira ocorrência, retornamos apenas o resto.

---

## 7. `remover_ultimo`

```haskell
-- 7. remover_ultimo
remover_ultimo :: [t] -> [t]
remover_ultimo [_] = []
remover_ultimo (c:r) = c : remover_ultimo r
```

Comentário:

- a lista vazia não precisa ser tratada porque o enunciado diz que não há como remover o último de lista vazia;
- quando resta um único elemento, ele é removido.

---

## 8. `remover_repetidos`

```haskell
-- 8. remover_repetidos
remover_repetidos :: Eq t => [t] -> [t]
remover_repetidos [] = []
remover_repetidos (c:r) = c : remover_repetidos (removeTodos c r)
    where
        removeTodos _ [] = []
        removeTodos x (y:ys)
            | x == y = removeTodos x ys
            | otherwise = y : removeTodos x ys
```

Comentário:

- preserva a primeira ocorrência;
- remove as ocorrências seguintes antes de continuar.

---

## 10. `variacoes`

```haskell
-- 10. variacoes
variacoes :: Num t => [t] -> [t]
variacoes [] = []
variacoes [_] = []
variacoes (a:b:r) = (b - a) : variacoes (b:r)
```

Comentário:

- listas com zero ou um elemento não têm variação;
- comparamos cada elemento com o próximo.

---

## 12. `divide`

```haskell
-- 12. divide
divide :: [t] -> Int -> ([t],[t])
divide lista 0 = ([], lista)
divide [] _ = ([], [])
divide (c:r) n = (c:inicio, fim)
    where
        (inicio, fim) = divide r (n - 1)
```

Comentário:

- quando `n` chega em zero, não pegamos mais elementos;
- a função retorna uma tupla;
- usamos `where` para desmontar a tupla retornada pela chamada recursiva.

---

## 13. `sequencia`

```haskell
-- 13. sequencia
sequencia :: Int -> Int -> [Int]
sequencia 0 _ = []
sequencia n m = m : sequencia (n - 1) (m + 1)
```

Comentário:

- gera `n` elementos;
- o primeiro é `m`;
- a cada chamada, `n` diminui e `m` aumenta.

---

## 14. `somatorio`

```haskell
-- 14. somatorio
somatorio :: Num t => [t] -> t
somatorio [] = 0
somatorio (c:r) = c + somatorio r
```

Comentário:

- soma da lista vazia é zero;
- lista não vazia: cabeça mais soma do resto.

---

## 16. `intercala`

```haskell
-- 16. intercala
intercala :: [t] -> [t] -> [t]
intercala [] ys = ys
intercala xs [] = xs
intercala (x:xs) (y:ys) = x : y : intercala xs ys
```

Comentário:

- se uma lista acaba, retornamos a outra;
- se as duas têm elementos, pegamos um de cada.

---

## 17. `uniao`

```haskell
-- 17. uniao
uniao :: Eq t => [t] -> [t] -> [t]
uniao xs [] = xs
uniao xs (y:ys)
    | pertence y xs = uniao xs ys
    | otherwise = uniao (insere_no_fim y xs) ys
    where
        pertence _ [] = False
        pertence e (c:r)
            | e == c = True
            | otherwise = pertence e r

        insere_no_fim x [] = [x]
        insere_no_fim x (c:r) = c : insere_no_fim x r
```

Comentário:

- o enunciado diz que as listas de entrada não possuem repetidos;
- mantemos a primeira lista;
- adicionamos da segunda apenas os elementos que ainda não aparecem.

---

## 18. `interseccao`

```haskell
-- 18. interseccao
interseccao :: Eq t => [t] -> [t] -> [t]
interseccao [] _ = []
interseccao (c:r) ys
    | pertence c ys = c : interseccao r ys
    | otherwise = interseccao r ys
    where
        pertence _ [] = False
        pertence e (x:xs)
            | e == x = True
            | otherwise = pertence e xs
```

Comentário:

- percorremos a primeira lista;
- mantemos apenas os elementos que pertencem à segunda.

---

## 20. `insere_ordenado`

```haskell
-- 20. insere_ordenado
insere_ordenado :: Ord t => t -> [t] -> [t]
insere_ordenado x [] = [x]
insere_ordenado x (c:r)
    | x <= c = x : c : r
    | otherwise = c : insere_ordenado x r
```

Comentário:

- se a lista está vazia, o item vira o único elemento;
- se `x` deve vir antes da cabeça, inserimos ali;
- se não, continuamos no resto.

---

## 21. `ordenada`

```haskell
-- 21. ordenada
ordenada :: Ord t => [t] -> Bool
ordenada [] = True
ordenada [_] = True
ordenada (a:b:r)
    | a <= b = ordenada (b:r)
    | otherwise = False
```

Comentário:

- lista vazia e lista com um elemento são ordenadas;
- a lista está ordenada se cada par vizinho está em ordem.

---

## 22. `ordena`

```haskell
-- 22. ordena
ordena :: Ord t => [t] -> [t]
ordena [] = []
ordena (c:r) = insere_ordenado c (ordena r)
    where
        insere_ordenado x [] = [x]
        insere_ordenado x (y:ys)
            | x <= y = x : y : ys
            | otherwise = y : insere_ordenado x ys
```

Comentário:

- é ordenação por inserção;
- ordenamos o resto e inserimos a cabeça no lugar correto.

---

## 26. `todas_maiusculas`

```haskell
-- 26. todas_maiusculas
todas_maiusculas :: String -> String
todas_maiusculas [] = []
todas_maiusculas (c:r) = maiuscula c : todas_maiusculas r
    where
        maiuscula x
            | x >= 'a' && x <= 'z' = toEnum (fromEnum x - 32)
            | otherwise = x
```

Comentário:

- string é lista de `Char`;
- subtraímos 32 do código ASCII das letras minúsculas.

---

## 28. `media`

```haskell
-- 28. media
media :: Fractional t => [t] -> t
media lista = soma lista / fromIntegral (quantidade lista)
    where
        soma [] = 0
        soma (c:r) = c + soma r

        quantidade [] = 0
        quantidade (_:r) = 1 + quantidade r
```

Comentário:

- `fromIntegral` converte a quantidade para um tipo compatível com `/`;
- usamos auxiliares escondidas porque só servem aqui.

---

## 29. `variancia`

```haskell
-- 29. variancia
variancia :: Fractional t => [t] -> t
variancia lista = somaQuadrados mediaLista lista / fromIntegral (quantidade lista)
    where
        mediaLista = soma lista / fromIntegral (quantidade lista)

        soma [] = 0
        soma (c:r) = c + soma r

        quantidade [] = 0
        quantidade (_:r) = 1 + quantidade r

        somaQuadrados _ [] = 0
        somaQuadrados m (c:r) = (c - m) * (c - m) + somaQuadrados m r
```

Comentário:

- calcula primeiro a média;
- depois soma os quadrados das diferenças;
- divide pela quantidade de elementos.

---

## 30. `mediana`

```haskell
-- 30. mediana
mediana :: (Ord t, Fractional t) => [t] -> t
mediana lista
    | mod n 2 == 1 = elemento (div n 2 + 1) ordenadaLista
    | otherwise = (elemento (div n 2) ordenadaLista + elemento (div n 2 + 1) ordenadaLista) / 2
    where
        ordenadaLista = ordena lista
        n = quantidade lista

        quantidade [] = 0
        quantidade (_:r) = 1 + quantidade r

        elemento 1 (c:_) = c
        elemento pos (_:r) = elemento (pos - 1) r

        ordena [] = []
        ordena (c:r) = insere c (ordena r)

        insere x [] = [x]
        insere x (y:ys)
            | x <= y = x : y : ys
            | otherwise = y : insere x ys
```

Comentário:

- primeiro ordena;
- se a quantidade é ímpar, pega o centro;
- se é par, faz a média dos dois centrais.

---

## 33. `palindromo`

```haskell
-- 33. palindromo
palindromo :: Eq t => [t] -> Bool
palindromo lista = lista == reverso lista
    where
        reverso [] = []
        reverso (c:r) = insereFim c (reverso r)

        insereFim x [] = [x]
        insereFim x (y:ys) = y : insereFim x ys
```

Comentário:

- uma lista é palíndromo se é igual ao próprio reverso;
- funciona também para strings, porque `String` é `[Char]`.

---

## 34. `primo`

```haskell
-- 34. primo
primo :: Integral t => t -> Bool
primo n
    | n < 2 = False
    | otherwise = not (temDivisor 2)
    where
        temDivisor d
            | d * d > n = False
            | mod n d == 0 = True
            | otherwise = temDivisor (d + 1)
```

Comentário:

- números menores que 2 não são primos;
- não precisamos testar divisores maiores que a raiz, mas fazemos isso sem calcular raiz: usamos `d*d > n`.

---

## 35. `soma_digitos`

```haskell
-- 35. soma_digitos
soma_digitos :: Integral t => t -> t
soma_digitos n
    | n < 10 = n
    | otherwise = mod n 10 + soma_digitos (div n 10)
```

Comentário:

- `mod n 10` pega o último dígito;
- `div n 10` remove o último dígito.

---

## 38. Quadrado perfeito

```haskell
-- 38. quadrado perfeito
quadrado_perfeito :: Integral t => t -> Bool
quadrado_perfeito n
    | n < 0 = False
    | otherwise = testa 0
    where
        testa x
            | x * x == n = True
            | x * x > n = False
            | otherwise = testa (x + 1)
```

Comentário:

- não usa raiz quadrada;
- testa quadrados sucessivos até encontrar ou passar do número.

---

## 39. `muda_base`

```haskell
-- 39. muda_base
muda_base :: Integral t => t -> t -> String
muda_base n b
    | n < b = [digito n]
    | otherwise = muda_base (div n b) b ++ [digito (mod n b)]
    where
        digito x
            | x < 10 = toEnum (fromIntegral x + fromEnum '0')
            | otherwise = toEnum (fromIntegral (x - 10) + fromEnum 'A')
```

Comentário:

- para converter base, dividimos repetidamente pela base;
- o resto vira o último dígito;
- para valores de 10 a 35, usamos letras de `A` a `Z`.

---

## 40. `partes`

```haskell
-- 40. partes
partes :: [t] -> [[t]]
partes [] = [[]]
partes (c:r) = semC ++ comC
    where
        semC = partes r
        comC = adicionaEmTodos c semC

        adicionaEmTodos _ [] = []
        adicionaEmTodos x (lista:listas) = (x:lista) : adicionaEmTodos x listas
```

Comentário:

- o conjunto das partes da lista vazia é `[[]]`;
- para cada subconjunto do resto, existem duas versões:
  - uma sem `c`;
  - outra com `c`.

A ordem pode variar dependendo da implementação. O mais importante é gerar todos os subconjuntos corretos.

---

# Observações finais

Para desenvolver as outras funções do trabalho, siga este roteiro:

1. Escreva a assinatura de tipo mais genérica possível.
2. Descubra o caso base.
3. Descubra o padrão da lista: `[]`, `[x]`, `(c:r)` ou `(a:b:r)`.
4. Decida se precisa de `Eq`, `Ord`, `Num`, `Integral` ou `Fractional`.
5. Use `where` para esconder auxiliares específicas.
6. Teste com os exemplos do enunciado.
7. Só depois pense em casos maiores.

O segredo do trabalho é perceber que quase todas as funções são variações de poucos padrões:

- percorrer lista;
- filtrar lista;
- transformar lista;
- comparar vizinhos;
- construir lista com `:`;
- usar tuplas;
- usar função auxiliar recursiva.

Dominando esses padrões, você consegue resolver praticamente toda a lista.
