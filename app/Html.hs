module Html
  ( Html,
    Title,
    Structure,
    html_,
    p_,
    h1_,
    append_,
    render,
  )
where

newtype Html = Html String

newtype Structure = Structure String

type Title = String

el :: String -> String -> String
el tag content = "<" <> tag <> ">" <> content <> "</" <> tag <> ">"

html_ :: Title -> Structure -> Html
html_ title content = Html $ el "html" (el "head" (el "title" title)) <> (el "body" (getStructureString content))

p_ :: String -> Structure
p_ = Structure . el "paragraph"

h1_ :: String -> Structure
h1_ = Structure . el "h1"

append_ :: Structure -> Structure -> Structure
append_ (Structure a) (Structure b) = Structure $ a <> b

getStructureString :: Structure -> String
getStructureString (Structure s) = s

render :: Html -> String
render (Html h) = h
