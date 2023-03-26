module Pages.Item.View exposing (view)

import App.Types exposing (Language)
import Backend.Model exposing (ModelBackend)
import Dict
import Html exposing (..)
import Html.Attributes exposing (class)
import Pages.Item.Model exposing (Model, Msg(..))


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
        |> List.map (\country -> li [] [ text country.flag, text " ", text country.name ])
        |> ol [ class "list-decimal" ]


viewPlayers : Model -> Html Msg
viewPlayers model =
    model.players
        |> Dict.values
        |> List.map (\player -> li [] [ text player.name ])
        |> ol [ class "list-decimal" ]
