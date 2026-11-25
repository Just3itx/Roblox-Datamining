-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent

local React = require(ServerDrivenUiParent.React)
local Responsive = require(ServerDrivenUiParent.Responsive)
local GetInputModeStore = Responsive.GetInputModeStore
local Constants = require(ServerDrivenUiParent.HoldToPlay).Constants
local AppShortcutBarContext = require(ServerDrivenUiParent.AppShortcutBar).AppShortcutBarContext
local FocusNavigationUtils = require(ServerDrivenUiParent.FocusNavigationUtils)
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local useButtonHold = FocusNavigationUtils.useButtonHold
local ButtonHoldStateEnum = FocusNavigationUtils.ButtonHoldStateEnum
local GamePlayButton = require(ServerDrivenUiParent.GamePlayButton)
local useOnPlayButtonCallback = GamePlayButton.useOnPlayButtonCallback
local usePlayButtonState = GamePlayButton.usePlayButtonState
local PlayButtonStates = GamePlayButton.PlayButtonStates
local RobloxAppSessionization = require(ServerDrivenUiParent.RobloxAppSessionization)
local SetGamePlaySession = RobloxAppSessionization.SetGamePlaySession
local SessionType = RobloxAppSessionization.SessionType
local HoldToPlayLauncher = require(ServerDrivenUiParent.DiscoveryAnalytics).Constants.Context.HoldToPlayLauncher

local _SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiFocusNavActions = require(ServerDrivenUi.FocusNavigation.SduiFocusNavActions)
local useSduiReportExperienceLaunched = require(ServerDrivenUiParent.SduiSharedContent).useSduiReportExperienceLaunched

return React.memo(function(tbl1) -- name: SduiHoldToPlay
    local dependencies = tbl1.sduiContext.dependencies
    local networking = dependencies.networking
    local sessionService = dependencies.sessionService
    local var1 = React.useRef(nil)
    local var2 = useButtonHold(Constants.SIGNAL_HOLD_INTENT_SECONDS, Constants.SIGNAL_HOLD_COMPLETE_SECONDS)

    local bool1 = var2.holdState == ButtonHoldStateEnum.HOLDING
        or var2.holdState == ButtonHoldStateEnum.JUST_PRESSED
        or var2.holdState == ButtonHoldStateEnum.COMPLETED
    local bool2 = var2.holdState == ButtonHoldStateEnum.COMPLETED

    local var3 = AppShortcutBarContext.useDispatchButtonHoldStarted()
    local var4 = AppShortcutBarContext.useDispatchButtonHoldEnded()

    local guiObject = React.useMemo(function()
        return if tbl1.guiObject then tbl1.guiObject else GuiService.SelectedCoreObject
    end, { tbl1.guiObject })

    local bool3 = var2.holdState == ButtonHoldStateEnum.HOLDING or var2.holdState == ButtonHoldStateEnum.COMPLETED

    React.useEffect(function()
        if bool3 then
            local var6 = GetInputModeStore(false).getLastInputType(false)

            if tbl1.setDisabledForHold and var6 == Responsive.Input.Directional then
                tbl1.setDisabledForHold(true)
            end
        end
        return function()
            if tbl1.setDisabledForHold then
                tbl1.setDisabledForHold(false)
            end
        end
    end, { bool3, tbl1.setDisabledForHold })

    React.useEffect(function()
        if not var1.current and bool1 then
            var1.current = true
            var3(FocusNavigationEventNameEnum.HoldToPlay, var2.holdProgress)
        elseif var1.current and not bool1 then
            var4(FocusNavigationEventNameEnum.HoldToPlay)
            var1.current = false
        end
    end, {
        bool1,
        var2.holdProgress,
        var3,
        var4
    })
    local var6 = usePlayButtonState(networking, tbl1.universeId)
    local var7 = useOnPlayButtonCallback(tbl1.universeId, nil, HoldToPlayLauncher, nil, nil)

    local var8 = useSduiReportExperienceLaunched(tbl1.sduiContext, tbl1.analyticsContext, tbl1.universeId, tbl1.placeId)

    React.useEffect(function()
        if not bool2 then
            return
        end

        local playButtonState = var6.playButtonState
        SetGamePlaySession(sessionService, SessionType.StructuralIdentifier.GamePlayFromHoldToPlay, true)
        var7(playButtonState, var8)
        if var2.cancelHold and playButtonState == PlayButtonStates.Playable then
            var2.cancelHold()
        end
    end, {
        bool2,
        var2.cancelHold,
        var6.playButtonState,
        sessionService,
        var8,
        var7
    })

    local focusNavActions = React.useMemo(function()
        return {
            keys = {
                [Enum.KeyCode.ButtonA] = FocusNavigationEventNameEnum.HoldToPlay
            },
            events = {
                [FocusNavigationEventNameEnum.HoldToPlay] = {
                    handler = var2.eventHandler
                }
            }
        }
    end, { var2.eventHandler })

    return React.createElement(SduiFocusNavActions, { focusNavActions = focusNavActions, guiObject = guiObject })
end)
