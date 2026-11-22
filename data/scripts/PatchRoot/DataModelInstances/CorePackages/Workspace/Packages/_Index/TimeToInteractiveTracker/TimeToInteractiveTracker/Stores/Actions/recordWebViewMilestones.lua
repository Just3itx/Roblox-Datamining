-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TimeToInteractiveTracker = script:FindFirstAncestor("TimeToInteractiveTracker")

local var1 = require(TimeToInteractiveTracker.Logger):new(script.Name)
local FFlagDebugTimeToInteractiveTracker = require(TimeToInteractiveTracker.Utils.FFlagDebugTimeToInteractiveTracker)

local _types = require(script.Parent.Parent.types)
local _types2 = require(TimeToInteractiveTracker.Milestones.types)
local constants = require(TimeToInteractiveTracker.Milestones.constants)

return function(arg1, callback)
    return function(str1: string, tbl1)
        if #tbl1 == 0 then
            return
        end

        local var2 = arg1(false)[str1]
        if FFlagDebugTimeToInteractiveTracker and not (var2 and var2.startTime) then
            var1:warning(`called before trackStart for eventName={str1}`)
        end
        if not (var2 and var2.startTime) then
            return
        end

        local startTime = var2.startTime
        local subphase = constants.DataProcessingCompleted.Subphase

        local function materializeSubphases(subphases)
            if subphases == nil then
                return nil
            end
            local result = {}
            for _, value in subphases do
                local timestamp = startTime + value.deltaMs / 1000
                local tbl2 = if value.name == subphase.Decode or value.name == subphase.DataUpdate or value.name == subphase.TreeBuild then {
                    name = value.name,
                    timestamp = timestamp,
                    deltaMs = value.deltaMs
                } else {
                    name = value.name,
                    timestamp = timestamp,
                    deltaMs = value.deltaMs
                }
                table.insert(result, tbl2)
            end
            return result
        end

        local tbl2 = {}
        for _, value in tbl1 do
            table.insert(tbl2, {
                name = value.name,
                id = value.id,
                timestamp = startTime + value.deltaMs / 1000,
                deltaMs = value.deltaMs,
                subphases = materializeSubphases(value.subphases)
            })
        end

        callback(function(arg2)
            local var3 = arg2[str1]
            if not var3 then
                return arg2
            end

            local var4 = table.clone(arg2)
            local var5 = table.clone(var3)
            local milestones = not var5.milestones and {} or table.clone(var5.milestones)
            for _, value in tbl2 do
                table.insert(milestones, value)
            end
            var5.milestones = milestones
            var4[str1] = var5
            return var4
        end)
    end
end
