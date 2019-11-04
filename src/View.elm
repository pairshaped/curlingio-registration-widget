module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode
import Types exposing (..)


view : Model -> Html Msg
view model =
    div
        [ class "curlingio_container" ]
        [ viewItems model ]


viewFilter : Model -> Html Msg
viewFilter model =
    div [ class "curlingio_filter-container" ]
        [ input
            [ placeholder "Type to filter results"
            , value model.filter
            , onInput ChangeFilter
            , class "curlingio_filter-input"
            , style "padding" "5px"
            , style "min-width" "200px"
            , style "margin" "0 5px 10px 5px"
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
                    , table
                        [ class "curlingio_results"
                        , style "border" "none"
                        ]
                        (List.map viewItem items)
                    ]


viewItem : Item -> Html Msg
viewItem item =
    tr
        [ class "curlingio_item"
        , style "margin-bottom" "10px"
        ]
        [ td
            [ class "curlingio_item-details"
            , style "width" "600px"
            , style "padding" "5px"
            , style "vertical-align" "top"
            ]
            [ a
                [ class "curlingio_item-name"
                , style "display" "block"
                , style "margin" "5px"
                , style "padding" "0"
                , href item.url
                , custom "click" (Json.Decode.succeed { message = ExpandItem item.id, stopPropagation = True, preventDefault = True })
                ]
                [ text item.name ]
            , p
                [ class "curlingio_item-summary"
                , style "padding" "5px"
                , style "margin" "0"
                , style "color" "#333"
                ]
                [ text (Maybe.withDefault "" item.summary) ]
            , p
                [ class "curlingio_item-description"
                , style "display"
                    (if item.expanded then
                        "block"

                     else
                        "none"
                    )
                , style "margin" "5px"
                , style "padding" "0"
                ]
                [ text (Maybe.withDefault "" item.description) ]
            ]
        , td
            [ class "curlingio_item-occurs-on"
            , style "min-width" "140px"
            , style "vertical-align" "top"
            ]
            [ text item.occursOn ]
        , td
            [ class "curlingio_item-price"
            , style "min-width" "140px"
            , style "vertical-align" "top"
            ]
            [ text item.price ]
        , td
            [ class "curlingio_item-purchase"
            , style "min-width" "140px"
            , style "vertical-align" "top"
            ]
            [ viewPurchaseLink item.url item.price
            ]
        ]


viewPurchaseLink : String -> String -> Html Msg
viewPurchaseLink url price =
    if not (String.isEmpty price) && not (String.contains "$" price) then
        text ""

    else
        a
            [ style "min-width" "100px"
            , style "text-align" "right"
            , href (url ++ "/add_to_cart")
            , target "_blank"
            ]
            [ text
                (if String.isEmpty price then
                    "Register"

                 else
                    "Purchase"
                )
            ]
