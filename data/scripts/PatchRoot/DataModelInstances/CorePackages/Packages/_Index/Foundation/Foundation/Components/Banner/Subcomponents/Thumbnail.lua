-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:00:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local _BuilderIcons = require(FoundationParent.BuilderIcons)
local React = require(FoundationParent.React)

local Avatar = require(Foundation.Components.Avatar)
local Icon = require(Foundation.Components.Icon)
local Image = require(Foundation.Components.Image)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local useTokens = require(Foundation.Providers.Style.useTokens)

local AvatarSize = require(Foundation.Enums.AvatarSize)
local CardDensity = require(Foundation.Enums.CardDensity)
local IconSize = require(Foundation.Enums.IconSize)
local _UserPresence = require(Foundation.Enums.UserPresence)

local function Thumbnail(tbl1)
    local var1 = useTokens()
    local var2 = if tbl1.density == CardDensity.Compact then var1.Size.Size_1200 else var1.Size.Size_1600
    local thumbnail = tbl1.thumbnail
    local element

    if thumbnail.type == "Avatar" then
        element = React.createElement(Avatar, {
            userId = thumbnail.userId,
            size = if tbl1.density == CardDensity.Compact then AvatarSize.Large else AvatarSize.XLarge,
            userPresence = thumbnail.userPresence,
            testId = `{tbl1.testId}--thumbnail-avatar`
        })
    elseif thumbnail.type == "Image" then
        element = React.createElement(Image, {
            Image = thumbnail.image,
            ScaleType = Enum.ScaleType.Crop,
            tag = "size-full radius-medium",
            testId = `{tbl1.testId}--thumbnail-image`
        })
    elseif thumbnail.type == "Icon" then
        element = React.createElement(Icon, {
            name = if typeof(thumbnail.icon) == "table" then thumbnail.icon.name else thumbnail.icon,
            variant = if typeof(thumbnail.icon) == "table" then thumbnail.icon.variant else nil,
            size = IconSize.Large,
            testId = `{tbl1.testId}--thumbnail-icon`
        })
    else
        element = React.createElement(
            View,
            {
                tag = "align-x-center align-y-center size-full clip",
                testId = `{tbl1.testId}--thumbnail-slot`
            },
            thumbnail.children
        )
    end

    return React.createElement(View, {
        tag = "align-x-center align-y-center",
        Size = UDim2.fromOffset(var2, var2),
        LayoutOrder = tbl1.LayoutOrder,
        testId = `{tbl1.testId}--thumbnail`
    }, { Content = element })
end

return Thumbnail
