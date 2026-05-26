-- Trabalho de Programação Funcional 2026/1 --
--                 Grupo 2                  --
-- Alunos:
    -- Daniel Reis 
    -- João Vitor Rezende Marciano - 202510356
    -- Paulo Sérgio Mendes Taciano - 

-- Questões: 2, 5, 8, 11, 14, 17, 20, 23, 26, 29, 32, 35 e 38

-- 2. insere_no_fim: recebe um elemento e uma lista e insere o elemento no final da lista.

insere_no_fim :: (Num t) t -> [t] -> [t]
insere_no_fim x [] = [x]
insere_no_fim x (c:r) = c : insere_no_fim x r