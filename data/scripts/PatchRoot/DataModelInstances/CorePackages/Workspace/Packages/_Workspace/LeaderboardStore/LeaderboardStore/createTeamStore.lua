-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:21:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Signals = require(scriptParentParent.Signals)

local createSignalMap = require(scriptParentParent.CoreScriptsRoactCommon).Utilities.createSignalMap

local _LeaderboardStoreTypes = require(script.Parent.LeaderboardStoreTypes)

local function createTeamStore(arg1, _)
    local tbl1 = {}

    local getStats = createSignalMap()
    local getPlayers = createSignalMap()

    local tbl2 = ({})
    local var1, var2, var3, var4, var5, var6

    if arg1 == "Neutral" then
        local var7
        var1, var7 = Signals.createSignal("Neutral")
        var2 = var7
        local var8
        var3, var8 = Signals.createSignal(BrickColor.White().Color)
        var4 = var8
        local var9
        var5, var9 = Signals.createSignal(1000)
        var6 = var9
    else
        local var7
        var1, var7 = Signals.createSignal(arg1.Name)
        var2 = var7
        local var8
        var3, var8 = Signals.createSignal(arg1.TeamColor.Color)
        var4 = var8
        local var9
        var5, var9 = Signals.createSignal(arg1.ChildOrder)
        var6 = var9

        local teamPropChanged = arg1.Changed:Connect(function(str1: string)
            if str1 == "Name" then
                var2(arg1.Name)
            elseif str1 == "TeamColor" then
                var4(arg1.TeamColor.Color)
            elseif str1 == "ChildOrder" then
                var6(arg1.ChildOrder)
            end
        end)
        tbl1.teamPropChanged = teamPropChanged
    end

    local function updateStat(str1: string, func1: (...any) -> (...any)) -- Luacid: Inlined by compiler; 3 call sites recovered
        local computed = Signals.createComputed(function(arg2)
            local var7 = nil
            local allData = getPlayers.getAllData(arg2)
            if typeof(allData) == "table" then
                for k, _ in pairs(allData) do
                    local var8 = func1(k, str1, arg2)
                    if not var8 or type(var8) ~= "number" then
                        continue
                    end

                    if var7 then
                        var7 += var8
                    else
                        var7 = var8
                    end
                end
            end

            return var7
        end)
        getStats.setData(str1, computed, false)

        tbl2[str1] = func1
    end

    local function updateAllStats() -- Luacid: Inlined by compiler; 2 call sites recovered
        for k, value in pairs(tbl2) do
            updateStat(k, value)
        end
    end

    return {
        getName = var1,
        getColor = var3,
        getOrder = var5,
        getStats = getStats,
        getPlayers = getPlayers,
        updateStat = updateStat,
        removeStat = function(str1: string)
            getStats.removeData(str1, false)

            tbl2[str1] = nil
        end,
        addPlayer = function(arg2)
            getPlayers.setData(arg2, arg2.UserId, false)
            updateAllStats()
        end,
        removePlayer = function(arg2)
            getPlayers.removeData(arg2, false)
            updateAllStats()
        end,
        destroy = function()
            for _, value in pairs(tbl1) do
                if value.Disconnect then
                    value:Disconnect()
                end
            end
            tbl1 = {}
            tbl2 = {}
        end
    }
end
return createTeamStore
