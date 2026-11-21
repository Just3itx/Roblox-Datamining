-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarViewport = script:FindFirstAncestor("AvatarViewport")
local AvatarViewportParent = AvatarViewport.Parent

local React = require(AvatarViewportParent.React)

local _Types = require(AvatarViewport.Types)

local function useAvatarViewportScene()
    local viewportFrame = React.useRef(nil)
    local worldModel = React.useRef(nil)
    local camera = React.useRef(nil)

    return React.useMemo(function()
        return { viewportFrame = viewportFrame, worldModel = worldModel, camera = camera }
    end, { viewportFrame, worldModel, camera })
end

return useAvatarViewportScene
