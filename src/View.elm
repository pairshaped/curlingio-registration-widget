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
        [ resolveData model
        ]


resolveData : Model -> Html Msg
resolveData model =
    case model.products of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading products..."

        RemoteData.Success products ->
            div []
                [ Components.Filters.view products model.filter
                , Components.Products.view products model.filter
                ]

        RemoteData.Failure error ->
            text (toString error)
