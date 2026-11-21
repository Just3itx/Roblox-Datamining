-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailParent = script:FindFirstAncestor("GameDetail").Parent

local React = require(GameDetailParent.React)

local Foundation = require(GameDetailParent.Foundation)
local View = Foundation.View
local IconButton = Foundation.IconButton
local IconName = Foundation.Enums.IconName
local ButtonSize = Foundation.Enums.ButtonSize
local ButtonVariant = Foundation.Enums.ButtonVariant
local useTokens = Foundation.Hooks.useTokens

local useDeviceInsets = require(GameDetailParent.Responsive).useDeviceInsets
local AppPage = require(GameDetailParent.RobloxAppEnums).AppPage
local NavigationRodux = require(GameDetailParent.NavigationRodux)
local Selectors = NavigationRodux.Selectors
local NavigateBack = NavigationRodux.Thunks.NavigateBack
local PeekViewState = require(GameDetailParent.PeekView).PeekViewState

local RoactUtils = require(GameDetailParent.RoactUtils)
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch

local SharedFlags = require(GameDetailParent.SharedFlags)
local FFlagUseNavigationSelectors = SharedFlags.FFlagUseNavigationSelectors
local FFlagSignalsNavP3fGameDetails = SharedFlags.FFlagSignalsNavP3fGameDetails
local FFlagSignalsNavP3Dispatch = SharedFlags.FFlagSignalsNavP3Dispatch
local FFlagFixOverlayTopInsetForDeviceSafeInsets = SharedFlags.FFlagFixOverlayTopInsetForDeviceSafeInsets
local shouldUseDeviceSafeInsets = require(GameDetailParent.Display).shouldUseDeviceSafeInsets
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(GameDetailParent.RobloxAppNavigation).NavigationCommands else nil
local useSignalState = require(GameDetailParent.SignalsReact).useSignalState
local createComputed = require(GameDetailParent.Signals).createComputed
local GetLegacyNavigationStore = require(GameDetailParent.NavigationRodux).GetLegacyNavigationStore

local ExperienceDetailsPageUtils = require(script.Parent.ExperienceDetailsPageUtils)

return React.memo(function(tbl1) -- name: PeekViewTopBar
    local pageProps = tbl1.pageProps
    local onClose = tbl1.onClose

    local var1 = useDispatch()
    local var2 = useDeviceInsets()
    local var3 = useTokens()
    local var4

    if FFlagSignalsNavP3fGameDetails then
        local var5 = React.useMemo(function()
            local legacyNavigationStore = GetLegacyNavigationStore(false)
            return createComputed(function(arg1)
                local currentLegacyRoute = legacyNavigationStore.getCurrentLegacyRoute(arg1)
                local num1 = 0
                if currentLegacyRoute then
                    for i = 1, #currentLegacyRoute do
                        if currentLegacyRoute[i].name ~= AppPage.GameDetail then
                            continue
                        end

                        num1 += 1
                        if num1 > 1 then
                            return true
                        end
                    end
                end

                return false
            end)
        end, {})
        var4 = useSignalState(var5)
    else
        var4 = useSelector(function(arg1)
            local var5 = if FFlagUseNavigationSelectors then Selectors.selectLegacyHistory(arg1) else arg1.Navigation.history
            local var6 = var5 and var5[#var5]
            local num1 = 0
            if var6 then
                for i = 1, #var6 do
                    if var6[i].name ~= AppPage.GameDetail then
                        continue
                    end

                    num1 += 1
                    if num1 > 1 then
                        return true
                    end
                end
            end

            return false
        end)
    end

    React.useEffect(function()
        return function()
            if not var4 then
                var1({ type = "SetGameDetailsPeekViewState", viewState = PeekViewState.Closed })
            end
        end
    end, { var1, var4 })

    local fromPropsOrNavigationParams = ExperienceDetailsPageUtils.getFromPropsOrNavigationParams(pageProps, "showBackButton")

    if fromPropsOrNavigationParams == nil then
        fromPropsOrNavigationParams = var4
    end
    local onActivated = React.useCallback(function()
        if not fromPropsOrNavigationParams then
            onClose()

            return
        end

        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.back()
            return
        end
        var1(NavigateBack())
    end, { fromPropsOrNavigationParams, var1, onClose })

    local createElement = React.createElement
    local var6 = View
    local tbl2 = {
        tag = "row align-y-center size-full",
        padding = {
            top = UDim.new(0, if FFlagFixOverlayTopInsetForDeviceSafeInsets and shouldUseDeviceSafeInsets then 0 else var2.top),
            left = UDim.new(0, var3.Padding.Large)
        }
    }
    local tbl3 = {
        NavButton = React.createElement(IconButton, {
            icon = if fromPropsOrNavigationParams then IconName.ChevronLargeLeft else IconName.X,
            variant = ButtonVariant.Utility,
            size = ButtonSize.Medium,
            isCircular = true,
            onActivated = onActivated,
            testId = "--discovery-edp-iconbutton-peekview-nav"
        })
    }
    return createElement(var6, tbl2, tbl3)
end)
