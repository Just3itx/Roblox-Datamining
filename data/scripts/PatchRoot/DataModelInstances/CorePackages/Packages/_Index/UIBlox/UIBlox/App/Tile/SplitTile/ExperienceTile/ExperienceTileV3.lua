-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:10:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParentParent = scriptParentParent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent
local Core = scriptParentParentParentParentParent.Core
local scriptParentParentParentParentParentParent = scriptParentParentParentParentParent.Parent

local Cryo = require(scriptParentParentParentParentParentParent.Cryo)
local React = require(scriptParentParentParentParentParentParent.React)
local Roact = require(scriptParentParentParentParentParentParent.Roact)
local getControlStateColor = require(scriptParentParentParentParentParent.Utility.getControlStateColor)
local setDefault = require(scriptParentParentParentParentParent.Utility.setDefault)

local useStyle = require(Core.Style.useStyle)
local Interactable = require(Core.Control.Interactable)
local useControlState = require(Core.Control.useControlState)
local _StyleTypes = require(scriptParentParentParentParent.Style.StyleTypes)
local _Fonts = require(scriptParentParentParentParent.Style.Fonts)
local useCursor = require(scriptParentParentParentParent.SelectionCursor.useCursor)

local Constants = require(scriptParent.Constants)
local ExperienceActionRow = require(scriptParent.ExperienceActionRow)
local AspectRatioMode = require(scriptParent.Enum.AspectRatioMode)
local getAspectRatio = require(scriptParent.getAspectRatio)
local VerticalTile = require(scriptParentParent.VerticalTile.VerticalTile)
local TileContentPanel = require(scriptParentParent.TileContentPanel)
local VerticalTileThumbnail = require(scriptParentParent.VerticalTile.VerticalTileThumbnail)

local function renderContentWithPadding(arg1, arg2, tbl1, tbl2)
    return React.createElement(
        arg1,
        Cryo.Dictionary.join({ Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1 }, tbl1),
        {
            Padding = React.createElement("UIPadding", {
                PaddingLeft = UDim.new(0, arg2.Left),
                PaddingRight = UDim.new(0, arg2.Right),
                PaddingTop = UDim.new(0, arg2.Top),
                PaddingBottom = UDim.new(0, arg2.Bottom)
            }),
            Content = Roact.createFragment(tbl2)
        }
    )
end

local function getFinalAspectRatioMode(thumbnailAspectRatioOverride, bool1: boolean) -- Luacid: Inlined by compiler; 1 call site recovered
    return if thumbnailAspectRatioOverride == nil then if bool1 then AspectRatioMode.Wide else AspectRatioMode.Square elseif bool1 then AspectRatioMode.Wide else thumbnailAspectRatioOverride
end

