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
    ( { flags = flags, filter = "", items = Loading }, getItems flags.host flags.section )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeFilter filter ->
            ( { model | filter = filter }, Cmd.none )

        GotItems result ->
            case result of
                Ok items ->
                    ( { model | items = Success items }, Cmd.none )

                Err err ->
                    let
                        errorMessage =
                            case err of
                                Http.BadUrl string ->
                                    "Invalid URL used to fetch the " ++ model.flags.section ++ ": " ++ string

                                Http.Timeout ->
                                    "Network timeout when trying to fetch the " ++ model.flags.section ++ "."

                                Http.NetworkError ->
                                    "Network timeout when trying to fetch the " ++ model.flags.section ++ "."

                                Http.BadStatus int ->
                                    if List.member model.flags.section [ "leagues", "competitions", "products" ] then
                                        "Invalid response status from server when trying to fetch the " ++ model.flags.section ++ "."

                                    else
                                        "The section paramter passed is incorrect. \"" ++ model.flags.section ++ "\" is not a valid section."

                                Http.BadBody string ->
                                    "Invalid response body from server when trying to fetch the " ++ model.flags.section ++ ": " ++ string
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
        { url = host ++ "/" ++ section ++ ".json?season=current"
        , expect = Http.expectJson GotItems itemsDecoder
        }
