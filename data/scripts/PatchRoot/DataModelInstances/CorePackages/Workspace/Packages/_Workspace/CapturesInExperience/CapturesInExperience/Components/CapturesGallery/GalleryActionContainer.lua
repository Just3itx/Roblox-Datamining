-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:41:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local CoreGui = game:GetService("CoreGui")

local Localization = require(scriptParentParentParentParent.Localization)
local React = require(scriptParentParentParentParent.React)
local RoactUtils = require(scriptParentParentParentParent.RoactUtils)
local UIBlox = require(scriptParentParentParentParent.UIBlox)
local normalizeFontFace = require(scriptParentParentParentParent.Foundation).Utility.normalizeFontFace

local useAnalytics = require(scriptParentParentParent.Analytics.useAnalytics)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useLocalization = Localization.Hooks.useLocalization
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector

local IconButton = UIBlox.App.Button.IconButton
local IconSize = UIBlox.App.ImageSet.Enum.IconSize
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Interactable = UIBlox.Core.Control.Interactable
local TooltipOrientation = UIBlox.App.Dialog.Enum.TooltipOrientation
local useStyle = UIBlox.Core.Style.useStyle
local withTooltip = UIBlox.App.Dialog.TooltipV2.withTooltip

local CaptureManagerOpened = require(scriptParentParentParent.Actions.CaptureManagerOpened)
local CapturesPolicy = require(scriptParentParentParent.App.CapturesPolicy)
local Constants = require(scriptParentParentParent.Constants)
local EventNames = require(scriptParentParentParent.Analytics.EventNames)
local getCaptureStorageUsage = require(scriptParentParentParent.Utils.getCaptureStorageUsage)
local usePingLazyRenderResizing = require(scriptParentParentParent.Hooks.usePingLazyRenderResizing)

return (CapturesPolicy.connect(function(arg1)
    return {
        enableCapturesBulkManagement = arg1.enableCapturesBulkManagement()
    }
end)(function(tbl1)
    local var1 = useAnalytics()
    local var2 = useStyle()
    local var3 = useDispatch()

    local textDefaultColor = var2.Theme.TextDefault.Color
    local textSize = var2.Font.BaseSize * var2.Font.CaptionBody.RelativeSize

    local active, var6 = React.useState(false)

    local var7 = useLocalization({
        oneCaptureLabel = "Feature.Captures.Label.OneCapture",
        multipleCapturesLabel = {
            "Feature.Captures.Label.CaptureCounts",
            numberOfCaptures = tbl1.itemCount
        },
        tooltipTitle = "Feature.Captures.Title.CaptureStorageTooltipTitle",
        tooltipBody = "Feature.Captures.Label.CaptureStorageTooltipLabel"
    })

    local var8 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].Captures
    end)

    local var9 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].Carousel.IsOpen
    end)

    React.useEffect(function()
        if var9 then
            var6(false)
        end
    end, { var9 })

    local onActivated = React.useCallback(function()
        var6(false)
        var1.fireEvent(EventNames.CapturesManagerOpened)
        var3(CaptureManagerOpened())
    end, {})

    local var11 = React.useCallback(function(_)
        var6(not active)
    end, { active })

    local var12 = React.useMemo(function()
        return getCaptureStorageUsage(var8)
    end, { var8 })

    local var13 = if tbl1.itemCount == 1 then var7.oneCaptureLabel else var7.multipleCapturesLabel

    if not tbl1.enableCapturesBulkManagement then
        return nil
    end

    local str1 = `{var13}{if var12 == "" then "" else ", "}{var12}`

    local ref = React.useRef(nil)
    usePingLazyRenderResizing(ref, str1)

    return React.createElement("Frame", {
        BackgroundColor3 = var2.Theme.BackgroundDefault.Color,
        BackgroundTransparency = var2.Theme.BackgroundDefault.Transparency,
        BorderSizePixel = 0,
        LayoutOrder = tbl1.LayoutOrder,
        Size = UDim2.new(1, 0, 0, 36)
    }, {
        GridLayout = React.createElement("UIGridLayout", {
            CellSize = UDim2.new(0.5, -4, 0, 36),
            FillDirection = Enum.FillDirection.Horizontal,
            FillDirectionMaxCells = 2,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }),
        IconFrame = React.createElement("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 0)
        }, {
            ListLayout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Right,
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Center
            }),
            SettingIcon = React.createElement(IconButton, {
                icon = Images["icons/common/settings"],
                iconSize = IconSize.Medium,
                onActivated = onActivated,
                showBackground = false,
                size = UDim2.fromOffset(36, 36)
            })
        }),
        TextFrame = React.createElement("Frame", { BackgroundTransparency = 1 }, {
            ListLayout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                Padding = UDim.new(0, 4),
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Center
            }),
            ItemCountAndStorageSpaceLabel = React.createElement("TextLabel", {
                AutomaticSize = Enum.AutomaticSize.X,
                BackgroundTransparency = 1,
                FontFace = normalizeFontFace(var2.Tokens.Typography.BodySmall.Font),
                LayoutOrder = 1,
                Size = UDim2.fromOffset(0, 20),
                Text = str1,
                TextColor3 = textDefaultColor,
                TextSize = textSize,
                TextWrapped = false,
                TextXAlignment = Enum.TextXAlignment.Left,
                ref = ref
            }),
            InfoIconWithTooltip = withTooltip(
                {
                    headerText = var7.tooltipTitle,
                    bodyText = var7.tooltipBody
                },
                {
                    preferredOrientation = TooltipOrientation.Bottom,
                    guiTarget = CoreGui,
                    DisplayOrder = 100,
                    active = active
                },
                function(callback)
                    local function func1(arg1)
                        var6(false)
                        callback(arg1)
                    end
                    return React.createElement(Interactable, {
                        AnchorPoint = Vector2.new(1, 0.5),
                        BackgroundTransparency = 1,
                        LayoutOrder = 2,
                        Position = UDim2.fromScale(1, 0.5),
                        Size = UDim2.fromOffset(16, 16),
                        [React.Change.AbsolutePosition] = func1,
                        [React.Change.AbsoluteSize] = func1,
                        [React.Event.Activated] = var11
                    }, {
                        InfoIcon = React.createElement(
                            ImageSetLabel,
                            {
                                Size = UDim2.fromScale(1, 1),
                                BackgroundTransparency = 1,
                                Image = Images["icons/actions/info_small"]
                            }
                        )
                    })
                end
            )
        })
    })
end))
