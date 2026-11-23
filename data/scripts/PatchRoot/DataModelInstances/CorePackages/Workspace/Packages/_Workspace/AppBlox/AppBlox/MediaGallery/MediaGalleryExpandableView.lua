-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent
local Cryo = require(AppBloxParent.Cryo)
local React = require(AppBloxParent.React)
local ReactOtter = require(AppBloxParent.ReactOtter)

local UIBlox = require(AppBloxParent.UIBlox)
local CursorKind = UIBlox.App.SelectionImage.CursorKind
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local useCursor = UIBlox.App.SelectionCursor.useCursor
local useSelectionCursor = UIBlox.App.SelectionImage.useSelectionCursor
local useStyle = require(AppBloxParent.UIBlox).Core.Style.useStyle

local Foundation = require(AppBloxParent.Foundation)
local Icon = Foundation.Icon
local View = Foundation.View
local IconSize = Foundation.Enums.IconSize
local useTokens = Foundation.Hooks.useTokens

local SharedFlags = require(AppBloxParent.SharedFlags)
local FFlagLuaAppEdpConsoleMediaGalleryVideo = SharedFlags.FFlagLuaAppEdpConsoleMediaGalleryVideo
local FFlagLuaAppEdpConsoleMediaGalleryVideoPlayIcon = SharedFlags.FFlagLuaAppEdpConsoleMediaGalleryVideoPlayIcon

local Constants = require(script.Parent.Constants)
local _MediaGalleryTypes = require(script.Parent.MediaGalleryTypes)

local tbl1 = {
    titleText = "Media",
    numItemsShown = 4,
    itemAspectRatio = 16 / 9,
    animationConfig = {
        dampingRatio = 1,
        frequency = 20 / 3
    },
    onActivated = function() end,
    onSelectionGained = function() end,
    exitFullscreen = function() end
}

