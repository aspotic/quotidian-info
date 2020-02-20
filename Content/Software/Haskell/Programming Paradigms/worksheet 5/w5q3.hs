-- file: rose.hs
-- 2010.t2.CMPT.340.WS05.Q3

-- The comprehension as given in the question
mylist n = [(x,y)| x <- [1 .. n], y <- [x .. n], (x + y) `mod` 3 == 0 ]

-- Recursive function to compute the same output:
-- This version uses a single function to control the repetition
-- loop starts with a pair, as an accumulator
--      if the pair is valid, it's put into the list
--      if the pair is not valid, then one or both of the components
--      are changed
mylist2 :: Integer -> [(Integer,Integer)]
mylist2 n = loop (1,1)
  where loop (x,y)
          | x > n = []
          | y > n = loop (x+1,x+1)
	  | (x + y) `mod` 3 == 0 = (x,y):loop (x,y+1)
	  | otherwise = loop (x,y+1)
          

-- Recursive function to compute the same output:
-- This version has two explicit loops
--   loop1 controls the first componenet of the pair
--   loop2 controls the second componenet of the pair
--         and checks the validity of the pair
mylist3 :: Integer -> [(Integer,Integer)]
mylist3 n = loop1 1 
  where loop1 x 
          | x > n = []
          | otherwise = (loop2 x) ++ (loop1 (x+1))
	  where loop2 y 
		  | y > n = []
		  | (x + y) `mod` 3 == 0 = (x,y):loop2 (y+1)
		  | otherwise = loop2 (y+1)



-- a function to check if the output of 2 
-- above implementations are identical
test_two :: Eq b => (t -> [b]) -> (t -> [b]) -> t -> Bool
test_two f g n = foldr (&&) True zipped
  where zipped = zipWith (==) (f n) (g n)

-- E.g., 
-- *Main> test_two mylist mylist2 5
-- True

-- eof
