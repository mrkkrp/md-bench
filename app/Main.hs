module Main (main) where

import MD
import qualified Data.Text.IO      as TIO
import qualified Data.Text.Lazy.IO as TLIO

main :: IO ()
main = do
  input <- TIO.readFile "data/README.md"
  TLIO.writeFile "data/output.html" (mmarkTest input)
