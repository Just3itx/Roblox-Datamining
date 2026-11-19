-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")

local UserGameSettings = UserSettings():GetService("UserGameSettings")

local DevConsoleMaster = require(CoreGui.RobloxGui.Modules.DevConsoleMaster)

local scriptParentParent = script.Parent.Parent

local OpenSystemMenu = require(scriptParentParent.Thunks.OpenSystemMenu)
local CloseMenu = require(scriptParentParent.Thunks.CloseMenu)
local SetRespawning = require(scriptParentParent.Actions.SetRespawning)
local SetCurrentPage = require(scriptParentParent.Actions.SetCurrentPage)
local NavigateBack = require(scriptParentParent.Actions.NavigateBack)
local SetCurrentZone = require(scriptParentParent.Actions.SetCurrentZone)

local Pages = require(scriptParentParent.Components.Pages)
local Constants = require(scriptParentParent.Resources.Constants)

local function bindMenuActions(arg1)
    ContextActionService:BindCoreAction("ToggleInGameMenu", function(_, userInputState, _) -- name: toggleMenuFunc
        if userInputState ~= Enum.UserInputState.Begin then
            return
        end

        local state = arg1:getState()
        local isMenuOpen = state.isMenuOpen

        local var1 = Pages.pagesByKey[state.menuPage]

        if var1 and var1.isModal then
            arg1:dispatch(SetCurrentPage(Constants.defaultPageKey))
            return
        end
        if not isMenuOpen then
            arg1:dispatch(OpenSystemMenu(Constants.AnalyticsMenuOpenTypes.Keyboard))
            return
        end

        if state.menuPage == Constants.InitalPageKey then
            arg1:dispatch(OpenSystemMenu(Constants.AnalyticsMenuOpenTypes.Keyboard))
            return
        end
        arg1:dispatch(CloseMenu)
    end, false, Enum.KeyCode.Escape)

    ContextActionService:BindCoreAction("ToggleDeveloperConsole", function(arg2, userInputState)
        if arg2 == "ToggleDeveloperConsole" and userInputState == Enum.UserInputState.Begin then
            DevConsoleMaster:ToggleVisibility()
        end
    end, false, Enum.KeyCode.F9)

    ContextActionService:BindCoreAction("TogglePerformanceStats", function(arg2, userInputState)
        if not (UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.RightControl)) then
            return Enum.ContextActionResult.Pass
        elseif arg2 == "TogglePerformanceStats" and userInputState == Enum.UserInputState.Begin then
            UserGameSettings.PerformanceStatsVisible = not UserGameSettings.PerformanceStatsVisible
        end
    end, false, Enum.KeyCode.F7)

    ContextActionService:BindCoreAction("LeaveGame", function(_, userInputState, _) -- name: leaveGameFunc
        local state = arg1:getState()
        if userInputState ~= Enum.UserInputState.Begin or not state.isMenuOpen then
            return Enum.ContextActionResult.Pass
        end

        if Pages.pagesByKey[state.menuPage].isModal then
            return Enum.ContextActionResult.Pass
        end

        arg1:dispatch(SetCurrentPage(Constants.LeaveGamePromptPageKey))

        return Enum.ContextActionResult.Sink
    end, false, Enum.KeyCode.L, Enum.KeyCode.ButtonX)

    ContextActionService:BindCoreAction("ResetCharacter", function(_, userInputState, _) -- name: resetCharacterFunc
        local state = arg1:getState()
        if userInputState ~= Enum.UserInputState.Begin or not state.isMenuOpen then
            return Enum.ContextActionResult.Pass
        end

        if not state.respawn.enabled then
            return Enum.ContextActionResult.Pass
        end

        if Pages.pagesByKey[state.menuPage].isModal then
            return Enum.ContextActionResult.Pass
        end

        if state.menuPage == Constants.InitalPageKey then
            return Enum.ContextActionResult.Pass
        end

        arg1:dispatch(SetRespawning(true))

        return Enum.ContextActionResult.Sink
    end, false, Enum.KeyCode.R, Enum.KeyCode.ButtonY)

    ContextActionService:BindCoreAction("NavigateBack", function(_, userInputState, _) -- name: navigateBackFunc
        local state = arg1:getState()
        local parentPage = Pages.pagesByKey[state.menuPage].parentPage
        local visibility = DevConsoleMaster:GetVisibility()

        if userInputState ~= Enum.UserInputState.End or not (state.isMenuOpen or visibility) then
            return Enum.ContextActionResult.Pass
        end

        if visibility then
            DevConsoleMaster:SetVisibility(false)
        elseif parentPage == nil and not state.respawn.dialogOpen then
            arg1:dispatch(CloseMenu)
        else
            arg1:dispatch(NavigateBack())
        end

        return Enum.ContextActionResult.Sink
    end, false, Enum.KeyCode.ButtonB)

    local function canBumperSwitch() -- Luacid: Inlined by compiler; 2 call sites recovered
        local state = arg1:getState()

        return not (state.menuPage == "Controls")
            and state.isMenuOpen
            and not state.respawn.dialogOpen
            and not (state.report.dialogOpen or state.report.reportSentOpen)
    end

    ContextActionService:BindCoreAction("LeftBumperSwitchToZone0", function(_, userInputState, _)
        if userInputState ~= Enum.UserInputState.Begin or not canBumperSwitch() then
            return Enum.ContextActionResult.Pass
        end

        arg1:dispatch(SetCurrentZone(0))
        return Enum.ContextActionResult.Sink
    end, false, Enum.KeyCode.ButtonL1)

    ContextActionService:BindCoreAction("RightBumperSwitchToZone1", function(_, userInputState, _)
        if userInputState ~= Enum.UserInputState.Begin or not canBumperSwitch() then
            return Enum.ContextActionResult.Pass
        end

        arg1:dispatch(SetCurrentZone(1))
        return Enum.ContextActionResult.Sink
    end, false, Enum.KeyCode.ButtonR1)
end

return bindMenuActions
