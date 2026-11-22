-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProgressLoadingParent = script:FindFirstAncestor("ProgressLoading").Parent

local React = require(ProgressLoadingParent.React)
local Foundation = require(ProgressLoadingParent.Foundation)
local Localization = require(ProgressLoadingParent.Localization)
local InExperienceLocales = require(ProgressLoadingParent.InExperienceLocales)
local Responsive = require(ProgressLoadingParent.Responsive)
local useDeviceInsets = Responsive.useDeviceInsets
local usePreferredInput = Responsive.usePreferredInput
local getBuilderIconForKeycode = Foundation.Utility.getBuilderIconForKeycode

local TiltLoadingScreenContent = require(script.Parent.TiltLoadingScreenContent)
local useExperienceLoadingLifecycle = require(script.Parent.Hooks.useExperienceLoadingLifecycle)
local useDeferredLoadingLifecycle = require(script.Parent.Hooks.useDeferredLoadingLifecycle)
local Constants = require(script.Parent.Constants)
local FFlagEnableTiltLoadingScreen = require(ProgressLoadingParent.SharedFlags).FFlagEnableTiltLoadingScreen
local FFlagIncreaseLoadingScreenOrder = require(ProgressLoadingParent.SharedFlags).FFlagIncreaseLoadingScreenOrder
local FFlagTiltLoadingScreenConsoleHints = require(ProgressLoadingParent.SharedFlags).FFlagTiltLoadingScreenConsoleHints
local FFlagTiltLoadingScreenEnterExitHold = require(ProgressLoadingParent.SharedFlags).FFlagTiltLoadingScreenEnterExitHold
local FFlagTiltLoadingScreenDismissOnLoaded = require(ProgressLoadingParent.SharedFlags).FFlagTiltLoadingScreenDismissOnLoaded
local isPioneerLaunch = require(ProgressLoadingParent.PioneerUtils).isPioneerLaunch

local ContextActionService = game:GetService("ContextActionService")
local LocalizationService = game:GetService("LocalizationService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")

local _Types = require(script.Parent.Types)

local function TiltLoadingScreenContainer(arg1)
    if not FFlagEnableTiltLoadingScreen then
        return nil
    end

    local onTopOfCoreBlur = arg1.deferredJoin ~= nil
    local var1 = useExperienceLoadingLifecycle(not onTopOfCoreBlur, arg1.milestones, arg1.onDismissComplete)
    local var2 = useDeferredLoadingLifecycle
    local assetService = if arg1.deferredJoin then arg1.deferredJoin.assetService else nil
    local var3, onCancel = var2(onTopOfCoreBlur, assetService, arg1.onCancel)

    local reducedMotion = UserGameSettings.ReducedMotion
    local var4 = React.useRef(arg1.onCancel)
    if not onTopOfCoreBlur then
        onCancel = arg1.onCancel
    end

    var4.current = onCancel
    local var5 = if FFlagTiltLoadingScreenConsoleHints then usePreferredInput() else nil
    local isDirectionalInput = FFlagTiltLoadingScreenConsoleHints and var5 == Responsive.Input.Directional
    local gamepadCancelIcon = if isDirectionalInput then getBuilderIconForKeycode(Enum.KeyCode.ButtonB) else nil
    local safeAreaInsets = useDeviceInsets()
    local localization = React.useMemo(function()
        return InExperienceLocales.Localization.new(LocalizationService.RobloxLocaleId)
    end, {})

    local bool2 = not (FFlagTiltLoadingScreenDismissOnLoaded and not var1.isVisible)

    React.useEffect(function()
        if not bool2 then
            return
        end
        if isPioneerLaunch() then
            return
        end
        local var9 = arg1.contextActionService or ContextActionService
        local bool3 = false
        var9:BindCoreAction("CancelGameLoad", function(_, userInputState)
            if userInputState == Enum.UserInputState.Begin then
                bool3 = true
            elseif userInputState == Enum.UserInputState.End and bool3 then
                bool3 = false
                if var4.current then
                    var4.current(false, true)
                end
            end
        end, false, Enum.KeyCode.ButtonB)

        return function()
            var9:UnbindCoreAction("CancelGameLoad")
        end
    end, { arg1.contextActionService, bool2 })
    local preferences = React.useMemo(function()
        return { reducedMotion = reducedMotion }
    end, { reducedMotion })
    local var6 = React.useCallback(function()
        if var4.current then
            var4.current(true)
        end
    end, {})

    if not var1.isVisible then
        return nil
    end

    local displayOrder = if arg1.deferredJoin then arg1.deferredJoin.displayOrder elseif FFlagIncreaseLoadingScreenOrder then Constants.DISPLAY_ORDER + 1 else Constants.DISPLAY_ORDER
    local createElement = React.createElement
    local str1 = "ScreenGui"
    local tbl1 = {
        DisplayOrder = displayOrder,
        OnTopOfCoreBlur = onTopOfCoreBlur,
        IgnoreGuiInset = true,
        ScreenInsets = Enum.ScreenInsets.None,
        ClipToDeviceSafeArea = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    }
    local tbl2 = { Foundation = 0 }
    local createElement2 = React.createElement
    local foundationProvider = Foundation.FoundationProvider
    local tbl3 = {
        colorMode = Foundation.Enums.ColorMode.Dark,
        preferences = preferences
    }
    local tbl4 = { Localization = 0 }
    local createElement3 = React.createElement
    local localizationProvider = Localization.LocalizationProvider
    local tbl5 = { localization = localization }
    local tbl6 = { View = 0 }
    local createElement4 = React.createElement
    local var12 = TiltLoadingScreenContent
    local tbl7 = {
        placeId = arg1.placeId,
        destinationUniverseId = if arg1.deferredJoin then arg1.deferredJoin.universeId else nil,
        milestones = 0,
        reducedMotion = 0,
        isDismissing = 0,
        onEnterComplete = 0,
        isDirectionalInput = 0,
        gamepadCancelIcon = 0,
        chromeReveal = 0,
        onCancel = 0,
        safeAreaInsets = 0
    }

    if not onTopOfCoreBlur then
        var3 = var1.milestones
    end

    tbl7.milestones = var3
    tbl7.reducedMotion = reducedMotion
    tbl7.isDismissing = var1.isDismissing
    tbl7.onEnterComplete = if onTopOfCoreBlur or not FFlagTiltLoadingScreenEnterExitHold then nil else var1.onEnterComplete

    tbl7.isDirectionalInput = isDirectionalInput
    tbl7.gamepadCancelIcon = gamepadCancelIcon
    tbl7.chromeReveal = var1.chromeReveal
    tbl7.onCancel = var6
    tbl7.safeAreaInsets = safeAreaInsets
    tbl6.View = createElement4(var12, tbl7)
    tbl4.Localization = createElement3(localizationProvider, tbl5, tbl6)
    tbl2.Foundation = createElement2(foundationProvider, tbl3, tbl4)
    return createElement(str1, tbl1, tbl2)
end

return TiltLoadingScreenContainer
