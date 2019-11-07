
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DeriveGeneric #-}
module Main where

import           Data.Aeson
import qualified Data.Map as M
import           Data.Proxy
import           Servant
import           GHC.Generics
import           Network.Wai.Handler.Warp

type AlpacaAPI = "alpaca" :> Get '[JSON] (M.Map Int Alpaca)
      :<|> "alpaca" :> Capture "alpacaId" Int :> Get '[JSON] Alpaca
      :<|> "alpaca" :> Capture "alpacaId" Int
                    :> ReqBody '[JSON] Alpaca
                    :> PutCreated '[JSON] NoContent

alpacaApi :: Proxy AlpacaAPI
alpacaApi = Proxy

fetchAll :: Monad m => m (M.Map Int Alpaca)
fetchAll = pure $ M.singleton 1 dummy

fetch :: Monad m => Int -> m Alpaca
fetch _ = pure dummy

insert :: Monad m => Int -> Alpaca -> m NoContent
insert _ _ = pure NoContent

data Color = White | Beige | Brown | Black | Silver 
         deriving (Generic, Show)

data Alpaca = Alpaca {
     name  :: String
   , color :: Color
   , age   :: Int
} deriving (Generic, Show)

instance ToJSON Color
instance FromJSON Color
instance ToJSON Alpaca
instance FromJSON Alpaca

dummy :: Alpaca
dummy = Alpaca "Dotty" White 0

server :: Server AlpacaAPI
server = fetchAll
  :<|> fetch
  :<|> insert

app :: Application
app = serve alpacaApi server

main :: IO ()
main = run 8080 app
