module Types exposing (Flags, Item, Items(..), Model, Msg(..), itemDecoder, itemsDecoder)

import Http
import Json.Decode exposing (Decoder, field, list, maybe, string)


type Msg
    = GotItems (Result Http.Error (List Item))
    | ChangeFilter String


type alias Flags =
    { host : String
    , section : String
    }


type Items
    = Failure String
    | Loading
    | Success (List Item)


type alias Item =
    { name : String
    , summary : Maybe String
    , description : Maybe String
    , price : String
    , url : String
    }


type alias Model =
    { flags : Flags
    , filter : String
    , items : Items
    }


itemsDecoder : Decoder (List Item)
itemsDecoder =
    list itemDecoder


itemDecoder : Decoder Item
itemDecoder =
    Json.Decode.map5 Item
        (field "name" string)
        (maybe (field "summary" string))
        (maybe (field "description" string))
        (field "price" string)
        (field "url" string)
