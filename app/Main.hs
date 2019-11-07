

module Main where

import           Network.Wai.Handler.Warp
import           API

main :: IO ()
main = run 8080 app
