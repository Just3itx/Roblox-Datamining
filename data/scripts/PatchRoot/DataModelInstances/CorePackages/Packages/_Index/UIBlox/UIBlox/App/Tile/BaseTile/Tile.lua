-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:01:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local RoactGamepad = require(scriptParentParentParentParentParent.RoactGamepad)

local React = require(scriptParentParentParentParentParent.React)
local Cryo = require(scriptParentParentParentParentParent.Cryo)
local t = require(scriptParentParentParentParentParent.t)
local withStyle = require(scriptParentParentParentParent.Core.Style.withStyle)
local validateFontInfo = require(scriptParentParentParentParent.Core.Style.Validator.validateFontInfo)
local validateTypographyInfo = require(scriptParentParentParentParent.Core.Style.Validator.validateTypographyInfo)
local GetTextSize = require(scriptParentParentParentParent.Core.Text.GetTextSize)
local GetFontFromFontStyle = require(scriptParentParentParentParent.Core.Text.GetFontFromFontStyle)
local GetWrappedTextWithIcon = require(scriptParentParentParentParent.Core.Text.GetWrappedTextWithIcon)
local withTextSizeOffset = require(scriptParentParentParentParent.Core.Style.withTextSizeOffset)

local CursorKind = require(scriptParentParentParent.SelectionImage.CursorKind)
local withSelectionCursorProvider = require(scriptParentParentParent.SelectionImage.withSelectionCursorProvider)
local useCursor = require(scriptParentParentParentParent.App.SelectionCursor.useCursor)

local TileName = require(scriptParent.TileName)
local TileThumbnail = require(scriptParent.TileThumbnail)
local TileBanner = require(scriptParent.TileBanner)
local StyledTextLabel = require(scriptParentParentParent.Text.StyledTextLabel)
local Images = require(scriptParentParentParentParent.App.ImageSet.Images)
local Interactable = require(scriptParentParentParentParent.Core.Control.Interactable)

local uDim = UDim.new(0, 10)

local var1 = React.PureComponent:extend("Tile")

local var2 = t.strictInterface({
    footer = t.optional(t.table),
    name = t.optional(t.string),
    nameTextColor = t.optional(t.Color3),
    nameTextTransparency = t.optional(t.number),
    nameOverThumbnail = t.optional(t.boolean),
    titleRichText = t.optional(t.boolean),
    subtitle = t.optional(t.string),
    hasVerifiedBadge = t.optional(t.boolean),
    titleTextLineCount = t.optional(t.integer),
    innerPadding = t.optional(t.number),
    titleTopPadding = t.optional(t.number),
    subtitleTopPadding = t.optional(t.number),
    footerTopPadding = t.optional(t.number),
    onActivated = t.optional(t.callback),
    thumbnail = t.optional(t.union(t.string, t.table)),
    thumbnailSize = t.optional(t.UDim2),
    thumbnailFrameSize = t.optional(t.UDim2),
    thumbnailColor = t.optional(t.Color3),
    thumbnailTransparency = t.optional(t.number),
    thumbnailAspectRatio = t.optional(t.number),
    thumbnailScaleType = t.optional(t.enum(Enum.ScaleType)),
    bannerText = t.optional(t.string),
    backgroundImage = t.optional(t.union(t.string, t.table)),
    isSelected = t.optional(t.boolean),
    Selectable = t.optional(t.boolean),
    multiSelect = t.optional(t.boolean),
    isDisabled = t.optional(t.boolean),
    hasRoundedCorners = t.optional(t.boolean),
    titleIcon = t.optional(t.table),
    thumbnailOverlayComponents = t.optional(t.table),
    NextSelectionLeft = t.optional(t.table),
    NextSelectionRight = t.optional(t.table),
    NextSelectionUp = t.optional(t.table),
    NextSelectionDown = t.optional(t.table),
    thumbnailRef = t.optional(t.table),
    textButtonRef = t.optional(t.table),
    inputBindings = t.optional(t.table),
    useMaxTitleHeight = t.optional(t.boolean),
    addSubtitleSpace = t.optional(t.boolean),
    titleFontStyle = t.optional(t.union(validateFontInfo, validateTypographyInfo)),
    subtitleFontStyle = t.optional(t.union(validateFontInfo, validateTypographyInfo)),
    renderTileInset = t.optional(t.callback),
    [React.Tag] = t.optional(t.string),
    cursor = t.optional(t.any),
    isCircular = t.optional(t.boolean),
    horizontalAlignment = t.optional(t.EnumItem),
    openTypeFeatures = t.optional(t.string),
    onThumbnailLoaded = t.optional(t.callback),
    isRoactGamepadEnabled = t.optional(t.boolean)
})

