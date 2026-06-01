-- Trabalho de Programação Funcional 2026/1 --
--                 Grupo 2                  --
-- Alunos:
    -- Daniel Reis - 202510364
    -- João Vitor Rezende Marciano - 202510356
    -- Paulo Sérgio Mendes Taciano - 

-- Questões: 2, 5, 8, 11, 14, 17, 20, 23, 26, 29, 32, 35 e 38

-- 2. insere_no_fim: recebe um elemento e uma lista e insere o elemento no final da lista.

insere_no_fim :: (Num t) t -> [t] -> [t]
insere_no_fim x [] = [x]
insere_no_fim x (c:r) = c : insere_no_fim x r





-- Exercicio 14 - Soma todos os elementos de uma lista numerica.
somatorio :: Num a => [a] -> a
somatorio []     = 0          -- lista vazia: soma e zero
somatorio (x:xs) = x + somatorio xs  -- soma a cabeca com o somatorio do resto


-- Exercicio 17 - Verifica se um elemento pertence a uma lista.
pertence :: Eq a => a -> [a] -> Bool
pertence _ []     = False             -- lista vazia: nao pertence
pertence x (y:ys) = x == y           -- encontrou: retorna True
                 || pertence x ys    -- || e curto-circuito: so busca o resto se necessario

-- Retorna a uniao das duas listas sem repeticao.
-- Logica: para cada elemento da 1a lista, so inclui se nao estiver na 2a.

uniao :: Eq a => [a] -> [a] -> [a]
uniao [] ys = ys                          -- 1a lista esgotada: retorna a 2a inteira
uniao (x:xs) ys
  | pertence x ys = uniao xs ys          -- x ja esta em ys: ignora e continua
  | otherwise     = x : uniao xs ys      -- x nao esta em ys: inclui na frente


-- Exercicio 20 - Insere um elemento numa lista mantendo a ordem crescente.

insere_ordenado :: Ord a => a -> [a] -> [a]
insere_ordenado x [] = [x]               -- lista vazia: cria lista so com x
insere_ordenado x (y:ys)
  | x <= y    = x : y : ys              -- x cabe antes de y: insere e termina
  | otherwise = y : insere_ordenado x ys -- y e menor: mantem y e insere x no resto


-- Exercicio 23 - Retorna os "picos": elementos maiores que ambos os vizinhos numa lista circular
-- (o primeiro vizinho da cabeca e o ultimo elemento, e vice-versa).

picos :: Ord a => [a] -> [a]
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
