module Pages.Item.View exposing (view)

import App.Types exposing (Language)
import Backend.Model exposing (ModelBackend)
import Dict
import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Pages.Item.Model exposing (Country, CountryState(..), Model, Msg(..))


view : Language -> ModelBackend -> Model -> Html Msg
view language modelBackend model =
    div [ class "bg-gray-50 py-10" ]
        [ div [ class "grid grid-rows-2 max-w-3xl mx-auto" ]
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
        |> Dict.toList
        |> List.map (\( countryId, country ) -> li [] (viewCountry ( countryId, country )))
        |> ol [ class "list-decimal" ]


viewCountry : ( Int, Country ) -> List (Html Msg)
viewCountry ( countryId, country ) =
    let
        name =
            [ text country.flag, text " ", text country.name, text " " ]
    in
    case country.countryState of
        Independent ->
            [ text "🕊️ (Independent)", viewCountryStateButton ( countryId, country ) ]
                |> List.append name

        Conquered ->
            [ text "⚔️ (Conquered)", viewCountryStateButton ( countryId, country ) ]
                |> List.append name


viewCountryStateButton : ( Int, Country ) -> Html Msg
viewCountryStateButton ( countryId, country ) =
    case country.countryState of
        Independent ->
            button
                [ class "bg-red-300 p-2"
                , onClick <| SetCountryState countryId Conquered
                ]
                [ text "Change to Conquered" ]

        Conquered ->
            button
                [ class "bg-green-300 p-2"
                , onClick <| SetCountryState countryId Independent
                ]
                [ text "Change to Independent" ]


viewPlayers : Model -> Html Msg
viewPlayers model =
    model.players
        |> Dict.values
        |> List.map (\player -> li [] [ text player.name ])
        |> ol [ class "list-decimal" ]
