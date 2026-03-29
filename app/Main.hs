module Main (main) where

import Html

myhtml :: Html
myhtml = html_ "Page Title" (append_ (h1_ "Hello World") (p_ "We're Haskellin"))

main :: IO ()
main = putStrLn $ render myhtml
