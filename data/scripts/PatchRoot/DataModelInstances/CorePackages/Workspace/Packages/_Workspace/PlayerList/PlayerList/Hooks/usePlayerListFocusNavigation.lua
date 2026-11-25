-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:10:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local React = require(scriptParentParentParent.React)
local _Signals = require(scriptParentParentParent.Signals)

local useFocusGuiObject = require(scriptParentParentParent.ReactFocusNavigation).useFocusGuiObject

local FocusNavHelper = require(scriptParentParent.Common.FocusNavHelper)

local _LeaderboardStore = require(scriptParentParentParent.LeaderboardStore)

local Constants = require(scriptParentParent.Common.Constants)

local function usePlayerListFocusNavigation()
    local var1 = useFocusGuiObject()

    local var2 = React.useRef(nil)
    local var3 = React.useRef(nil)

    local var4 = React.useRef({})

    local var5 = React.useCallback(function(arg1, arg2)
        local nextPlayerInstance = FocusNavHelper.getNextPlayerInstance(var4.current, arg1, arg2)

        if nextPlayerInstance then
            var1(nextPlayerInstance.object)
            return
        end
        var1(var2.current)
    end, {})

    local getFocus = React.useCallback(function()
        if var3.current and var3.current ~= Constants.SELECTED_TITLE_PLAYER_ID then
            for _, value in var4.current do
                for _, player in value.players do
                    if player.userId == var3.current then
                        var1(player.object)
                        return
                    end
                end
            end
        end

        if var2.current then
            var1(var2.current)
            return
        end

        local firstPlayerInstance = FocusNavHelper.getFirstPlayerInstance(var4.current)
        if firstPlayerInstance then
            var1(firstPlayerInstance.object)
        end
    end, {})

    local var7 = React.useCallback(function(arg1)
        return function(userId: number, arg2, order)
            if not (arg2 and var4.current[arg1]) then
                return
            end

            var4.current[arg1].players[userId] = { userId = userId, object = arg2, order = order }
        end
    end, {})

    local var8 = React.useCallback(function(arg1): (number) -> ()
        return function(num1: number)
            local var8 = var4.current[arg1]
            if not var8 then
                return
            end

            local player = var8.players[num1]
            if not player then
                return
            end

            if GuiService.SelectedCoreObject == player.object then
                var5(player, arg1)
            end

            var4.current[arg1].players[num1] = nil
        end
    end, {})

    local registerTeamInstance = React.useCallback(function(teamId, order)
        local tbl1 = {
            teamId = teamId,
            order = order,
            players = {},
            registerPlayerInstance = var7(teamId),
            unregisterPlayerInstance = var8(teamId)
        }

        var4.current[teamId] = tbl1

        return tbl1
    end, {})

    local unregisterTeamInstance = React.useCallback(function(arg1)
        var4.current[arg1] = nil
    end, {})

    local setTitlePlayerInstance = React.useCallback(function(current)
        var2.current = current
    end, {})

    local setSelectedPlayerId = React.useCallback(function(current: number?)
        var3.current = current
    end, {})

    local cleanup = React.useCallback(function(bool1: boolean?)
        if bool1 then
            var1(nil)
        end

        var2.current = nil
        var3.current = nil
        var4.current = {}
    end, {})

    return React.useMemo(function()
        return {
            getFocus = getFocus,
            registerTeamInstance = registerTeamInstance,
            unregisterTeamInstance = unregisterTeamInstance,
            setTitlePlayerInstance = setTitlePlayerInstance,
            setSelectedPlayerId = setSelectedPlayerId,
            cleanup = cleanup
        }
    end, {
        getFocus,
        registerTeamInstance,
        unregisterTeamInstance,
        setTitlePlayerInstance,
        setSelectedPlayerId,
        cleanup
    })
end

return usePlayerListFocusNavigation
