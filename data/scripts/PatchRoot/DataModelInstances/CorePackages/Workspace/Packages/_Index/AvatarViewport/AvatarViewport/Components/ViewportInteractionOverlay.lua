-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarViewport = script:FindFirstAncestor("AvatarViewport")
local AvatarViewportParent = AvatarViewport.Parent

local React = require(AvatarViewportParent.React)

local _Types = require(AvatarViewport.Types)

local function ViewportInteractionOverlay(tbl1)
    return React.createElement("Frame", {
        Name = tbl1.name or "InteractionOverlay",
        Size = tbl1.size,
        Position = tbl1.position,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Active = true,
        Selectable = false,
        ZIndex = tbl1.zIndex,
        [React.Event.InputBegan] = tbl1.inputHandlers.onInputBegan,
        [React.Event.InputChanged] = tbl1.inputHandlers.onInputChanged,
        [React.Event.InputEnded] = tbl1.inputHandlers.onInputEnded,
        [React.Event.TouchPinch] = tbl1.inputHandlers.onTouchPinch
    })
end

return ViewportInteractionOverlay
