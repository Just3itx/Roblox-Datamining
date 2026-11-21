-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:01:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetail = script:FindFirstAncestor("GameDetail")
local SetGameDetailsPeekViewState = require(GameDetail.PeekView.SetGameDetailsPeekViewState)
local UseGameDetailsPeekView = require(GameDetail.PeekView.UseGameDetailsPeekView)

local GameDetailParent = GameDetail.Parent
local Cryo = require(GameDetailParent.Cryo)
local AppPage = require(GameDetailParent.RobloxAppEnums).AppPage
local FormFactor = require(GameDetailParent.FormFactor).Enums.FormFactor
local PeekViewState = require(GameDetailParent.PeekView).PeekViewState
local NavigationRodux = require(GameDetailParent.NavigationRodux)
local NavigateDown = NavigationRodux.Thunks.NavigateDown
local Selectors = NavigationRodux.Selectors

local SharedFlags = require(GameDetailParent.SharedFlags)
local FFlagSignalsNavP2NavigationPrimitives = SharedFlags.FFlagSignalsNavP2NavigationPrimitives
local FFlagSignalsNavP3fGameDetails = SharedFlags.FFlagSignalsNavP3fGameDetails
local FFlagSignalsNavP3Dispatch = SharedFlags.FFlagSignalsNavP3Dispatch
local FFlagSignalsNavPendingLock = SharedFlags.FFlagSignalsNavPendingLock
local FFlagUseNavigationSelectors = SharedFlags.FFlagUseNavigationSelectors
local FFlagLuaAppSduiEdpEnabled = SharedFlags.FFlagLuaAppSduiEdpEnabled
local FFlagFixSduiEdpTtiPeekCategory = SharedFlags.FFlagFixSduiEdpTtiPeekCategory
local FFlagFixSduiEdpTtiColdStart = SharedFlags.FFlagFixSduiEdpTtiColdStart
local FFlagEDPTTIParityDefinitions = SharedFlags.FFlagEDPTTIParityDefinitions
local RobloxAppNavigation = require(GameDetailParent.RobloxAppNavigation)
local NavigationCommands = if FFlagSignalsNavP3Dispatch then RobloxAppNavigation.NavigationCommands else nil
local AppNavigationRegistry = if FFlagSignalsNavP3fGameDetails then RobloxAppNavigation.AppNavigationRegistry else nil
local SduiSurfaceLoadTimeTracker = require(GameDetailParent.SduiSharedUtilities).SduiSurfaceLoadTimeTracker
local DeviceType = require(GameDetailParent.RobloxAppEnums).DeviceType
local FetchGamePlayButtonData = require(GameDetailParent.GamePlayButton).FetchGamePlayButtonData
local Display = require(GameDetailParent.Display)
local Responsive = require(GameDetailParent.Responsive)

local fetchExperienceDetailsPage = require(script.Parent.ExperienceDetailsPage.fetchExperienceDetailsPage)
local getExperienceDetailsPageKey = require(script.Parent.ExperienceDetailsPage.getExperienceDetailsPageKey)
local createExperienceDetailsPageTimer = require(script.Parent.ExperienceDetailsPage.createExperienceDetailsPageTimer)

local GameDetailTelemetry = require(GameDetailParent.GameDetailTelemetry)
local EDPTTIManager = GameDetailTelemetry.EDPTTIManager
local FFlagEDPTTITrackingEnabled = GameDetailTelemetry.FFlagEDPTTITrackingEnabled
local EDPTTIConstants = GameDetailTelemetry.EDPTTIConstants

