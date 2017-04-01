module Main

data InfIO : Type where
  Do : IO a ->
       (a -> Inf InfIO) ->
       InfIO

(>>=) : IO a -> (a -> Inf InfIO) -> InfIO
(>>=) = Do

-- First try, infinite IO with partial run

loopPrint : String -> InfIO
loopPrint x = do putStrLn x
                 loopPrint x

run : InfIO -> IO ()
run (Do x f) = do res <- x
                  run (f res)

-- Second try, finine infinite IO with total run

data Fuel : Type where
  Dry : Fuel
  More : Fuel -> Fuel

tank : Nat -> Fuel
tank Z = Dry
tank (S k) = More (tank k)

runTank : Fuel -> InfIO -> IO ()
runTank Dry _ = putStrLn "Out of Fuel"
runTank (More fuel) (Do c f) = do res <- c
                                  runTank fuel (f res)

-- Third try, Lazy Fuel for infinite infinite IO with a total run

data Gas : Type where
  Empty : Gas
  Some : Lazy Gas -> Gas

freeGas : Gas
freeGas = Some freeGas

runEngine : Gas -> InfIO -> IO ()
runEngine Empty y = putStrLn "Out of fuel"
runEngine (Some x) (Do y f) = do ?run_a_y y
                                 ?what_runEngine
