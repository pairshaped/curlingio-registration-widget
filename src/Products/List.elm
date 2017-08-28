module Products.List exposing (..)

import Html exposing (Html, ul, li, text)
import Models exposing (Product)
import Msgs exposing (Msg)


view : List Product -> Html Msg
view products =
    ul [] (List.map row products)


row : Product -> Html Msg
row product =
    li [] [ text product.name ]
