module View exposing (..)

import Element exposing (..)
import Element.Attributes exposing (..)
import Html exposing (Html)
import RemoteData exposing (WebData)
import Types exposing (Msg, Model, Filter, Product)
import Components.Filters
import Components.Products
import Styles exposing (..)


view : Model -> Html Msg
view model =
    Element.layout stylesheet <|
        column Styles.Main
            [ padding 10, spacing 10 ]
            [ (Components.Filters.view model.filter)
            , viewProducts model.products model.filter
            ]


viewProducts : WebData (List Product) -> Filter -> Element Styles variation Msg
viewProducts response filter =
    maybeList response filter


maybeList : WebData (List Product) -> Filter -> Element Styles variation Msg
maybeList response filter =
    case response of
        RemoteData.NotAsked ->
            el None [] (text "")

        RemoteData.Loading ->
            el None [] (text "Loading products...")

        RemoteData.Success products ->
            Components.Products.view products filter

        RemoteData.Failure error ->
            el None [] (text (toString error))
