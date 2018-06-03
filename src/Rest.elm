module Rest exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required, optional)
import Types exposing (Msg(..), AccessKey, Product)
import RemoteData


fetchProducts : AccessKey -> Cmd Msg
fetchProducts accessKey =
    Http.get (productsUrl accessKey) productsDecoder
        |> RemoteData.sendRequest
        |> Cmd.map OnFetchProducts


productsUrl : AccessKey -> String
productsUrl accessKey =
    -- "http://localhost:4000/products"
    -- "http://localhost:3000/api/organizations/" ++ accessKey ++ "/products"
    "https://legacy.curling.io/api/organizations/" ++ accessKey ++ "/products"


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
        |> optional "quantity" Decode.int -1
        |> optional "available_quantity" Decode.int -1
