module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Msgs exposing (Msg)
import Models exposing (Product)
import RemoteData


fetchProducts : Cmd Msg
fetchProducts =
    Http.get productsUrl productsDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchProducts


productsUrl : String
productsUrl =
    -- "https://curling.io/api/organizations/ACCESS_KEY/products"
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
