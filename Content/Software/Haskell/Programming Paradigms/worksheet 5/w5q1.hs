-- file: tutor.hs
-- 2010.t2.CMPT.340.WS05.q1
-- Give type signatures for each function in the file

-- (a) (1 mark)
boring :: Integer -> Integer -> Integer
boring x y = x + y

-- (b) (1 mark)
yawn :: Integer -> Integer -> Bool
yawn x y = x == y

-- (c) (2 marks)
stretch :: (t1 -> t2) -> t1 -> t2
stretch x y = x y

-- (d) (2 marks)
pull :: (t1 -> Integer) -> (t1 -> Integer) -> t1 -> Integer
pull a b c = (a c) + (b c)

-- (e) (3 marks)
twin :: (t1 -> t2 -> t3) -> (t -> t1) -> (t -> t2) -> t -> t3
twin u v w x = u (v x) (w x)

-- (f) (3 marks)
knit :: (t1 -> t1 -> t2) -> (t -> t1) -> t -> t -> t2
knit u v x y = u (v x) (v y)

-- (g) (3 marks)
-- given the following data definition. . .
data Temp = Cold | Cool | Warm | Hot
  deriving (Show)

-- . . . give the type signature for this function:
kelvin :: Integer -> Temp -> Integer -> Temp
kelvin a b c 
  | a < 100 = Cold
  | otherwise = if (a > c) then Hot else b

-- eof
