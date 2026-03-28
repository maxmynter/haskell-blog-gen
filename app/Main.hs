module Main (main) where

wrapIn :: String -> String -> String
wrapIn tag content = "<" ++ tag ++ ">" <> content <> "</" ++ tag ++ ">"

html_ :: String -> String
html_ = wrapIn "html"

body_ :: String -> String
body_ = wrapIn "body"

head_ :: String -> String
head_ = wrapIn "head"

title_ :: String -> String
title_ = wrapIn "title"

myhtml :: String -> String
myhtml = html_ . body_

makehtml :: String -> String -> String
makehtml title body = html_ $ (head_ . title_) title <> body_ body

main :: IO ()
main = putStrLn $ makehtml "Page Title" "Page Content"
