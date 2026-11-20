-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationFlow = script:FindFirstAncestor("MomentsCreationFlow")
local MomentsCreationFlowParent = MomentsCreationFlow.Parent

local BuilderIcons = require(MomentsCreationFlowParent.BuilderIcons)
local Cryo = require(MomentsCreationFlowParent.Cryo)
local Foundation = require(MomentsCreationFlowParent.Foundation)
local MomentsCommon = require(MomentsCreationFlowParent.MomentsCommon)
local React = require(MomentsCreationFlowParent.React)

local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local Chip = Foundation.Chip
local InputSize = Foundation.Enums.InputSize
local FoundationText = Foundation.Text
local View = Foundation.View

local Image = BuilderIcons.Icon.Image
local VideoCamera = BuilderIcons.Icon.VideoCamera

local CaptureItem = require(MomentsCreationFlow.Components.CaptureItem)
local ScrollingGridView = MomentsCommon.ScrollingGridView

local useCallback = React.useCallback
local useContext = React.useContext
local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useTokens = Foundation.Hooks.useTokens

local CreationFlowContext = require(MomentsCreationFlow.Context.CreationFlowContext)

local Constants = require(MomentsCreationFlow.Constants)
local CreationFlowLocalization = require(MomentsCreationFlow.Enums.CreationFlowLocalization)
local EventNames = require(MomentsCreationFlow.Analytics.EventNames)

return function(tbl1)
    local var1 = useDeviceInsets()
    local var2 = useTokens()
    local var3 = useContext(CreationFlowContext)
    local var4, var5 = React.useState(nil)
    local var6 = React.useRef(false)

    local items = React.useMemo(function()
        if not var4 then
            return tbl1.captures
        end

        return Cryo.List.filter(tbl1.captures, function(arg1): boolean
            return arg1.CaptureType == var4
        end)
    end, { tbl1.captures, var4 })

    React.useEffect(function()
        if #tbl1.captures == 0 and var6.current == false then
            var6.current = true
            var3.fireEvent(EventNames.EditingFlowGalleryNoCapturesAvailable)
        end
    end, { tbl1.captures })

    local renderItem = useCallback(function(capture, _: number)
        return React.createElement(
            CaptureItem,
            {
                capture = capture,
                onActivated = tbl1.onCaptureSelected,
                selected = tbl1.selectedCapture == capture,
                zIndex = 1
            }
        )
    end, { tbl1.selectedCapture, tbl1.onCaptureSelected })

    local renderEmptyState = useCallback(function()
        return React.createElement(View, { tag = "shrink size-full-full" }, {
            EmptyState = React.createElement(FoundationText, {
                tag = "anchor-top-center auto-xy content-action-emphasis padding-large position-top-center text-align-x-center text-align-y-center text-body-medium",
                Text = var3.getLocalization(CreationFlowLocalization.GeneralEmptyStateText)
            })
        })
    end, { var3 })

    local onActivated = useCallback(function()
        var5(nil)
    end, {})

    local var7 = useCallback(function()
        var5(Enum.CaptureType.Screenshot)
    end, {})

    local var8 = useCallback(function()
        var5(Enum.CaptureType.Video)
    end, {})

    local onShowMoreCallback = useCallback(function()
        var3.fetchAdditionalCaptures()
    end, { var3 })

    local createElement = React.createElement
    local var14 = View
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        tag = "align-x-center auto-y align-y-bottom anchor-bottom-center gap-large position-bottom-center col shrink size-full-0"
    }
    local tbl3 = {
        Padding = React.createElement(
            "UIPadding",
            {
                PaddingTop = UDim.new(0, var2.Padding.Large),
                PaddingBottom = UDim.new(0, math.max(var1.bottom, var2.Padding.Large))
            }
        ),
        FilterButtons = 0,
        CaptureGrid = 0,
        ButtonContainer = 0
    }

    local createElement2 = React.createElement
    local var15 = View

    local tbl4 = {
        Padding = React.createElement("UIPadding", {
            PaddingLeft = UDim.new(0, math.max(var1.left, var2.Padding.XLarge)),
            PaddingRight = UDim.new(0, math.max(var1.right, var2.Padding.XLarge))
        }),
        AllChip = React.createElement(Chip, {
            isChecked = var4 == nil,
            LayoutOrder = 1,
            onActivated = onActivated,
            size = Foundation.Enums.ChipSize.Small,
            text = var3.getLocalization(CreationFlowLocalization.GeneralAllChipLabel)
        }),
        PhotosChip = React.createElement(Chip, {
            isChecked = var4 == Enum.CaptureType.Screenshot,
            LayoutOrder = 2,
            leading = Image,
            onActivated = var7,
            size = Foundation.Enums.ChipSize.Small,
            text = var3.getLocalization(CreationFlowLocalization.GeneralPhotosChipLabel)
        }),
        VideosChip = React.createElement(Chip, {
            isChecked = var4 == Enum.CaptureType.Video,
            LayoutOrder = 3,
            leading = VideoCamera,
            onActivated = var8,
            size = Foundation.Enums.ChipSize.Small,
            text = var3.getLocalization(CreationFlowLocalization.GeneralVideosChipLabel)
        })
    }
    tbl3.FilterButtons = createElement2(
        var15,
        {
            LayoutOrder = 1,
            tag = "auto-y anchor-top-center gap-small position-top-center row size-full-0"
        },
        tbl4
    )

    tbl3.CaptureGrid = React.createElement(
        View,
        {
            LayoutOrder = 2,
            tag = "anchor-top-center gap-small position-top-center row shrink size-full-full"
        },
        {
            Padding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, var1.left), PaddingRight = UDim.new(0, var1.right) }),
            CaptureGrid = React.createElement(ScrollingGridView, {
                aspectRatio = 1,
                itemConfig = {
                    padding = 2,
                    maxItemsPerRow = 5,
                    minItemsPerPage = 6,
                    minItemWidth = 100
                },
                items = items,
                layoutOrder = 1,
                onShowMoreCallback = onShowMoreCallback,
                padding = {
                    bottom = UDim.new(0, var2.Padding.Large)
                },
                renderEmptyState = renderEmptyState,
                renderItem = renderItem,
                shouldShowShowMoreButton = not var3.capturesPagesIsFinished(),
                showMoreButtonText = var3.getLocalization(CreationFlowLocalization.GeneralCtaShowMore)
            })
        }
    )
    local createElement3 = React.createElement
    local var16 = View

    local tbl5 = {
        Padding = React.createElement("UIPadding", {
            PaddingLeft = UDim.new(0, math.max(var1.left, var2.Padding.XLarge)),
            PaddingRight = UDim.new(0, math.max(var1.right, var2.Padding.XLarge))
        }),
        ButtonConstraint = React.createElement(
            View,
            {
                sizeConstraint = {
                    MaxSize = Constants.BottomBarSizeConstraint
                },
                tag = "auto-y size-full-0"
            },
            {
                NextButton = React.createElement(Button, {
                    fillBehavior = Foundation.Enums.FillBehavior.Fill,
                    isDisabled = not tbl1.selectedCapture,
                    LayoutOrder = 1,
                    onActivated = tbl1.onNextCallback,
                    size = InputSize.Medium,
                    text = var3.getLocalization(CreationFlowLocalization.PublishingCtaContinue),
                    variant = ButtonVariant.Emphasis
                })
            }
        )
    }
    tbl3.ButtonContainer = createElement3(var16, { LayoutOrder = 3, tag = "align-x-center auto-y size-full-0" }, tbl5)
    return createElement(var14, tbl2, tbl3)
end