local function MediaGalleryExpandableView(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local var2 = useStyle()
    local var3 = if FFlagLuaAppEdpConsoleMediaGalleryVideoPlayIcon then useTokens() else nil
    local defaultStyleProps = Constants.getDefaultStyleProps(var2)
    local var4 = Cryo.Dictionary.join(defaultStyleProps, var1.styleProps or {})
    local borderRadius = var4.borderRadius
    local gutter = var4.gutter
    local contentGap = var4.contentGap
    local titleFont = var4.titleFont
    local titleTextColor = var4.titleTextColor

    local var5, var6 = ReactOtter.useAnimatedBinding(0)

    local var7, var8 = React.useState(Vector2.zero)
    local var9 = React.useCallback(function(arg1, _: boolean, _, _)
        local var9 = gutter * (var1.numItemsShown - 1)
        local x = (arg1.AbsoluteSize.X - var9) / var1.numItemsShown
        var8(Vector2.new(x, x / var1.itemAspectRatio))
    end, { gutter, var1.itemAspectRatio, var1.numItemsShown })

    local var10 = React.useCallback(function(arg1, _: boolean, arg2, arg3)
        if not arg1 then
            return nil
        end

        local isDescendantOf = not (arg3 == nil) and arg3:IsDescendantOf(arg1)
        local isDescendantOf2 = not (arg2 == nil) and arg2:IsDescendantOf(arg1)
        local var10 = not isDescendantOf and isDescendantOf2

        if isDescendantOf and not isDescendantOf2 then
            var6(ReactOtter.spring(var1.expandableAreaHeightOffset, var1.animationConfig))
            var1.mediaGalleryGainFocused(true)
            return nil
        end

        if not var10 then
            return nil
        end

        if arg3 == nil or not (arg3.AbsolutePosition.Y > arg2.AbsolutePosition.Y) then
            var6(ReactOtter.spring(0, var1.animationConfig))
        end
        var1.exitFullscreen()
        var1.mediaGalleryGainFocused(false)
        return nil
    end, {
        var1.expandableAreaHeightOffset,
        var1.animationConfig,
        var1.exitFullscreen,
        var1.mediaGalleryGainFocused
    })

    local var11 = useCursor(borderRadius)
    local var12 = useSelectionCursor(CursorKind.Invisible)
    if not var1.showCursor then
        var11 = var12
    end
    local useMemo = React.useMemo
    local function func1()
        local result = ({})
        for layoutOrder, item in var1.items do
            local var13 = "Item" .. layoutOrder
            local createElement = React.createElement
            local str1 = "ImageButton"
            local tbl3 = {
                LayoutOrder = layoutOrder,
                Size = UDim2.fromOffset(var7.X, var7.Y),
                Image = item.imageId,
                ScaleType = Enum.ScaleType.Crop,
                BackgroundTransparency = 1,
                AutoButtonColor = false,
                SelectionImageObject = var11
            }

            tbl3[React.Event.Activated] = function()
                var1.onActivated(layoutOrder)
            end
            tbl3[React.Event.SelectionGained] = function()
                var1.onSelectionGained(layoutOrder)
            end
            local tbl4 = {
                Corner = React.createElement("UICorner", { CornerRadius = borderRadius }),
                PlayIcon = 0
            }
            local var14

            if FFlagLuaAppEdpConsoleMediaGalleryVideoPlayIcon and item.videoId then
                local createElement2 = React.createElement
                local var15 = View
                local tbl5 = {
                    tag = "auto-xy padding-medium radius-circle bg-over-media-100",
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromScale(0.5, 0.5),
                    ZIndex = 2,
                    selection = { Selectable = false }
                }
                local tbl6 = {
                    Icon = React.createElement(Icon, { name = "play-large", size = IconSize.Medium, style = var3.Color.Content.Emphasis })
                }
                var14 = createElement2(var15, tbl5, tbl6)
            else
                var14 = nil
            end

            tbl4.PlayIcon = var14
            result[var13] = createElement(str1, tbl3, tbl4)
        end

        return result
    end

    local items = var1.items
    local onActivated = var1.onActivated
    local onSelectionGained = var1.onSelectionGained
    local var13 = if FFlagLuaAppEdpConsoleMediaGalleryVideoPlayIcon then var3 else nil
    local var14 = useMemo(func1, { var7, items, onActivated, onSelectionGained, var11, borderRadius, var13 })
    local yOffset = if titleFont.RelativeSize then titleFont.RelativeSize * var2.Font.BaseSize else titleFont.FontSize
    local createElement = React.createElement
    local str1 = "CanvasGroup"
    local tbl3 = {
        GroupTransparency = var1.groupTransparency,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        ref = if FFlagLuaAppEdpConsoleMediaGalleryVideo then var1.rootRef else nil
    }

    local tbl4 = {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, contentGap)
        }),
        ExpandableArea = React.createElement("Frame", {
            Size = var5:map(function(yOffset2: number?): UDim2
                return UDim2.new(1, 0, 0, yOffset2)
            end),
            BackgroundTransparency = 1,
            LayoutOrder = 1
        }),
        Title = React.createElement(StyledTextLabel, {
            text = var1.titleText,
            fontStyle = titleFont,
            colorStyle = titleTextColor,
            textXAlignment = Enum.TextXAlignment.Left,
            size = UDim2.new(1, 0, 0, yOffset),
            layoutOrder = 2
        }),
        MediaGallery = React.createElement("ScrollingFrame", {
            Size = UDim2.new(1, 0, 0, var7.Y),
            BackgroundTransparency = 1,
            AutomaticCanvasSize = Enum.AutomaticSize.XY,
            ScrollBarImageTransparency = 1,
            ScrollBarThickness = 0,
            ScrollingDirection = Enum.ScrollingDirection.X,
            Selectable = false,
            LayoutOrder = 3,
            [React.Change.AbsoluteSize] = var9,
            [React.Event.SelectionChanged] = var10
        }, {
            Layout = React.createElement(
                "UIListLayout",
                {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    FillDirection = Enum.FillDirection.Horizontal,
                    Padding = UDim.new(0, gutter)
                }
            ),
            Items = React.createElement(React.Fragment, {}, var14)
        })
    }

    return createElement(str1, tbl3, tbl4)
end

return MediaGalleryExpandableView
