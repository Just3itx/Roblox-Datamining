-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:21:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent
local React = require(ServerDrivenUiParent.React)
local useTokens = require(ServerDrivenUiParent.Foundation).Hooks.useTokens
local Cryo = require(ServerDrivenUiParent.Cryo)

local SduiTile = require(ServerDrivenUi.Content.SduiTile)

return React.memo(function(arg1) -- name: SduiBadgeTile
    local var1 = useTokens()
    local imageCornerRadius = arg1.imageCornerRadius or 1000
    local imagePadding = arg1.imagePadding or var1.Padding.Medium

    local isContained = arg1.isContained == nil or arg1.isContained

    local var4 = Cryo.Dictionary.join(arg1, {
        testId = "--sdui-badge-tile",
        imagePadding = imagePadding,
        imageCornerRadius = imageCornerRadius,
        isContained = isContained
    })

    return React.createElement(SduiTile, var4)
end)
