-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local React = require(CorePackages.Packages.React)
local t = require(CorePackages.Packages.t)
local VerifiedBadges = require(CorePackages.Workspace.Packages.VerifiedBadges)
local UserLib = require(CorePackages.Workspace.Packages.UserLib)
local Cryo = require(CorePackages.Packages.Cryo)

local scriptParentParentParent = script.Parent.Parent.Parent
local Connection = scriptParentParentParent.Components.Connection
local WithLayoutValues = require(Connection.LayoutValues).WithLayoutValues
local usePlayerCombinedName = require(scriptParentParentParent.Hooks.usePlayerCombinedName)
local createShallowEqualAndTables = require(scriptParentParentParent.createShallowEqualAndTables)
local FFlagPlayerListReduceRerenders = require(scriptParentParentParent.Flags.FFlagPlayerListReduceRerenders)
local useVerifiedBadge = require(CorePackages.Workspace.Packages.UserProfiles).Hooks.useVerifiedBadge
local FFlagEnableVerifiedBadgeStore = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableVerifiedBadgeStore

local playerInterface = require(RobloxGui.Modules.Interfaces.playerInterface)

local var1 = React.PureComponent:extend("PlayerNameTag")

var1.validateProps = t.strictInterface({
    player = playerInterface,
    isTitleEntry = t.boolean,
    isHovered = t.boolean,
    layoutOrder = t.integer,
    name = t.union(t.string, t.table),
    hasVerifiedBadge = t.optional(t.boolean),
    textStyle = t.strictInterface({
        Color = t.Color3,
        Transparency = t.number,
        StrokeColor = t.optional(t.Color3),
        StrokeTransparency = t.optional(t.number)
    }),
    textFont = t.strictInterface(
        {
            Size = t.number,
            MinSize = t.number,
            Font = t.enum(Enum.Font),
            FontFace = t.optional(t.typeof("Font"))
        }
    )
})

function var1.render(arg1)
    return WithLayoutValues(function(arg2)
        local iconUnSelectedColor = arg2.IconUnSelectedColor
        if arg1.props.isHovered then
            iconUnSelectedColor = arg2.IconSelectedColor
        end

        local fontFace = arg1.props.textFont.FontFace
        local textFontSize = arg1.props.textFont.Size

        local tbl1 = ({})
        local platformName = arg1.props.player.PlatformName
        local var2 = if FFlagEnableVerifiedBadgeStore then arg1.props.hasVerifiedBadge else UserLib.Utils.isPlayerVerified(arg1.props.player)

        if arg2.IsTenFoot and platformName ~= "" then
            tbl1.VerticalLayout = React.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Vertical,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                Padding = UDim.new(0, 10)
            })

            tbl1.PlayerPlatformName = React.createElement("TextLabel", {
                Position = UDim2.new(0, 0, 0, 0),
                Size = UDim2.new(1, 0, 0.35, 0),
                TextXAlignment = Enum.TextXAlignment.Left,
                Font = Enum.Font.SourceSans,
                TextSize = textFontSize,
                TextColor3 = arg1.props.textStyle.Color,
                TextTransparency = arg1.props.textStyle.Transparency,
                TextStrokeColor3 = arg1.props.textStyle.StrokeColor,
                TextStrokeTransparency = arg1.props.textStyle.StrokeTransparency,
                BackgroundTransparency = 1,
                Text = platformName,
                LayoutOrder = 2
            })

            tbl1.RobloxNameFrame = React.createElement(
                "Frame",
                {
                    Size = UDim2.new(1, 0, 0.45, 0),
                    BackgroundTransparency = 1,
                    LayoutOrder = 2
                },
                {
                    Layout = React.createElement("UIListLayout", {
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        FillDirection = Enum.FillDirection.Horizontal,
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        Padding = UDim.new(0, 6)
                    }),
                    RobloxIcon = React.createElement("ImageButton", {
                        Size = UDim2.new(0, 24, 0, 24),
                        Image = arg2.RobloxIconImage,
                        BackgroundTransparency = 1,
                        Selectable = false,
                        ImageColor3 = iconUnSelectedColor,
                        LayoutOrder = 1
                    }),
                    PlayerNameContainer = React.createElement(VerifiedBadges.EmojiWrapper, {
                        emoji = if var2 then VerifiedBadges.emoji.verified else "",
                        layoutOrder = 2,
                        mockIsEnrolled = true,
                        size = UDim2.new(1, -30, 0, 0),
                        automaticSize = Enum.AutomaticSize.Y,
                        verticalAlignment = Enum.VerticalAlignment.Center
                    }, {
                        PlayerName = React.createElement("TextLabel", {
                            AutomaticSize = Enum.AutomaticSize.X,
                            ClipsDescendants = false,
                            Size = UDim2.fromScale(0, 1),
                            FontFace = fontFace,
                            Text = arg1.props.name,
                            TextSize = textFontSize,
                            TextColor3 = arg1.props.textStyle.Color,
                            TextTransparency = arg1.props.textStyle.Transparency,
                            TextStrokeColor3 = arg1.props.textStyle.StrokeColor,
                            TextStrokeTransparency = arg1.props.textStyle.StrokeTransparency,
                            TextTruncate = Enum.TextTruncate.AtEnd,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            BackgroundTransparency = 1
                        })
                    })
                }
            )
        else
            tbl1.PlayerNameContainer = React.createElement(VerifiedBadges.EmojiWrapper, {
                emoji = if var2 then VerifiedBadges.emoji.verified else "",
                anchorPoint = Vector2.new(0, 0.5),
                position = UDim2.fromScale(0, 0.5),
                mockIsEnrolled = true,
                verticalAlignment = Enum.VerticalAlignment.Center,
                automaticSize = Enum.AutomaticSize.X,
                size = UDim2.new(0, 0, 0, textFontSize)
            }, {
                PlayerName = React.createElement("TextLabel", {
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2.fromScale(0, 1),
                    FontFace = fontFace,
                    Text = arg1.props.name,
                    TextSize = textFontSize,
                    TextColor3 = arg1.props.textStyle.Color,
                    TextTransparency = arg1.props.textStyle.Transparency,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    TextScaled = false,
                    TextStrokeColor3 = arg1.props.textStyle.StrokeColor,
                    TextStrokeTransparency = arg1.props.textStyle.StrokeTransparency,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BackgroundTransparency = 1
                })
            })
        end

        return React.createElement(
            "Frame",
            {
                LayoutOrder = arg1.props.layoutOrder,
                Size = arg2.PlayerNameSize,
                BackgroundTransparency = 1
            },
            tbl1
        )
    end)
end

local function PlayerNameTagContainer(tbl1)
    local name = usePlayerCombinedName(tostring(tbl1.player.UserId), tbl1.player.DisplayName)
    local var3 = if FFlagEnableVerifiedBadgeStore then useVerifiedBadge(tbl1.player) else nil
    local createElement = React.createElement
    local var4 = var1
    local join = Cryo.Dictionary.join
    local tbl2 = { name = name, hasVerifiedBadge = 0 }
    if not FFlagEnableVerifiedBadgeStore then
        var3 = nil
    end

    tbl2.hasVerifiedBadge = var3
    return createElement(var4, join(tbl1, tbl2))
end

if FFlagPlayerListReduceRerenders then
    return (React.memo(PlayerNameTagContainer, createShallowEqualAndTables({ "textFont" })))
end

return PlayerNameTagContainer
