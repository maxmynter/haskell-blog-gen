module Main (main) where

import Html

myhtml :: Html
myhtml = html_ "Page Title" (append_ (h1_ "Hello World") (append_ (append_ (p_ "Paragraph 1") (p_ "We're Haskellin <3")) (ul_ [p_ "Haskell", p_ "Rust", p_ "Python"])))

main :: IO ()
main = putStrLn $ render myhtml
