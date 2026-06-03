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
somatorio (x:xs) = x + somatorio xs  -- soma a cabeca com o somatorio do resto


-- 17. uniao: recebe duas listas que não contenham elementos repetidos e retorna uma nova com todos os elementos das duas listas originais (sem repetição). 
-- ex.: uniao [3,6,5,7] [2,9,7,5,1] [3,6,5,7,2,9,1]
  
-- Verifica se um elemento pertence a uma lista.
pertence :: (Eq a) => a -> [a] -> Bool
pertence _ []     = False             -- lista vazia: nao pertence
pertence x (y:ys) = x == y           -- encontrou: retorna True
  || pertence x ys    -- || e curto-circuito: so busca o resto se necessario

-- Retorna a uniao das duas listas sem repeticao.
-- Logica: para cada elemento da 1a lista, so inclui se nao estiver na 2a.

uniao :: (Eq a) => [a] -> [a] -> [a]
uniao [] ys = ys                          -- 1a lista esgotada: retorna a 2a inteira
uniao (x:xs) ys
  | pertence x ys = uniao xs ys          -- x ja esta em ys: ignora e continua
  | otherwise     = x : uniao xs ys      -- x nao esta em ys: inclui na frente


-- 20. insere_ordenado: recebe um item e uma lista em ordem crescente, retorna a lista em ordem crescente com todos os itens da lista inicial mais o item inserido.
-- ex.: insere_ordenado 2 [1,5,9] [1,2,5,9]

insere_ordenado :: (Ord a) => a -> [a] -> [a]
insere_ordenado x [] = [x]               -- lista vazia: cria lista so com x
insere_ordenado x (y:ys)
  | x <= y    = x : y : ys              -- x cabe antes de y: insere e termina
  | otherwise = y : insere_ordenado x ys -- y e menor: mantem y e insere x no resto


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
