-- file: shapes_sol.hs
-- 2010.t2.CMPT.340.WS05.Q2

-- --------------------------------------------------------------------
-- Given information:
type Coord a = (a,a)

-- 4 kinds of shapes
data Shape a = Circle (Coord a) a        -- Circle position radius
             | Square (Coord a) a        -- Square position side
             | Rectangle (Coord a) a a   -- Rectangle position width height
             | Triangle (Coord a) a a    -- Triangle base height
  deriving (Show)


area :: Floating a => Shape a -> a

area (Circle _ r) = pi*r*r
area (Square _ s) = s*s
area (Rectangle _ w h) = w*h
area (Triangle _ b h) = b*h/2

test_shapes :: Floating a => [Shape a]
test_shapes = [Circle (1, 2) 3
              ,Square (4, 5) 6
              ,Rectangle (7, 8) 9 10
              ,Triangle (7, 5) 3 2
              ]

-- --------------------------------------------------------------------
-- Q2.1
total_area :: Floating a => [Shape a] -> a
total_area [] = 0
total_area (s:ss) = (area s) + (total_area ss)

-- Example:
-- *Main> total_area test_shapes 
-- 157.27433388230813


-- --------------------------------------------------------------------
-- Q2.2
total_area_2 :: Floating a => [Shape a] -> a
total_area_2 = foldr ((+).area) 0

-- Example:
-- *Main> total_area_2 test_shapes 
-- 157.27433388230813


-- --------------------------------------------------------------------
-- Q2.3
moveShape :: Num a => Coord a -> Shape a -> Shape a
moveShape c (Circle d r)      = Circle    (addCoords c d) r
moveShape c (Square d r)      = Square    (addCoords c d) r
moveShape c (Rectangle d w h) = Rectangle (addCoords c d) w h
moveShape c (Triangle d t h)  = Triangle  (addCoords c d) t h

addCoords :: Num a => Coord a -> Coord a -> Coord a
addCoords (x,y) (u,v) = (x+u,y+v)

-- --------------------------------------------------------------------
-- Q2.4
moveAll :: Num a => [Shape a] -> [Shape a]
moveAll = map (moveShape (10,10)) 


-- --------------------------------------------------------------------
-- Q2.5
isSquare :: Shape a -> Bool
isSquare (Square _ _) = True
isSquare _ = False



-- --------------------------------------------------------------------
-- Q2.6
keepSquares :: [Shape a] -> [Shape a]
keepSquares = filter isSquare 

-- --------------------------------------------------------------------
-- Q2.7
removeSquares :: [Shape a] -> [Shape a]
removeSquares = filter (not.isSquare)


-- --------------------------------------------------------------------
-- Q2.8
keepSquaresAndTriangles :: [Shape a] -> [Shape a]
keepSquaresAndTriangles = filter special
  where special x = (isSquare x) || (isTriangle x)

isTriangle :: Shape a -> Bool
isTriangle (Triangle _ _ _) = True
isTriangle _ = False

keepSquaresAndTriangles_2 = filter (twin (||) isSquare isTriangle)
  where twin u v w x = u (v x) (w x)


-- --------------------------------------------------------------------
-- Q2.9.a
myAve1 :: [Float] -> Float
myAve1 list = (sum list) / (fromInteger (mylength list))
  where mylength = foldr ((+).(\x -> 1)) 0

-- --------------------------------------------------------------------
-- Q2.9.b
myAve2 :: [Float] -> Float
myAve2 l = a / b
  where (a,b) = foldr f (0,0) l
        f x (s,c) = (s+x,c+1)


-- --------------------------------------------------------------------
-- Q2.10
-- Definitely not Swedish.
borg :: Floating a => [Shape a] -> Shape a
borg ss = Circle coords (sqrt (a/pi))
  where (coords,a) = foldr f ((0,0),0) ss
        f s (c,r) = (addCoords (getCoord s) c, r + (area s))

getCoord :: Shape a -> Coord a
getCoord (Circle (x,y) _)      = (x,y)
getCoord (Square (x,y) _)      = (x,y)
getCoord (Rectangle (x,y) _ _) = (x,y)
getCoord (Triangle (x,y) _ _)  = (x,y)

-- eof
