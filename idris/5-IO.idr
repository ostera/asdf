module Main

import System

printLength : IO ()
printLength = getLine >>= \line => let len = show (length line) in putStrLn len

printTwoThings : IO ()
printTwoThings = do putStrLn "One"
                    putStrLn "Two"

printLength' : IO ()
printLength' = do putStr "Input > "
                  input <- getLine
                  let len = length input
                  putStrLn (show len)

readNumber : IO (Maybe Nat)
readNumber = do
  input <- getLine
  if all isDigit (unpack input)
     then pure (Just (cast input))
     else pure Nothing

readNumbers : IO (Maybe (Nat, Nat))
readNumbers = do
  n1 <- readNumber
  case n1 of
       Nothing => pure Nothing
       Just n1' => do
         n2 <- readNumber
         case n2 of
              Nothing => pure Nothing
              Just n2' => pure (Just (n1', n2'))

readPair : IO (String, String)
readPair = do str1 <- getLine
              str2 <- getLine
              pure (str1, str2)

usePair : IO ()
usePair = do (str1, str2) <- readPair
             putStrLn (show (str1, str2))

readNumbers' : IO (Maybe (Nat, Nat))
readNumbers' = do
  Just n1 <- readNumber | Nothing => pure Nothing
  Just n2 <- readNumber | Nothing => pure Nothing
  pure (Just (n1, n2))

countdown : (secs : Nat) -> IO ()
countdown Z = putStrLn "Yeeehaw!"
countdown (S k) = do putStrLn (show (S k))
                     usleep 1000000
                     countdown k

continue : IO ()
continue = do
  putStr "Countdown from: "
  Just startNum <- readNumber
    | Nothing => do
      putStrLn "Not a valid number...try again"
      continue
  countdown startNum
  putStr "Run again? (yes)"
  y <- getLine
  if y == "yes"
     then continue
     else pure ()

main : IO ()
main = do
  putStr "Enter a name: "
  x <- getLine
  putStrLn ("Hello " ++ x ++ "!")
