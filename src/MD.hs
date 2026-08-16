{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

-- | Turning a markdown document into HTML with each of the libraries under
-- comparison. Every function does the same amount of work: parse the
-- document and render it to HTML as lazy text.
module MD
  ( mmarkTest,
    commonmarkTest,
    pandocTest,
    cmarkTest,
  )
where

import CMark
import Commonmark qualified as CM
import Data.Text (Text)
import Data.Text.Lazy qualified as TL
import Lucid (renderText)
import Text.Blaze.Html.Renderer.Text
import Text.MMark qualified as MMark
import Text.Pandoc

mmarkTest :: Text -> TL.Text
mmarkTest txt =
  case MMark.parse "" txt of
    Left _ -> error "mmark failed to parse the input"
    Right x -> renderText (MMark.render mempty x)

commonmarkTest :: Text -> TL.Text
commonmarkTest txt =
  case CM.commonmark "" txt of
    Left _ -> error "commonmark failed to parse the input"
    Right (html :: CM.Html ()) -> CM.renderHtml html

pandocTest :: Text -> TL.Text
pandocTest txt = fromRight . runPure $ do
  doc <- readMarkdown def txt
  renderHtml <$> writeHtml5 def doc

cmarkTest :: Text -> Text
cmarkTest = commonmarkToHtml []

fromRight :: Either a b -> b
fromRight (Left _) = error "pandoc failed to parse the input"
fromRight (Right x) = x
