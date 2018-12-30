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
        [ viewItems model
        ]


viewFilter : Model -> Html Msg
viewFilter model =
    div []
        [ input
            [ placeholder "Type to filter results"
            , value model.filter
            , onInput ChangeFilter
            , style "padding" "5px"
            , style "min-width" "200px"
            , style "width" "40%"
            , style "margin-bottom" "10px"
            ]
            []
        ]


filteredItems : List Item -> String -> List Item
filteredItems items filter =
    case filter of
        "" ->
            items

        _ ->
            let
                matches item =
                    String.contains (String.toUpper filter) (String.toUpper (String.append item.name (Maybe.withDefault "" item.summary)))
            in
            List.filter matches items


viewItems : Model -> Html Msg
viewItems model =
    case model.items of
        Failure message ->
            text message

        Loading ->
            text "Loading..."

        Success decodedItems ->
            div []
                [ viewFilter model
                , div [] (List.map viewItem (filteredItems decodedItems model.filter))
                ]


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
                [ style "min-width" "500px"
                , style "width" "80%"
                ]
                [ text item.name ]
            , div
                [ style "min-width" "140px"
                , style "width" "20%"
                ]
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
