module Components.Products exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (Msg, Product, Filter(..))
import Styles


filterProducts : List Product -> Filter -> List Product
filterProducts products filter =
    case filter of
        All ->
            products

        Bundles ->
            List.filter (\product -> product.registrationType == "league_bundle") products

        Leagues ->
            List.filter (\product -> product.registrationType == "direct_league") products

        Competitions ->
            List.filter (\product -> product.registrationType == "direct_competition") products

        Other ->
            List.filter (\product -> product.registrationType == "general") products


item : Product -> Html Msg
item product =
    let
        description =
            if product.description == "" then
                "Click to purchase"
            else
                product.description
    in
        a
            [ style Styles.productContainer
            , href ("https://curling.io/p/" ++ (toString product.id))
            ]
            [ strong
                [ style Styles.productHeader ]
                [ div [] [ (text product.name) ]
                , div [] [ (text product.price) ]
                ]
            , div [ style Styles.productBody ] [ (text description) ]
            ]


view : List Product -> Filter -> Html Msg
view products filter =
    let
        filteredProducts =
            (filterProducts products filter)
    in
        div
            [ style Styles.products ]
            (List.map item filteredProducts)
