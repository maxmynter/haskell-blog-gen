module Markup
  ( Document,
    Structure (..),
  )
where

import Html.Internal (Document, Structure (..))

parse :: String -> Document
parse = parseLines [] . lines

parseLines :: [String] -> [String] -> Document
parseLines currentParagraph txts =
  let paragraph = Paragraph (unlines (reverse currentParagraph))
   in case txts of
        [] -> [paragraph]
        currentLine : rest ->
          if trim currentLine == ""
            then paragraph : parseLines [] rest
            else parseLines (currentLine : currentParagraph) rest

trim :: String -> String
trim = unwords . words

print :: (Show a) => a -> IO ()
print = putStrLn . show
