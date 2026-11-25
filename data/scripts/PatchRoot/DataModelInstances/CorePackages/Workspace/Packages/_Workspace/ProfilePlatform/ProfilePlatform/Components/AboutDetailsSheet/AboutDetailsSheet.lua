-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:41:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)
local RobloxAppHooks = require(ProfilePlatformParent.RobloxAppHooks)
local PeekView = require(ProfilePlatformParent.PeekView)
local RoactUtils = require(ProfilePlatformParent.RoactUtils)
local NavigationRodux = require(ProfilePlatformParent.NavigationRodux)
local Foundation = require(ProfilePlatformParent.Foundation)
local InputUi = require(ProfilePlatformParent.InputUi)
local useNavigationProps = require(ProfilePlatformParent.RobloxAppNavigation).useNavigationProps
local SharedFlags = require(ProfilePlatformParent.SharedFlags)
local useProfileFormFactor = require(ProfilePlatform.Hooks.useProfileFormFactor)
local Enums = require(ProfilePlatform.Common.Enums)
local Constants = require(ProfilePlatform.Common.Constants)
local useProfileCardWidth = require(ProfilePlatform.Hooks.useProfileCardWidth)
local useProfileCardWidth2 = require(ProfilePlatformParent.ProfilePlatformCommon).Hooks.useProfileCardWidth
local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization
local TextKeys = require(ProfilePlatform.Common.TextKeys)

local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local NavigateBack = NavigationRodux.Thunks.NavigateBack
local useScreenSize = RobloxAppHooks.useScreenSize
local useTopBarHeight = RobloxAppHooks.useTopBarHeight
local getSafeAreaSize = InputUi.getSafeAreaSize
local PeekViewWithTopBar = PeekView.PeekViewWithTopBar
local PeekViewState = PeekView.PeekViewState
local FFlagProfilePlatformNewProfileHeader = SharedFlags.FFlagProfilePlatformNewProfileHeader
local FFlagSwitchProfileWidthHookToSocialCommon = SharedFlags.FFlagSwitchProfileWidthHookToSocialCommon
local FFlagSignalsNavP3Dispatch = SharedFlags.FFlagSignalsNavP3Dispatch
local FFlagProfileAboutDetailsUseSheet = SharedFlags.FFlagProfileAboutDetailsUseSheet
local FFlagEnableSplitPane = SharedFlags.FFlagEnableSplitPane
local SplitPaneStore = if FFlagEnableSplitPane then require(ProfilePlatformParent.SplitPane).SplitPaneStore else nil
local useSignalState = if FFlagEnableSplitPane then require(ProfilePlatformParent.SignalsReact).useSignalState else nil
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(ProfilePlatformParent.RobloxAppNavigation).NavigationCommands else nil
local IconButton = Foundation.IconButton
local View = Foundation.View
local FoundationText = Foundation.Text
local Sheet = Foundation.Sheet
local OverlayProvider = Foundation.OverlayProvider

local snapPoints = { 0.55, 1 }

local tbl2 = {
    position = UDim2.fromScale(0, 0),
    size = UDim2.fromScale(1, 1),
    anchorPoint = Vector2.new(0, 0)
}

