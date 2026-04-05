module Main (main) where

import Html

myhtml :: Html
myhtml =
  html_
    "Page Title"
    [ h1_ "Hello World",
      p_ "Paragraph 1",
      p_ "We're Haskellin <3",
      ul_ ["Haskell", "Rust", "Python"]
    ]

main :: IO ()
main = putStrLn $ render myhtml
