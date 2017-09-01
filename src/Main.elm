module Main exposing (..)

import Html exposing (programWithFlags)
import Rest exposing (fetchProducts)
import Types exposing (Flags, Msg, Model)
import State exposing (initialModel, update)
import View exposing (view)


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( initialModel, (fetchProducts flags.accessKey) )


main : Program Flags Model Msg
main =
    programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
