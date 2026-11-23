-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceAnalyticsParent = script:FindFirstAncestor("AvatarExperienceAnalytics").Parent

local Signals = require(AvatarExperienceAnalyticsParent.Signals)
local createSignal = Signals.createSignal

return Signals.createComputed(function() -- name: createUnifiedLoggingDeferredEventStore
    local isEntered, var2 = createSignal(false)
    local tbl1 = ({})

    return {
        isEntered = isEntered,
        enqueue = function(arg1, func1: (...any) -> (...any))
            local tbl2 = tbl1[arg1]
            if not tbl2 then
                tbl2 = {}
                tbl1[arg1] = tbl2
            end
            table.insert(tbl2, func1)
        end,
        takePending = function(arg1)
            if arg1 ~= nil then
                local var3 = tbl1[arg1] or {}
                tbl1[arg1] = nil
                return var3
            end

            local result = {}
            for _, value in tbl1 do
                for _, value2 in value do
                    table.insert(result, value2)
                end
            end
            tbl1 = {}
            return result
        end,
        markEntered = function()
            var2(true)
        end,
        reset = function()
            var2(false)
            tbl1 = {}
        end
    }
end)
