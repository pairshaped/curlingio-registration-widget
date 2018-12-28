module Main exposing (getItems, init, main, subscriptions, update)

import Browser
import Http
import Types exposing (..)
import View exposing (view)



-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Loading, getItems )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotItems result ->
            case result of
                Ok items ->
                    ( Success items, Cmd.none )

                Err err ->
                    let
                        message =
                            case err of
                                Http.BadUrl string ->
                                    "Bad URL: " ++ string

                                Http.Timeout ->
                                    "Timeout"

                                Http.NetworkError ->
                                    "Network Error"

                                Http.BadStatus int ->
                                    "Bad Status"

                                Http.BadBody string ->
                                    "Bad Body: " ++ string
                    in
                    ( Failure message, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- HTTP


getItems : Cmd Msg
getItems =
    Http.get
        { url = "http://canada.curling.local:3000/en/api/v1/competitions"
        , expect = Http.expectJson GotItems itemsDecoder
        }
