-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Cryo = require(CorePackages.Packages.Cryo)

local scriptParentParent = script.Parent.Parent
local Actions = scriptParentParent.Actions
local AddGameStat = require(Actions.AddGameStat)
local RemoveGameStat = require(Actions.RemoveGameStat)
local SetGameStatText = require(Actions.SetGameStatText)
local SetGameStatAddId = require(Actions.SetGameStatAddId)

local FFlagLeaderstatsWithASideOfClient = require(scriptParentParent.Flags.FFlagLeaderstatsWithASideOfClient)

local FormatStatString = require(scriptParentParent.FormatStatString)

local function gameStatsComp(arg1, arg2)
    if arg1.isPrimary ~= arg2.isPrimary then
        return arg1.isPrimary
    end
    if arg1.priority ~= arg2.priority then
        return arg1.priority > arg2.priority
    end

    if FFlagLeaderstatsWithASideOfClient then
        local serverAddId = arg1.serverAddId
        local serverAddId2 = arg2.serverAddId
        if serverAddId and serverAddId2 then
            return serverAddId < serverAddId2
        end
    end
    return arg1.addId < arg2.addId
end

local num1 = 0

local function GameStats(arg1, arg2)
    arg1 = arg1 or {}

    if arg2.type ~= AddGameStat.name then
        if arg2.type == RemoveGameStat.name then
            return Cryo.List.filter(arg1, function(arg3): boolean
                return arg3.name ~= arg2.statName
            end)
        end

        if arg2.type == SetGameStatText.name then
            return Cryo.List.map(arg1, function(arg3)
                if arg3.name == arg2.statName then
                    arg3 = Cryo.Dictionary.join(arg3, { text = arg2.text }) or arg3
                end

                return arg3
            end)
        end

        if not FFlagLeaderstatsWithASideOfClient or arg2.type ~= SetGameStatAddId.name then
            return arg1
        end

        local var1 = Cryo.List.map(arg1, function(arg3)
            if arg3.name == arg2.statName then
                arg3 = Cryo.Dictionary.join(arg3, { serverAddId = arg2.serverAddId }) or arg3
            end

            return arg3
        end)

        table.sort(var1, gameStatsComp)
        return var1
    end

    local addId = nil
    local serverAddId = nil
    local var1 = FormatStatString(nil)
    local tbl1 = {}
    for _, value in ipairs(arg1) do
        if value.name == arg2.statName then
            addId = value.addId
            var1 = value.text
            if FFlagLeaderstatsWithASideOfClient then
                serverAddId = value.serverAddId
            end
        else
            table.insert(tbl1, value)
        end
    end
    num1 += 1
    local var2 = Cryo.List.join(tbl1, {{
        name = arg2.statName,
        text = var1,
        addId = addId or num1,
        isPrimary = arg2.isPrimary,
        priority = arg2.priority,
        serverAddId = serverAddId
    }})

    table.sort(var2, gameStatsComp)
    return var2
end

return GameStats
