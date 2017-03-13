module Main

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

readNumber : IO (Bool)
readNumber = do
  input <- getLine
  pure (all isDigit (unpack input))

main : IO ()
main = do
  putStr "Enter a name: "
  x <- getLine
  putStrLn ("Hello " ++ x ++ "!")
