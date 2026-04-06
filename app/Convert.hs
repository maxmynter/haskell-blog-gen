module Convert where

import qualified Html
import qualified Markup

convertStructure :: Markup.Structure -> Html.Structure
convertStructure structure =
  case structure of
    Markup.Heading n txt -> Html.h_ n txt
    Markup.Paragraph p -> Html.p_ p
    Markup.UnorderedList list -> Html.ul_ $ map convertStructure list
    Markup.OrderedList list -> Html.ol_ $ map convertStructure list
    Markup.CodeBlock code -> Html.code_ $ show code
    Markup.Empty -> Html.Empty

concatStructure :: [Markup.Structure] -> Html.Structure
concatStructure list = case list of
  [] -> Html.Empty
  x : xs -> convertStructure x <> (concatStructure xs)

convert :: Html.Title -> Markup.Document -> Html.Html
convert title = Html.html_ title . map convertStructure
