
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
module API where


import qualified Data.Map as M
import           Data.Proxy
import           Servant

import User


-- "users" say 
type UserAPI1 = "users" :> Get '[JSON] [User]
type UserAPI2 = "users" :>

server1 :: Server UserAPI1
server1 = return users1

userAPI :: Proxy UserAPI1
userAPI = Proxy

app1 :: Application
app1 = serve userAPI server1
