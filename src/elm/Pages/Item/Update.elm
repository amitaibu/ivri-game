module Pages.Item.Update exposing (update)

import App.Model exposing (PagesReturn)
import Backend.Model exposing (ModelBackend)
import Error.Utils exposing (noError)
import Pages.Item.Model exposing (Model, Msg(..))


update : ModelBackend -> Msg -> Model -> PagesReturn Model Msg
update modelBackend msg model =
    case msg of
        NoOp ->
            PagesReturn
                model
                Cmd.none
                noError
                []
