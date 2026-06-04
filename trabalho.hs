-- Trabalho de Programação Funcional 2026/1 --
--                 Grupo 2                  --
-- Alunos:
    -- Daniel Reis - 202510364
    -- João Vitor Rezende Marciano - 202510356
    -- Paulo Sérgio Mendes Taciano - 202510345

-- Questões: 2, 5, 8, 11, 14, 17, 20, 23, 26, 29, 32, 35 e 38

-- 2. insere_no_fim: recebe um elemento e uma lista e insere o elemento no final da lista.
-- ex.: insere_no_fim 3 [1,2] [1,2,3] 

insere_no_fim :: t -> [t] -> [t]               -- recebe um elemento e uma lista, retorna uma lista
insere_no_fim x [] = [x]                       -- lista vazia: cria lista com x
insere_no_fim x (c:r) = c : insere_no_fim x r  -- mantem a cabeca e insere no resto


-- 5. concatena: recebe duas listas quaisquer e retorna uma terceira lista com os elementos da
-- primeira no início e os elementos da segunda no fim.
-- ex.: concatena [] [] ⇒ [] 
-- concatena [1,2] [3,4]⇒ [1,2,3,4] 

concatena :: [t] -> [t] -> [t]             -- recebe duas listas, retorna uma lista
concatena [] y = y                       -- primeira vazia: retorna a segunda
concatena (c:r) y = c : concatena r y    -- anexa a cabeca e concatena o resto


-- 8. remover_repetidos: recebe uma lista e retorna outra lista sem repetição de elementos.
-- ex.: remover_repetidos [7,4,3,5,7,4,4,6,4,1,2] [7,4,3,5,6,1,2] 

remover_repetidos :: (Eq t) => [t] -> [t]    -- recebe uma lista, retorna uma lista. Classe Eq para comparar elementos
remover_repetidos [] = []                    -- lista vazia: retorna lista vazia
remover_repetidos (c:r)                      -- verifica se a cabeca ja aparece no resto
    | pertence c r = remover_repetidos r     -- c aparece no resto: descarta
    | otherwise    = c : remover_repetidos r -- c unico: mantem


-- 11. reverso: recebe uma lista e retorna outra, que contém os mesmos elementos da primeira, em ordem contrária

reverso :: [t] -> [t]
reverso [] = []
reverso (c:r) = concatena (reverso r) [c]  -- inverte o resto e coloca a cabeca no fim


-- 14. somatorio: recebe uma lista de números e retorna a soma deles.
-- ex.: somatorio [] 0 ⇒ 0
-- somatorio [2,3] 5 ⇒ 5

somatorio :: (Num a) => [a] -> a           -- recebe uma lista de numeros, retorna um numero. Classe Num para usar a operacao de soma
somatorio []    = 0                        -- lista vazia: soma zero
somatorio (c:r) = c + somatorio r          -- soma a cabeca com o somatorio do resto


-- 17. uniao: recebe duas listas que não contenham elementos repetidos e retorna uma nova com todos os elementos das duas listas originais (sem repetição).
-- ex.: uniao [3,6,5,7] [2,9,7,5,1] [3,6,5,7,2,9,1] 

--pertence: verifica se um elemento pertence a uma lista.
pertence :: (Eq a) => a -> [a] -> Bool     -- recebe um elemento e uma lista, retorna um booleano. Classe Eq para comparar elementos
pertence _ []    = False                   -- lista vazia: nao pertence
pertence e (c:r)
  | e == c    = True                       -- encontrou
  | otherwise = pertence e r               -- busca no resto

-- uniao: retorna a uniao de duas listas sem repeticao.

uniao :: (Eq a) => [a] -> [a] -> [a]       -- recebe duas listas, retorna uma lista. Classe Eq para comparar elementos
uniao [] y = y                           -- primeira esgotada: retorna a segunda
uniao (c:r) y
  | pertence c y = uniao r y             -- c ja esta em y: ignora
  | otherwise     = c : uniao r y         -- c novo: inclui


-- 20. insere_ordenado: recebe um item e uma lista em ordem crescente, retorna a lista em ordem crescente com todos os itens da lista initial mais o item inserido.
-- ex.: insere_ordenado 2 [1,5,9] [1,2,5,9] 

insere_ordenado :: (Ord a) => a -> [a] -> [a]     -- recebe um elemento e uma lista ordenada, retorna uma lista ordenada. Classe Ord para comparar elementos
insere_ordenado x [] = [x]                        -- lista vazia: retorna lista com x
insere_ordenado x (y:r)
  | x <= y    = x : y : r                         -- x cabe antes de y: insere aqui
  | otherwise = y : insere_ordenado x r            -- y e menor: mantem y e continua


