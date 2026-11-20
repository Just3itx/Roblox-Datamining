-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:10:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local Core = scriptParentParentParentParent.Core
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)
local normalizeFontFace = require(scriptParentParentParentParentParent.Foundation).Utility.normalizeFontFace

local withStyle = require(Core.Style.withStyle)
local Interactable = require(Core.Control.Interactable)
local ControlState = require(Core.Control.Enum.ControlState)
local LoadableImage = require(scriptParentParentParentParent.App.Loading.LoadableImage)
local Images = require(scriptParentParentParent.ImageSet.Images)
local ImageSetComponent = require(Core.ImageSet.ImageSetComponent)
local ItemSplitTileFooter = require(scriptParentParentParentParent.App.Tile.ItemSplitTile.ItemSplitTileFooter)

local uDim = UDim.new(0, 8)

local uDim2 = UDim.new(0, 8)
local uDim3 = UDim.new(0, 12)

local var1 = Roact.PureComponent:extend("ItemSplitTile")

var1.validateProps = t.strictInterface({
    itemName = t.optional(t.string),
    priceText = t.optional(t.string),
    isOwned = t.optional(t.boolean),
    hasBackground = t.optional(t.boolean),
    isHovered = t.optional(t.boolean),
    onActivated = t.optional(t.callback),
    thumbnail = t.optional(t.string)
})

var1.defaultProps = { itemName = "--", priceText = "--", hasBackground = true, isHovered = false }

function var1.init(arg1)
    arg1:setState({ controlState = ControlState.Initialize })

    function arg1.onStateChanged(_, controlState)
        arg1:setState({ controlState = controlState })
    end
end

function var1.renderImageFrame(_, image, arg1, arg2, arg3)
    local theme = arg3.Theme
    local var2 = arg2 or not arg1
    local bool1 = typeof(image) == "table"

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl1 = {
        Position = UDim2.fromScale(0, if arg1 then 0.5 else 0),
        Size = UDim2.fromScale(1, if arg2 then 1 else 0.5),
        ClipsDescendants = true,
        BackgroundTransparency = 1
    }

    local tbl2 = { Image = 0 }
    local element

    if bool1 then
        element = Roact.createElement(
            ImageSetComponent.Label,
            {
                BackgroundColor3 = theme.PlaceHolder.Color,
                BackgroundTransparency = 1,
                Image = image,
                Position = UDim2.fromScale(0, if arg1 then -1 else 0),
                Size = UDim2.fromScale(1, if arg2 then 1 else 2)
            },
            {
                UICorner = if var2 then Roact.createElement("UICorner", { CornerRadius = uDim }) else nil
            }
        )
    else
        element = Roact.createElement(LoadableImage, {
            BackgroundColor3 = theme.PlaceHolder.Color,
            BackgroundTransparency = 1,
            Image = image,
            Position = UDim2.fromScale(0.5, if arg1 then 0 else 1),
            Size = UDim2.fromScale(1, if arg2 then 1 else 2),
            AnchorPoint = Vector2.new(0.5, if arg2 then 1 else 0.5),
            cornerRadius = if var2 then uDim else nil,
            showFailedStateWhenLoadingFailed = true,
            useShimmerAnimationWhileLoading = true
        })
    end

    tbl2.Image = element
    return createElement(str1, tbl1, tbl2)
end

function var1.renderTopContent(arg1, arg2)
    local hasBackground = arg1.props.hasBackground
    local isHovered = arg1.props.isHovered
    local bool1 = not hasBackground
    local theme = arg2.Theme
    local var2 = Images[theme.ItemBackgroundDefault.Image]

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl1 = {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        SizeConstraint = Enum.SizeConstraint.RelativeXX,
        ZIndex = 2
    }
    local tbl2 = {
        BackgroundImage = if arg1.props.thumbnail then Roact.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1
            },
            {
                TopImageFrame = arg1:renderImageFrame(var2, false, bool1, arg2),
                BottomImageFrame = if bool1 then nil else arg1:renderImageFrame(var2, true, false, arg2)
            }
        ) else nil,
        ItemImage = Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1
        }, {
            TopImageFrame = arg1:renderImageFrame(arg1.props.thumbnail, false, bool1, arg2),
            BottomImageFrame = if bool1 then nil else arg1:renderImageFrame(arg1.props.thumbnail, true, false, arg2)
        }),
        HoverShadow = 0
    }
    local element2

    if isHovered and not hasBackground then
        element2 = Roact.createElement(ImageSetComponent.Label, {
            ZIndex = 0,
            Position = UDim2.new(0.5, 0, 0.5, 2),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 12),
            Image = Images["component_assets/dropshadow_24_6"],
            ImageColor3 = theme.DropShadow.Color,
            ImageTransparency = theme.DropShadow.Transparency,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(18, 18, 18, 18)
        })
    else
        element2 = nil
    end

    tbl2.HoverShadow = element2
    return createElement(str1, tbl1, tbl2)
end

