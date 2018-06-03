module Components.Products exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (Msg, Product, Filter(..))
import Helpers
import Styles


view : List Product -> Filter -> Html Msg
view products filter =
    let
        filteredProducts =
            (Helpers.filterProducts products filter)
    in
        div
            [ style Styles.products ]
            (List.map item filteredProducts)


item : Product -> Html Msg
item product =
    let
        description =
            if product.description == "" then
                "Click to purchase"
            else
                product.description

        price =
            if product.price == "$0.00" then
                ""
            else
                "Starting at " ++ product.price

        availableQuantity =
            case product.available_quantity of
                (-1) ->
                    ""

                0 ->
                    " (Sold Out)"

                _ ->
                    " (" ++ (toString product.available_quantity) ++ " available)"
    in
        a
            [ style Styles.productContainer
            , href ("https://legacy.curling.io/p/" ++ (toString product.id))
            ]
            [ strong
                [ style Styles.productHeader ]
                [ div [ style Styles.productName ] [ (text (product.name ++ availableQuantity)) ]
                , div [ style Styles.productPrice ] [ (text price) ]
                ]
            , div [ style Styles.productBody ] [ (text description) ]
            ]
