module Components.Products exposing (view)

import Element exposing (..)
import Element.Attributes exposing (..)
import Types exposing (Msg, Product, Filter(..))
import Styles exposing (..)


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


item : Product -> Element Styles variation Msg
item product =
    let
        description =
            if product.description == "" then
                "Click to purchase"
            else
                product.description
    in
        link ("https://curling.io/p/" ++ (toString product.id)) <|
            column Styles.Product
                []
                [ row Styles.ProductHeader
                    [ justify, padding 5, spacing 10 ]
                    [ el None [] (text product.name)
                    , el None [] (text product.price)
                    ]
                , el None [ padding 5 ] (text description)
                ]


view : List Product -> Filter -> Element Styles variation Msg
view products filter =
    let
        filteredProducts =
            (filterProducts products filter)
    in
        column Styles.Products [ spacing 10 ] (List.map item filteredProducts)
