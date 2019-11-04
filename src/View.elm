module View exposing (view)

import Html exposing (Html, a, div, input, p, text)
import Html.Attributes exposing (class, href, placeholder, style, value)
import Html.Events exposing (onInput)
import Json.Decode
import Types exposing (..)


view : Model -> Html Msg
view model =
    div
        [ class "curlingio_container" ]
        [ viewItems model ]


viewFilter : Model -> Html Msg
viewFilter model =
    div
        [ class "curlingio_filter-container"
        , style "display" "flex"
        , style "justify-content" "space-between"
        , style "margin-bottom" "15px"
        ]
        [ input
            [ placeholder "Type to filter results"
            , value model.filter
            , onInput ChangeFilter
            , class "curlingio_filter-input"
            , style "padding" "5px"
            , style "min-width" "250px"
            ]
            []
        , a
            [ href (model.flags.host ++ "/" ++ model.flags.section)
            , style "margin-left" "10px"
            , style "padding" "5px"
            ]
            [ text ("All " ++ model.flags.section) ]
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
                    , div
                        [ class "curlingio_results"
                        ]
                        (List.map viewItem items)
                    ]


viewItem : Item -> Html Msg
viewItem item =
    div
        [ class "curlingio_item"
        , style "display" "flex"
        , style "padding" "5px 0"
        , style "margin" "5px 0"
        , style "border-bottom" "1px solid #eee"
        ]
        [ div
            [ class "curlingio_item-details"
            , style "min-width" "180px"
            , style "flex-grow" "1"
            ]
            [ a
                [ class "curlingio_item-name"
                , style "display" "block"
                , style "margin-bottom" "5px"
                , href item.url
                ]
                [ text item.name ]
            , div
                [ class "curlingio_item-occurs-on"
                , style "margin-bottom" "5px"
                ]
                [ text item.occursOn ]
            , div
                [ class "curlingio_item-summary"
                , style "margin-bottom" "5px"
                ]
                [ text (Maybe.withDefault "" item.summary) ]
            ]
        , div
            [ class "curlingio_item-price"
            , style "min-width" "140px"
            ]
            [ div [ style "margin-bottom" "5px" ]
                [ text item.price ]
            , viewPurchaseLink item.url item.price
            ]
        ]


viewPurchaseLink : String -> String -> Html Msg
viewPurchaseLink url price =
    if not (String.isEmpty price) && not (String.contains "$" price) then
        text ""

    else
        a
            [ href (url ++ "/add_to_cart")
            ]
            [ text
                (if String.isEmpty price then
                    "Register"

                 else
                    "Purchase"
                )
            ]
