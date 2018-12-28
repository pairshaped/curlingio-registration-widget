module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Styles exposing (..)
import Types exposing (..)


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ viewItems model ]


viewItems : Model -> Html Msg
viewItems model =
    case model of
        Failure message ->
            text message

        Loading ->
            text "Loading..."

        Success items ->
            div [ class "items" ] (List.map viewItem items)


viewItem : Item -> Html Msg
viewItem item =
    div [ class "item" ]
        [ div [ class "item-link-wrapper" ]
            [ a
                [ class "item-link", href item.url, target "_blank" ]
                [ text item.name ]
            ]
        , div
            [ class "item-name" ]
            [ text item.name ]
        , div [ class "item-price" ] [ text item.price ]
        , div [ class "item-summary" ] [ text (Maybe.withDefault "" item.summary) ]
        , div [ class "item-description" ] [ text (Maybe.withDefault "" item.description) ]
        ]
