module App.Fetch exposing (fetch)

import App.Model exposing (..)
import App.Types exposing (Page(..))
import Pages.Item.Fetch


fetch : Model -> List Msg
fetch model =
    case model.activePage of
        Item ->
            Pages.Item.Fetch.fetch model.backend model.itemPage
                |> List.map (\subMsg -> MsgBackend subMsg)

        _ ->
            []