var1.validateProps = t.intersection(var2, function(arg1) -- name: tileBannerUseValidator
    if arg1.bannerText and arg1.footer then
        return false, "A custom footer and bannerText can't be used together"
    end

    return true
end)
var1.defaultProps = {
    titleTextLineCount = 2,
    innerPadding = 8,
    titleTopPadding = 0,
    subtitleTopPadding = 0,
    footerTopPadding = 0,
    isSelected = false,
    multiSelect = false,
    isDisabled = false,
    hasRoundedCorners = true,
    Selectable = false,
    isCircular = false,
    horizontalAlignment = nil,
    thumbnailFrameSize = UDim2.new(1, 0, 1, 0),
    titleRichText = false,
    isRoactGamepadEnabled = true
}

function var1.init(arg1)
    arg1.state = { tileWidth = 0, tileHeight = 0 }

    function arg1.onAbsoluteSizeChange(arg2)
        local absoluteSizeX = arg2.AbsoluteSize.X
        local absoluteSizeY = arg2.AbsoluteSize.Y
        arg1:setState({ tileWidth = absoluteSizeX, tileHeight = absoluteSizeY })
    end
end

function var1.render(arg1)
    local footer = arg1.props.footer
    local name = arg1.props.name
    local subtitle = arg1.props.subtitle
    local hasVerifiedBadge = arg1.props.hasVerifiedBadge
    local titleTextLineCount = arg1.props.titleTextLineCount
    local innerPadding = arg1.props.innerPadding
    local titleTopPadding = arg1.props.titleTopPadding
    local subtitleTopPadding = arg1.props.subtitleTopPadding
    local footerTopPadding = arg1.props.footerTopPadding
    local onActivated = arg1.props.onActivated
    local thumbnail = arg1.props.thumbnail
    local thumbnailSize = arg1.props.thumbnailSize
    local thumbnailFrameSize = arg1.props.thumbnailFrameSize
    local thumbnailColor = arg1.props.thumbnailColor
    local thumbnailTransparency = arg1.props.thumbnailTransparency
    local bannerText = arg1.props.bannerText
    local hasRoundedCorners = arg1.props.hasRoundedCorners
    local isSelected = arg1.props.isSelected
    local multiSelect = arg1.props.multiSelect
    local isDisabled = arg1.props.isDisabled
    local titleIcon = arg1.props.titleIcon
    local thumbnailOverlayComponents = arg1.props.thumbnailOverlayComponents
    local backgroundImage = arg1.props.backgroundImage
    local useMaxTitleHeight = arg1.props.useMaxTitleHeight
    local addSubtitleSpace = arg1.props.addSubtitleSpace
    local horizontalAlignment = arg1.props.horizontalAlignment

    return withTextSizeOffset(function(arg2)
        return withStyle(function(arg3)
            return withSelectionCursorProvider(function(arg4)
                local font = arg3.Font
                local theme = arg3.Theme

                local tileHeight = arg1.state.tileHeight
                local tileWidth = arg1.state.tileWidth

                local titleFontStyle = arg1.props.titleFontStyle or font.Header2
                local titleRichText = arg1.props.titleRichText
                local fontStyle = arg1.props.subtitleFontStyle or font.CaptionHeader
                local var5 = if titleFontStyle.RelativeSize then font.BaseSize * titleFontStyle.RelativeSize else titleFontStyle.FontSize
                local var6 = if fontStyle.RelativeSize then font.BaseSize * fontStyle.RelativeSize else fontStyle.FontSize
                math.ceil(var5 * titleTextLineCount)
                local y = math.ceil((var5 + arg2) * titleTextLineCount)

                local var7 = tileHeight - tileWidth / (arg1.props.thumbnailAspectRatio or 1) - innerPadding - y - innerPadding - titleTopPadding
                local _vector2 = Vector2.new(0, 0)
                local yOffset = 0
                local var8

                if addSubtitleSpace then
                    var8 = Vector2.new(0, y)
                    yOffset = math.ceil(var6) + arg2
                    var7 -= yOffset
                else
                    if useMaxTitleHeight then
                        var8 = Vector2.new(0, y)
                    else
                        local var9 = name or ""

                        local fontFromFontStyle = GetFontFromFontStyle(titleFontStyle)

                        if titleIcon then
                            local var10 = titleIcon.ImageRectSize.X / Images.ImagesResolutionScale

                            var9 = GetWrappedTextWithIcon(var9, var5, fontFromFontStyle, var10, 4)
                        end
                        local textSize = GetTextSize(var9, var5, fontFromFontStyle, Vector2.new(tileWidth, y))

                        var8 = Vector2.new(textSize.X, math.min(textSize.Y, y))
                    end

                    if subtitle ~= nil and subtitle ~= "" then
                        yOffset = math.ceil(var6) + arg2
                        var7 -= yOffset
                    end
                end

                local yOffset2 = math.max(0, var7)

                local bool1 = footer ~= nil or bannerText ~= nil

                local renderTileInset = arg1.props.renderTileInset

                local uDim2 = UDim2.new(1, 0, 0, var8.Y + yOffset + titleTopPadding)
                local element

                if arg1.props.nameOverThumbnail then
                    uDim2 = UDim2.new(0, tileWidth - 10, 0, -(var8.Y + 20))
                    element = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, 10) })
                else
                    element = nil
                end

                local var9 = arg1.props.inputBindings
                    or not isDisabled and onActivated and {
                        Activate = RoactGamepad.Input.onBegin(Enum.KeyCode.ButtonA, onActivated)
                    }
                    or nil

                local createElement = React.createElement
                local var10 = Interactable
                local tbl1 = {
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Selectable = arg1.props.Selectable,
                    [React.Event.Activated] = if isDisabled then nil else onActivated,
                    [React.Change.AbsoluteSize] = arg1.onAbsoluteSizeChange,
                    ref = arg1.props.textButtonRef,
                    SelectionImageObject = if arg1.props.cursor then arg1.props.cursor else arg4(CursorKind.RoundedRect)
                }

                local tbl2 = {
                    UIListLayout = React.createElement("UIListLayout", {
                        FillDirection = Enum.FillDirection.Vertical,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Padding = UDim.new(0, innerPadding),
                        HorizontalAlignment = if arg1.props.nameOverThumbnail then nil else horizontalAlignment
                    }),
                    Thumbnail = 0,
                    TitleArea = 0,
                    FooterContainer = 0
                }
                local createElement2 = React.createElement
                local var11 = if arg1.props.isRoactGamepadEnabled then RoactGamepad.Focusable.Frame else "Frame"
                local tbl3 = {
                    Size = thumbnailFrameSize,
                    SizeConstraint = Enum.SizeConstraint.RelativeXX,
                    BackgroundTransparency = 1,
                    LayoutOrder = 1,
                    NextSelectionLeft = arg1.props.NextSelectionLeft,
                    NextSelectionRight = arg1.props.NextSelectionRight,
                    NextSelectionUp = arg1.props.NextSelectionUp,
                    NextSelectionDown = arg1.props.NextSelectionDown,
                    ref = arg1.props.thumbnailRef,
                    [React.Tag] = arg1.props[React.Tag],
                    SelectionImageObject = if arg1.props.cursor then arg1.props.cursor else arg4(CursorKind.RoundedRectNoInset)
                }

                if not arg1.props.isRoactGamepadEnabled then
                    var9 = nil
                end

                tbl3.inputBindings = var9

                local tbl4 = {
                    Image = React.createElement(TileThumbnail, {
                        Image = thumbnail,
                        hasRoundedCorners = hasRoundedCorners,
                        cornerRadius = if arg1.props.isCircular then UDim.new(0.5, 0) else uDim,
                        isSelected = isSelected,
                        multiSelect = multiSelect,
                        overlayComponents = thumbnailOverlayComponents,
                        imageSize = thumbnailSize,
                        imageColor = thumbnailColor,
                        imageTransparency = thumbnailTransparency,
                        backgroundImage = backgroundImage,
                        scaleType = arg1.props.thumbnailScaleType,
                        onThumbnailLoaded = arg1.props.onThumbnailLoaded
                    }),
                    TileInset = renderTileInset and renderTileInset() or nil,
                    UIAspectRatioConstraint = if arg1.props.thumbnailAspectRatio == nil then nil else React.createElement(
                        "UIAspectRatioConstraint",
                        {
                            AspectRatio = arg1.props.thumbnailAspectRatio,
                            AspectType = Enum.AspectType.ScaleWithParentSize
                        }
                    )
                }
                tbl2.Thumbnail = createElement2(var11, tbl3, tbl4)

                local createElement3 = React.createElement
                local str1 = "Frame"
                local tbl5 = { Size = uDim2, BackgroundTransparency = 1, LayoutOrder = 2 }

                local tbl6 = {
                    TitleTopPadding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, titleTopPadding) }),
                    UIListLayout = React.createElement("UIListLayout", {
                        FillDirection = Enum.FillDirection.Vertical,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Padding = UDim.new(0, subtitleTopPadding),
                        HorizontalAlignment = horizontalAlignment
                    }),
                    NameOverThumbnailPadding = element,
                    Name = titleTextLineCount > 0
                        and tileWidth > 0
                        and React.createElement(TileName, {
                            titleIcon = titleIcon,
                            name = name,
                            nameTextColor = arg1.props.nameTextColor,
                            nameTextTransparency = arg1.props.nameTextTransparency,
                            hasVerifiedBadge = hasVerifiedBadge,
                            maxHeight = y,
                            maxWidth = tileWidth,
                            LayoutOrder = 1,
                            useMaxHeight = useMaxTitleHeight,
                            titleFontStyle = titleFontStyle,
                            richText = titleRichText,
                            horizontalAlignment = horizontalAlignment
                        }),
                    Subtitle = 0
                }
                local element2

                if subtitle == "" or subtitle == nil then
                    element2 = false
                else
                    element2 = React.createElement(StyledTextLabel, {
                        size = UDim2.new(0, 0, 0, yOffset),
                        automaticSize = Enum.AutomaticSize.X,
                        text = subtitle,
                        colorStyle = theme.TextDefault,
                        fontStyle = fontStyle,
                        openTypeFeatures = arg1.props.openTypeFeatures,
                        layoutOrder = 2,
                        fluidSizing = false,
                        textTruncate = Enum.TextTruncate.AtEnd,
                        richText = false,
                        lineHeight = 1
                    })
                end

                tbl6.Subtitle = element2
                tbl2.TitleArea = createElement3(str1, tbl5, tbl6)

                tbl2.FooterContainer = bool1
                    and React.createElement(
                        "Frame",
                        {
                            Size = UDim2.new(1, 0, 0, yOffset2),
                            BackgroundTransparency = 1,
                            LayoutOrder = 3
                        },
                        {
                            FooterTopPadding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, footerTopPadding) }),
                            Banner = bannerText and React.createElement(TileBanner, { bannerText = bannerText }),
                            Footer = not bannerText and footer
                        }
                    )
                return createElement(var10, tbl1, tbl2)
            end)
        end)
    end)
end

local function func1(arg1)
    local cursor = useCursor(uDim)
    local var4 = Cryo.Dictionary.join({ cursor = cursor }, arg1)

    return React.createElement(var1, var4)
end

return React.forwardRef(function(arg1, thumbnailRef)
    return React.createElement(func1, Cryo.Dictionary.join(arg1, { thumbnailRef = thumbnailRef }))
end)
