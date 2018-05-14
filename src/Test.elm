module Test exposing (main)

import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (height, style, width)
import Html.Events exposing (onClick)
import WebGL exposing (Mesh, Shader)


type alias Model =
    { offset : Float }


initialModel : Model
initialModel =
    { offset = 0 }


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | offset = model.offset + 1 }

        Decrement ->
            { model | offset = model.offset - 1 }


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Increment ] [ text "+1" ]
        , div [] [ text <| String.fromFloat model.offset ]
        , button [ onClick Decrement ] [ text "-1" ]
        , WebGL.toHtml
            [ width 400
            , height 400
            , style "display" "block"
            ]
            [ WebGL.entity
                vertexShader
                fragmentShader
                mesh
                { offset = model.offset }
            ]
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }


type alias Attributes =
    { x : Float
    , y : Float
    , z : Float
    }


type alias Uniforms =
    { offset : Float }


mesh : Mesh Attributes
mesh =
    WebGL.triangles
        [ ( Attributes 0 0 0
          , Attributes 1 1 0
          , Attributes 1 -1 0
          )
        ]



-- Shaders


vertexShader : Shader Attributes Uniforms {}
vertexShader =
    [glsl|
        precision mediump float;
        attribute float x;
        attribute float y;
        attribute float z;
        uniform float offset;
        void main () {
            gl_Position = vec4(x + offset / 10.0, y, z, 1.0);
        }
    |]


fragmentShader : Shader {} Uniforms {}
fragmentShader =
    [glsl|
        precision mediump float;
        void main () {
            gl_FragColor = vec4(1.0, 0, 0, 1.0);
        }
    |]
