-- file: inflists.hs
-- 2010.t2.CMPT.340.WS05.Q4

-- Q4.1
facts :: [Integer]
facts = facto 1 1
  where facto p n = p : facto (p*n) (n+1)

-- Q4.2
fibs :: [Integer]
fibs = fibo 0 1
  where fibo f1 f2 = f1 : fibo f2 (f1+f2)

-- Q4.3
-- sqrts :: Floating a => a -> [a]
sqrts :: Float -> [Float]
sqrts x = sqrto 1
  where sqrto y = y : sqrto ((y + (x/y))/2.0)

-- Q4.4
randoms :: Integer -> Integer -> Integer -> Integer -> [Integer]
randoms a b c s = rando s
  where rando x = x : rando (mod (x*a + b) c)


-- eof
