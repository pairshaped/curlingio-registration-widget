module Styles exposing (..)


root : List ( String, String )
root =
    [ ( "display", "flex" )
    , ( "flex-direction", "column" )
    ]


filters : List ( String, String )
filters =
    [ ( "display", "flex" )
    , ( "margin-bottom", "10px" )
    ]


filter : List ( String, String )
filter =
    [ ( "margin-right", "10px" )
    , ( "text-decoration", "underline" )
    , ( "cursor", "pointer" )
    ]


products : List ( String, String )
products =
    []


productContainer : List ( String, String )
productContainer =
    [ ( "display", "flex" )
    , ( "flex-direction", "column" )
    , ( "border", "1px solid #eee" )
    , ( "text-decoration", "none" )
    , ( "margin-bottom", "10px" )
    ]


productHeader : List ( String, String )
productHeader =
    [ ( "display", "flex" )
    , ( "justify-content", "space-between" )
    , ( "padding", "5px" )
    , ( "background", "#eee" )
    ]


productBody : List ( String, String )
productBody =
    [ ( "padding", "5px" )
    , ( "color", "#333" )
    , ( "font-weight", "normal" )
    ]
