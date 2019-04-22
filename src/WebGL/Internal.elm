module WebGL.Internal exposing
    ( Option(..)
    , Setting(..)
    , disableSetting
    , enableOption
    , enableSetting
    )

import Elm.Kernel.WebGL


type Option
    = Alpha Bool
    | Depth Float
    | Stencil Int
    | Antialias
    | ClearColor Float Float Float Float
    | PreserveDrawingBuffer


enableOption : () -> Option -> ()
enableOption ctx option =
    case option of
        Alpha _ ->
            Elm.Kernel.WebGL.enableAlpha ctx option

        Depth _ ->
            Elm.Kernel.WebGL.enableDepth ctx option

        Stencil _ ->
            Elm.Kernel.WebGL.enableStencil ctx option

        Antialias ->
            Elm.Kernel.WebGL.enableAntialias ctx option

        ClearColor _ _ _ _ ->
            Elm.Kernel.WebGL.enableClearColor ctx option

        PreserveDrawingBuffer ->
            Elm.Kernel.WebGL.enablePreserveDrawingBuffer ctx option


type Setting
    = Blend Int Int Int Int Int Int Float Float Float Float
    | DepthTest Int Bool Float Float
    | StencilTest Int Int Int Int Int Int Int Int Int Int Int
    | Scissor Int Int Int Int
    | ColorMask Bool Bool Bool Bool
    | CullFace Int
    | PolygonOffset Float Float
    | SampleCoverage Float Bool
    | SampleAlphaToCoverage


enableSetting : () -> Setting -> ()
enableSetting gl setting =
    case setting of
        Blend _ _ _ _ _ _ _ _ _ _ ->
            Elm.Kernel.WebGL.enableBlend gl setting

        DepthTest _ _ _ _ ->
            Elm.Kernel.WebGL.enableDepthTest gl setting

        StencilTest _ _ _ _ _ _ _ _ _ _ _ ->
            Elm.Kernel.WebGL.enableStencilTest gl setting

        Scissor _ _ _ _ ->
            Elm.Kernel.WebGL.enableScissor gl setting

        ColorMask _ _ _ _ ->
            Elm.Kernel.WebGL.enableColorMask gl setting

        CullFace _ ->
            Elm.Kernel.WebGL.enableCullFace gl setting

        PolygonOffset _ _ ->
            Elm.Kernel.WebGL.enablePolygonOffset gl setting

        SampleCoverage _ _ ->
            Elm.Kernel.WebGL.enableSampleCoverage gl setting

        SampleAlphaToCoverage ->
            Elm.Kernel.WebGL.enableSampleAlphaToCoverage gl setting


disableSetting : () -> Setting -> ()
disableSetting gl setting =
    case setting of
        Blend _ _ _ _ _ _ _ _ _ _ ->
            Elm.Kernel.WebGL.disableBlend gl

        DepthTest _ _ _ _ ->
            Elm.Kernel.WebGL.disableDepthTest gl

        StencilTest _ _ _ _ _ _ _ _ _ _ _ ->
            Elm.Kernel.WebGL.disableStencilTest gl

        Scissor _ _ _ _ ->
            Elm.Kernel.WebGL.disableScissor gl

        ColorMask _ _ _ _ ->
            Elm.Kernel.WebGL.disableColorMask gl

        CullFace _ ->
            Elm.Kernel.WebGL.disableCullFace gl

        PolygonOffset _ _ ->
            Elm.Kernel.WebGL.disablePolygonOffset gl

        SampleCoverage _ _ ->
            Elm.Kernel.WebGL.disableSampleCoverage gl

        SampleAlphaToCoverage ->
            Elm.Kernel.WebGL.disableSampleAlphaToCoverage gl
