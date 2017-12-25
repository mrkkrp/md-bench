module Main (main) where

import Control.DeepSeq
import Criterion.Main
import Data.Text (Text)
import MD
import qualified Data.Text.IO as T

main :: IO ()
main = defaultMain
  [ bparser "MMark"  mmarkTest
  , bparser "Pandoc" pandocTest
  , bparser "CMark"  cmarkTest
  , bparser "Markdown" markdownTest
  , bparser "Cheapskate" cheapskateTest
  ]

----------------------------------------------------------------------------
-- Helpers

bparser
  :: NFData a
  => String
  -> (Text -> a)
  -> Benchmark
bparser name f = env (T.readFile "data/README.md") (bench name . nf f)
