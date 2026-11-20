-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:10:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParentParent = scriptParentParent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local React = require(scriptParentParentParentParentParent.React)
local Cryo = require(scriptParentParentParentParentParent.Cryo)
local t = require(scriptParentParentParentParentParent.t)

local Images = require(scriptParentParentParentParent.App.ImageSet.Images)
local ItemRestrictionStatus = require(scriptParent.ItemRestrictionStatus)
local ItemTileStatusIcon = require(scriptParent.ItemTileStatusIcon)
local ItemTileStatus = require(scriptParent.ItemTileStatus)
local ItemTileEnums = require(scriptParentParent.Enum.ItemTileEnums)
local ItemIcon = require(scriptParent.ItemIcon)
local Tile = require(scriptParentParent.BaseTile.Tile)

local var1 = React.PureComponent:extend("ItemTile")

local function tileBannerUseValidator(props)
    if props.bannerText and props.footer then
        return false, "A custom footer and bannerText can't be used together"
    end

    return true
end

local strictInterface = t.strictInterface
local tbl1 = {
    footer = t.optional(t.table),
    name = t.optional(t.string),
    nameTextColor = t.optional(t.Color3),
    nameTextTransparency = t.optional(t.number),
    subtitle = t.optional(t.string),
    titleTextLineCount = t.optional(t.integer),
    innerPadding = t.optional(t.integer),
    titleTopPadding = t.optional(t.integer),
    subtitleTopPadding = t.optional(t.integer),
    footerTopPadding = t.optional(t.integer),
    onActivated = t.optional(t.callback),
    thumbnail = t.optional(t.string),
    backgroundImage = t.optional(t.union(t.string, t.table)),
    bannerText = t.optional(t.string),
    itemIconType = t.optional(ItemTileEnums.ItemIconType.isEnumValue),
    isSelected = t.optional(t.boolean),
    Selectable = t.optional(t.boolean),
    multiSelect = t.optional(t.boolean),
    isPremium = t.optional(t.boolean),
    restrictionTypes = t.optional(t.map(ItemTileEnums.Restriction.isEnumValue, t.boolean)),
    restrictionInfo = t.optional(t.table),
    hasRoundedCorners = t.optional(t.boolean),
    statusText = t.optional(t.string),
    statusStyle = t.optional(ItemTileEnums.StatusStyle.isEnumValue),
    NextSelectionLeft = t.optional(t.table),
    NextSelectionRight = t.optional(t.table),
    NextSelectionUp = t.optional(t.table),
    NextSelectionDown = t.optional(t.table),
    thumbnailRef = t.optional(t.table),
    textButtonRef = t.optional(t.table),
    inputBindings = t.optional(t.table),
    useMaxTitleHeight = t.optional(t.boolean),
    addSubtitleSpace = t.optional(t.boolean),
    titleFontStyle = t.optional(t.table),
    renderTileInset = t.optional(t.callback),
    hasVerifiedBadge = t.optional(t.boolean),
    [React.Tag] = t.optional(t.string),
    aspectRatio = t.optional(t.number),
    scaleType = t.optional(t.enum(Enum.ScaleType)),
    onThumbnailLoaded = t.optional(t.callback),
    isRoactGamepadEnabled = t.optional(t.boolean)
}
var1.validateProps = strictInterface(tbl1)

var1.defaultProps = {
    titleTextLineCount = 2,
    innerPadding = 8,
    isSelected = false,
    multiSelect = false,
    isPremium = false,
    hasRoundedCorners = true,
    Selectable = false,
    isRoactGamepadEnabled = true
}

local function isIconStatusStyle(statusStyle): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return statusStyle == ItemTileEnums.StatusStyle.PendingIcon or statusStyle == ItemTileEnums.StatusStyle.AlertIcon
end

