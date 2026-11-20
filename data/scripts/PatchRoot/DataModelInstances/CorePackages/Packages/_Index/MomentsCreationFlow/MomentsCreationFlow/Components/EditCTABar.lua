-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationFlow = script:FindFirstAncestor("MomentsCreationFlow")
local MomentsCreationFlowParent = MomentsCreationFlow.Parent

local BuilderIcons = require(MomentsCreationFlowParent.BuilderIcons)
local Foundation = require(MomentsCreationFlowParent.Foundation)
local MomentsCommon = require(MomentsCreationFlowParent.MomentsCommon)
local React = require(MomentsCreationFlowParent.React)

local Icon = Foundation.Icon
local FoundationText = Foundation.Text
local View = Foundation.View

local TextUppercaseALowercaseA = BuilderIcons.Icon.TextUppercaseALowercaseA
local ThreeBarsVerticalTrianglesHorizontal = BuilderIcons.Icon.ThreeBarsVerticalTrianglesHorizontal
local MusicNote = BuilderIcons.Icon.MusicNote

local GradientBackdrop = MomentsCommon.GradientBackdrop

local CreationFlowStateUpdated = require(MomentsCreationFlow.Actions.CreationFlowStateUpdated)

local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useDispatch = MomentsCommon.Hooks.useDispatch
local useTokens = Foundation.Hooks.useTokens

local CreationFlowContext = require(MomentsCreationFlow.Context.CreationFlowContext)

local CreationFlowState = require(MomentsCreationFlow.Enums.CreationFlowState)

local CreationFlowLocalization = require(MomentsCreationFlow.Enums.CreationFlowLocalization)
local EventNames = require(MomentsCreationFlow.Analytics.EventNames)

return function(tbl1)
    local var1 = useDeviceInsets()
    local var2 = useTokens()
    local var3 = React.useContext(CreationFlowContext)

    local var4 = useDispatch()
    local size, var6 = React.useBinding(UDim2.fromScale(1, 0))

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        var6(UDim2.new(0, 1.5 * arg1.AbsoluteSize.X, 1, 0))
    end, {})

    local onActivated = React.useCallback(function()
        var4(CreationFlowStateUpdated(CreationFlowState.Trimming))
        var3.fireEvent(EventNames.EditingFlowTrimButtonPressed)
    end)

    local var5 = React.useCallback(function()
        var4(CreationFlowStateUpdated(CreationFlowState.Music))
        var3.fireEvent(EventNames.EditingFlowMusicButtonPressed)
    end)

    local var7 = React.useCallback(function()
        var4(CreationFlowStateUpdated(CreationFlowState.TextOverlay))
        var3.fireEvent(EventNames.EditingFlowTextOverlayButtonPressed)
    end)

    local createElement = React.createElement
    local var11 = View
    local tbl2 = {
        tag = "auto-x anchor-center-right position-center-right size-0-full",
        ZIndex = tbl1.zIndex
    }
    local tbl3 = {
        GradientBackdrop = React.createElement(GradientBackdrop, { color3 = var2.Color.Common.Scrim.Color3, rotation = 180, size = size }),
        EditCTABar = 0
    }

    local createElement2 = React.createElement
    local var12 = View
    local tbl4 = {
        tag = "align-x-right align-y-center anchor-center-right auto-x col gap-small position-center-right size-0-full",
        onAbsoluteSizeChanged = onAbsoluteSizeChanged
    }
    local tbl5 = {
        Padding = React.createElement(
            "UIPadding",
            {
                PaddingLeft = UDim.new(0, var2.Padding.Large),
                PaddingRight = UDim.new(0, var1.right + var2.Padding.Large)
            }
        ),
        TrimCTAButton = 0,
        MusicCTAButton = 0,
        TextOverlayCTAButton = 0
    }
    local element

    if tbl1.captureType == Enum.CaptureType.Video then
        element = React.createElement(View, {
            LayoutOrder = 1,
            onActivated = onActivated,
            tag = "align-x-right align-y-center auto-xy row gap-medium padding-xsmall radius-medium"
        }, {
            Icon = React.createElement(
                Icon,
                {
                    name = ThreeBarsVerticalTrianglesHorizontal,
                    LayoutOrder = 2,
                    size = Foundation.Enums.IconSize.Large
                }
            ),
            Text = if tbl1.showText then React.createElement(FoundationText, {
                LayoutOrder = 1,
                tag = "auto-xy text-label-medium content-emphasis",
                Text = var3.getLocalization(CreationFlowLocalization.EditingCtaTrimming)
            }) else nil
        })
    else
        element = nil
    end

    tbl5.TrimCTAButton = element
    local element2

    if tbl1.captureType == Enum.CaptureType.Video or tbl1.captureType == Enum.CaptureType.Screenshot then
        element2 = React.createElement(View, {
            LayoutOrder = 2,
            onActivated = var5,
            tag = "align-x-right align-y-center auto-xy row gap-medium padding-xsmall radius-medium"
        }, {
            Icon = React.createElement(Icon, { name = MusicNote, LayoutOrder = 2, size = Foundation.Enums.IconSize.Large }),
            Text = if tbl1.showText then React.createElement(FoundationText, {
                LayoutOrder = 1,
                tag = "auto-xy text-label-medium content-emphasis",
                Text = var3.getLocalization(CreationFlowLocalization.EditingCtaMusic)
            }) else nil
        })
    else
        element2 = nil
    end

    tbl5.MusicCTAButton = element2
    local element3

    if tbl1.captureType == Enum.CaptureType.Video then
        element3 = React.createElement(View, {
            LayoutOrder = 3,
            onActivated = var7,
            tag = "align-x-right align-y-center auto-xy row gap-medium padding-xsmall radius-medium"
        }, {
            Icon = React.createElement(Icon, { name = TextUppercaseALowercaseA, LayoutOrder = 2, size = Foundation.Enums.IconSize.Large }),
            Text = if tbl1.showText then React.createElement(FoundationText, {
                LayoutOrder = 1,
                tag = "auto-xy text-label-medium content-emphasis",
                Text = var3.getLocalization(CreationFlowLocalization.EditingCtaTextOverlay)
            }) else nil
        })
    else
        element3 = nil
    end

    tbl5.TextOverlayCTAButton = element3
    tbl3.EditCTABar = createElement2(var12, tbl4, tbl5)
    return createElement(var11, tbl2, tbl3)
end
