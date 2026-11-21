-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:21:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarViewport = script:FindFirstAncestor("AvatarViewport")
local AvatarViewportParent = AvatarViewport.Parent

local React = require(AvatarViewportParent.React)

local Constants = require(AvatarViewport.Constants)
local _Types = require(AvatarViewport.Types)

local function bindCurrentCamera(current, currentCamera) -- Luacid: Inlined by compiler; 2 call sites recovered
    if current and currentCamera then
        current.CurrentCamera = currentCamera
    end
end

local function AvatarViewportScene(tbl1)
    local refs = tbl1.refs
    local inputHandlers = tbl1.inputHandlers
    local var1 = tbl1.lighting
        or {
            ambient = Constants.DefaultAmbient,
            lightColor = Constants.DefaultLightColor,
            lightDirection = Constants.DefaultLightDirection
        }

    local ref = React.useCallback(function(current)
        refs.viewportFrame.current = current
        bindCurrentCamera(current, refs.camera.current)
    end, { refs })

    local var2 = React.useCallback(function(current)
        refs.camera.current = current
        bindCurrentCamera(refs.viewportFrame.current, current)
    end, { refs })

    return React.createElement("ViewportFrame", {
        Size = tbl1.size,
        BackgroundColor3 = tbl1.backgroundColor3,
        BackgroundTransparency = tbl1.backgroundTransparency or 0,
        BorderSizePixel = 0,
        Ambient = var1.ambient,
        LightColor = var1.lightColor,
        LightDirection = var1.lightDirection,
        Active = inputHandlers ~= nil,
        Selectable = false,
        [React.Event.InputBegan] = inputHandlers and inputHandlers.onInputBegan,
        [React.Event.InputChanged] = inputHandlers and inputHandlers.onInputChanged,
        [React.Event.InputEnded] = inputHandlers and inputHandlers.onInputEnded,
        [React.Event.TouchPinch] = inputHandlers and inputHandlers.onTouchPinch,
        ref = ref
    }, {
        WorldModel = React.createElement("WorldModel", { ref = refs.worldModel }),
        Camera = React.createElement("Camera", { CameraType = Enum.CameraType.Scriptable, ref = var2 })
    })
end

return AvatarViewportScene