-- 23. picos: recebe uma lista de números e retorna os números que são maiores que seus vizinhos. Considere que a lista é circular, ou seja, o início e o fim estão ligados.
-- ex.: picos [2,3,5,10,5,5,6,2,3] [10,6,3] 

picos :: (Ord a) => [a] -> [a]
picos []  = []
picos [_] = []                                     -- um elemento nao tem vizinhos
picos l   = picosAux (last l) l (head l)           -- vizinho esquerdo da cabeca e o ultimo
  where
    picosAux _ [] _  = []                          -- nunca alcancado na pratica
    picosAux ant [a] pri                           -- ultimo elemento: vizinho direito e a cabeca
      | a > ant && a > pri = [a]
      | otherwise          = []
    picosAux ant (a:p:r) pri                       -- elemento do meio: vizinho direito e o proximo
      | a > ant && a > p = a : picosAux a (p:r) pri
      | otherwise        =     picosAux a (p:r) pri


-- 26. todas_maiusculas: Recebe uma string qualquer e retorna outra string onde todas as letras são maiúsculas.
-- Pode ser útil saber os seguintes códigos de representação de caracteres: 
-- a=97, z=122, A=65, Z=90, 0=48, 9=57, espaço=32.
-- ex.: todas_maiusculas "abc 123" = "ABC 123"

todas_maiusculas :: [Char] -> [Char]  -- recebe uma string (lista de caracteres), retorna uma string. Tipo Char para representar caracteres
todas_maiusculas [] = []              -- string vazia: retorna string vazia
todas_maiusculas (c:r)                -- verifica se c e letra minuscula
    | codigo >= 97 && codigo <= 122 = toEnum (codigo - 32) : todas_maiusculas r  -- letra minuscula: converte
    | otherwise                     = c : todas_maiusculas r                      -- outros caracteres: mantem
    where codigo = fromEnum c          -- codigo ASCII do caractere


-- 29. variancia: recebe uma lista de números e retorna a variância (populacional) deles.
-- ex.: variancia [6,2,9,0,8,3,0,2] 10.6875

variancia :: (Fractional a) => [a] -> a                         -- recebe uma lista de numeros, retorna um numero. Classe Fractional para usar a operacao de divisao
variancia [] = 0
variancia lista = somaDesvios lista media / tamanho lista       -- variancia = soma (x - media)^2 / n
    where
        media           = somatorio lista / tamanho lista       -- media aritmetica
        tamanho []      = 0
        tamanho (_:r)   = 1 + tamanho r                         -- conta os elementos
        somaDesvios [] _    = 0
        somaDesvios (c:r) m = (c - m) * (c - m) + somaDesvios r m  -- soma (x - media)^2


-- 32. separa: separa os elementos de uma lista de números nas posições com zero.
-- ex.: separa [3,4,7,-1,0,4,7,3,0,0,9,8] [[3,4,7,-1],[4,7,3],[],[9,8]] 

separa :: (Eq a, Num a) => [a] -> [[a]]      -- recebe uma lista de numeros, retorna uma lista de listas. Classe Eq para comparar elementos, Classe Num para usar o numero zero
separa [] = [[]]                             -- lista vazia: retorna lista com uma sublista vazia
separa (c:r)
    | c == 0    = [] : separa r              -- zero: inicia nova sublista
    | otherwise = (c : cabeca) : calda       -- insere na sublista atual
    where (cabeca:calda) = separa r


-- 35. soma_digitos: recebe um número natural e retorna a soma de seus dígitos.
-- ex.: soma_digitos 328464584658 63

soma_digitos :: Integer -> Integer
soma_digitos 0 = 0
soma_digitos n = mod n 10 + soma_digitos (div n 10)  -- pega o ultimo digito e soma com o resto


-- 38.  Dizemos que um quadrado perfeito é um número cuja raiz quadrada é um número inteiro.
-- Sabemos o que a raiz quadrada é um cálculo lento quando comparado à operações como
-- adição ou multiplicação. Implemente uma função que verifica se um número é um quadrado
-- perfeito sem usar uma função que calcula raiz quadrada. 

quadrado_perfeito :: Integer -> Bool   -- recebe um numero inteiro, retorna um booleano
quadrado_perfeito n
    | n < 0     = False
    | otherwise = verificaQuadrado 0
    where
        verificaQuadrado i
            | i * i == n = True   -- encontrou a raiz exata
            | i * i > n  = False  -- passou: nao e quadrado perfeito
            | otherwise  = verificaQuadrado (i + 1)
