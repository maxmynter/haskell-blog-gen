module Convert where

import qualified Html
import qualified Markup

convertStructure :: Markup.Structure -> Html.Structure
convertStructure structure =
  case structure of
    Markup.Heading n txt -> Html.h_ n txt
    Markup.Paragraph p -> Html.p_ p
    Markup.UnorderedList list -> Html.UnorderedList list
    Markup.OrderedList list -> Html.OrderedList list
    Markup.CodeBlock code -> Html.CodeBlock code
