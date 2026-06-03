-- Trabalho de Programação Funcional 2026/1 --
--                 Grupo 2                  --
-- Alunos:
  -- Daniel Reis - 202510364
  -- João Vitor Rezende Marciano - 202510356
  -- Paulo Sérgio Mendes Taciano - 

-- Questões: 2, 5, 8, 11, 14, 17, 20, 23, 26, 29, 32, 35 e 38

-- 2. insere_no_fim: recebe um elemento e uma lista e insere o elemento no final da lista.

insere_no_fim :: t -> [t] -> [t] -- recebe um elemento de qualquer tipo e uma lista do mesmo tipo, retorna uma lista do mesmo tipo. 
insere_no_fim x [] = [x] -- caso base: lista vazia, retorna uma nova lista contendo apenas o elemento x
insere_no_fim x (c:r) = c : insere_no_fim x r -- caso recursivo: a cabeça da lista é mantida, e o elemento x é inserido no final da calda da lista

-- 5. concatena: recebe duas listas quaisquer e retorna uma terceira lista com os elementos da primeira no início e os elementos da segunda no fim.

concatena :: [t] -> [t] -> [t] -- recebe duas listas de qualquer tipo e retorna  lista do mesmo tipo
concatena [] lista2 = lista2 -- caso base: se a primeira lista for vazia, retorna a segunda lista
concatena (c:r) lista2 = c : concatena r lista2
-- caso recursivo: a cabeça da primeira lista é mantida, e a função concatena é chamada recursivamente com a calda da primeira lista e a segunda lista, resultando em uma nova lista que contém os elementos da primeira lista seguidos pelos elementos da segunda lista

-- 8. remover_repetidos: recebe uma lista e retorna outra lista sem repetição de elementos. ex.: remover_repetidos [7,4,3,5,7,4,4,6,4,1,2] [7,4,3,5,6,1,2]

remover_repetidos :: (Eq t) => [t] -> [t] -- recebe uma lista  e retorna uma nova lista do mesmo tipo. classe Eq pois será realizada comparação de elementos
remover_repetidos [] = [] -- se a lista for vazia, retorna uma lista vazia
remover_repetidos (c:r) -- verifica se a cabeça da lista já está presente na calda da lista usando a função pertence.
    | pertence c r = remover_repetidos r -- se a cabeça já estiver presente, chama recursivamente a função com a calda da lista, ignorando a cabeça.
    | otherwise = c : remover_repetidos r -- se a cabeça não estiver presente, inclui a cabeça na nova lista e chama recursivamente a função com a calda da lista para continuar o processo de remoção de repetidos.


-- 11. reverso: recebe uma lista e retorna outra, que contém os mesmos elementos da primeira, em ordem contrária.

reverso :: [t] -> [t] -- recebe uma lista e retorna outra lista do mesmo tipo
reverso [] = [] -- se a lista for vazia, retorna uma nova lista vazia
reverso (c:r) = concatena (reverso r) [c] -- chama a função concatena para concatenar o reverso da calda com a cabeça da lista

-- 14. Soma todos os elementos de uma lista numerica.
somatorio :: (Num a) => [a] -> a
somatorio []     = 0          -- lista vazia: soma e zero
somatorio (c:r) = c + somatorio r  -- soma a cabeca com o somatorio do resto


-- 17. uniao: recebe duas listas que não contenham elementos repetidos e retorna uma nova com todos os elementos das duas listas originais (sem repetição). 
-- ex.: uniao [3,6,5,7] [2,9,7,5,1] [3,6,5,7,2,9,1]
  
-- Verifica se um elemento pertence a uma lista.
pertence :: (Eq a) => a -> [a] -> Bool
pertence _ []     = False             -- lista vazia: nao pertence
pertence x (c:r) = x == c           -- encontrou: retorna True
  || pertence x r    -- || e curto-circuito: so busca o resto se necessario

-- Retorna a uniao das duas listas sem repeticao.
-- Logica: para cada elemento da 1a lista, so inclui se nao estiver na 2a.

uniao :: (Eq a) => [a] -> [a] -> [a]
uniao [] y = y                          -- 1a lista esgotada: retorna a 2a inteira
uniao (c:r) x
  | pertence c y = uniao r y          -- c ja esta em y: ignora e continua
  | otherwise = c : uniao r y      -- c nao esta em y: inclui na frente


-- 20. insere_ordenado: recebe um item e uma lista em ordem crescente, retorna a lista em ordem crescente com todos os itens da lista inicial mais o item inserido.
-- ex.: insere_ordenado 2 [1,5,9] [1,2,5,9]

insere_ordenado :: (Ord a) => a -> [a] -> [a]
insere_ordenado x [] = [x]               -- lista vazia: cria lista so com x
insere_ordenado x (c:r)
  | x <= c    = x : c : r              -- x cabe antes de c: insere e termina
  | otherwise = c : insere_ordenado x r -- c e menor: mantem c e insere x no resto


