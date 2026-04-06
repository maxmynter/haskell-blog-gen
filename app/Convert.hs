module Convert where

import qualified Html
import qualified Markup

convertStructure :: Markup.Structure -> Html.Structure
convertStructure structure = 
  case structure of 
    Markup.Heading 1 txt -> Html.h1_ txt

