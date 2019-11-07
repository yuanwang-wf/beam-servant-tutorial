
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
module API where

import qualified Data.Map as M
import           Data.Proxy
import           Servant

import Alpaca


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

server :: Server AlpacaAPI
server = fetchAll
  :<|> fetch
  :<|> insert

app :: Application
app = serve alpacaApi server