return function(arg1, arg2, extraProps, arg3)
    return function(arg4)
        local state = arg4:getState()
        local formFactor = state.FormFactor
        local viewState = state.GameDetailsPeekView.viewState

        if FFlagSignalsNavP3fGameDetails then
            if FFlagSignalsNavPendingLock then
                if AppNavigationRegistry.isNavigationLocked(false) then
                    return
                end
            elseif AppNavigationRegistry.get().getIsNavigating() then
                return
            end
        elseif FFlagUseNavigationSelectors then
            if Selectors.selectNavigationLocked(state) then
                return
            end
        elseif state.Navigation.lockNavigationActions then
            return
        end

        if FFlagEDPTTITrackingEnabled and not (FFlagFixSduiEdpTtiColdStart and FFlagLuaAppSduiEdpEnabled) then
            if FFlagEDPTTIParityDefinitions then
                EDPTTIManager.restartTracking(EDPTTIConstants.EDP_ENTRY_PATH.GAME_DETAIL_OPEN_GAME_DETAILS)
            else
                EDPTTIManager.startTracking(EDPTTIConstants.EDP_ENTRY_PATH.GAME_DETAIL_OPEN_GAME_DETAILS)
            end
        end

        if FFlagLuaAppSduiEdpEnabled then
            local var1

            if FFlagFixSduiEdpTtiPeekCategory then
                local var2 = Display.GetDisplayStore(false).getViewportSize(false)
                local var3 = Responsive.GetInputModeStore(false).getPreferredInputType(false)
                if Responsive.getIsCompactTouch(var2, var3) then
                    var1 = EDPTTIConstants.EDP_IMPLEMENTATION.SDUI_PEEK_VIEW
                else
                    var1 = EDPTTIConstants.EDP_IMPLEMENTATION.SDUI_FULL_PAGE
                end
            elseif state.DeviceType == DeviceType.Phone then
                var1 = EDPTTIConstants.EDP_IMPLEMENTATION.SDUI_PEEK_VIEW
            else
                var1 = EDPTTIConstants.EDP_IMPLEMENTATION.SDUI_FULL_PAGE
            end

            local pageTimer = if FFlagEDPTTIParityDefinitions then createExperienceDetailsPageTimer(
                getExperienceDetailsPageKey(tostring(arg1)),
                {
                    page = EDPTTIConstants.EDP_ENTRY_PATH.GAME_DETAIL_OPEN_GAME_DETAILS,
                    category = var1
                }
            ) else SduiSurfaceLoadTimeTracker.createLoadTimerWithSurfaceLoadTime(getExperienceDetailsPageKey(tostring(arg1)), {
                eventName = EDPTTIConstants.EDP_TTI_EVENT_NAME,
                metadata = {
                    page = EDPTTIConstants.EDP_ENTRY_PATH.GAME_DETAIL_OPEN_GAME_DETAILS,
                    category = var1
                },
                manualSurfaceReady = true
            })
            extraProps = Cryo.Dictionary.join(extraProps or {}, { pageTimer = pageTimer })

            if arg3 ~= nil then
                arg4:dispatch(FetchGamePlayButtonData.Fetch(arg3, tostring(arg1)))
            end
            fetchExperienceDetailsPage(tostring(arg1), pageTimer)
        end

        local tbl2

        if formFactor == FormFactor.COMPACT and UseGameDetailsPeekView() then
            tbl2 = {
                name = AppPage.GameDetail,
                detail = tostring(arg1),
                extraProps = extraProps
            }

            if viewState == PeekViewState.Full or viewState == PeekViewState.Extended or extraProps and extraProps.mountAsFullView then
                tbl2 = Cryo.Dictionary.join(tbl2, { extraProps = Cryo.Dictionary.join(tbl2.extraProps or {}, { mountAsFullView = true }) })
            else
                arg4:dispatch(SetGameDetailsPeekViewState(PeekViewState.Closed))
                arg2.clearAppScreens({ AppPage.GameDetail })
            end
        else
            tbl2 = {
                name = AppPage.ExperienceDetail,
                detail = tostring(arg1),
                extraProps = extraProps
            }
        end

        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl2), FFlagSignalsNavP2NavigationPrimitives or nil)
            return
        end
        arg4:dispatch(NavigateDown(tbl2, FFlagSignalsNavP2NavigationPrimitives or nil))
    end
end
