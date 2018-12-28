module Main exposing (Item, Model(..), Msg(..), getItems, init, itemDecoder, itemsDecoder, main, subscriptions, update, view, viewItem, viewItems)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode exposing (Decoder, field, list, maybe, string)



-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type Msg
    = GotItems (Result Http.Error (List Item))


type alias Item =
    { name : String
    , summary : Maybe String
    , description : Maybe String
    , price : String
    , url : String
    }


type Model
    = Failure String
    | Loading
    | Success (List Item)


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
                                    "BadUrl " ++ string

                                Http.Timeout ->
                                    "Timeout"

                                Http.NetworkError ->
                                    "NetworkError"

                                Http.BadStatus int ->
                                    "BadStatus"

                                Http.BadBody string ->
                                    "BadBody " ++ string
                    in
                    ( Failure message, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ viewItems model ]


viewItems : Model -> Html Msg
viewItems model =
    case model of
        Failure message ->
            text message

        Loading ->
            text "Loading..."

        Success items ->
            div [] (List.map viewItem items)


viewItem : Item -> Html Msg
viewItem item =
    a
        [ href item.url, target "_blank" ]
        [ strong
            []
            [ div [] [ text item.name ]
            , div [] [ text item.price ]
            ]
        , div [] [ text (Maybe.withDefault "" item.summary) ]
        ]



-- HTTP


getItems : Cmd Msg
getItems =
    Http.get
        { url = "http://canada.curling.local:3000/en/api/v1/competitions"
        , expect = Http.expectJson GotItems itemsDecoder
        }


itemsDecoder : Decoder (List Item)
itemsDecoder =
    list itemDecoder


itemDecoder : Decoder Item
itemDecoder =
    Json.Decode.map5 Item
        (field "name" string)
        (maybe (field "summary" string))
        (maybe (field "description" string))
        (field "price" string)
        (field "url" string)
