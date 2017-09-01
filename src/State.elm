module State exposing (..)

import RemoteData exposing (WebData)
import Types exposing (Msg(..), Model, Filter(..))


initialModel : Model
initialModel =
    { filter = All
    , products = RemoteData.Loading
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnFetchProducts response ->
            ( { model | products = response }, Cmd.none )

        ChangeFilter filter ->
            ( { model | filter = filter }, Cmd.none )