-- 23. picos: recebe uma lista de números e retorna os números que são maiores que seus vizinhos. Considere que a lista é circular, ou seja, o início e o fim estão ligados.
-- ex.: picos [2,3,5,10,5,5,6,2,3] [10,6,3]

picos :: (Ord a) => [a] -> [a]
picos []  = []   -- sem elementos: sem picos
picos [_] = []   -- um elemento: sem vizinhos para comparar
picos l   = picosAux (last l) l (head l)
  -- ant = ultimo elemento (vizinho esquerdo da cabeca)
  -- pri = cabeca        (vizinho direito do ultimo elemento)
  where
    picosAux _ [] _  = []  -- caso defensivo: nunca alcancado na pratica
    picosAux ant [a] pri            -- ultimo elemento da lista
      | a > ant && a > pri = [a]   -- maior que o anterior e que a cabeca: e pico
      | otherwise          = []
    picosAux ant (a:p:xs) pri       -- elemento do meio
      | a > ant && a > p = a : picosAux a (p:xs) pri  -- maior que vizinhos: e pico
      | otherwise        =     picosAux a (p:xs) pri  -- nao e pico: continua


-- 26. todas_maiusculas: recebe uma string qualquer e retorna outra string onde todas as letras são maiúsculas.

todas_maiusculas :: [Char] -> [Char] -- recebe uma lista de caracteres (string) e retorna outra lista de caracteres
todas_maiusculas [] = [] -- caso base: string vazia, retorna string vazia
todas_maiusculas (c:r) -- caso recursivo: verifica se a cabeça é uma letra minúscula usando seu código numérico
    | codigo >= 97 && codigo <= 122 = toEnum (codigo - 32) : todas_maiusculas r -- se for minúscula (código entre 97 e 122), converte para maiúscula subtraindo 32 do código
    | otherwise = c : todas_maiusculas r -- se não for letra minúscula, mantém o caractere inalterado
    where codigo = fromEnum c -- obtém o código numérico do caractere usando fromEnum


-- 29. variancia: recebe uma lista de números e retorna a variância (populacional) deles.

variancia :: (Fractional a) => [a] -> a -- recebe uma lista de números e retorna a variância. classe Fractional para permitir divisão.
variancia [] = 0 -- caso base: lista vazia, variância é zero
variancia lista = somaDesvios lista media / tamanho lista -- variância = soma dos desvios quadráticos / número de elementos
    where
        media = somatorio lista / tamanho lista -- calcula a média aritmética dos elementos da lista
        tamanho [] = 0 -- função auxiliar: lista vazia tem tamanho zero
        tamanho (_:r) = 1 + tamanho r -- função auxiliar: conta recursivamente os elementos da lista
        somaDesvios [] _ = 0 -- função auxiliar: caso base, lista vazia, soma dos desvios é zero
        somaDesvios (c:r) m = (c - m) * (c - m) + somaDesvios r m -- função auxiliar: calcula (elemento - média)² e soma com os desvios restantes


-- 32. separa: separa os elementos de uma lista de números nas posições com zero.

separa :: (Eq a, Num a) => [a] -> [[a]] -- recebe uma lista de números e retorna uma lista de listas. classes Eq e Num para comparação com zero.
separa [] = [[]] -- caso base: lista vazia, retorna uma lista contendo uma lista vazia
separa (c:r) -- caso recursivo: verifica se a cabeça é zero para decidir se deve separar
    | c == 0 = [] : separa r -- se a cabeça for zero, cria uma nova sublista vazia e continua separando a calda
    | otherwise = (c : cabeca) : calda -- se não for zero, insere a cabeça no início da primeira sublista do resultado
    where (cabeca:calda) = separa r -- separa recursivamente a calda e decompõe o resultado em cabeça e calda das sublistas


-- 35. soma_digitos: recebe um número natural e retorna a soma de seus dígitos.

soma_digitos :: Integer -> Integer -- recebe um número inteiro e retorna outro número inteiro
soma_digitos 0 = 0 -- caso base: número é zero, soma dos dígitos é zero
soma_digitos n = mod n 10 + soma_digitos (div n 10) -- caso recursivo: soma o último dígito (mod n 10) com a soma dos dígitos restantes (div n 10 remove o último dígito)


-- 38. quadrado_perfeito: verifica se um número é um quadrado perfeito sem usar uma função que calcula raiz quadrada.

quadrado_perfeito :: Integer -> Bool -- recebe um número inteiro e retorna um valor booleano (True se for quadrado perfeito, False caso contrário)
quadrado_perfeito n
    | n < 0 = False -- números negativos não são quadrados perfeitos
    | otherwise = verificaQuadrado 0 -- inicia a verificação a partir de 0
    where
        verificaQuadrado i -- função auxiliar: testa se i*i é igual a n
            | i * i == n = True -- se i² é igual a n, então n é quadrado perfeito
            | i * i > n = False -- se i² ultrapassou n, então n não é quadrado perfeito
            | otherwise = verificaQuadrado (i + 1) -- caso contrário, testa o próximo número