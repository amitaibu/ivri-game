module Pages.Item.View exposing (view)

import App.Types exposing (Language)
import Backend.Model exposing (ModelBackend)
import Dict
import Html exposing (..)
import Html.Attributes exposing (class)
import Pages.Item.Model exposing (Country, CountryState(..), Model, Msg(..))


view : Language -> ModelBackend -> Model -> Html Msg
view language modelBackend model =
    div [ class "bg-gray-200 py-10" ]
        [ div [ class "grid grid-cols-2 max-w-3xl mx-auto" ]
            [ div []
                [ h2 [ class "font-bold" ] [ text "Countries" ]
                , div [] [ viewCountries model ]
                ]
            , div []
                [ h2 [ class "font-bold" ] [ text "Players" ]
                , div [] [ viewPlayers model ]
                ]
            ]
        ]


viewCountries : Model -> Html Msg
viewCountries model =
    model.countries
        |> Dict.values
        |> List.map (\country -> li [] (viewCountry country))
        |> ol [ class "list-decimal" ]


viewCountry : Country -> List (Html Msg)
viewCountry country =
    let
        name =
            [ text country.flag, text " ", text country.name, text " " ]
    in
    case country.countryState of
        Independent ->
            [ text "🕊️ (Independent)" ]
                |> List.append name

        Conquered ->
            [ text "⚔️ (Conquered)" ]
                |> List.append name


viewPlayers : Model -> Html Msg
viewPlayers model =
    model.players
        |> Dict.values
        |> List.map (\player -> li [] [ text player.name ])
        |> ol [ class "list-decimal" ]