local function ExperienceTileV3(tbl1)
    local var1 = useStyle()
    local offset = setDefault(tbl1.footerHeight, Constants.DEFAULT_FOOTER_HEIGHT)
    local isHoverEnabled = setDefault(tbl1.isHoverEnabled, false)
    local hasBackground = setDefault(tbl1.hasBackground, true)
    local defaultStyleProps = Constants.getDefaultStyleProps(var1)
    local var4 = Cryo.Dictionary.join(defaultStyleProps, tbl1.styleProps or {})
    local backgroundColor = var4.backgroundColor
    local border = var4.border
    local dropShadow = var4.dropShadow
    local topContentPadding = var4.topContentPadding
    local bottomContentPadding = var4.bottomContentPadding
    local overlayColors = var4.overlayColors
    local selectionCursorPadding = var4.selectionCursorPadding
    local contentTitlePadding = var4.contentTitlePadding
    local contentTitleFont = var4.contentTitleFont
    local textLineCount = setDefault(tbl1.contentTextLineCount, Constants.DEFAULT_TEXT_LINE_COUNT)

    local renderTopContent = React.useCallback(function(bool1: boolean)
        bool1 = bool1 and not var1.Settings.ReducedMotion

        local finalAspectRatioMode = getFinalAspectRatioMode(tbl1.thumbnailAspectRatioOverride, bool1)
        local aspectRatio = getAspectRatio(finalAspectRatioMode)
        local thumbnail = if finalAspectRatioMode == AspectRatioMode.Wide then tbl1.wideThumbnail else tbl1.thumbnail
        return renderContentWithPadding(
            "Frame",
            topContentPadding,
            {
                Size = UDim2.new(1, 0, aspectRatio, 0),
                SizeConstraint = Enum.SizeConstraint.RelativeXX,
                ZIndex = 3
            },
            {
                Thumbnail = React.createElement(VerticalTileThumbnail, {
                    aspectRatio = aspectRatio,
                    border = border,
                    isTopRounded = true,
                    isBottomRounded = not hasBackground,
                    thumbnail = thumbnail
                }),
                TopContentOverlay = if tbl1.renderTopContentOverlay == nil then nil else Roact.createFragment((tbl1.renderTopContentOverlay(bool1, border)))
            }
        )
    end, {
        tbl1.renderTopContentOverlay,
        tbl1.wideThumbnail,
        tbl1.thumbnail,
        tbl1.thumbnailAspectRatioOverride,
        topContentPadding,
        border,
        hasBackground
    })

    local renderBottomContent = React.useCallback(function(bool1: boolean)
        local var7 = math.floor(textLineCount * contentTitleFont.RelativeSize * var1.Font.BaseSize + contentTitlePadding) + offset + bottomContentPadding.Top + bottomContentPadding.Bottom
        if tbl1.renderBottomContent ~= nil then
            return renderContentWithPadding(
                "Frame",
                bottomContentPadding,
                {
                    Size = UDim2.new(1, 0, 0, var7)
                },
                {
                    BottomContent = tbl1.renderBottomContent(bool1, border)
                }
            )
        end

        return React.createElement(TileContentPanel, {
            contentTitle = tbl1.experienceName,
            panelHeight = UDim.new(0, var7),
            outerPadding = bottomContentPadding,
            footerHeight = UDim.new(0, offset),
            textLineCount = textLineCount,
            titleFont = contentTitleFont,
            titlePadding = contentTitlePadding,
            contentFooter = if bool1 then tbl1.footer else nil,
            hasSidePadding = true
        })
    end, {
        tbl1.experienceName,
        tbl1.renderBottomContent,
        tbl1.footer,
        textLineCount,
        contentTitlePadding,
        bottomContentPadding,
        offset,
        contentTitleFont,
        border,
        var1
    })

    local renderFooterRow = React.useCallback(function(bool1: boolean?)
        if tbl1.renderBottomContent ~= nil then
            return nil
        elseif bool1 then
            if tbl1.renderActionRow ~= nil then
                return tbl1.renderActionRow()
            end
            return React.createElement(ExperienceActionRow, tbl1.actionRowProps)
        else
            local yOffset = offset + bottomContentPadding.Top + bottomContentPadding.Bottom
            return renderContentWithPadding(
                "Frame",
                bottomContentPadding,
                {
                    Size = UDim2.new(1, 0, 0, yOffset),
                    Position = UDim2.new(0, 0, 1, 0),
                    AnchorPoint = Vector2.new(0, 1)
                },
                {
                    FooterContent = React.createElement("Frame", {
                        Size = UDim2.new(1, 0, 0, 0),
                        Position = UDim2.new(0, 0, 1, 0),
                        AnchorPoint = Vector2.new(0, 1),
                        BackgroundTransparency = 1,
                        AutomaticSize = Enum.AutomaticSize.Y
                    }, {
                        Footer = tbl1.footer
                    })
                }
            )
        end
    end, {
        tbl1.footer,
        tbl1.actionRowProps,
        tbl1.renderBottomContent,
        tbl1.renderActionRow,
        bottomContentPadding,
        offset
    })

    local var9, onStateChanged = useControlState()

    local selectionImageObject = useCursor(border.CornerRadius)
    local controlStateColor = getControlStateColor(var9, overlayColors)
    local color, transparency

    if controlStateColor == nil then
        color = nil
        transparency = 1
    else
        color = controlStateColor.Color
        transparency = controlStateColor.Transparency
    end

    return renderContentWithPadding(Interactable, selectionCursorPadding, {
        Size = UDim2.new(1, 0, 1, 0),
        SelectionImageObject = selectionImageObject,
        onStateChanged = onStateChanged,
        isDisabled = tbl1.isDisabled,
        [React.Event.Activated] = tbl1.onActivated,
        [React.Event.SelectionGained] = tbl1.onSelectionGained,
        [React.Event.SelectionLost] = tbl1.onSelectionLost
    }, {
        VerticalTile = React.createElement(VerticalTile, {
            hasBackground = hasBackground,
            hasOutline = setDefault(tbl1.hasOutline, true),
            isHoverEnabled = isHoverEnabled,
            hoverDelay = tbl1.hoverDelay,
            onHoverChanged = tbl1.onHoverChanged,
            isOverlayVisible = false,
            isActive = false,
            renderTopContent = renderTopContent,
            renderBottomContent = renderBottomContent,
            renderFooterRow = renderFooterRow,
            reservedBottomHeight = 0,
            backgroundColor = backgroundColor,
            border = border,
            dropShadow = dropShadow
        }),
        OverlayColor = React.createElement(
            "Frame",
            {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundColor3 = color,
                ZIndex = 10,
                BackgroundTransparency = transparency
            },
            {
                Corner = React.createElement("UICorner", { CornerRadius = border.CornerRadius })
            }
        )
    })
end

return ExperienceTileV3
