-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local ShareGame = RobloxGui.Modules.Settings.Pages.ShareGame
local RectangleButton = require(ShareGame.Components.RectangleButton)
local IconButton = require(ShareGame.Components.IconButton)
local Roact = require(CorePackages.Packages.Roact)

local Constants = require(ShareGame.Constants)
local ShareGameIcons = require(RobloxGui.Modules.Settings.Pages.ShareGame.Spritesheets.ShareGameIcons)
local Theme = require(RobloxGui.Modules.Settings.Theme)

local var1 = require(ShareGame.getTranslator)()

local var2 = Roact.PureComponent:extend("BackButton")
var2.IconType = { Arrow = "Arrow", Cross = "Cross", None = "None" }

var2.defaultProps = {
    iconType = var2.IconType.None
}

local tbl1 = {
    [var2.IconType.Arrow] = "back",
    [var2.IconType.Cross] = "cross"
}

local function func1(props)
    local iconType = props.iconType
    local visible = props.visible
    local anchorPoint = props.anchorPoint
    local position = props.position
    local size = props.size
    local zIndex = props.zIndex
    local onClick = props.onClick

    local var3 = tbl1[iconType]
    if not var3 then
        return
    end

    local iconSpritePath = ShareGameIcons:GetImagePath()
    local iconSpriteFrame = ShareGameIcons:GetFrame(var3)

    return Roact.createElement(IconButton, {
        visible = visible,
        anchorPoint = anchorPoint,
        position = position,
        size = size,
        zIndex = zIndex,
        onClick = onClick,
        iconHorizontalAlignment = Enum.HorizontalAlignment.Left,
        iconSpritePath = iconSpritePath,
        iconSpriteFrame = iconSpriteFrame
    })
end

function var2.render(arg1)
    local iconType = arg1.props.iconType
    local zIndex = arg1.props.zIndex

    if iconType ~= var2.IconType.None then
        return func1(arg1.props)
    end

    return Roact.createElement(RectangleButton, arg1.props, {
        TextLabel = Roact.createElement("TextLabel", {
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Text = var1:FormatByKey("Feature.SettingsHub.Action.InviteFriendsBack"),
            TextSize = Theme.textSize(24, "BackButton"),
            TextColor3 = Constants.Color.WHITE,
            Font = Theme.font(Enum.Font.SourceSansSemibold, "BackButton"),
            ZIndex = zIndex
        })
    })
end
return var2
