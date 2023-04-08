module Pages.Item.Update exposing (update)

import App.Model exposing (PagesReturn)
import Backend.Model exposing (ModelBackend)
import Dict
import Error.Utils exposing (noError)
import Pages.Item.Model exposing (Model, Msg(..))


update : ModelBackend -> Msg -> Model -> PagesReturn Model Msg
update modelBackend msg model =
    let
        noChange =
            PagesReturn
                model
                Cmd.none
                noError
                []
    in
    case msg of
        SetCountryState countryId countryState ->
            case Dict.get countryId model.countries of
                Nothing ->
                    noChange

                Just country ->
                    let
                        countryUpdated =
                            { country | countryState = countryState }

                        countriesUpdated =
                            Dict.insert countryId countryUpdated model.countries
                    in
                    PagesReturn
                        { model | countries = countriesUpdated }
                        Cmd.none
                        noError
                        []

        SetSelectedPlayer maybeSelectedPlayer ->
            PagesReturn
                { model | selectedPlayer = maybeSelectedPlayer }
                Cmd.none
                noError
                []
