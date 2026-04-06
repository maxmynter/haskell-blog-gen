module Main (main) where

import qualified Html
import qualified Markup

testDoc :: Html.Document
testDoc =
  [ Html.Heading 1 "Hello World",
    Html.Paragraph "Paragraph 1",
    Html.Paragraph "We're Haskellin <3",
    Html.UnorderedList ["Haskell", "Rust", "Python"]
  ]

hello :: Html.Document
hello = [Html.Paragraph "Hello, world!"]

welcome :: Html.Document
welcome = [Html.Heading 1 "Welcome", Html.Paragraph "To this tutorial about Haskell"]

lists :: Html.Document
lists =
  [ Html.Paragraph "Remember that multiple lines with no separation are grouped together into a single paragraph but list items remain separate.",
    Html.OrderedList
      [ "Item 1 of a list",
        "Item 2 of the same list"
      ]
  ]

doc :: Html.Document
doc =
  [ Html.Heading 1 "Compiling programs with ghc",
    Html.Paragraph "Running ghc invokes the Glasgow Haskell Compiler (GHC), and can be used to compile Haskell modules and programs into native executables and libraries.",
    Html.Paragraph "Create a new Haskell source file named hello.hs, and write the following code in it:",
    Html.CodeBlock
      [ "main = putStrLn \"Hello, Haskell!\""
      ],
    Html.Paragraph "Now, we can compile the program by invoking ghc with the file name:",
    Html.CodeBlock
      [ "➜ ghc hello.hs",
        "[1 of 1] Compiling Main             ( hello.hs, hello.o )",
        "Linking hello ..."
      ],
    Html.Paragraph "GHC created the following files:",
    Html.UnorderedList
      [ "hello.hi - Haskell interface file",
        "hello.o - Object file, the output of the compiler before linking",
        "hello (or hello.exe on Microsoft Windows) - A native runnable executable."
      ],
    Html.Paragraph "GHC will produce an executable when the source file satisfies both conditions:",
    Html.OrderedList
      [ "Defines the main function in the source file",
        "Defines the module name to be Main or does not have a module declaration"
      ],
    Html.Paragraph "Otherwise, it will only produce the .o and .hi files."
  ]

main :: IO ()
main = mapM_ (putStrLn . Html.render) (map (Html.html_ "TestTitle") [testDoc, hello, welcome, lists, doc])
