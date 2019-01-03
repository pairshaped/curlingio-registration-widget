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
        , class "curlingio-registration_container"
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
            , class "curlingio-registration_search-box"
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
            let
                items =
                    filteredItems decodedItems model.filter
            in
            if List.isEmpty items then
                div []
                    [ viewFilter model
                    , p [ class "curlingio-registration_no-results" ]
                        [ case model.filter of
                            "" ->
                                text "There's nothing available right now."

                            _ ->
                                text "There are no results matching your search."
                        ]
                    ]

            else
                div []
                    [ viewFilter model
                    , div [ class "curlingio-registration_results" ] (List.map viewItem items)
                    ]


viewItem : Item -> Html Msg
viewItem item =
    div
        [ style "display" "flex"
        , style "flex-direction" "column"
        , style "margin-bottom" "10px"
        , class "curlingio-registration_item"
        ]
        [ a
            [ style "display" "flex"
            , style "flex-direction" "row"
            , style "text-decoration" "none"
            , style "padding" "5px"
            , class "curlingio-registration_item-link"
            , href item.url
            , target "_blank"
            ]
            [ div
                [ style "min-width" "500px"
                , style "width" "80%"
                , class "curlingio-registration_item-name"
                ]
                [ text item.name ]
            , div
                [ style "min-width" "140px"
                , style "width" "20%"
                , class "curlingio-registration_item-price"
                ]
                [ text item.price ]
            ]
        , div
            [ style "padding" "5px"
            , style "color" "#333"
            , class "curlingio-registration_item-summary"
            ]
            [ text (Maybe.withDefault "" item.summary) ]
        , div
            [ style "display" "none", class "curlingio-registration_item-description" ]
            [ text (Maybe.withDefault "" item.description) ]
        ]
