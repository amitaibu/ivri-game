module Translate exposing
    ( StringIdHttpError(..)
    , TranslationId(..)
    , translate
    )

import App.Types exposing (Language(..))


type alias TranslationSet =
    { english : String
    }


type StringIdHttpError
    = ErrorBadUrl
    | ErrorBadStatus Int
    | ErrorNetworkError
    | ErrorTimeout
    | ErrorBadBody String


type TranslationId
    = HttpError StringIdHttpError


{-| Main function to call for translation.
-}
translate : Language -> TranslationId -> String
translate language trans =
    let
        translationSet =
            case trans of
                HttpError val ->
                    translateHttpError val
    in
    case language of
        English ->
            .english translationSet


translateHttpError : StringIdHttpError -> TranslationSet
translateHttpError transId =
    case transId of
        ErrorBadUrl ->
            { english = "URL is not valid."
            }

        ErrorBadBody message ->
            { english = "The server responded with data of an unexpected type: " ++ message
            }

        ErrorBadStatus int ->
            { english = String.fromInt int
            }

        ErrorNetworkError ->
            { english = "There was a network error."
            }

        ErrorTimeout ->
            { english = "The network request timed out."
            }
