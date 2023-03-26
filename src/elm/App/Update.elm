module App.Update exposing
    ( init
    , subscriptions
    , update
    )

import App.Fetch exposing (fetch)
import App.Model exposing (..)
import App.Types exposing (Language(..), Page(..))
import App.Utils exposing (updateSubModel)
import Backend.Update
import Pages.Item.Update
import Task
import Time


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        activePage =
            resolveActivePage flags.page

        model =
            emptyModel
                |> (\model_ ->
                        { model_
                            | activePage = activePage
                        }
                   )

        cmds =
            fetch model
                |> List.map (Task.succeed >> Task.perform identity)
                |> List.append [ Task.perform SetCurrentDate Time.now ]
                |> Cmd.batch
    in
    ( model
      -- Let the Fetcher act upon the active page.
    , cmds
    )


resolveActivePage : String -> Page
resolveActivePage page =
    case page of
        "item" ->
            Item

        _ ->
            NotFound


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        MsgBackend subMsg ->
            updateSubModel
                subMsg
                model.backend
                (\subMsg_ subModel -> Backend.Update.updateBackend model.currentDate subMsg_ subModel)
                (\subModel model_ -> { model_ | backend = subModel })
                (\subCmds -> MsgBackend subCmds)
                model

        MsgItemPage subMsg ->
            updateSubModel
                subMsg
                model.itemPage
                (\subMsg_ subModel -> Pages.Item.Update.update model.backend subMsg_ subModel)
                (\subModel model_ -> { model_ | itemPage = subModel })
                (\subCmds -> MsgItemPage subCmds)
                model

        SetActivePage activePage ->
            ( { model | activePage = activePage }
            , Cmd.none
            )

        SetCurrentDate date ->
            ( { model | currentDate = date }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
