module Html.Internal where

import Numeric.Natural

newtype Html = Html String

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

type Title = String

html_ :: Title -> Document -> Html
html_ title content =
  Html $
    el "html" $
      el "head" (el "title" (escape title))
        <> (el "body" (concatMap getStructureString content))

el :: String -> String -> String
el tag content = "<" <> tag <> ">" <> content <> "</" <> tag <> ">"

instance Semigroup Structure where
  (<>) (Heading n h1) (Heading _ h2) = Heading n (h1 <> h2)
  (<>) (Paragraph s) (Paragraph t) = Paragraph (s <> t)
  (<>) (UnorderedList u) (UnorderedList v) = UnorderedList (u <> v)
  (<>) (OrderedList o) (OrderedList p) = OrderedList (o <> p)
  (<>) (CodeBlock c) (CodeBlock d) = CodeBlock (c <> d)
  (<>) s1 s2 = Concat s1 s2

getStructureString :: Structure -> String
getStructureString structure = case structure of
  Heading level text -> el ("h" <> show level) (escape text)
  Paragraph text -> el ("p") (escape text)
  UnorderedList items -> el "ul" (concatMap (el "li" . escape) (map getStructureString items))
  OrderedList items -> el "ol" (concatMap (el "li" . escape) (map getStructureString items))
  CodeBlock lines_ -> el "pre" (el "code" (unlines (map (escape . getStructureString) lines_)))
  Concat s1 s2 -> (getStructureString s1) ++ (getStructureString s2)
  Empty -> ""

p_ :: String -> Structure
p_ = Paragraph . escape

h_ :: Natural -> String -> Structure
h_ n txt = Heading n $ escape txt

h1_ :: String -> Structure
h1_ = h_ 1

ul_ :: [Structure] -> Structure
ul_ = UnorderedList

ol_ :: [Structure] -> Structure
ol_ = OrderedList

code_ :: String -> Structure
code_ = CodeBlock . (map p_ . lines . escape)

render :: Html -> String
render (Html h) = h

escape :: String -> String
escape =
  let escapeChar c =
        case c of
          '<' -> "&lt;"
          '>' -> "&gt;"
          '&' -> "&amp;"
          '"' -> "&quot;"
          '\'' -> "&#39;"
          _ -> [c]
   in concat . map escapeChar

empty_ :: Structure
empty_ = Empty
