-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local UserInputService = game:GetService("UserInputService")
local React = require(CorePackages.Packages.React)

local VerifiedBadges = require(CorePackages.Workspace.Packages.VerifiedBadges)

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local UIBlox = InGameMenuDependencies.UIBlox
local Cryo = InGameMenuDependencies.Cryo
local t = InGameMenuDependencies.t

local Cell = UIBlox.App.Table.Cell
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local Foundation = require(CorePackages.Packages.Foundation)
local Image = Foundation.Image
local FFlagCoreUiMigrateUIBloxToFoundation = require(CorePackages.Workspace.Packages.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation
local LoadableImage = UIBlox.App.Loading.LoadableImage
local LoadingStrategy = UIBlox.App.Loading.Enum.LoadingStrategy
local Images = UIBlox.App.ImageSet.Images
local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle
local var1 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.UNSTABLE.withCursorMigration else UIBlox.App.SelectionImage.withSelectionCursorProvider
local scriptParentParent = script.Parent.Parent
local Assets = require(scriptParentParent.Resources.Assets)
local ThemedTextLabel = require(scriptParentParent.Components.ThemedTextLabel)

local uDim = UDim.new(0, 24)

local var2 = Roact.PureComponent:extend("PlayerCell")

var2.validateProps = t.strictInterface({
    userId = t.number,
    username = t.string,
    displayName = t.optional(t.string),
    hasVerifiedBadge = t.optional(t.boolean),
    isOnline = t.optional(t.boolean),
    isSelected = t.optional(t.boolean),
    LayoutOrder = t.union(t.integer, t.table),
    Visible = t.optional(t.boolean),
    loadingStrategy = t.optional(LoadingStrategy.isEnumValue),
    onActivated = t.optional(t.callback),
    memoKey = t.optional(t.number),
    [Roact.Children] = t.optional(t.table),
    [Roact.Change.AbsolutePosition] = t.optional(t.callback),
    forwardRef = t.optional(t.union(t.callback, t.table)),
    UserInputService = t.optional(t.union(t.Instance, t.table))
})

var2.defaultProps = { Visible = true, UserInputService = UserInputService }

function var2.init(arg1)
    function arg1.onActivated()
        if arg1.props.onActivated and arg1.props.userId then
            arg1.props.onActivated(arg1.props.userId)
        end
    end
end

function var2.renderButtons(arg1)
    local prop = arg1.props[Roact.Children] or {}
    return (Cryo.Dictionary.join(prop, {
        List = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, 5)
        })
    }))
end

