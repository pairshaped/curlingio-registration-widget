module View exposing (..)

import Html exposing (Html, div, text)
import RemoteData exposing (WebData)
import Models exposing (Model, Product)
import Msgs exposing (Msg)
import Products.List


view : Model -> Html Msg
view model =
    div []
        [ viewProducts model.products ]


viewProducts : WebData (List Product) -> Html Msg
viewProducts response =
    div []
        [ maybeList response ]


maybeList : WebData (List Product) -> Html Msg
maybeList response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading products..."

        RemoteData.Success products ->
            Products.List.view products

        RemoteData.Failure error ->
            text (toString error)
