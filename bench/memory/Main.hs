{-# LANGUAGE OverloadedStrings #-}

module Main (main) where

import Control.DeepSeq
import Data.Text (Text)
import Data.Text.IO qualified as T
import MD
import Weigh

main :: IO ()
main = mainWith $ do
  setColumns [Case, Allocated, GCs, Max]
  bparser "mmark" mmarkTest
  bparser "commonmark" commonmarkTest
  bparser "cmark" cmarkTest
  bparser "pandoc" pandocTest

----------------------------------------------------------------------------
-- Helpers

bparser :: (NFData a) => String -> (Text -> a) -> Weigh ()
bparser name f = action name (f <$> T.readFile "data/README.md")
