module Styles exposing (item, itemBody, itemName, itemPrice, items)

import Html.Attributes exposing (style)



-- container : String -> String
-- container =
--     [ style "display" "flex"
--     , style "flex-direction" "column"
--     ]
--


items : List ( String, String )
items =
    []


item : List ( String, String )
item =
    [ ( "display", "flex" )
    , ( "flex-direction", "column" )
    , ( "border", "1px solid #eee" )
    , ( "text-decoration", "none" )
    , ( "margin-bottom", "10px" )
    ]


itemName : List ( String, String )
itemName =
    []


itemPrice : List ( String, String )
itemPrice =
    []


itemBody : List ( String, String )
itemBody =
    [ ( "padding", "5px" )
    , ( "color", "#333" )
    , ( "font-weight", "normal" )
    ]
