module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import RemoteData exposing (WebData)
import Types exposing (Msg, Model, Filter, Product)
import Components.Filters
import Components.Products
import Styles


view : Model -> Html Msg
view model =
    div [ style Styles.root ]
        [ (Components.Filters.view model.filter)
        , viewProducts model.products model.filter
        ]


viewProducts : WebData (List Product) -> Filter -> Html Msg
viewProducts response filter =
    maybeList response filter


maybeList : WebData (List Product) -> Filter -> Html Msg
maybeList response filter =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading products..."

        RemoteData.Success products ->
            Components.Products.view products filter

        RemoteData.Failure error ->
            text (toString error)
