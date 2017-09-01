module Components.Filters exposing (view)

import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Events exposing (onClick)
import Types exposing (Msg(..), Filter(..), Product)
import Styles exposing (..)


view : Filter -> Element Styles variation Msg
view selected =
    let
        filters =
            [ All, Bundles, Leagues, Competitions, Other ]
    in
        row Styles.Filters [ justify ] (List.map (viewFilter selected) filters)


viewFilter : Filter -> Filter -> Element Styles variation Msg
viewFilter selected filter =
    let
        selectedStyle =
            if (selected == filter) then
                Styles.None
            else
                Styles.Filter
    in
        el selectedStyle
            [ padding 3, onClick (ChangeFilter filter) ]
            (text (toString filter))
