-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:50:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local FriendsLandingParent = FriendsLanding.Parent
local dependencies = require(FriendsLanding.dependencies)

local HeaderBar = dependencies.UIBlox.App.Bar.HeaderBar

local useDesignTokens = require(FriendsLandingParent.Style).useDesignTokens

local GetFFlagFixConnectTabSearchBarHeight = dependencies.GetFFlagFixConnectTabSearchBarHeight

local React = require(FriendsLandingParent.React)

local FFlagAppThemeHalloween2026FriendsBackground = require(FriendsLandingParent.SharedFlags).FFlagAppThemeHalloween2026FriendsBackground
local useThemeBackground = require(FriendsLandingParent.ThemeBackground).useThemeBackground
local function FriendsLandingHeaderBarPresentational(arg1)
    local size2400 = useDesignTokens().Size.Size_2400
    local bool1 = if FFlagAppThemeHalloween2026FriendsBackground then useThemeBackground() ~= nil else false
    local createElement = React.createElement
    local str1 = "Frame"
    local tbl1 = {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, size2400),
        LayoutOrder = -1,
        ZIndex = 2
    }

    local tbl2 = {
        headerBar = React.createElement(HeaderBar, {
            title = arg1.title,
            barHeight = size2400,
            renderLeft = arg1.renderLeft,
            renderCenter = arg1.renderCenter,
            renderRight = arg1.renderRight,
            isSecondary = arg1.isSecondary,
            shouldHideSecondaryLeftItem = arg1.shouldHideSecondaryLeftItem,
            paddingTop = if GetFFlagFixConnectTabSearchBarHeight() then UDim.new(0, 0) else nil,
            paddingBottom = if GetFFlagFixConnectTabSearchBarHeight() then UDim.new(0, 0) else nil,
            backgroundTransparency = if bool1 then 1 else nil
        })
    }
    return createElement(str1, tbl1, tbl2)
end

return FriendsLandingHeaderBarPresentational
