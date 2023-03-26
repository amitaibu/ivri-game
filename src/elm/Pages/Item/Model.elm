module Pages.Item.Model exposing (..)

import Dict exposing (Dict)


type alias Country =
    { name : String
    , population : Int
    , flag : String
    }


type alias Player =
    { name : String
    , age : Int
    }


countries : Dict Int Country
countries =
    [ ( 1, { name = "Israel", population = 6, flag = "🇮🇱" } )
    , ( 2, { name = "Canada", population = 10, flag = "🇨🇦" } )
    , ( 3, { name = "France", population = 20, flag = "🇫🇷" } )
    ]
        |> Dict.fromList


players : Dict Int Player
players =
    [ ( 1, { name = "Ivri", age = 10 } )
    , ( 2, { name = "Ye'ela", age = 13 } )
    , ( 3, { name = "Aya", age = 10 } )
    ]
        |> Dict.fromList


type alias Model =
    { countries : Dict Int Country
    , players : Dict Int Player
    }


emptyModel : Model
emptyModel =
    { countries = countries
    , players = players
    }


type Msg
    = NoOp


juji : Int
juji =
    5


ivri : String
ivri =
    "I love Daddy"


imushHappy : Bool
imushHappy =
    True


imsushMad : Bool
imsushMad =
    False


abushCannotDecide : List Int
abushCannotDecide =
    [ 1, 5, 10, 100 ]


q1 : List String
q1 =
    [ "hi", "ivri", "shalom" ]



--countries : List ( Int, String )
--countries =
--    [ ( 1, "Israel" )
--    , ( 2, "Canada" )
--    , ( 3, "France" )
--    ]
