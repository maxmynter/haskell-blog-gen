module Html.Internal where

newtype Html = Html String

newtype Structure = Structure String

type Title = String

el :: String -> String -> String
el tag content = "<" <> tag <> ">" <> content <> "</" <> tag <> ">"

html_ :: Title -> Structure -> Html
html_ title content = Html $ el "html" (el "head" (el "title" $ escape title)) <> (el "body" (getStructureString content))

p_ :: String -> Structure
p_ = Structure . el "paragraph" . escape

h1_ :: String -> Structure
h1_ = Structure . el "h1" . escape

ul_ :: [Structure] -> Structure
ul_ items =
  Structure $ el "ul" (li_ items)
  where
    li_ [] = mempty
    li_ [i] = el "li" (getStructureString i)
    li_ (i : is) = (el "li" (getStructureString i)) <> (li_ is)

append_ :: Structure -> Structure -> Structure
append_ (Structure a) (Structure b) = Structure $ a <> b

getStructureString :: Structure -> String
getStructureString (Structure s) = s

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
          '\'' -> "&#39"
          _ -> [c]
   in concat . map escapeChar
