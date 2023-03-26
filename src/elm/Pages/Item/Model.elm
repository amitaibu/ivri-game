module Pages.Item.Model exposing (..)

import Dict exposing (Dict)


type alias Country =
    { name : String
    , population : Int
    , flag : String
    }


countries : Dict Int Country
countries =
    [ ( 1, { name = "Israel", population = 6, flag = "🇮🇱" } )
    , ( 2, { name = "Canada", population = 10, flag = "🇨🇦" } )
    , ( 3, { name = "France", population = 20, flag = "🇫🇷" } )
    ]
        |> Dict.fromList


type alias Model =
    { countries : Dict Int Country
    }


emptyModel : Model
emptyModel =
    { countries = countries
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
