-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:10:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local App = script:FindFirstAncestor("App")
local AppParent = App.Parent

local Core = AppParent.Core
local AppParentParent = AppParent.Parent

local t = require(AppParentParent.t)
local Roact = require(AppParentParent.Roact)
local Object = require(AppParentParent.LuauPolyfill).Object
local Cryo = require(AppParentParent.Cryo)
local Dictionary = Cryo.Dictionary
local List = Cryo.List

local Images = require(App.ImageSet.Images)
local validateImageSetData = require(Core.ImageSet.Validator.validateImageSetData)
local ControlState = require(Core.Control.Enum.ControlState)
local withStyle = require(Core.Style.withStyle)
local getContentStyle = require(Core.Button.getContentStyle)
local PlayerTileButton = require(App.Tile.PlayerTile.PlayerTileButton)
local PlayerContext = require(App.Indicator.PlayerContext)
local SpringAnimatedItem = require(AppParent.Utility.SpringAnimatedItem)

local validateFontInfo = require(Core.Style.Validator.validateFontInfo)
local validateTypographyInfo = require(AppParent.Core.Style.Validator.validateTypographyInfo)

local Tile = require(App.Tile.BaseTile.Tile)

local var1 = Roact.PureComponent:extend("PlayerTile")

local var2 = t.union(t.string, validateImageSetData)
var1.validateProps = t.strictInterface({
    title = t.optional(t.string),
    subtitle = t.optional(t.string),
    subtitleFontStyle = t.optional(t.union(validateFontInfo, validateTypographyInfo)),
    hasVerifiedBadge = t.optional(t.boolean),
    Selectable = t.optional(t.boolean),
    thumbnail = t.optional(t.union(t.string, t.table)),
    buttons = t.optional(
        t.array(
            t.strictInterface({
                icon = t.optional(var2),
                onActivated = t.optional(t.callback),
                isSecondary = t.optional(t.boolean),
                isDisabled = t.optional(t.boolean)
            })
        )
    ),
    relevancyInfo = t.strictInterface({
        text = t.optional(t.string),
        icon = t.optional(t.union(t.string, t.table)),
        iconSize = t.optional(t.UDim2),
        iconColor = t.optional(t.Color3),
        iconTransparency = t.optional(t.number),
        onActivated = t.optional(t.callback),
        fontStyle = t.optional(t.union(validateFontInfo, validateTypographyInfo)),
        horizontalAlignment = t.optional(t.EnumItem),
        textXAlignment = t.optional(t.EnumItem)
    }),
    tileSize = t.optional(t.UDim2),
    thumbnailFrameSize = t.optional(t.UDim2),
    isCircular = t.optional(t.boolean),
    horizontalAlignment = t.optional(t.EnumItem),
    footerTopPadding = t.optional(t.integer),
    onActivated = t.optional(t.callback),
    forwardedRef = t.optional(t.table),
    openTypeFeatures = t.optional(t.string),
    isRoactGamepadEnabled = t.optional(t.boolean),
    buttonRef = t.optional(t.table)
})

var1.defaultProps = {
    buttons = {},
    relevancyInfo = {},
    tileSize = UDim2.new(0, 150, 0, 150),
    onActivated = function() end,
    Selectable = false,
    isCircular = false,
    openTypeFeatures = nil,
    isRoactGamepadEnabled = true
}

local springOptions = { dampingRatio = 1, frequency = 4 }

local tbl2 = {
    [ControlState.Default] = "SystemPrimaryContent"
}

local component_assetsVignette_246 = Images["component_assets/vignette_246"]

local function footer(tbl3: {controlState: number, playerContext: number}) -- Luacid: Inlined by compiler; 1 call site recovered
    return withStyle(function(arg1)
        local tokens = arg1.Tokens

        local var3 = Object.assign({}, {
            fontStyle = if tbl3.playerContext.onActivated then tokens.Typography.CaptionMedium else tokens.Typography.BodySmall,
            iconTextSpacing = tokens.Size.Size_100,
            iconPadding = 0,
            iconSize = UDim2.fromOffset(tokens.Size.Size_300, tokens.Size.Size_300),
            textHeight = tokens.Size.Size_700,
            horizontalAlignment = tbl3.horizontalAlignment,
            textXAlignment = tbl3.textXAlignment
        }, tbl3.playerContext)

        return Roact.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1
            },
            {
                PlayerContext = Roact.createElement(PlayerContext, var3)
            }
        )
    end)
