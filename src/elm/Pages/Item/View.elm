module Pages.Item.View exposing (view)

import App.Types exposing (Language)
import Backend.Model exposing (ModelBackend)
import Dict
import Html exposing (..)
import Html.Attributes exposing (class, classList)
import Html.Events exposing (onClick)
import Pages.Item.Model exposing (Country, CountryState(..), Model, Msg(..), Player)


view : Language -> ModelBackend -> Model -> Html Msg
view language modelBackend model =
    div []
        [ div [ class "bg-gray-50 px-5 md:px-10 py-10" ]
            [ div [ class "grid grid-cols-1 md:grid-cols-2 gap-8 md:max-w-3xl mx-auto" ]
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
        ]


viewCountries : Model -> Html Msg
viewCountries model =
    model.countries
        |> Dict.toList
        |> List.map (\( countryId, country ) -> li [ class "flex flex-row gap-4 items-center" ] (viewCountry model ( countryId, country )))
        |> ol [ class "list-decimal flex flex-col gap-y-6" ]


viewCountry : Model -> ( Int, Country ) -> List (Html Msg)
viewCountry model ( countryId, country ) =
    let
        name =
            [ text country.flag, text " ", text country.name, text " " ]
    in
    case country.countryState of
        Independent ->
            [ text "🕊️", viewCountryStateButton model.selectedPlayer ( countryId, country ) ]
                |> List.append name

        Conquered playerId ->
            let
                playerName =
                    Dict.get playerId model.players
                        |> Maybe.map (\player -> player.name)
                        |> Maybe.withDefault ""
            in
            [ text <| "⚔️ - Conquered by " ++ playerName, viewCountryStateButton model.selectedPlayer ( countryId, country ) ]
                |> List.append name


viewCountryStateButton : Maybe Int -> ( Int, Country ) -> Html Msg
viewCountryStateButton maybeSelectedPlayer ( countryId, country ) =
    case country.countryState of
        Independent ->
            case maybeSelectedPlayer of
                Nothing ->
                    text "Please select a player"

                Just playerId ->
                    button
                        [ class "bg-red-300 py-2 px-4 rounded-full border border-red-400"
                        , onClick <| SetCountryState countryId <| Conquered playerId
                        ]
                        [ text "Change to Conquered" ]

        Conquered playerId ->
            button
                [ class "bg-green-300 py-2 px-4 rounded-full border border-green-400"
                , onClick <| SetCountryState countryId Independent
                ]
                [ text "Change to Independent" ]


viewPlayers : Model -> Html Msg
viewPlayers model =
    model.players
        |> Dict.toList
        |> List.map (\( playerId, player ) -> li [] [ viewPlayerButton model.selectedPlayer ( playerId, player ) ])
        |> ol [ class "list-decimal" ]


viewPlayerButton : Maybe Int -> ( Int, Player ) -> Html Msg
viewPlayerButton maybeSelectedPlayer ( playerId, player ) =
    button
        [ classList
            [ ( "py-2 px-4 rounded-full border border-green-400", True )
            , ( "bg-blue-300", maybeSelectedPlayer == Just playerId )
            , ( "bg-green-300", maybeSelectedPlayer /= Just playerId )
            ]
        , onClick <| SetSelectedPlayer <| Just playerId
        ]
        [ text player.name ]
