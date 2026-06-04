-- Tipo Num funciona para qualquer tipo numérico
dobro :: Num t => t -> t
dobro x = 2 * x 

-- Tipo ordenavel para variaveis que precisam ser comparadas
maiorDeDois :: (Ord t) => t -> t -> t
maiorDeDois x y
    |x > y = x
    |otherwise = y 

triploMenosUm :: (Num t) => t -> t
triploMenosUm x = 3*x -1

quadrado :: (Num t) => t -> t
quadrado x = x * x

-- recebe uma lista e retorna um inteiro 
-- funciona com recursão
somatorio :: (Num t) => [t] -> t
somatorio [] = 0
somatorio (c:r) = c + somatorio r

-- função que verifica se um item esta na lista ou nao
pertence :: (Eq t) => t -> [t] -> Bool
pertence _ [] = False
pertence e (c:r)
    |e == c = True 
    |otherwise = pertence e r


    
