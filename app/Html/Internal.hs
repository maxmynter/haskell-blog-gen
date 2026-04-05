module Html.Internal where

import Markup
import Numeric.Natural

newtype Html = Html String

type Title = String

el :: String -> String -> String
el tag content = "<" <> tag <> ">" <> content <> "</" <> tag <> ">"

html_ :: Title -> Document -> Html
html_ title content =
  Html $
    el "html" $
      el "head" (el "title" (escape title))
        <> (el "body" (concatMap getStructureString content))

p_ :: String -> Structure
p_ = Paragraph . escape

h1_ :: String -> Structure
h1_ = (Heading 1) . escape

ul_ :: [String] -> Structure
ul_ = UnorderedList

ol_ :: [String] -> Structure
ol_ = OrderedList

code_ :: String -> Structure
code_ = CodeBlock . lines . escape

append_ :: Structure -> Structure -> Structure
append_ (UnorderedList a) (UnorderedList b) = UnorderedList $ a <> b
append_ (OrderedList a) (OrderedList b) = OrderedList $ a <> b
append_ (CodeBlock a) (CodeBlock b) = CodeBlock $ a <> b
append_ (Heading n1 s1) (Heading _ s2) = Heading n1 (s1 <> s2)
append_ (Paragraph p1) (Paragraph p2) = Paragraph (p1 <> p2)
append_ _ _ = error $ "Cannot append incompatible structures"

getStructureString :: Structure -> String
getStructureString structure = case structure of
  Heading level text -> el ("h" <> show level) (escape text)
  Paragraph text -> el ("p") (escape text)
  UnorderedList items -> el "ul" (concatMap (el "li" . escape) items)
  OrderedList items -> el "ol" (concatMap (el "li" . escape) items)
  CodeBlock lines_ -> el "pre" (el "code" (unlines (map escape lines_)))

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
