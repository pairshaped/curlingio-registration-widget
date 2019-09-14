module Types exposing (Flags, Item, Items(..), Model, Msg(..), itemDecoder, itemsDecoder)

import Http
import Json.Decode exposing (Decoder, field, int, list, maybe, string, succeed)


type Msg
    = GotItems (Result Http.Error (List Item))
    | ExpandItem Int
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
    { id : Int
    , name : String
    , summary : Maybe String
    , description : Maybe String
    , price : String
    , url : String
    , expanded : Bool
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
    Json.Decode.map7 Item
        (field "id" int)
        (field "name" string)
        (maybe (field "summary" string))
        (maybe (field "description" string))
        (field "price" string)
        (field "url" string)
        (succeed False)
