module MD
  ( mmarkTest
  , pandocTest
  , cmarkTest
  , markdownTest
  , cheapskateTest )
where

import CMark
import Data.Text (Text)
import Lucid (renderText)
import Text.Blaze.Html (toHtml)
import Text.Blaze.Html.Renderer.Text
import Text.Markdown
import Text.Pandoc
import qualified Cheapskate     as C
import qualified Data.Text.Lazy as TL
import qualified Text.MMark     as MMark

mmarkTest :: Text -> TL.Text
mmarkTest txt =
  case MMark.parse "" txt of
    Left  _ -> error "fucked up"
    Right x -> renderText (MMark.render x)

pandocTest :: Text -> TL.Text
pandocTest txt = fromRight . runPure $ do
  doc <- readMarkdown def txt
  renderHtml <$> writeHtml5 def doc

cmarkTest :: Text -> Text
cmarkTest = commonmarkToHtml []

markdownTest :: Text -> TL.Text
markdownTest = renderHtml . markdown def . TL.fromStrict

cheapskateTest :: Text -> TL.Text
cheapskateTest = renderHtml . toHtml . C.markdown def

fromRight :: Either a b -> b
fromRight (Left _) = error "fucked up"
fromRight (Right x) = x
