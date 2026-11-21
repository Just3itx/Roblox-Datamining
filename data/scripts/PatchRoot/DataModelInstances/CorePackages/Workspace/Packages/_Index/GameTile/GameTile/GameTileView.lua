-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTile = script:FindFirstAncestor("GameTile")

local GameTileParent = GameTile.Parent
local React = require(GameTileParent.React)
local useDesignTokens = require(GameTileParent.Style).useDesignTokens
local UIBlox = require(GameTileParent.UIBlox)

local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local LoadableImage = UIBlox.App.Loading.LoadableImage
local useCursor = UIBlox.App.SelectionCursor.useCursor

local Foundation = require(GameTileParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local RightAlignedButtonWrapper = require(GameTile.Footer.RightAlignedButtonWrapper)
local ZoomAnimatedFrame = require(GameTile.ZoomAnimatedFrame)
local GameTileViewConfig = require(GameTile.GameTileViewConfig)
local FFlagLuaAppContinueSortInstantPlay = require(GameTileParent.SharedFlags).FFlagLuaAppContinueSortInstantPlay
local FFlagLuaAppMigrateGameTileHoverFixes = require(GameTileParent.SharedFlags).FFlagLuaAppMigrateGameTileHoverFixes

local FFlagLuaAppGameViewTileBackgroundColorOverride = require(GameTileParent.SharedFlags).FFlagLuaAppGameViewTileBackgroundColorOverride

local FFlagLuaAppHomePageFirstImageLoadObserver = require(GameTileParent.SharedFlags).FFlagLuaAppHomePageFirstImageLoadObserver

local function GameTileView(tbl1)
    local var1 = useDesignTokens()
    local numLinesForTitle = if tbl1.isUnifiedGameTile then tbl1.numLinesForTitle or 1 else nil
    local numLinesForMetadata = tbl1.numLinesForMetadata or 1
    local textSizeOffset = tbl1.textSizeOffset
    local var2 = useTokens()

    local elementSizes = GameTileViewConfig.getElementSizes(
        var1,
        textSizeOffset,
        if tbl1.isUnifiedGameTile then numLinesForTitle else nil,
        if tbl1.isUnifiedGameTile then var2 else nil,
        if tbl1.isUnifiedGameTile then true else nil,
        numLinesForMetadata
    )
    local offset = if var2 and tbl1.isUnifiedGameTile then var2.Radius.Medium else var1.Size.Size_200
    local uDim = UDim.new(0, offset)
    local selectionImageObject = useCursor(uDim)
    local var4 = if var2 and tbl1.isUnifiedGameTile then var2.Typography.TitleMedium else var1.Typography.TitleLarge
    local fontSize = var4.FontSize
    local emphasis = if var2 and tbl1.isUnifiedGameTile then var2.Color.Content.Emphasis else var1.Color.Content.Emphasis
    local size100 = var1.Size.Size_100
    local offset2 = if tbl1.isUnifiedGameTile then tbl1.hoverPadding or var1.Size.Size_300 else var1.Size.Size_300
    local yOffset = if tbl1.hidePlayButton then 0 else elementSizes.playButtonHeight
    local xOffset = if tbl1.isUnifiedGameTile then if tbl1.isContained then tbl1.containmentSidePadding or var2.Padding.Medium else 0 elseif tbl1.isContained then var1.Size.Size_300 else 0
    local yOffset2 = if tbl1.hidePlayButton or tbl1.isContained and tbl1.isUnifiedGameTile then 0 else var1.Size.Size_300

    local isHovered = tbl1.isHovered
    local isUnifiedGameTile = FFlagLuaAppMigrateGameTileHoverFixes and isHovered and tbl1.isUnifiedGameTile

    local x = UDim.new(1, -(if tbl1.isUnifiedGameTile then xOffset else var1.Size.Size_300 + xOffset))

    local var5 = tbl1.Size or UDim2.fromScale(1, 1)
    if isHovered then
        var5 += UDim2.fromOffset(offset2 * 2, offset2 * 2)
    end

    local footerHeight = GameTileViewConfig.getFooterHeight(
        var1,
        tbl1.isContained,
        tbl1.footerMetadata == nil,
        tbl1.title == nil,
        textSizeOffset,
        tbl1.extraFooterSpace,
        numLinesForTitle,
        var2,
        tbl1.isUnifiedGameTile,
        tbl1.numLinesForMetadata
    )

    local yOffset3 = if tbl1.title or tbl1.footerMetadata then elementSizes.footerTopPadding else 0
    local var6 = if tbl1.title and tbl1.footerMetadata then elementSizes.paddingAboveMetadata else 0
    local yOffset4 = if tbl1.title then elementSizes.titleHeight else 0
    local var7 = if var2 and tbl1.isUnifiedGameTile then isHovered and var2.Color.Surface.Surface_100.Transparency or 1 else isHovered and var1.Color.Surface.Surface_300.Transparency or 1
    local color3 = if var2 and tbl1.isUnifiedGameTile then var2.Color.Surface.Surface_100.Color3 else var1.Color.Surface.Surface_300.Color3

    if FFlagLuaAppGameViewTileBackgroundColorOverride and tbl1.backgroundStyle then
        var7 = isHovered and tbl1.backgroundStyle.Transparency or 1
        color3 = tbl1.backgroundStyle.Color3
    end

    local var8 = React.useRef(false)

    local var9 = React.useCallback(function(...)
        var8.current = false
        if tbl1.onGuiStateChanged then
            tbl1.onGuiStateChanged(...)
        end
    end, { tbl1.onGuiStateChanged })

    local var10 = React.useCallback(function()
        if not tbl1.onTouchLongPress or tbl1.isDisabled then
            return
        end

        local current = var8.current
        var8.current = true
        if current == false then
            tbl1.onTouchLongPress()
        end
    end, { tbl1.onTouchLongPress, tbl1.isDisabled })

    local var11 = React.useCallback(function()
        if var8.current then
            var8.current = false
            return
        end

        if tbl1.onActivated and not tbl1.isDisabled then
            tbl1.onActivated()
        end
    end, { tbl1.onActivated, tbl1.isDisabled })

    local var12 = if FFlagLuaAppContinueSortInstantPlay then React.useCallback(function()
        if var8.current then
            var8.current = false
            return
        end

        if tbl1.onMetadataActivated and not tbl1.isDisabled then
            tbl1.onMetadataActivated()
        end
    end, { tbl1.onMetadataActivated, tbl1.isDisabled }) else nil

    local var13 = if FFlagLuaAppContinueSortInstantPlay then tbl1.isTouchPreferredInput and tbl1.onMetadataActivated ~= nil else nil
    local createElement = React.createElement
    local var14 = ZoomAnimatedFrame
    local tbl2 = {
        isZoomEnabled = isHovered,
        expansionOffsetX = size100 * 2,
        expansionOffsetTop = size100,
        expansionOffsetBottom = yOffset + yOffset2 + (if tbl1.hidePlayButton then 0 else size100) / (tbl1.imageAspectRatio or 1) + size100 + (if tbl1.hideMetadata and tbl1.footerMetadata then elementSizes.metadataHeight else 0),
        reducedMotion = tbl1.reducedMotion
    }
    local tbl3 = { HoverShadow = 0, GameTileContent = 0 }
    local element

    if isHovered then
        element = React.createElement(ImageSetLabel, {
            Position = UDim2.new(0.5, 0, 0.5, 2),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Size = UDim2.new(1, offset2 + 18, 1, offset2 + 20),
            Image = Images["component_assets/dropshadow_56_8"],
            ImageColor3 = var1.Color.Common.Shadow.Color3,
            ImageTransparency = var1.Color.Common.Shadow.Transparency,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(35, 35, 37, 37),
            ZIndex = -1
        })
            or nil
    else
        element = nil
    end

    tbl3.HoverShadow = element

    local createElement2 = React.createElement
    local str1 = "TextButton"
    local tbl4 = {
        SelectionOrder = tbl1.SelectionOrder,
        ref = tbl1.forwardRef,
        Size = var5,
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        SelectionImageObject = selectionImageObject,
        Active = not tbl1.isDisabled,
        [React.Change.GuiState] = var9,
        [React.Event.Activated] = var11,
        [React.Event.SelectionGained] = tbl1.onSelectionGained,
        [React.Event.SelectionLost] = tbl1.onSelectionLost,
        [React.Event.TouchLongPress] = var10,
        ClipsDescendants = false,
        Text = "",
        BackgroundTransparency = var7,
        BackgroundColor3 = color3,
        AutoButtonColor = false,
        Selectable = tbl1.Selectable,
        [React.Tag] = "data-testid=--game-tile"
    }
    local tbl5 = {
        UIPadding = if isHovered then React.createElement("UIPadding", {
            PaddingLeft = UDim.new(0, offset2),
            PaddingTop = UDim.new(0, offset2),
            PaddingRight = UDim.new(0, offset2),
            PaddingBottom = UDim.new(0, offset2)
        })
            or nil else nil,
        UICorner = React.createElement("UICorner", {
            CornerRadius = if FFlagLuaAppMigrateGameTileHoverFixes and tbl1.isUnifiedGameTile then uDim else uDim + UDim.new(0, offset2)
        }),
        UIListLayout = React.createElement(
            "UIListLayout",
            {
                FillDirection = Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        ),
        ThumbnailFrame = 0,
        BottomContent = 0,
        PaddingAboveActionRow = 0,
        ActionRow = 0
    }
    local createElement3 = React.createElement
    local str2 = "Frame"
    local tbl6 = {
        [React.Tag] = if FFlagLuaAppHomePageFirstImageLoadObserver then "observed-image" else nil,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        LayoutOrder = 1,
        ZIndex = -1
    }
    local tbl7 = {
        Thumbnail = 0,
        ContainedBackgroundTop = 0,
        UIAspectRatioConstraint = 0,
        ThumbnailOverlay = 0,
        OverflowMenu = 0
    }
    local var15

    if tbl1.thumbnailComponent then
        var15 = tbl1.thumbnailComponent
    else
        var15 = React.createElement(LoadableImage, {
            BackgroundTransparency = 1,
            Image = tbl1.image,
            Size = UDim2.new(1, 0, 1, if not tbl1.isContained or isUnifiedGameTile then 0 else offset),
            cornerRadius = uDim,
            showFailedStateWhenLoadingFailed = true,
            useShimmerAnimationWhileLoading = true,
            ZIndex = -2,
            ScaleType = if tbl1.isContained and not isUnifiedGameTile then Enum.ScaleType.Tile else nil,
            TileSize = if tbl1.isContained and not isUnifiedGameTile then UDim2.new(1, 0, 1, -offset) else nil
        })
    end

    tbl7.Thumbnail = var15

    tbl7.ContainedBackgroundTop = if tbl1.isContained and not isUnifiedGameTile then React.createElement("Frame", {
        Size = UDim2.new(1, 0, 0, footerHeight - offset),
        Position = UDim2.new(0, 0, 1, 0),
        BackgroundTransparency = 0,
        ZIndex = -1,
        BackgroundColor3 = color3,
        BorderSizePixel = 0
    }) else nil

    tbl7.UIAspectRatioConstraint = React.createElement("UIAspectRatioConstraint", { AspectRatio = tbl1.imageAspectRatio or 1 })

    tbl7.ThumbnailOverlay = tbl1.thumbnailOverlay
    tbl7.OverflowMenu = tbl1.overflowMenu
    tbl5.ThumbnailFrame = createElement3(str2, tbl6, tbl7)

    local createElement4 = React.createElement
    local str3 = "Frame"
    local tbl8 = {
        Size = UDim2.new(1, 0, 0, footerHeight),
        LayoutOrder = 2,
        BackgroundTransparency = if tbl1.isContained then 0 else 1,
        BackgroundColor3 = color3,
        BorderSizePixel = 0,
        Active = if FFlagLuaAppContinueSortInstantPlay and var13 then not tbl1.isDisabled else nil
    }

    local guiState = React.Change.GuiState

    if not (FFlagLuaAppContinueSortInstantPlay and var13) then
        var9 = nil
    end

    tbl8[guiState] = var9

    local touchTap = React.Event.TouchTap

    if not (FFlagLuaAppContinueSortInstantPlay and var13) then
        var12 = nil
    end

    tbl8[touchTap] = var12

    local touchLongPress = React.Event.TouchLongPress

    if not (FFlagLuaAppContinueSortInstantPlay and var13) then
        var10 = nil
    end

    tbl8[touchLongPress] = var10

    local tbl9 = {
        UICorner = if tbl1.isContained then React.createElement("UICorner", { CornerRadius = uDim }) else nil,
        TextWrapper = 0
    }

    local createElement5 = React.createElement
    local var16 = RightAlignedButtonWrapper
    local tbl10 = {
        Button = tbl1.rightCornerButton,
        Padding = UDim.new(0, if tbl1.isContained then 0 else var1.Size.Size_300),
        Content = 0
    }
    local createElement6 = React.createElement
    local fragment = React.Fragment
    local var17 = nil
    local tbl11 = { Title = 0, Metadata = 0, ExtraContent = 0 }
    local element2

    if tbl1.title then
        element2 = React.createElement("TextLabel", {
            Position = UDim2.new(0, xOffset, 0, yOffset3),
            Size = UDim2.new(1, -2 * xOffset, 0, yOffset4),
            BackgroundTransparency = 1,
            Text = tbl1.title,
            FontFace = normalizeFontFace(var4.Font),
            TextSize = fontSize,
            TextTransparency = emphasis.Transparency,
            TextColor3 = emphasis.Color3,
            TextWrapped = if numLinesForTitle and tbl1.isUnifiedGameTile then numLinesForTitle > 1 else false,
            TextTruncate = Enum.TextTruncate.SplitWord,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = if tbl1.isUnifiedGameTile then Enum.TextYAlignment.Top else Enum.TextYAlignment.Center,
            LayoutOrder = 3
        })
            or nil
    else
        element2 = nil
    end

    tbl11.Title = element2

    tbl11.Metadata = tbl1.footerMetadata
        and React.createElement("Frame", {
            Position = UDim2.new(0, xOffset, 0, yOffset4 + yOffset3 + var6),
            Size = UDim2.new(x, UDim.new(0, elementSizes.metadataHeight)),
            ClipsDescendants = false,
            BackgroundTransparency = 1,
            LayoutOrder = 5
        }, {
            MetadataContent = tbl1.footerMetadata
        })
    tbl11.ExtraContent = tbl1.extraFooterContent
        and tbl1.extraFooterSpace
        and React.createElement("Frame", {
            Size = UDim2.new(1, -xOffset * 2, 0, tbl1.extraFooterSpace),
            Position = UDim2.new(0, xOffset, 0, yOffset4 + yOffset3 + var6 + elementSizes.metadataHeight),
            BackgroundTransparency = 1
        }, { tbl1.extraFooterContent })
    tbl10.Content = createElement6(fragment, var17, tbl11)
    tbl9.TextWrapper = createElement5(var16, tbl10)
    tbl5.BottomContent = createElement4(str3, tbl8, tbl9) or nil

    tbl5.PaddingAboveActionRow = if isHovered then React.createElement("Frame", { LayoutOrder = 6, Size = UDim2.fromOffset(0, yOffset2), BackgroundTransparency = 1 })
        or nil else nil

    tbl5.ActionRow = if isHovered then React.createElement(
        "Frame",
        {
            Size = UDim2.new(1, 0, 0, yOffset),
            BackgroundTransparency = 1,
            LayoutOrder = 7
        },
        {
            Content = tbl1.hoverActionRow
        }
    )
        or nil else nil
    tbl3.GameTileContent = createElement2(str1, tbl4, tbl5)
    return createElement(var14, tbl2, tbl3)
end

return GameTileView
