module Msgs exposing (..)

import Models exposing (Product)
import RemoteData exposing (WebData)


type Msg
    = OnFetchProducts (WebData (List Product))
