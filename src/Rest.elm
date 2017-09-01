module Rest exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Types exposing (Msg(..), AccessKey, Product)
import RemoteData


fetchProducts : AccessKey -> Cmd Msg
fetchProducts accessKey =
    Http.get (productsUrl accessKey) productsDecoder
        |> RemoteData.sendRequest
        |> Cmd.map OnFetchProducts


productsUrl : AccessKey -> String
productsUrl accessKey =
    -- "https://curling.io/api/organizations/" ++ accessKey ++ "/products"
    "http://localhost:4000/products"


productsDecoder : Decode.Decoder (List Product)
productsDecoder =
    Decode.list productDecoder


productDecoder : Decode.Decoder Product
productDecoder =
    decode Product
        |> required "id" Decode.int
        |> required "name" Decode.string
        |> required "price" Decode.string
        |> required "description" Decode.string
        |> required "registration_type" Decode.string