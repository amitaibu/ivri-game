module App.Model exposing
    ( Flags
    , Model
    , Msg(..)
    , PagesReturn
    , emptyModel
    )

import App.Types exposing (Language(..), Page(..))
import Backend.Model
import Error.Model exposing (Error)
import Json.Decode exposing (Value)
import Pages.Item.Model
import Time


type alias PagesReturn subModel subMsg =
    { model : subModel
    , cmd : Cmd subMsg
    , error : Maybe Error
    , appMsgs : List Msg
    }


type Msg
    = MsgBackend Backend.Model.Msg
    | MsgItemPage Pages.Item.Model.Msg
    | NoOp
    | SetActivePage Page
    | SetCurrentDate Time.Posix


type alias Flags =
    { page : String
    }


type alias Model =
    { backend : Backend.Model.ModelBackend
    , errors : List Error
    , language : Language
    , activePage : Page
    , currentDate : Time.Posix
    , itemPage : Pages.Item.Model.Model
    }


emptyModel : Model
emptyModel =
    { backend = Backend.Model.emptyModelBackend
    , errors = []
    , language = English
    , activePage = NotFound
    , currentDate = Time.millisToPosix 0
    , itemPage = Pages.Item.Model.emptyModel
    }
