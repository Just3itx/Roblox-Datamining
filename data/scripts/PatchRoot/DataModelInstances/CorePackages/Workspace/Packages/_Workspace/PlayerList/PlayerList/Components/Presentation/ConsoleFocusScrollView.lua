-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:01:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local ContextActionService = game:GetService("ContextActionService")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")

local React = require(scriptParentParentParentParent.React)
local CoreGuiCommon = require(scriptParentParentParentParent.CoreGuiCommon)
local SignalsReact = require(scriptParentParentParentParent.SignalsReact)
local Foundation = require(scriptParentParentParentParent.Foundation)
local _LeaderboardStore = require(scriptParentParentParentParent.LeaderboardStore)

local ScrollView = Foundation.ScrollView

local PlayerListVisibilityStore = require(scriptParentParentParent.Common.PlayerListVisibilityStore)
local PlayerContextualMenuStore = require(scriptParentParentParent.Common.PlayerContextualMenuStore)
local TeamListView = require(scriptParentParentParent.Components.Presentation.TeamListView)
local useGamepadStickScroll = CoreGuiCommon.Hooks.useGamepadStickScroll

local function isGamepad(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return UserInputService:GetLastInputType().Name:find("Gamepad") ~= nil
end

local function ConsoleFocusScrollView(tbl1)
    local var1 = React.useRef(nil)
    local var2 = React.useRef(nil)

    local var3 = SignalsReact.useSignalState(PlayerListVisibilityStore.getEffectiveVisible)
    local bool1 = SignalsReact.useSignalState(PlayerContextualMenuStore.getMenuData) ~= nil

    local enabled = var3 and not bool1
    local allTeams = tbl1.allTeams
    local bool2 = if tbl1.isGamepadOverride ~= nil then tbl1.isGamepadOverride else not not isGamepad()
    useGamepadStickScroll(
        {
            actionName = "RbxPlayerListReskinGamepadStickScroll",
            scrollingFrameRef = var2,
            enabled = enabled
        }
    )
    local var5 = React.useRef(Enum.OverrideMouseIconBehavior.None)
    local var6 = React.useRef(nil)
    local var7 = React.useRef(false)
    local var8 = React.useRef(false)

    local function restoreHud() -- Luacid: Inlined by compiler; 2 call sites recovered
        if not var8.current then
            return
        end
        UserInputService.OverrideMouseIconBehavior = var5.current
        var5.current = Enum.OverrideMouseIconBehavior.None
        local selectedCoreObject = GuiService.SelectedCoreObject
        if selectedCoreObject and var2.current and selectedCoreObject:IsDescendantOf(var2.current) then
            GuiService.SelectedCoreObject = var6.current
        end
        var6.current = nil
        var8.current = false
        var7.current = false
    end

    local function releaseRosterSelection() -- Luacid: Inlined by compiler; 2 call sites recovered
        local selectedCoreObject = GuiService.SelectedCoreObject
        if selectedCoreObject and var2.current and selectedCoreObject:IsDescendantOf(var2.current) then
            GuiService.SelectedCoreObject = nil
        end
        var7.current = false
    end

    React.useEffect(function()
        if not var3 then
            restoreHud()
            return function() end
        elseif bool1 then
            releaseRosterSelection()
            return function() end
        else
            if not var7.current and bool2 and var1.current then
                if not var8.current then
                    var6.current = GuiService.SelectedCoreObject
                    var5.current = UserInputService.OverrideMouseIconBehavior
                    var8.current = true
                end
                GuiService.SelectedCoreObject = var1.current
                UserInputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.ForceHide
                var7.current = true
            end

            return function()
                if not PlayerListVisibilityStore.getEffectiveVisible(false) then
                    restoreHud()
                elseif PlayerContextualMenuStore.getMenuData(false) ~= nil then
                    releaseRosterSelection()
                end
            end
        end
    end, { var3, bool1, bool2 })

    React.useEffect(function()
        if not (enabled and bool2 and var1.current) then
            return
        end

        if var7.current then
            GuiService.SelectedCoreObject = var1.current
            return
        end

        if not var8.current then
            var6.current = GuiService.SelectedCoreObject
            var5.current = UserInputService.OverrideMouseIconBehavior
            var8.current = true
        end
        GuiService.SelectedCoreObject = var1.current
        UserInputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.ForceHide
        var7.current = true
    end, { enabled, allTeams, bool2 })

    React.useEffect(function()
        if not enabled then
            return function() end
        end
        ContextActionService:BindCoreAction("RbxPlayerListReskinGamepadClose", function(_, userInputState, _)
            if userInputState ~= Enum.UserInputState.Begin then
                return Enum.ContextActionResult.Pass
            end

            PlayerContextualMenuStore.closeContextMenu()
            PlayerListVisibilityStore.setVisible(false)
            return Enum.ContextActionResult.Sink
        end, false, Enum.KeyCode.ButtonB)
        return function()
            ContextActionService:UnbindCoreAction("RbxPlayerListReskinGamepadClose")
        end
    end, { enabled })

    local leaderboardStore = tbl1.leaderboardStore
    local statColumns = tbl1.statColumns
    local statWidth = tbl1.statWidth
    local rowHeight = tbl1.rowHeight
    local columnHeaderHeight = tbl1.columnHeaderHeight
    local hasNonNeutralTeams = tbl1.hasNonNeutralTeams
    local localPlayer = tbl1.localPlayer
    local onActivated = tbl1.onActivated

    local tbl2 = {}
    for k, allTeam in pairs(allTeams) do
        if allTeam then
            table.insert(tbl2, k)
        end
    end
    table.sort(tbl2, function(arg1, arg2): boolean
        if arg1 == "Neutral" and arg2 ~= "Neutral" then
            return false
        end

        if arg2 == "Neutral" and arg1 ~= "Neutral" then
            return true
        end
        local allTeam = allTeams[arg1]
        local allTeam2 = allTeams[arg2]
        local var9 = if allTeam and allTeam.order then allTeam.order(false) else 0
        local var10 = if allTeam2 and allTeam2.order then allTeam2.order(false) else 0

        if var9 == var10 then
            return tostring(arg1) < tostring(arg2)
        end

        return var9 < var10
    end)

    local bool3 = false
    local tbl3 = {}
    for _, value in ipairs(tbl2) do
        local teamEntry = allTeams[value]
        local var9 = teamEntry and teamEntry.players and next(teamEntry.players.getAllData(false)) ~= nil
        local var10 = nil
        if not bool3 and var9 then
            var10 = var1
            bool3 = true
        end

        tbl3[`Team_{tostring(value)}`] = React.createElement(TeamListView, {
            teamEntry = teamEntry,
            isNeutral = value == "Neutral",
            hasNonNeutralTeams = hasNonNeutralTeams,
            leaderboardStore = leaderboardStore,
            statColumns = statColumns,
            statWidth = statWidth,
            rowHeight = rowHeight,
            columnHeaderHeight = columnHeaderHeight,
            onActivated = onActivated,
            localPlayer = localPlayer,
            firstRowRefForward = var10
        })
    end

    local var9 = table.clone(tbl1.scrollViewProps)
    var9.ref = var2

    return React.createElement(ScrollView, var9, tbl3)
end

return ConsoleFocusScrollView
