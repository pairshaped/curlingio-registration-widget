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


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { flags = flags, items = Loading }, getItems flags.host flags.section )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotItems result ->
            case result of
                Ok items ->
                    ( { model | items = Success items }, Cmd.none )

                Err err ->
                    let
                        errorMessage =
                            case err of
                                Http.BadUrl string ->
                                    "Invalid URL used to fetch data: " ++ string

                                Http.Timeout ->
                                    "Network Timeout when trying to fetch data."

                                Http.NetworkError ->
                                    "Network Error when trying to fetch data."

                                Http.BadStatus int ->
                                    if List.member model.flags.section [ "leagues", "competitions", "products" ] then
                                        "Invalid response status from server"

                                    else
                                        "The section paramter passed is incorrect. \"" ++ model.flags.section ++ "\" is not a valid section."

                                Http.BadBody string ->
                                    "Invalid response body from server: " ++ string
                    in
                    ( { model | items = Failure errorMessage }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- HTTP


getItems : String -> String -> Cmd Msg
getItems host section =
    Http.get
        { url = host ++ "/" ++ section ++ ".json"
        , expect = Http.expectJson GotItems itemsDecoder
        }
