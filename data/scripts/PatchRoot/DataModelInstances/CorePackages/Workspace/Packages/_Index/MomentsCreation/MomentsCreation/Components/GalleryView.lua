-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:51:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local BuilderIcons = require(MomentsCreationParent.BuilderIcons)
local Cryo = require(MomentsCreationParent.Cryo)
local Foundation = require(MomentsCreationParent.Foundation)
local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local React = require(MomentsCreationParent.React)

local Button = Foundation.Button
local ButtonVariant = Foundation.Enums.ButtonVariant
local Chip = Foundation.Chip
local InputSize = Foundation.Enums.InputSize
local FoundationText = Foundation.Text
local View = Foundation.View

local Image = BuilderIcons.Icon.Image
local VideoCamera = BuilderIcons.Icon.VideoCamera

local CaptureItem = require(MomentsCreation.Components.CaptureItem)
local ScrollingGridView = MomentsCommon.ScrollingGridView

local useCallback = React.useCallback
local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useTokens = Foundation.Hooks.useTokens

local Constants = require(MomentsCreation.Constants)
local fireAnalyticsEvent = require(MomentsCreation.Analytics.fireAnalyticsEvent)
local makeCreationEventFields = require(MomentsCreation.Analytics.makeCreationEventFields)
local useCreationFlowStrings = require(MomentsCreation.Hooks.useCreationFlowStrings)

local EventNames = MomentsCommon.Analytics.EventNames
local SessionManager = MomentsCommon.Analytics.SessionManager
local FunnelEventNames = MomentsCommon.Analytics.FunnelEventNames

return function(tbl1)
    local var1 = useDeviceInsets()
    local var2 = useTokens()
    local var3 = useCreationFlowStrings()
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

            local sessionId = SessionManager.getSessionId(FunnelEventNames.FunnelTypes.CreationFlow)
            fireAnalyticsEvent(
                EventNames.EditingFlowGalleryNoCapturesAvailable,
                makeCreationEventFields.makeCreationBaseFields(sessionId)
            )
        end
    end, { tbl1.captures })

    local onActivated = useCallback(function(arg1)
        tbl1.onCaptureSelected(arg1)
    end, { tbl1.onCaptureSelected })

    local renderItem = useCallback(function(capture, _: number)
        return React.createElement(
            CaptureItem,
            {
                capture = capture,
                onActivated = onActivated,
                selected = tbl1.selectedCapture == capture,
                zIndex = 1
            }
        )
    end, { tbl1.selectedCapture, onActivated })

    local renderEmptyState = useCallback(function()
        return React.createElement(View, { tag = "shrink size-full-full" }, {
            EmptyState = React.createElement(FoundationText, {
                tag = "position-top-center anchor-top-center auto-xy padding-large text-body-medium text-align-x-center text-align-y-center content-action-emphasis",
                Text = var3.GeneralEmptyStateText
            })
        })
    end, { var3 })

    local var7 = useCallback(function()
        var5(nil)
    end, {})

    local var8 = useCallback(function()
        var5(Enum.CaptureType.Screenshot)
    end, {})

    local var9 = useCallback(function()
        var5(Enum.CaptureType.Video)
    end, {})

    local onShowMoreCallback = useCallback(function()
        if tbl1.onShowMore then
            tbl1.onShowMore()
        end
    end, { tbl1.onShowMore })

    local createElement = React.createElement
    local var15 = View
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        padding = {
            top = UDim.new(0, var2.Padding.Large),
            bottom = UDim.new(0, math.max(var1.bottom, var2.Padding.Large))
        },
        tag = "col align-x-center align-y-bottom shrink gap-large position-bottom-center anchor-bottom-center size-full-0 auto-y"
    }

    local tbl3 = {
        FilterButtons = React.createElement(View, {
            LayoutOrder = 1,
            padding = {
                left = UDim.new(0, math.max(var1.left, var2.Padding.XLarge)),
                right = UDim.new(0, math.max(var1.right, var2.Padding.XLarge))
            },
            tag = "row gap-small position-top-center anchor-top-center size-full-0 auto-y"
        }, {
            AllChip = React.createElement(Chip, {
                isChecked = var4 == nil,
                LayoutOrder = 1,
                onActivated = var7,
                size = Foundation.Enums.ChipSize.Small,
                text = var3.GeneralAllChipLabel
            }),
            PhotosChip = React.createElement(Chip, {
                isChecked = var4 == Enum.CaptureType.Screenshot,
                LayoutOrder = 2,
                leading = Image,
                onActivated = var8,
                size = Foundation.Enums.ChipSize.Small,
                text = var3.GeneralPhotosChipLabel
            }),
            VideosChip = React.createElement(Chip, {
                isChecked = var4 == Enum.CaptureType.Video,
                LayoutOrder = 3,
                leading = VideoCamera,
                onActivated = var9,
                size = Foundation.Enums.ChipSize.Small,
                text = var3.GeneralVideosChipLabel
            })
        }),
        CaptureGrid = React.createElement(View, {
            LayoutOrder = 2,
            padding = {
                left = UDim.new(0, var1.left),
                right = UDim.new(0, var1.right)
            },
            tag = "row shrink gap-small position-top-center anchor-top-center size-full-full"
        }, {
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
                shouldShowShowMoreButton = tbl1.hasMoreCaptures == true,
                showMoreButtonText = var3.GeneralCtaShowMore
            })
        }),
        ButtonContainer = React.createElement(View, {
            LayoutOrder = 3,
            padding = {
                left = UDim.new(0, math.max(var1.left, var2.Padding.XLarge)),
                right = UDim.new(0, math.max(var1.right, var2.Padding.XLarge))
            },
            tag = "align-x-center size-full-0 auto-y"
        }, {
            ButtonConstraint = React.createElement(
                View,
                {
                    sizeConstraint = {
                        MaxSize = Constants.BottomBarSizeConstraint
                    },
                    tag = "size-full-0 auto-y"
                },
                {
                    NextButton = React.createElement(Button, {
                        fillBehavior = Foundation.Enums.FillBehavior.Fill,
                        isDisabled = not tbl1.selectedCapture,
                        LayoutOrder = 1,
                        onActivated = tbl1.onNextCallback,
                        size = InputSize.Medium,
                        text = var3.PublishingCtaContinue,
                        variant = ButtonVariant.Emphasis
                    })
                }
            )
        })
    }
    return createElement(var15, tbl2, tbl3)
end
