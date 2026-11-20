-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent
local Core = scriptParentParentParentParentParent.Core
local scriptParentParentParentParentParentParent = scriptParentParentParentParentParent.Parent

local Cryo = require(scriptParentParentParentParentParentParent.Cryo)
local React = require(scriptParentParentParentParentParentParent.React)

local useDebouncedState = require(scriptParentParentParentParentParentParent.ReactUtils).useDebouncedState

local useStyle = require(Core.Style.useStyle)
local ImageSetComponent = require(Core.ImageSet.ImageSetComponent)
local Images = require(scriptParentParentParentParent.ImageSet.Images)
local TileOverlay = require(scriptParentParentParent.SplitTile.TileOverlay)
local _StyleTypes = require(scriptParentParentParentParent.Style.StyleTypes)

local uDim = UDim.new(0, 8)

local function useIsHoveredState<T>(hoverDelay: number?, callback: ((...any) -> (...any))?)
    local var1, var2 = useDebouncedState(false, hoverDelay)

    React.useLayoutEffect(function()
        if callback ~= nil then
            callback(var1)
        end
    end, { callback, var1 })

    return var1, var2
end

local function VerticalTile(tbl1)
    local theme = useStyle().Theme
    local var1 = Cryo.Dictionary.join({
        hasBackground = true,
        hasOutline = true,
        isHoverEnabled = true,
        isOverlayVisible = true,
        isActive = true,
        backgroundColor = {
            Color = theme.BackgroundUIDefault.Color,
            Transparency = theme.BackgroundUIDefault.Transparency
        },
        border = {
            BorderColor = {
                Color = theme.Divider.Color,
                Transparency = theme.Divider.Transparency
            },
            CornerRadius = uDim,
            Width = 1
        },
        dropShadow = {
            Position = UDim2.new(0.5, 0, 0.5, 2),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Size = UDim2.new(1, 10, 1, 12),
            ImageColor = {
                Color = theme.DropShadow.Color,
                Transparency = theme.DropShadow.Transparency
            },
            ImageAssetName = "component_assets/dropshadow_24_6",
            SliceCenter = Rect.new(18, 18, 18, 18)
        }
    }, tbl1)

    local hasBackground = var1.hasBackground
    local isHoverEnabled = var1.isHoverEnabled
    local var2, var3 = useIsHoveredState(var1.hoverDelay, var1.onHoverChanged)
    local var4 = React.useCallback(function(bool1: boolean)
        return function()
            var3(bool1)
        end
    end, {})
    local var5 = var2 and isHoverEnabled
    local backgroundColorColor = if hasBackground then var1.backgroundColor.Color else nil
    local backgroundTransparency = if hasBackground then var1.backgroundColor.Transparency else 1
    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1
    }
    local tbl3 = {
        UISizeConstraint = if var1.minTileSize then React.createElement("UISizeConstraint", { MinSize = var1.minTileSize }) else nil,
        TileContent = 0,
        BorderFrame = 0,
        HoverShadow = 0
    }

    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl4 = {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = backgroundColorColor,
        BackgroundTransparency = backgroundTransparency,
        [React.Event.MouseEnter] = if isHoverEnabled then var4(true) else nil,
        [React.Event.MouseLeave] = if isHoverEnabled then var4(false) else nil,
        ClipsDescendants = false,
        ZIndex = 1
    }
    local tbl5 = {
        UICorner = React.createElement("UICorner", { CornerRadius = var1.border.CornerRadius }),
        Panel = React.createElement("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            ZIndex = 2
        }, {
            UIListLayout = React.createElement("UIListLayout", { FillDirection = Enum.FillDirection.Vertical, SortOrder = Enum.SortOrder.Name }),
            Content1 = if var1.renderTopContent then var1.renderTopContent(var5) else nil,
            Content2 = if var1.renderBottomContent then var1.renderBottomContent(var5) else nil
        }),
        FooterRow = if var1.renderFooterRow then var1.renderFooterRow(var5) else nil,
        Overlay = React.createElement(TileOverlay, {
            reservedBottomHeight = var1.reservedBottomHeight,
            isVisible = var1.isOverlayVisible,
            isActive = var1.isActive,
            onActivated = var1.onActivated,
            zIndex = 3
        })
    }
    tbl3.TileContent = createElement2(str2, tbl4, tbl5)
    local element

    if var1.hasOutline then
        element = React.createElement("Frame", {
            Size = UDim2.new(1, -2 * var1.border.Width, 1, -2 * var1.border.Width),
            AnchorPoint = if hasBackground then Vector2.new(0.5, 0.5) else nil,
            Position = if hasBackground then UDim2.fromScale(0.5, 0.5) else UDim2.fromOffset(var1.border.Width, var1.border.Width),
            BackgroundTransparency = 1,
            SizeConstraint = if hasBackground then nil else Enum.SizeConstraint.RelativeXX,
            ZIndex = 4
        }, {
            UIStroke = React.createElement("UIStroke", {
                Color = var1.border.BorderColor.Color,
                Transparency = var1.border.BorderColor.Transparency,
                Thickness = var1.border.Width
            }),
            UICorner = React.createElement("UICorner", { CornerRadius = var1.border.CornerRadius })
        })
    else
        element = nil
    end

    tbl3.BorderFrame = element
    local element2

    if var5 and hasBackground then
        element2 = React.createElement(ImageSetComponent.Label, {
            ZIndex = 0,
            Position = var1.dropShadow.Position,
            AnchorPoint = var1.dropShadow.AnchorPoint,
            BackgroundTransparency = 1,
            Size = var1.dropShadow.Size,
            Image = Images[var1.dropShadow.ImageAssetName],
            ImageColor3 = var1.dropShadow.ImageColor.Color,
            ImageTransparency = var1.dropShadow.ImageColor.Transparency,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = var1.dropShadow.SliceCenter
        })
    else
        element2 = nil
    end

    tbl3.HoverShadow = element2
    return createElement(str1, tbl2, tbl3)
end

return VerticalTile
