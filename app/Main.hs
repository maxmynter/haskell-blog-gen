module Main (main) where

import Convert
import qualified Html
import qualified Markup

testDoc :: Html.Html
testDoc =
  convert
    "Hello"
    [ Markup.Heading 1 "Hello World",
      Markup.Paragraph "Paragraph 1",
      Markup.Paragraph "We're Haskellin <3",
      Markup.UnorderedList [Markup.Paragraph "Haskell", Markup.Paragraph "Rust", Markup.Paragraph "Python"]
    ]

hello :: Html.Html
hello = convert "short hello" [Markup.Paragraph "Hello, world!"]

welcome :: Html.Html
welcome = convert "Haskell" [Markup.Heading 1 "Welcome", Markup.Paragraph "To this tutorial about Haskell"]

lists :: Html.Html
lists =
  convert
    "Multiline"
    [ Markup.Paragraph "Remember that multiple lines with no separation are grouped together into a single paragraph but list items remain separate.",
      Markup.OrderedList
        [ Markup.Paragraph "Item 1 of a list",
          Markup.Paragraph "Item 2 of the same list"
        ]
    ]

doc :: Html.Html
doc =
  convert
    "Compilation"
    [ Markup.Heading 1 "Compiling programs with ghc",
      Markup.Paragraph "Running ghc invokes the Glasgow Haskell Compiler (GHC), and can be used to compile Haskell modules and programs into native executables and libraries.",
      Markup.Paragraph "Create a new Haskell source file named hello.hs, and write the following code in it:",
      Markup.CodeBlock
        [ Markup.Paragraph "main = putStrLn \"Hello, Haskell!\""
        ],
      Markup.Paragraph "Now, we can compile the program by invoking ghc with the file name:",
      Markup.CodeBlock
        [ Markup.Paragraph "➜ ghc hello.hs",
          Markup.Paragraph "[1 of 1] Compiling Main             ( hello.hs, hello.o )",
          Markup.Paragraph "Linking hello ..."
        ],
      Markup.Paragraph "GHC created the following files:",
      Markup.UnorderedList
        [ Markup.Paragraph "hello.hi - Haskell interface file",
          Markup.Paragraph "hello.o - Object file, the output of the compiler before linking",
          Markup.Paragraph "hello (or hello.exe on Microsoft Windows) - A native runnable executable."
        ],
      Markup.Paragraph "GHC will produce an executable when the source file satisfies both conditions:",
      Markup.OrderedList
        [ Markup.Paragraph "Defines the main function in the source file",
          Markup.Paragraph "Defines the module name to be Main or does not have a module declaration"
        ],
      Markup.Paragraph "Otherwise, it will only produce the .o and .hi files."
    ]

main :: IO ()
main = mapM_ (putStrLn . Html.render) [testDoc, hello, welcome, lists, doc]