function var1.render(arg1)
    assert(tileBannerUseValidator(arg1.props))
    local footer = arg1.props.footer
    local bannerText = arg1.props.bannerText
    local hasRoundedCorners = arg1.props.hasRoundedCorners
    local innerPadding = arg1.props.innerPadding
    local isPremium = arg1.props.isPremium
    local isSelected = arg1.props.isSelected
    local multiSelect = arg1.props.multiSelect
    local itemIconType = arg1.props.itemIconType
    local name = arg1.props.name
    local nameTextColor = arg1.props.nameTextColor
    local nameTextTransparency = arg1.props.nameTextTransparency
    local subtitle = arg1.props.subtitle
    local titleTopPadding = arg1.props.titleTopPadding
    local subtitleTopPadding = arg1.props.subtitleTopPadding
    local footerTopPadding = arg1.props.footerTopPadding
    local onActivated = arg1.props.onActivated
    local restrictionInfo = arg1.props.restrictionInfo
    local restrictionTypes = arg1.props.restrictionTypes
    local statusStyle = arg1.props.statusStyle
    local statusText = arg1.props.statusText
    local titleTextLineCount = arg1.props.titleTextLineCount
    local thumbnail = arg1.props.thumbnail
    local backgroundImage = arg1.props.backgroundImage
    local useMaxTitleHeight = arg1.props.useMaxTitleHeight
    local addSubtitleSpace = arg1.props.addSubtitleSpace
    local selectable = arg1.props.Selectable
    local titleFontStyle = arg1.props.titleFontStyle
    local renderTileInset = arg1.props.renderTileInset
    local aspectRatio = arg1.props.aspectRatio
    local scaleType = arg1.props.scaleType

    local tbl2 = {}
    local bool1

    if itemIconType then
        tbl2.ItemIconType = React.createElement(ItemIcon, { itemIconType = itemIconType })
        bool1 = true
    else
        bool1 = false
    end

    if restrictionTypes then
        tbl2.RestrictionStatus = React.createElement(ItemRestrictionStatus, { restrictionInfo = restrictionInfo, restrictionTypes = restrictionTypes })
        bool1 = true
    end

    if statusText then
        tbl2.Status = React.createElement(ItemTileStatus, { statusStyle = statusStyle, statusText = statusText })
        bool1 = true
    end

    if isIconStatusStyle(statusStyle) then
        tbl2.Status = React.createElement(ItemTileStatusIcon, { statusStyle = statusStyle })
        bool1 = true
    end

    return React.createElement(Tile, {
        bannerText = bannerText,
        footer = footer,
        hasRoundedCorners = hasRoundedCorners,
        innerPadding = innerPadding,
        isSelected = isSelected,
        Selectable = selectable,
        multiSelect = multiSelect,
        name = name,
        nameTextColor = nameTextColor,
        nameTextTransparency = nameTextTransparency,
        subtitle = subtitle,
        titleTopPadding = titleTopPadding,
        subtitleTopPadding = subtitleTopPadding,
        footerTopPadding = footerTopPadding,
        onActivated = onActivated,
        thumbnail = thumbnail,
        backgroundImage = backgroundImage,
        thumbnailOverlayComponents = bool1 and tbl2 or nil,
        titleIcon = isPremium and Images["icons/status/premium_small"] or nil,
        titleTextLineCount = titleTextLineCount,
        useMaxTitleHeight = useMaxTitleHeight,
        addSubtitleSpace = addSubtitleSpace,
        titleFontStyle = titleFontStyle,
        renderTileInset = renderTileInset,
        thumbnailAspectRatio = aspectRatio,
        thumbnailScaleType = scaleType,
        hasVerifiedBadge = arg1.props.hasVerifiedBadge,
        NextSelectionLeft = arg1.props.NextSelectionLeft,
        NextSelectionRight = arg1.props.NextSelectionRight,
        NextSelectionUp = arg1.props.NextSelectionUp,
        NextSelectionDown = arg1.props.NextSelectionDown,
        textButtonRef = arg1.props.textButtonRef,
        inputBindings = arg1.props.inputBindings,
        ref = arg1.props.thumbnailRef,
        [React.Tag] = arg1.props[React.Tag],
        onThumbnailLoaded = arg1.props.onThumbnailLoaded,
        isRoactGamepadEnabled = arg1.props.isRoactGamepadEnabled
    })
end

return React.forwardRef(function(arg1, thumbnailRef)
    return React.createElement(var1, Cryo.Dictionary.join(arg1, { thumbnailRef = thumbnailRef }))
end)
