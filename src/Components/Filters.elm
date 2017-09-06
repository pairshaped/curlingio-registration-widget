module Components.Filters exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Types exposing (Msg(..), Filter(..), Product)
import Helpers exposing (showFilter)
import Styles


view : List Product -> Filter -> Html Msg
view products selected =
    let
        filters =
            List.filter (showFilter products) [ All, Bundles, Leagues, Competitions, Other ]
    in
        div [ style Styles.filters ] (List.map (viewFilter selected) filters)


viewFilter : Filter -> Filter -> Html Msg
viewFilter selected filter =
    let
        -- Remove the underline for the selected filter
        filterStyles =
            if (selected == filter) then
                List.filter
                    (\x -> (Tuple.first x) /= "text-decoration")
                    Styles.filter
            else
                Styles.filter
    in
        div
            [ style filterStyles
            , onClick (ChangeFilter filter)
            ]
            [ (text (toString filter)) ]
