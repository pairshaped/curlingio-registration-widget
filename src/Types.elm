module Types exposing (..)

import RemoteData exposing (WebData)


type Msg
    = OnFetchProducts (WebData (List Product))
    | ChangeFilter Filter


type alias Flags =
    { accessKey : AccessKey }


type alias AccessKey =
    String


type alias Model =
    { filter : Filter
    , products : WebData (List Product)
    }


type Filter
    = Bundles
    | Leagues
    | Competitions
    | Other
    | All


type alias Product =
    { id : Int
    , name : String
    , price : String
    , description : String
    , registrationType : String
    , quantity : Int
    , available_quantity : Int
    }
