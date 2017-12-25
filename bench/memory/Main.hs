{-# LANGUAGE OverloadedStrings #-}

module Main (main) where

import Control.DeepSeq
import Data.Text (Text)
import MD
import Weigh
import qualified Data.Text.IO as T

main :: IO ()
main = mainWith $ do
  setColumns [Case, Allocated, GCs, Max]
  bparser "MMark"  mmarkTest
  bparser "Pandoc" pandocTest
  bparser "CMark"  cmarkTest
  bparser "Markdown" markdownTest
  bparser "Cheapskate" cheapskateTest

----------------------------------------------------------------------------
-- Helpers

bparser
  :: NFData a
  => String
  -> (Text -> a)
  -> Weigh ()
bparser name f = action name (f <$> T.readFile "data/README.md")
