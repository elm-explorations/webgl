module IndexedTriangles exposing (main)

{-
   This module fills the canvas with many tiny triangles.

   It is used to test WebGL.indexedTriangles

   With OES_element_index_uint extension we can support
   element indices that are bigger than 65536
-}

import Html exposing (Html)
import Html.Attributes exposing (height, style, width)
import Math.Vector2 exposing (Vec2, vec2)
import Math.Vector3 exposing (Vec3, vec3)
import WebGL exposing (Mesh, Shader)


main : Html msg
main =
    WebGL.toHtml
        [ width 400
        , height 400
        , style "display" "block"
        ]
        [ WebGL.entity
            vertexShader
            fragmentShader
            mesh
            {}
        ]



-- Mesh


type alias Vertex =
    { position : Vec2
    , color : Vec3
    }


scale : Int
scale =
    let
        -- this is the limit of WebGL 1.0
        maxNumberOfIndices =
            65536
    in
    round (sqrt (toFloat maxNumberOfIndices)) + 1


mesh : Mesh Vertex
mesh =
    let
        dimension =
            List.range 0 scale

        vertices =
            List.foldl
                (\i result ->
                    List.foldl
                        (\j ->
                            let
                                x =
                                    toFloat i / toFloat scale * 2 - 1

                                y =
                                    toFloat j / toFloat scale * 2 - 1
                            in
                            (::)
                                { position = vec2 x y
                                , color =
                                    if modBy 2 i == 1 then
                                        vec3 1 0 0

                                    else if modBy 2 j == 1 then
                                        vec3 0 1 0

                                    else
                                        vec3 0 0 1
                                }
                        )
                        result
                        dimension
                )
                []
                dimension

        dimensionsToIndex i j =
            i * (scale + 1) + j

        indices =
            List.foldl
                (\i result ->
                    List.foldl
                        (\j ->
                            (++)
                                [ ( dimensionsToIndex (i - 1) (j - 1)
                                  , dimensionsToIndex i (j - 1)
                                  , dimensionsToIndex (i - 1) j
                                  )
                                , ( dimensionsToIndex i (j - 1)
                                  , dimensionsToIndex i j
                                  , dimensionsToIndex (i - 1) j
                                  )
                                ]
                        )
                        result
                        (List.drop 1 dimension)
                )
                []
                (List.drop 1 dimension)
    in
    WebGL.indexedTriangles (Debug.log "v" vertices) (Debug.log "i" indices)



-- Shaders


vertexShader : Shader Vertex {} { vcolor : Vec3 }
vertexShader =
    [glsl|

        attribute vec2 position;
        attribute vec3 color;
        varying vec3 vcolor;

        void main () {
            gl_Position = vec4(position, 0.0, 1.0);
            vcolor = color;
        }

    |]


fragmentShader : Shader {} {} { vcolor : Vec3 }
fragmentShader =
    [glsl|

        precision mediump float;
        varying vec3 vcolor;

        void main () {
            gl_FragColor = vec4(vcolor, 1.0);
        }

    |]
