-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent
local _RobloxAppHooks = require(AuthCommonParent.RobloxAppHooks)

local _Style = require(AuthCommonParent.Style)

return function(_, arg1)
    return {
        robloxLogoTextImageUrl = "rbxasset://textures/ui/LuaApp/graphic/Auth/logo_white_1x.png",
        robloxLogoTextImageSize = UDim2.new(0, 476, 0, 88),
        robloxLogoTextImagePosition = UDim2.new(0.5, 0, 0.28, 0),
        buttonContainerPosition = UDim2.new(0.5, 0, 0.58, 0),
        containerWidth = 846,
        containerHeight = 300,
        dividerWidth = 640,
        dividerHeight = 60,
        dividerPadding = 3,
        buttonPadding = arg1.Size.Size_150
    }
end
