module Types exposing (Flags, Item, Items(..), Model, Msg(..), itemDecoder, itemsDecoder)

import Http
import Json.Decode as Decode exposing (Decoder, int, list, nullable, string)
import Json.Decode.Pipeline exposing (hardcoded, optional, required)


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
    , occursOn : String
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
    Decode.succeed Item
        |> required "id" int
        |> required "name" string
        |> required "summary" (nullable string)
        |> required "description" (nullable string)
        |> optional "occurs_on" string ""
        |> required "price" string
        |> required "url" string
        |> hardcoded False