end

local function thumbnailOverlayComponents(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return withStyle(function(arg2)
        local tokens = arg2.Tokens

        local size200 = tokens.Size.Size_200
        local size200_2 = tokens.Size.Size_200
        local size900 = tokens.Size.Size_900

        local contentStyle = getContentStyle(tbl2, arg1.controlState, arg2)
        local createElement = Roact.createElement
        local str1 = "Frame"
        local tbl3 = {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0)
        }
        local tbl4 = {
            ButtonBackgroundGradient = not arg1.isCircular
                and not Cryo.isEmpty(arg1.buttons)
                and Roact.createElement("Frame", {
                    Size = UDim2.new(1, 0, 0, size900 + size200 * 2),
                    AnchorPoint = Vector2.new(0, 1),
                    Position = UDim2.new(0, 0, 1, 0),
                    LayoutOrder = 1
                }, {
                    UIGradient = Roact.createElement("UIGradient", {
                        Rotation = 90,
                        Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, arg2.Theme.BackgroundUIContrast.Color), ColorSequenceKeypoint.new(1, arg2.Theme.BackgroundUIContrast.Color) }),
                        Transparency = NumberSequence.new(
                            { NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, arg2.Theme.BackgroundUIContrast.Transparency) }
                        )
                    }),
                    UICorner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 8) })
                }),
            HoverTransparency = 0,
            ButtonContainer = 0
        }

        local createElement2 = Roact.createElement
        local animatedImageLabel = SpringAnimatedItem.AnimatedImageLabel

        local tbl5 = {
            springOptions = springOptions,
            animatedValues = {
                imageTransparency = if arg1.mouseEntered then 0.6 else 1
            },
            mapValuesToProps = function(arg3)
                return {
                    ImageTransparency = arg3.imageTransparency
                }
            end,
            regularProps = {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Image = component_assetsVignette_246.Image,
                ImageRectSize = component_assetsVignette_246.ImageRectSize,
                ImageRectOffset = component_assetsVignette_246.ImageRectOffset,
                ImageColor3 = contentStyle.Color,
                ImageTransparency = 0,
                LayoutOrder = 2,
                [Roact.Event.MouseEnter] = arg1.hoverMouseEnter,
                [Roact.Event.MouseLeave] = arg1.hoverMouseLeave
            }
        }

        local tbl6 = {
            corner = Roact.createElement("UICorner", { CornerRadius = if arg1.isCircular then UDim.new(0.5, 0) else UDim.new(0, 8) })
        }
        tbl4.HoverTransparency = createElement2(animatedImageLabel, tbl5, tbl6)

        tbl4.ButtonContainer = Roact.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                ZIndex = 2
            },
            {
                PlayerTileButtons = Roact.createElement(
                    "Frame",
                    {
                        BackgroundTransparency = 1,
                        Position = UDim2.new(1, 0, 1, 0),
                        Size = UDim2.new(0, arg1.tileSize.X.Offset - size200 * 2, 0, size900),
                        AnchorPoint = Vector2.new(1, 1),
                        LayoutOrder = 3,
                        ZIndex = 2
                    },
                    List.join(List.map(arg1.buttons, function(arg3)
                        return Roact.createElement(PlayerTileButton, {
                            buttonHeight = size900,
                            outerButtonPadding = size200,
                            tileSize = arg1.tileSize,
                            icon = arg3.icon,
                            isSecondary = arg3.isSecondary,
                            isDisabled = arg3.isDisabled,
                            onActivated = arg3.onActivated,
                            mouseEnter = arg1.hoverMouseEnter,
                            mouseLeave = arg1.hoverMouseLeave,
                            isRoactGamepadEnabled = arg1.isRoactGamepadEnabled
                        })
                    end), { Roact.createElement("UIListLayout", {
                            HorizontalAlignment = Enum.HorizontalAlignment.Right,
                            Padding = UDim.new(0, size200_2),
                            FillDirection = Enum.FillDirection.Horizontal
                        }) })
                ),
                UIPadding = Roact.createElement("UIPadding", { PaddingBottom = UDim.new(0, size200), PaddingRight = UDim.new(0, size200) })
            }
        )

        return createElement(str1, tbl3, tbl4)
    end)
end

