-- Trabalho de Programação Funcional 2026/1 --
--                 Grupo 2                  --
-- Alunos:
    -- Daniel Reis - 202510364
    -- João Vitor Rezende Marciano - 202510356
    -- Paulo Sérgio Mendes Taciano -

-- Questões: 2, 5, 8, 11, 14, 17, 20, 23, 26, 29, 32, 35 e 38

-- 2. insere_no_fim: insere um elemento no final de uma lista.

insere_no_fim :: t -> [t] -> [t]
insere_no_fim x [] = [x]                       -- lista vazia: cria lista com x
insere_no_fim x (c:r) = c : insere_no_fim x r  -- mantem a cabeca e insere no resto


-- 5. concatena: retorna uma lista com os elementos da primeira seguidos pelos da segunda.

concatena :: [t] -> [t] -> [t]
concatena [] ys = ys                        -- primeira vazia: retorna a segunda
concatena (c:r) ys = c : concatena r ys    -- anexa a cabeca e concatena o resto


-- 8. remover_repetidos: retorna a lista sem elementos repetidos.

remover_repetidos :: Eq t => [t] -> [t]
remover_repetidos [] = []
remover_repetidos (c:r)
    | pertence c r = remover_repetidos r    -- c aparece no resto: descarta
    | otherwise    = c : remover_repetidos r -- c unico: mantem


-- 11. reverso: retorna a lista com os elementos em ordem contraria.

reverso :: [t] -> [t]
reverso [] = []
reverso (c:r) = concatena (reverso r) [c]  -- inverte o resto e coloca a cabeca no fim


-- 14. somatorio: soma todos os elementos de uma lista numerica.

somatorio :: Num a => [a] -> a
somatorio []    = 0                        -- lista vazia: soma zero
somatorio (c:r) = c + somatorio r          -- soma a cabeca com o somatorio do resto


-- 17. pertence: verifica se um elemento pertence a uma lista.

pertence :: Eq a => a -> [a] -> Bool
pertence _ []    = False                   -- lista vazia: nao pertence
pertence e (c:r)
  | e == c    = True                       -- encontrou
  | otherwise = pertence e r               -- busca no resto

-- uniao: retorna a uniao de duas listas sem repeticao.

uniao :: Eq a => [a] -> [a] -> [a]
uniao [] ys = ys                           -- primeira esgotada: retorna a segunda
uniao (c:r) ys
  | pertence c ys = uniao r ys             -- c ja esta em ys: ignora
  | otherwise     = c : uniao r ys         -- c novo: inclui


-- 20. insere_ordenado: insere um elemento em uma lista ordenada mantendo a ordem crescente.

insere_ordenado :: Ord a => a -> [a] -> [a]
insere_ordenado x [] = [x]                        -- lista vazia: retorna lista com x
insere_ordenado x (y:r)
  | x <= y    = x : y : r                         -- x cabe antes de y: insere aqui
  | otherwise = y : insere_ordenado x r            -- y e menor: mantem y e continua


-- 23. picos: retorna os elementos maiores que ambos os vizinhos numa lista circular.

picos :: Ord a => [a] -> [a]
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


-- 26. todas_maiusculas: retorna a string com todas as letras em maiusculo.

todas_maiusculas :: [Char] -> [Char]
todas_maiusculas [] = []
todas_maiusculas (c:r)
    | codigo >= 97 && codigo <= 122 = toEnum (codigo - 32) : todas_maiusculas r  -- letra minuscula: converte
    | otherwise                     = c : todas_maiusculas r                      -- outros caracteres: mantem
    where codigo = fromEnum c          -- codigo ASCII do caractere


-- 29. variancia: retorna a variancia populacional de uma lista de numeros.

variancia :: Fractional a => [a] -> a
variancia [] = 0
variancia lista = somaDesvios lista media / tamanho lista
    where
        media           = somatorio lista / tamanho lista       -- media aritmetica
        tamanho []      = 0
        tamanho (_:r)   = 1 + tamanho r                        -- conta os elementos
        somaDesvios [] _    = 0
        somaDesvios (c:r) m = (c - m) * (c - m) + somaDesvios r m  -- soma (x - media)^2


-- 32. separa: separa os elementos de uma lista nas posicoes com zero.

separa :: (Eq a, Num a) => [a] -> [[a]]
separa [] = [[]]
separa (c:r)
    | c == 0    = [] : separa r              -- zero: inicia nova sublista
    | otherwise = (c : cabeca) : calda       -- insere na sublista atual
    where (cabeca:calda) = separa r


-- 35. soma_digitos: retorna a soma dos digitos de um numero natural.

soma_digitos :: Integer -> Integer
soma_digitos 0 = 0
soma_digitos n = mod n 10 + soma_digitos (div n 10)  -- pega o ultimo digito e soma com o resto


-- 38. quadrado_perfeito: verifica se um numero e um quadrado perfeito.

quadrado_perfeito :: Integer -> Bool
quadrado_perfeito n
    | n < 0     = False
    | otherwise = verificaQuadrado 0
    where
        verificaQuadrado i
            | i * i == n = True   -- encontrou a raiz exata
            | i * i > n  = False  -- passou: nao e quadrado perfeito
            | otherwise  = verificaQuadrado (i + 1)