function var1.renderBottomContent(arg1, arg2)
    local itemName = arg1.props.itemName
    local hasBackground = arg1.props.hasBackground

    local font = arg2.Font
    local textSize = math.ceil(arg2.Font.BaseSize * arg2.Font.Header2.RelativeSize)
    local theme = arg2.Theme
    local controlState = arg1.state.controlState
    local uDim4 = if (arg1.props.isHovered or controlState == ControlState.Pressed) and hasBackground then uDim3 else uDim2
    local yOffset = textSize * 3 + uDim2.Offset + uDim4.Offset * 2

    local textEmphasis = theme.TextEmphasis

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl1 = {
        Size = UDim2.new(1, 0, 0, yOffset),
        BackgroundTransparency = 1,
        LayoutOrder = 2
    }

    local tbl2 = {
        UIListLayout = Roact.createElement(
            "UIListLayout",
            {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = uDim2
            }
        ),
        Padding = 0,
        TitleArea = 0,
        Footer = 0
    }
    local createElement2 = Roact.createElement
    local str2 = "UIPadding"
    local tbl3 = {
        PaddingLeft = if hasBackground then uDim4 else nil,
        PaddingRight = if hasBackground then uDim4 else nil,
        PaddingTop = if hasBackground then uDim4 else uDim2,
        PaddingBottom = 0
    }

    if not hasBackground then
        uDim4 = uDim2
    end

    tbl3.PaddingBottom = uDim4
    tbl2.Padding = createElement2(str2, tbl3)
    local element

    if itemName and string.len(itemName) > 0 then
        element = Roact.createElement(
            "TextLabel",
            {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Text = itemName,
                FontFace = normalizeFontFace(font.Header2.Font),
                TextSize = textSize,
                TextTransparency = textEmphasis.Transparency,
                TextColor3 = textEmphasis.Color,
                TextWrapped = true,
                TextTruncate = Enum.TextTruncate.AtEnd,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                LayoutOrder = 1
            },
            {
                UISizeConstraint = Roact.createElement("UISizeConstraint", { MaxSize = Vector2.new(math.huge, textSize * 2) })
            }
        )
    else
        element = nil
    end

    tbl2.TitleArea = element

    tbl2.Footer = Roact.createElement(
        ItemSplitTileFooter,
        {
            priceText = arg1.props.priceText,
            isOwned = arg1.props.isOwned,
            layoutOrder = 2
        }
    )
    return createElement(str1, tbl1, tbl2)
end

function var1.renderTileContent(arg1, arg2)
    local hasBackground = arg1.props.hasBackground
    local onActivated = arg1.props.onActivated
    local theme = arg2.Theme
    local backgroundUiDefaultColor = if hasBackground then theme.BackgroundUIDefault.Color else nil
    local backgroundTransparency = if hasBackground then theme.BackgroundUIDefault.Transparency else 1

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl1 = {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = backgroundUiDefaultColor,
        BackgroundTransparency = backgroundTransparency,
        ClipsDescendants = true,
        ZIndex = 1
    }

    local tbl2 = {
        UICorner = Roact.createElement("UICorner", { CornerRadius = uDim }),
        Panel = Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1
        }, {
            UIListLayout = Roact.createElement(
                "UIListLayout",
                {
                    FillDirection = Enum.FillDirection.Vertical,
                    SortOrder = Enum.SortOrder.LayoutOrder
                }
            ),
            TopContentPlaceholder = Roact.createElement("Frame", {
                Size = UDim2.new(1, 0, 1, 0),
                SizeConstraint = Enum.SizeConstraint.RelativeXX,
                BackgroundTransparency = 1,
                LayoutOrder = 1
            }),
            BottomContent = arg1:renderBottomContent(arg2)
        }),
        TopContent = arg1:renderTopContent(arg2),
        TileOverlay = 0
    }
    local createElement2 = Roact.createElement
    local var3 = Interactable
    local tbl3 = {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        onStateChanged = arg1.onStateChanged,
        [Roact.Event.Activated] = onActivated,
        ZIndex = 3
    }
    local tbl4 = {
        UICorner = Roact.createElement("UICorner", { CornerRadius = uDim }),
        BorderFrame = Roact.createElement("Frame", {
            Size = UDim2.new(1, -2, 1, -2),
            Position = UDim2.fromOffset(1, 1),
            BackgroundTransparency = 1,
            SizeConstraint = if hasBackground then nil else Enum.SizeConstraint.RelativeXX
        }, {
            UIStroke = Roact.createElement(
                "UIStroke",
                {
                    Color = theme.Divider.Color,
                    Transparency = theme.Divider.Transparency,
                    Thickness = 1
                }
            ),
            UICorner = Roact.createElement("UICorner", { CornerRadius = uDim })
        })
    }
    tbl2.TileOverlay = createElement2(var3, tbl3, tbl4)
    return createElement(str1, tbl1, tbl2)
end

function var1.render(arg1)
    local hasBackground = arg1.props.hasBackground
    local isHovered = arg1.props.isHovered

    return withStyle(function(arg2)
        local theme = arg2.Theme

        local createElement = Roact.createElement
        local str1 = "Frame"
        local tbl1 = {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1
        }
        local tbl2 = {
            UISizeConstraint = Roact.createElement("UISizeConstraint", { MinSize = Vector2.new(146, 233) }),
            TileContent = arg1:renderTileContent(arg2),
            HoverShadow = 0
        }
        local element

        if isHovered and hasBackground then
            element = Roact.createElement(ImageSetComponent.Label, {
                ZIndex = 0,
                Position = UDim2.new(0.5, 0, 0.5, 2),
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 10, 1, 12),
                Image = Images["component_assets/dropshadow_24_6"],
                ImageColor3 = theme.DropShadow.Color,
                ImageTransparency = theme.DropShadow.Transparency,
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(18, 18, 18, 18)
            })
        else
            element = nil
        end

        tbl2.HoverShadow = element
        return createElement(str1, tbl1, tbl2)
    end)
end

return var1