function var1.init(arg1)
    arg1.firstButtonIcon = Roact.createRef()
    arg1.secondButtonIcon = Roact.createRef()
    arg1.mouseEntered = false
    arg1.state = {
        controlState = ControlState.Initialize,
        mouseEntered = false
    }

    function arg1.onStateChanged(arg2, controlState)
        arg1:setState({ controlState = controlState })

        if arg1.props.onStateChanged then
            arg1.props.onStateChanged(arg2, controlState)
        end
    end

    function arg1.hoverMouseEnter()
        arg1:setState({ mouseEntered = true })
    end

    function arg1.hoverMouseLeave()
        arg1:setState({ mouseEntered = false })
    end
end

function var1.render(arg1)
    local tileSize = arg1.props.tileSize
    local title = arg1.props.title
    local onActivated = arg1.props.onActivated
    local thumbnail = arg1.props.thumbnail

    return withStyle(function(arg2)
        local tokens = arg2.Tokens
        local subtitleFontStyle = arg1.props.subtitleFontStyle or tokens.Typography.CaptionMedium
        local footerTopPadding = arg1.props.footerTopPadding or tokens.Size.Size_100

        local createElement = Roact.createElement
        local str1 = "Frame"
        local tbl3 = {
            Size = tileSize,
            BackgroundTransparency = 1,
            LayoutOrder = 1,
            [Roact.Ref] = arg1.props.forwardedRef
        }
        local tbl4 = { Tile = 0 }
        local createElement2 = Roact.createElement
        local var5 = Tile
        local tbl5 = {
            textButtonRef = arg1.props.buttonRef,
            footer = 0,
            Selectable = 0,
            hasRoundedCorners = true,
            innerPadding = 0,
            titleTopPadding = 0,
            subtitleTopPadding = 0,
            footerTopPadding = 0,
            name = 0,
            nameTextColor = 0,
            titleRichText = true,
            titleFontStyle = 0,
            hasVerifiedBadge = 0,
            titleTextLineCount = 1,
            subtitle = 0,
            subtitleFontStyle = 0,
            onActivated = 0,
            thumbnail = 0,
            backgroundImage = 0,
            thumbnailOverlayComponents = 0,
            addSubtitleSpace = 0,
            isCircular = 0,
            horizontalAlignment = 0,
            thumbnailFrameSize = 0,
            openTypeFeatures = 0
        }
        local tbl6 = {
            playerContext = if arg1.props.Selectable then Dictionary.join(arg1.props.relevancyInfo, { Selectable = false }) else arg1.props.relevancyInfo,
            controlState = arg1.state.controlState
        }
        tbl5.footer = footer(tbl6)

        tbl5.Selectable = arg1.props.Selectable

        tbl5.titleTopPadding = tokens.Size.Size_200
        tbl5.subtitleTopPadding = tokens.Size.Size_50
        tbl5.footerTopPadding = footerTopPadding
        tbl5.name = title
        tbl5.nameTextColor = tokens.Color.Content.Emphasis.Color3

        tbl5.titleFontStyle = tokens.Typography.TitleLarge
        tbl5.hasVerifiedBadge = arg1.props.hasVerifiedBadge

        tbl5.subtitle = arg1.props.subtitle
        tbl5.subtitleFontStyle = subtitleFontStyle
        tbl5.onActivated = onActivated
        tbl5.thumbnail = thumbnail
        tbl5.backgroundImage = Images[arg2.Theme.PlayerBackgroundDefault.Image]
        tbl5.thumbnailOverlayComponents = thumbnailOverlayComponents(
            (Dictionary.join(arg1.props, {
                hoverMouseEnter = arg1.hoverMouseEnter,
                hoverMouseLeave = arg1.hoverMouseLeave,
                mouseEntered = arg1.state.mouseEntered
            }))
        )
        tbl5.addSubtitleSpace = title == nil
        tbl5.isCircular = arg1.props.isCircular
        tbl5.horizontalAlignment = arg1.props.horizontalAlignment
        tbl5.thumbnailFrameSize = arg1.props.thumbnailFrameSize
        tbl5.openTypeFeatures = arg1.props.openTypeFeatures
        tbl4.Tile = createElement2(var5, tbl5)
        return createElement(str1, tbl3, tbl4)
    end)
end

return Roact.forwardRef(function(arg1, forwardedRef)
    return Roact.createElement(var1, Dictionary.join(arg1, { forwardedRef = forwardedRef }))
end)
