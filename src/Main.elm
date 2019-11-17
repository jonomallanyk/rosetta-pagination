module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


-- MODEL

type alias Model =
    { itemCount : Int 
    , items : List String
    }


initialModel : Model
initialModel =
    { itemCount = 200 
    , items = []
    }


-- UDPATE

type Msg
    = NoOp
    | ClickedGenerateItems


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

        ClickedGenerateItems ->
            let
                newItems =
                    createList model.itemCount []
            in
                { model 
                    | items = newItems
                }


-- Generate Lists

createList : Int -> List String -> List String
createList count list =
    let
        newItem =
            numberItem (List.length list) "Item"
    in
        case count >= 1 of
            False ->
                list

            True ->
                createList (count - 1) (List.append list [ newItem ])

numberItem : Int -> String -> String
numberItem int str =
    let
        increasedNumber =
            int + 1
    in
        str ++ " " ++ (String.fromInt increasedNumber)


-- VIEW

view : Model -> Html Msg
view model =
   div []
        [ text ("Items = " ++ (String.fromInt model.itemCount))
        , button
            [ onClick ClickedGenerateItems ]
            [ text "Generate Items" ]
        ]
        
main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
