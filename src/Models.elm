module Models exposing (..)

import RemoteData exposing (WebData)


type alias Model =
    { filter : Maybe String
    , products : WebData (List Product)
    }


type alias Product =
    { id : Int
    , name : String
    , price : String
    , description : String
    }


initialModel : Model
initialModel =
    { filter = Nothing
    , products = RemoteData.Loading
    }
