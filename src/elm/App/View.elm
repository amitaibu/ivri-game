module App.View exposing (view)

import App.Model exposing (..)
import App.Types exposing (Page(..))
import Error.View
import Html exposing (..)
import Pages.Item.View


view : Model -> Html Msg
view model =
    case model.activePage of
        Item ->
            div []
                [ Error.View.view model.language model.errors
                , Html.map MsgItemPage <|
                    Pages.Item.View.view
                        model.language
                        model.backend
                        model.itemPage
                ]

        _ ->
            div []
                [ text "Wrong page?"
                ]
