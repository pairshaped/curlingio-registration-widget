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
        , style "overflow-x" "auto"
        , class "curlingio_container"
        ]
        [ viewItems model
        ]


viewFilter : Model -> Html Msg
viewFilter model =
    div [ class "curlingio_filter-container" ]
        [ input
            [ placeholder "Type to filter results"
            , value model.filter
            , onInput ChangeFilter
            , style "padding" "5px"
            , style "min-width" "200px"
            , style "width" "40%"
            , style "margin-bottom" "10px"
            , class "curlingio_filter-input"
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
                    , p [ class "curlingio_no-results" ]
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
                    , div [ class "curlingio_results" ] (List.map viewItem items)
                    ]


viewItem : Item -> Html Msg
viewItem item =
    div
        [ style "display" "flex"
        , style "flex-direction" "column"
        , style "margin-bottom" "10px"
        , class "curlingio_item-container"
        ]
        [ div
            [ style "display" "flex"
            , style "flex-direction" "row"
            , style "text-decoration" "none"
            , style "padding" "5px"
            , class "curlingio_item-top"
            ]
            [ a
                [ style "min-width" "500px"
                , class "curlingio_item-name"
                , href item.url
                , target "_blank"
                ]
                [ text item.name ]
            , div
                [ style "min-width" "140px"
                , class "curlingio_item-price"
                ]
                [ text item.price ]
            , a
                [ style "min-width" "100px"
                , style "text-align" "right"
                , class "curlingio_item-purchase"
                , href (item.url ++ "/add_to_cart")
                , target "_blank"
                ]
                [ text
                    (if item.price == "-" then
                        "Register"

                     else
                        "Purchase"
                    )
                ]
            ]
        , div
            [ style "padding" "5px"
            , style "color" "#333"
            , class "curlingio_item-summary"
            ]
            [ text (Maybe.withDefault "" item.summary) ]
        , div
            [ style "display" "none"
            , class "curlingio_item-description"
            , style "display" "none"
            ]
            [ text (Maybe.withDefault "" item.description) ]
        ]
