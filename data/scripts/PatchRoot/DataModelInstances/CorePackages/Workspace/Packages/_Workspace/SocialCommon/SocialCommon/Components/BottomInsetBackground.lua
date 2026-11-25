-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCommonParent = script:FindFirstAncestor("SocialCommon").Parent

local React = require(SocialCommonParent.React)
local UIBlox = require(SocialCommonParent.UIBlox)
local RoactUtils = require(SocialCommonParent.RoactUtils)

local FFlagAppThemeHalloween2026FriendsBackground = require(SocialCommonParent.SharedFlags).FFlagAppThemeHalloween2026FriendsBackground
local useThemeBackground = require(SocialCommonParent.ThemeBackground).useThemeBackground

local useStyle = UIBlox.Core.Style.useStyle
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector

return function()
    local var1 = useStyle()
    local bool1 = if FFlagAppThemeHalloween2026FriendsBackground then useThemeBackground() ~= nil else false

    local yOffset = useSelector(function(arg1)
        return if arg1.GlobalGuiInset then arg1.GlobalGuiInset.bottom else 0
    end)

    return React.createElement("Frame", {
        BackgroundColor3 = var1.Theme.BackgroundDefault.Color,
        BackgroundTransparency = if bool1 then 1 else var1.Theme.BackgroundDefault.Transparency,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 1, 0),
        Size = UDim2.new(1, 0, 0, yOffset),
        ZIndex = 3
    })
end
