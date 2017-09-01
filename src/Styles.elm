module Styles exposing (..)

import Color
import Style exposing (..)
import Style.Border as Border
import Style.Color as Color
import Style.Font as Font


type Styles
    = None
    | Main
    | Filters
    | Filter
    | Products
    | Product
    | ProductHeader


stylesheet : StyleSheet Styles variation
stylesheet =
    Style.stylesheet
        [ style None [] -- It's handy to have a blank style
        , style Main
            [ Color.text Color.darkCharcoal
            , Color.background Color.white
            ]
        , style Filters
            [ Color.text Color.darkCharcoal
            , Color.background Color.white
            , Color.border Color.gray
            ]
        , style Filter
            [ Font.underline
            , cursor "pointer"
            ]
        , style Products
            []
        , style Product
            [ Border.all 1
            , Color.border Color.lightGray
            ]
        , style ProductHeader
            [ Color.background Color.lightGray
            , Font.weight 600
            ]
        ]