local function AboutDetailsSheetLegacy(_)
    local uDim = UDim.new(0.55, 0)
    local topBarHeight = useTopBarHeight()
    local var1 = useDispatch()
    local var2 = useProfileFormFactor()
    local bool1 = var2.formFactor == Enums.ProfileFormFactor.Wide
    local var3 = if FFlagEnableSplitPane then useSignalState(SplitPaneStore.getStore().getIsSplitEnabled) else false
    local var4 = useScreenSize()
    local var5 = useSelector(function(arg1)
        return arg1.GlobalGuiInset
    end)
    local yOffset2 = useSelector(function(arg1)
        return arg1.TopBar.statusBarHeight
    end)

    local safeAreaSize = getSafeAreaSize(var4, var5)
    local var6 = if FFlagProfilePlatformNewProfileHeader then if FFlagSwitchProfileWidthHookToSocialCommon then useProfileCardWidth2() else useProfileCardWidth(bool1) else math.min(safeAreaSize.X.Offset, Constants.MAXIMUM_CONTAINER_WIDTH)
    local xScale = var6 / safeAreaSize.X.Offset

    local var7 = React.useCallback(function()
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.back(true)
            return
        end
        var1(NavigateBack(true))
    end, { var1 })

    local onActivated = React.useCallback(function()
        var7()
    end, { var7 })

    local onViewStateChanged = React.useCallback(function(closed, _, _)
        if closed == PeekViewState.Closed then
            var7()
        end
    end, { var7 })

    local var10 = useNavigationProps(function(_, arg1)
        return {
            sections = arg1.sections
        }
    end).sections or {}

    local tbl3 = {
        position = UDim2.fromScale(1, 0),
        size = UDim2.fromScale(xScale, 1),
        anchorPoint = Vector2.new(1, 0)
    }

    local var11 = React.useMemo(function()
        return if FFlagEnableSplitPane and var3 then tbl2 elseif bool1 then tbl3 else tbl2
    end, { var2.formFactor, var3 })

    return React.createElement(View, {
        Size = var11.size,
        Position = var11.position,
        AnchorPoint = var11.anchorPoint
    }, {
        AboutDetailsSheet = React.createElement(PeekViewWithTopBar, {
            briefViewContentHeight = uDim,
            fullViewContentHeight = UDim.new(1, -topBarHeight),
            onViewStateChanged = onViewStateChanged,
            topBarHeight = topBarHeight,
            topBarSlot = React.createElement(View, {
                tag = "bg-surface-100",
                Position = UDim2.new(0, 0, 0, 0),
                Size = UDim2.new(0, 0, 0, topBarHeight),
                Active = true,
                BorderSizePixel = 0
            }, {
                LeftNavigationButton = React.createElement(IconButton, {
                    Position = UDim2.new(0, 15, 0, yOffset2),
                    BackgroundTransparency = 1,
                    onActivated = onActivated,
                    icon = "icons/navigation/close"
                })
            }),
            contentSlot = React.createElement(
                View,
                {
                    Size = UDim2.new(1, 0, 1, -topBarHeight),
                    tag = "auto-y align-x-center col padding-bottom-large"
                },
                {
                    Contents = React.createElement(View, {
                        Size = UDim2.new(1, 0, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        tag = "align-x-center col padding-x-xlarge gap-xlarge padding-top-large padding-bottom-large"
                    }, {
                        ContentSections = React.createElement(React.Fragment, {}, var10)
                    })
                }
            )
        })
    })
end

local function AboutDetailsSheetFoundation(_)
    local var1 = useDispatch()
    local var2 = if FFlagEnableSplitPane then useSignalState(SplitPaneStore.getStore().getIsSplitEnabled) else false

    local onClose = React.useCallback(function()
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.back(true)
            return
        end
        var1(NavigateBack(true))
    end, { var1 })

    local var4 = useNavigationProps(function(_, arg1)
        return {
            sections = arg1.sections,
            profileName = arg1.profileName
        }
    end)
    local var5 = var4.sections or {}
    local profileName = var4.profileName

    local var6, ref = React.useState(nil)
    local var8 = useLocalization({ about = TextKeys.About, aboutHeading = { TextKeys.AboutDetailsHeading, name = profileName or "" } })
    local bool1

    if FFlagEnableSplitPane and var2 then
        bool1 = true
        var6 = nil
    else
        bool1 = var6 ~= nil
    end

    local createElement = React.createElement
    local var9 = View
    local tbl3 = {
        ref = ref,
        Size = UDim2.fromScale(1, 1)
    }
    local tbl4 = { Overlay = 0 }
    local var10

    if bool1 then
        local createElement2 = React.createElement
        local var11 = OverlayProvider
        local tbl5 = { gui = var6 }
        local tbl6 = { AboutSheet = 0 }
        local createElement3 = React.createElement
        local root = Sheet.Root
        local tbl7 = {
            onClose = onClose,
            isOpen = true,
            preferCenterSheet = true,
            snapPoints = snapPoints,
            defaultSnapPointIndex = 1
        }
        local tbl8 = { Header = 0, Content = 0 }
        local createElement4 = React.createElement
        local header = Sheet.Header
        local tbl9 = { hasCloseAffordance = true }

        local tbl10 = {
            HeaderContent = React.createElement(FoundationText, {
                LayoutOrder = 1,
                tag = "size-full-0 auto-y text-heading-small text-align-x-left",
                Text = if profileName then var8.aboutHeading else var8.about
            })
        }
        tbl8.Header = createElement4(header, tbl9, tbl10)

        tbl8.Content = React.createElement(Sheet.Content, nil, {
            Contents = React.createElement(View, {
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                tag = "col align-x-center gap-xlarge padding-bottom-large"
            }, {
                ContentSections = React.createElement(React.Fragment, {}, var5)
            })
        })
        tbl6.AboutSheet = createElement3(root, tbl7, tbl8)
        var10 = createElement2(var11, tbl5, tbl6) or nil
    else
        var10 = nil
    end

    tbl4.Overlay = var10
    return createElement(var9, tbl3, tbl4)
end

local function AboutDetailsSheet(arg1)
    if FFlagProfileAboutDetailsUseSheet then
        return AboutDetailsSheetFoundation(arg1)
    end
    return AboutDetailsSheetLegacy(arg1)
end

return AboutDetailsSheet
