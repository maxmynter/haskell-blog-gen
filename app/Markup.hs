module Markup
  ( Document,
    Structure (..),
  )
where

import Data.Maybe
import Numeric.Natural

type Document = [Structure]

data Structure
  = Heading Natural String
  | Paragraph String
  | UnorderedList [Structure]
  | OrderedList [Structure]
  | CodeBlock [Structure]
  | Concat Structure Structure
  | Empty
  deriving (Show, Eq)

instance Semigroup Structure where
  (<>) = Concat

instance Monoid Structure where
  mempty = Empty
  mconcat (a : as) = a <> (mconcat as)
  mconcat [] = Empty

parse :: String -> Document
parse = parseLines Nothing . lines

parseLines :: Maybe Structure -> [String] -> Document
parseLines context txts =
  case txts of
    [] -> maybeToList context
    -- Heading
    ('*' : ' ' : line) : rest -> maybe id (:) context (Heading 1 (trim line) : parseLines Nothing rest)
    -- Unordered List
    ('-' : ' ' : line) : rest -> case context of
      Just (UnorderedList list) -> parseLines (Just (UnorderedList (list <> [Paragraph $ trim line]))) rest
      _ -> maybe id (:) context (parseLines (Just (UnorderedList [Paragraph $ trim line])) rest)
    ('#' : ' ' : line) : rest -> case context of
      Just (OrderedList list) -> parseLines (Just (OrderedList (list <> [Paragraph $ trim line]))) rest
      _ -> maybe id (:) context (parseLines (Just (OrderedList [Paragraph $ trim line])) rest)
    ('>' : ' ' : line) : rest -> case context of
      Just (CodeBlock code) -> parseLines (Just (CodeBlock (code <> [Paragraph $ trim line]))) rest
      _ -> maybe id (:) context (parseLines (Just (CodeBlock [Paragraph $ trim line])) rest)
    -- Paragraph
    currentLine : rest ->
      let line = trim currentLine
       in if line == ""
            then maybe id (:) context (parseLines Nothing rest)
            else case context of
              Just (Paragraph paragraph) -> parseLines (Just (Paragraph (unwords [paragraph, line]))) rest
              _ -> maybe id (:) context (parseLines (Just (Paragraph line)) rest)

trim :: String -> String
trim = unwords . words

print :: (Show a) => a -> IO ()
print = putStrLn . show