function var2.renderWithSelectionCursor(arg1, _)
    local props = arg1.props
    local var3 = props.displayName ~= "" and props.displayName or props.username

    return withFoundationOrUIBloxStyle(function(arg2)
        return {
            Theme = {
                BackgroundContrast = {
                    Color = arg2.Color.Surface.Surface_100.Color3,
                    Transparency = arg2.Color.Surface.Surface_100.Transparency
                },
                BackgroundOnHover = {
                    Color = arg2.Color.State.Hover.Color3,
                    Transparency = arg2.Color.State.Hover.Transparency
                },
                OnlineStatus = {
                    Color = arg2.Color.System.Success.Color3,
                    Transparency = arg2.Color.System.Success.Transparency
                }
            }
        }
    end, function(arg2)
        local backgroundContrast = arg2.Theme.BackgroundContrast
        local num1

        if arg1.props.isSelected then
            backgroundContrast = arg2.Theme.BackgroundOnHover
            num1 = 0.23
        else
            num1 = 1.1
        end

        local backgroundContrastColor = backgroundContrast.Color

        local tbl1 = {
            Corner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 3) }),
            Border = Roact.createElement("UIStroke", {
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                Color = Color3.new(backgroundContrastColor.R * num1, backgroundContrastColor.G * num1, backgroundContrastColor.B * num1),
                Transparency = 0,
                Thickness = 2
            })
        }

        local tbl2 = {
            BorderRadius = Roact.createElement("UICorner", { CornerRadius = uDim }),
            PlayerIcon = Roact.createElement(LoadableImage, {
                loadingStrategy = arg1.props.loadingStrategy,
                Size = UDim2.fromScale(1, 1),
                ImageColor3 = props.isOnline and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(115, 115, 115),
                BackgroundTransparency = 1,
                Image = props.userId > 0 and "rbxthumb://type=AvatarHeadShot&id=" .. props.userId .. "&w=60&h=60" or "",
                ZIndex = 2,
                LayoutOrder = 1,
                useShimmerAnimationWhileLoading = true,
                renderOnFailed = function()
                    if FFlagCoreUiMigrateUIBloxToFoundation then
                        return Roact.createElement(
                            Image,
                            {
                                Size = UDim2.fromScale(1, 1),
                                Image = "icons/common/user",
                                ZIndex = 2,
                                LayoutOrder = 1,
                                cornerRadius = uDim
                            }
                        )
                    end

                    return Roact.createElement(ImageSetLabel, {
                        Size = UDim2.fromScale(1, 1),
                        BackgroundTransparency = 1,
                        Image = Images["icons/common/user"],
                        ZIndex = 2,
                        LayoutOrder = 1
                    }, {
                        Corner = Roact.createElement("UICorner", { CornerRadius = uDim })
                    })
                end,
                cornerRadius = uDim
            }),
            OnlineIndicator = 0
        }

        local var4

        if arg1.props.isOnline then
            local element

            if FFlagCoreUiMigrateUIBloxToFoundation then
                element = Roact.createElement(Image, {
                    AnchorPoint = Vector2.new(1, 1),
                    Image = Assets.Images.Circle,
                    imageStyle = {
                        Color3 = props.isOnline and arg2.Theme.OnlineStatus.Color or nil,
                        Transparency = 0
                    },
                    Position = UDim2.new(1, -3, 1, -3),
                    Size = UDim2.new(0, 6, 0, 6),
                    ZIndex = 3
                }, tbl1)
            else
                element = Roact.createElement(ImageSetLabel, {
                    AnchorPoint = Vector2.new(1, 1),
                    Image = Assets.Images.Circle,
                    ImageColor3 = props.isOnline and arg2.Theme.OnlineStatus.Color or nil,
                    Position = UDim2.new(1, -3, 1, -3),
                    Size = UDim2.new(0, 6, 0, 6),
                    ZIndex = 3
                }, tbl1)
            end

            var4 = element or nil
        else
            var4 = nil
        end

        tbl2.OnlineIndicator = var4

        local createElement = Roact.createElement
        local var5 = Cell
        local tbl3 = {
            background = arg1.props.isSelected
                and Roact.createElement("Frame", {
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundColor3 = backgroundContrastColor,
                    BackgroundTransparency = backgroundContrast.Transparency
                })
                or nil,
            onActivated = arg1.onActivated,
            [Roact.Change.AbsolutePosition] = arg1.props[Roact.Change.AbsolutePosition],
            [Roact.Ref] = arg1.props.forwardRef or nil,
            layoutOrder = props.LayoutOrder,
            size = UDim2.new(1, 0, 0, 72)
        }
        local createElement2 = Roact.createElement
        local str1 = "Frame"
        local tbl4 = {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            AnchorPoint = Vector2.new(0, 0),
            Size = UDim2.new(1, -20, 0, 72),
            AutomaticSize = Enum.AutomaticSize.XY
        }
        local tbl5 = {
            HeadListLayout = Roact.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Center
            }),
            AvatarBackground = if FFlagCoreUiMigrateUIBloxToFoundation then Roact.createElement(Image, { Image = "component_assets/userBG_dark", Size = UDim2.new(0, 48, 0, 48) }, tbl2) else Roact.createElement(
                ImageSetLabel,
                {
                    BackgroundTransparency = 1,
                    Image = Images["component_assets/userBG_dark"],
                    Size = UDim2.new(0, 48, 0, 48)
                },
                tbl2
            ),
            NameContainer = 0
        }

        local createElement3 = Roact.createElement
        local str2 = "Frame"
        local tbl6 = {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -68, 0, 72),
            Position = UDim2.fromOffset(48, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            LayoutOrder = 2
        }
        local tbl7 = {
            NameListLayout = Roact.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Center
            }),
            NamePadding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, 6) }),
            DisplayNameLabel = 0,
            UsernameLabel = 0
        }
        local createElement4 = Roact.createElement
        local emojiWrapper = VerifiedBadges.EmojiWrapper
        local tbl8 = {
            emoji = if props.hasVerifiedBadge then VerifiedBadges.emoji.verified else "",
            automaticSize = Enum.AutomaticSize.None,
            size = UDim2.new(1, -40, 0, 20)
        }
        local tbl9 = {
            DisplayNameLabel = Roact.createElement(ThemedTextLabel, {
                fontKey = "CaptionHeader",
                themeKey = "TextEmphasis",
                BackgroundTransparency = 1,
                Text = var3 or props.username,
                Size = UDim2.new(1, 0, 0, 20),
                AutomaticSize = if props.hasVerifiedBadge then Enum.AutomaticSize.XY else Enum.AutomaticSize.None,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                LayoutOrder = 1
            })
        }
        tbl7.DisplayNameLabel = createElement4(emojiWrapper, tbl8, tbl9)

        tbl7.UsernameLabel = Roact.createElement(ThemedTextLabel, {
            fontKey = "Footer",
            themeKey = "TextDefault",
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(0, 0.5),
            Size = UDim2.new(1, 0, 0, 14),
            Text = "@" .. props.username,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            LayoutOrder = 2
        })
        tbl5.NameContainer = createElement3(str2, tbl6, tbl7)
        tbl3.head = createElement2(str1, tbl4, tbl5)

        tbl3.tail = Roact.createElement("Frame", {
            AnchorPoint = Vector2.new(1, 0),
            BackgroundTransparency = 1,
            Position = UDim2.new(1, 0, 0, 0),
            Size = UDim2.new(0, 0, 1, 0)
        }, arg1:renderButtons())
        return createElement(var5, tbl3)
    end)
end

function var2.render(arg1)
    return var1(function(arg2)
        return arg1:renderWithSelectionCursor(arg2)
    end)
end

return React.memo(var2, function(arg1, arg2): boolean
    if arg1.isSelected == arg2.isSelected
        and arg1.isOnline == arg2.isOnline
        and arg1[Roact.Change.AbsolutePosition] == arg2[Roact.Change.AbsolutePosition]
        and arg1.forwardRef == arg2.forwardRef
        and arg1.memoKey == arg2.memoKey
    then
        return arg1.loadingStrategy == arg2.loadingStrategy
    end

    return false
end)
