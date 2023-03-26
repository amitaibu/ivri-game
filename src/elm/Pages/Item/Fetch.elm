module Pages.Item.Fetch exposing (fetch)

import Backend.Model
import Pages.Item.Model exposing (Model)


fetch : Backend.Model.ModelBackend -> Model -> List Backend.Model.Msg
fetch modelBackend model =
    []
