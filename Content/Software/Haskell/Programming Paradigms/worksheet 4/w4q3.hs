-- file: w4q3.hs
-- 2010.t2.CMPT.340.WS04.Q1


data ZenoBit = One | Z ZenoBit 
  deriving (Show)

type Zeno = [ZenoBit]

-- part 3
equals :: ZenoBit -> ZenoBit -> Bool

equals One One = True
equals (Z x) (Z y) = equals x y
equals _ _ = False


-- part 4
instance Eq ZenoBit where
  (==) = equals


-- part 5
zbleq :: ZenoBit -> ZenoBit -> Bool
zbleq One One = True
zbleq One (Z _) = True
zbleq (Z _) One = False
zbleq (Z x) (Z y) = zbleq x y

-- part 6
instance Ord ZenoBit where
  (<=) = zbleq

-- part 2
-- Note that my implementation assumes Eq ZenoBit and Ord ZenoBit
-- (parts 3-6 above)

add :: Zeno -> Zeno -> Zeno

add [] x = x
add x [] = x
add (x:xs) (y:ys) 
  | x == y    = add_helper (Z x) (add xs ys)
  | x < y     = add_helper y (add (x:xs) ys)
  | otherwise = add_helper x (add xs (y:ys))
    where add_helper c []  = [c]
          add_helper c (z:zs)
            | c == z    = (Z c) : zs
	    | otherwise = c:z:zs

-- part 3
multZBits :: ZenoBit -> ZenoBit -> ZenoBit

multZBits One x = x
multZBits (Z x) y = Z (multZBits x y)


multiply :: Zeno -> Zeno -> Zeno

multiply [] y = []
multiply (x:xs) y = add (map (multZBits x) y) (multiply xs y) 


-- part 7

greaterThan :: Zeno -> Zeno -> Bool
greaterThan [] [] = False
greaterThan [] (_:_) = False
greaterThan (_:_) [] = True
greaterThan (x:xs) (y:ys) 
  | x > y  = True
  | x == y = greaterThan xs ys
  | otherwise = False

-- eof
