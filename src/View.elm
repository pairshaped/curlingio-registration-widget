module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


view : Model -> Html Msg
view model =
    div
        [ style "display" "flex"
        , style "flex-direction" "column"
        ]
        [ viewItems model.items ]


viewItems : Items -> Html Msg
viewItems items =
    case items of
        Failure message ->
            text message

        Loading ->
            text "Loading..."

        Success decodedItems ->
            div [] (List.map viewItem decodedItems)


viewItem : Item -> Html Msg
viewItem item =
    div
        [ style "display" "flex"
        , style "flex-direction" "column"
        , style "margin-bottom" "10px"
        ]
        [ a
            [ style "display" "flex"
            , style "flex-direction" "row"
            , style "text-decoration" "none"
            , style "padding" "5px"
            , href item.url
            , target "_blank"
            ]
            [ div
                [ style "width" "500px" ]
                [ text item.name ]
            , div
                [ style "width" "140px" ]
                [ text item.price ]
            ]
        , div
            [ style "padding" "5px"
            , style "color" "#333"
            ]
            [ text (Maybe.withDefault "" item.summary) ]
        , div
            [ style "display" "none" ]
            [ text (Maybe.withDefault "" item.description) ]
        ]
