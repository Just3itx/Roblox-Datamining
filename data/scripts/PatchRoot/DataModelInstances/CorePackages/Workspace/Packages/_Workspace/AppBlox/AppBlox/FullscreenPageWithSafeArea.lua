-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent

local Roact = require(AppBloxParent.Roact)
local RoactRodux = require(AppBloxParent.RoactRodux)

local getSafeAreaSize = require(AppBloxParent.InputUi).getSafeAreaSize
local IsVRAppBuild = require(AppBloxParent.AppCommonLib).IsVRAppBuild
local Constants = require(AppBloxParent.AppSystemBar).Constants

local var1 = Roact.PureComponent:extend("FullscreenPageWithSafeArea")
local useSignalState = require(AppBloxParent.SignalsReact).useSignalState
local Display = require(AppBloxParent.Display)
local Cryo = require(AppBloxParent.Cryo)

local FFlagExtendScrollingFramesBySafeInsets = require(AppBloxParent.SharedFlags).FFlagExtendScrollingFramesBySafeInsets

function var1.render(arg1)
    local statusBarHeight = arg1.props.statusBarHeight
    local screenSize = arg1.props.screenSize
    local globalGuiInset = arg1.props.globalGuiInset

    local backgroundColor3 = arg1.props.BackgroundColor3
    local backgroundTransparency = arg1.props.BackgroundTransparency
    local includeStatusBar = arg1.props.includeStatusBar
    local includeBottomBar = arg1.props.includeBottomBar
    local renderFullscreenBackground = arg1.props.renderFullscreenBackground
    local prop = arg1.props[Roact.Children]
    local buttonRef = arg1.props.buttonRef
    local deviceSafePadding = if FFlagExtendScrollingFramesBySafeInsets then arg1.props.deviceSafePadding else nil

    if screenSize.X == 0 or screenSize.Y == 0 then
        return nil
    end

    local safeAreaSize = getSafeAreaSize(screenSize, globalGuiInset)
    local yOffset = globalGuiInset.top + (FFlagExtendScrollingFramesBySafeInsets and deviceSafePadding.top or 0)

    local var2 = arg1.props.useFullScalePage or IsVRAppBuild()

    if includeStatusBar then
        safeAreaSize = UDim2.new(0, safeAreaSize.X.Offset, 0, safeAreaSize.Y.Offset - statusBarHeight)
        yOffset += statusBarHeight
    end

    if includeBottomBar then
        safeAreaSize = UDim2.new(0, safeAreaSize.X.Offset, 0, safeAreaSize.Y.Offset - Constants.BOTTOM_BAR_SIZE)
    end

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl1 = {
        Position = if var2 then UDim2.new(0, 0, 0, 0) else UDim2.new(
            0,
            -globalGuiInset.left - (FFlagExtendScrollingFramesBySafeInsets and deviceSafePadding.left or 0),
            0,
            -globalGuiInset.top - (FFlagExtendScrollingFramesBySafeInsets and deviceSafePadding.top or 0)
        ),
        Size = if var2 then UDim2.new(1, 0, 1, 0) else UDim2.new(0, screenSize.X, 0, screenSize.Y),
        BackgroundColor3 = backgroundColor3,
        BackgroundTransparency = backgroundTransparency,
        Active = true,
        BorderSizePixel = 0,
        ClipsDescendants = not FFlagExtendScrollingFramesBySafeInsets,
        [Roact.Ref] = buttonRef
    }
    local tbl2 = {
        Background = renderFullscreenBackground and renderFullscreenBackground(yOffset),
        SafeAreaFrame = 0
    }
    local createElement2 = Roact.createElement
    local str2 = "Frame"
    local tbl3 = {
        Position = if var2 then UDim2.new(0, 0, 0, 0) else UDim2.new(0, globalGuiInset.left + (FFlagExtendScrollingFramesBySafeInsets and deviceSafePadding.left or 0), 0, yOffset),
        Size = 0,
        BackgroundTransparency = 1,
        ZIndex = 0
    }

    if var2 then
        safeAreaSize = UDim2.new(1, 0, 1, 0)
    end

    tbl3.Size = safeAreaSize

    tbl3.ZIndex = if renderFullscreenBackground then 2 else 1
    tbl2.SafeAreaFrame = createElement2(str2, tbl3, prop)
    return createElement(str1, tbl1, tbl2)
end

local var2 = RoactRodux.connect(function(arg1, _)
    return {
        statusBarHeight = arg1.TopBar.statusBarHeight,
        screenSize = arg1.ScreenSize,
        globalGuiInset = arg1.GlobalGuiInset
    }
end)(var1)

if not FFlagExtendScrollingFramesBySafeInsets then
    return var2
end

local function FullscreenPageWithSafeAreaFunctional(arg1)
    local deviceSafePadding = useSignalState(Display.GetDisplayStore().getDeviceSafePadding)
    local var4 = Cryo.Dictionary.join(arg1, { deviceSafePadding = deviceSafePadding })

    return Roact.createElement(var2, var4)
end
return FullscreenPageWithSafeAreaFunctional
