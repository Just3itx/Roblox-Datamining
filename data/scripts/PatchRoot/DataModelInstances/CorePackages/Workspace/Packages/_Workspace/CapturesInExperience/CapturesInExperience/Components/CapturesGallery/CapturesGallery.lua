-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local CapturesCommon = require(scriptParentParentParentParent.CapturesCommon)
local Localization = require(scriptParentParentParentParent.Localization)
local React = require(scriptParentParentParentParent.React)
local RoactUtils = require(scriptParentParentParentParent.RoactUtils)
local UIBlox = require(scriptParentParentParentParent.UIBlox)
local normalizeFontFace = require(scriptParentParentParentParent.Foundation).Utility.normalizeFontFace

local useAnalytics = require(scriptParentParentParent.Analytics.useAnalytics)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useLocalization = Localization.Hooks.useLocalization
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useStyle = UIBlox.Core.Style.useStyle
local useSystemMenuDetection = require(scriptParentParentParent.Hooks.useSystemMenuDetection)

local CaptureGridView = CapturesCommon.Components.CaptureGridView
local CaptureItem = CapturesCommon.Components.CaptureItem
local CarouselOpened = require(scriptParentParentParent.Actions.CarouselOpened)
local Constants = require(scriptParentParentParent.Constants)
local EventNames = require(scriptParentParentParent.Analytics.EventNames)
local GalleryActionContainer = require(scriptParentParentParent.Components.CapturesGallery.GalleryActionContainer)
local GalleryGridView = require(scriptParentParentParent.Components.CapturesGallery.GalleryGridView)

local FFlagUseCaptureCommonComponents = require(scriptParentParentParent.Flags.FFlagUseCaptureCommonComponents)

local FFlagCapturesGalleryDespawnOnMenuClose = require(scriptParentParentParent.Flags.FFlagCapturesGalleryDespawnOnMenuClose)

return function(tbl1)
    local var1 = useAnalytics()
    local var2 = useDispatch()
    local var3 = useStyle()
    local var4 = useSystemMenuDetection()

    local captures = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].Captures
    end)

    local bool1 = next(captures) == nil

    local var6 = useLocalization({ nothingHereYet = "Feature.Captures.Label.NothingHereYet", title = "Feature.Captures.Title.Gallery" })

    local var7 = React.useCallback(function(arg1)
        return function()
            var1.fireEvent(EventNames.CapturesCarouselOpened)
            var2(CarouselOpened(arg1))
        end
    end, {})

    local var8 = tbl1.Size or UDim2.fromScale(1, 1)

    local backgroundDefaultColor = var3.Theme.BackgroundDefault.Color
    local backgroundDefaultTransparency = var3.Theme.BackgroundDefault.Transparency

    local textMutedColor = var3.Theme.TextMuted.Color
    local textSize = var3.Font.BaseSize * var3.Font.CaptionBody.RelativeSize
    local textMutedTransparency = var3.Theme.TextMuted.Transparency
    local var10 = if FFlagCapturesGalleryDespawnOnMenuClose then var4 and not bool1 else not bool1

    return React.createElement("Frame", {
        BackgroundColor3 = backgroundDefaultColor,
        BackgroundTransparency = backgroundDefaultTransparency,
        BorderSizePixel = 0,
        LayoutOrder = tbl1.LayoutOrder,
        Size = var8
    }, {
        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 8) }),
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            Padding = UDim.new(0, 12),
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Top
        }),
        NothingHereYet = bool1
            and React.createElement(
                "TextLabel",
                {
                    BackgroundTransparency = 1,
                    FontFace = normalizeFontFace(var3.Tokens.Typography.BodySmall.Font),
                    Size = UDim2.new(1, -12, 1, 12),
                    Text = var6.nothingHereYet,
                    TextColor3 = textMutedColor,
                    TextSize = textSize,
                    TextTransparency = textMutedTransparency,
                    TextWrapped = true,
                    TextXAlignment = Enum.TextXAlignment.Center
                },
                {
                    MaxSize = React.createElement("UISizeConstraint", { MaxSize = Vector2.new(312, math.huge) })
                }
            ),
        GalleryGridView = if var10 then if FFlagUseCaptureCommonComponents then React.createElement(CaptureGridView, {
            captures = captures,
            header = React.createElement(GalleryActionContainer, { isDisabled = false, itemCount = #captures, LayoutOrder = 1 }),
            renderItem = function(capture, arg1)
                return React.createElement(CaptureItem, { capture = capture, onActivated = var7(arg1) })
            end,
            shouldShowShowMoreButton = true
        }) else React.createElement(GalleryGridView, { captures = captures, Size = UDim2.new(1, -12, 1, -12) }) else nil
    })
end
