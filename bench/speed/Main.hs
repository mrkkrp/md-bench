module Main (main) where

import Control.DeepSeq
import Criterion.Main
import Data.Text (Text)
import Data.Text.IO qualified as T
import MD

main :: IO ()
main =
  defaultMain
    [ bparser "mmark" mmarkTest,
      bparser "commonmark" commonmarkTest,
      bparser "cmark" cmarkTest,
      bparser "pandoc" pandocTest
    ]

----------------------------------------------------------------------------
-- Helpers

bparser :: (NFData a) => String -> (Text -> a) -> Benchmark
bparser name f = env (T.readFile "data/README.md") (bench name . nf f)
