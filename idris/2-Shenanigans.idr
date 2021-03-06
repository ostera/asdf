module Shenanigans

double : Num a => a -> a
double x = x + x

add : Num a => a -> a -> a
add x y = ?todo

id : a -> a
id x = x

||| Apply a function two times
||| @f The function to apply
||| @x The argument to supply
twice : (f : a -> a) -> (x : a) -> a
twice f x = f (f x)

Shape : Type
-- this function has a hole! (no definition)
rotate : Shape -> Shape

turn_around : Shape -> Shape
turn_around = twice rotate

pythagoras : Double -> Double -> Double
pythagoras x y = sqrt (square x + square y)
  where
    square : Double -> Double
    square x = x*x

