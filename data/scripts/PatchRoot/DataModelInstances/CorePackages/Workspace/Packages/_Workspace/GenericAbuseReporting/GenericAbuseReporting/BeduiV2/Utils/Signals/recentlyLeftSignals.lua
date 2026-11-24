-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:51:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent

local Signals = require(GenericAbuseReportingParent.Signals)

local function createRecentlyLeftStore(func1: ((...any) -> (...any))?)
    local var1 = func1 or os.clock
    local var2, var3 = Signals.createSignal({})
    local getRecentlyLeftIds = Signals.createComputed(function(arg1)
        local result = ({})
        for value in var2(arg1) do
            result[value] = true
        end
        return result
    end)
    local bool1 = false

    local function prune(tbl1)
        local var4 = var1()
        local result = ({})
        for value, value2 in tbl1 do
            if var4 - value2.leftAtClock <= 120 then
                result[value] = value2
            end
        end
        return result
    end

    local function handlePlayerRemoving(player: Player)
        local localPlayer = Players.LocalPlayer
        if localPlayer and player.UserId == localPlayer.UserId then
            return
        end
        local var4 = table.clone(var2(false))
        local userId = player.UserId
        var4[tostring(userId)] = {
            userId = player.UserId,
            username = player.Name,
            displayName = player.DisplayName,
            leftAtClock = var1()
        }
        var3((prune(var4)))
    end

    local function handlePlayerAdded(player: Player)
        local var4 = var2(false)
        if var4[tostring(player.UserId)] == nil then
            return
        end
        local var5 = table.clone(var4)
        local userId = player.UserId
        var5[tostring(userId)] = nil
        var3((prune(var5)))
    end

    return {
        init = function()
            if bool1 then
                return
            end
            bool1 = true
            Players.PlayerRemoving:Connect(handlePlayerRemoving)
            Players.PlayerAdded:Connect(handlePlayerAdded)
        end,
        getRecentlyLeft = function()
            local recentlyLeft = {}

            for _, value in (prune(var2(false))) do
                table.insert(recentlyLeft, { userId = value.userId, username = value.username, displayName = value.displayName })
            end

            return recentlyLeft
        end,
        getRecentlyLeftIds = function()
            return getRecentlyLeftIds
        end,
        handlePlayerRemoving = handlePlayerRemoving,
        handlePlayerAdded = handlePlayerAdded
    }
end

local recentlyLeftStore = createRecentlyLeftStore()

return {
    init = recentlyLeftStore.init,
    getRecentlyLeft = recentlyLeftStore.getRecentlyLeft,
    getRecentlyLeftIds = recentlyLeftStore.getRecentlyLeftIds,
    handlePlayerRemoving = recentlyLeftStore.handlePlayerRemoving,
    handlePlayerAdded = recentlyLeftStore.handlePlayerAdded,
    createRecentlyLeftStore = createRecentlyLeftStore
}
