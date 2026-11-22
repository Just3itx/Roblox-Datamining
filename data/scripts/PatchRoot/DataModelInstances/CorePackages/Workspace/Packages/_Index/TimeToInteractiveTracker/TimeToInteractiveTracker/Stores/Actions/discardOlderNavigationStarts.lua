-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TimeToInteractiveTracker = script:FindFirstAncestor("TimeToInteractiveTracker")

local _types = require(script.Parent.Parent.types)

local navigationEventPrefix = require(TimeToInteractiveTracker.Utils.navigationEventPrefix)
local logTTIDiscard = require(TimeToInteractiveTracker.Utils.logTTIDiscard)
local hasNavigationCommitted = require(TimeToInteractiveTracker.Utils.hasNavigationCommitted)

return function(callback, tbl1): (string) -> ()
    return function(str1: string)
        local tbl2 = {}
        local tbl3 = ({})
        callback(function(arg1)
            local var1 = arg1[str1]
            if var1 == nil or var1.startTime == nil then
                return arg1
            end
            for value, value2 in arg1 do
                if value == str1 then
                    continue
                end

                local navigationEventPrefixLen = #navigationEventPrefix

                if string.sub(value, 1, navigationEventPrefixLen) ~= navigationEventPrefix
                    or value2 == nil
                    or value2.startTime == nil
                    or value2.sent
                    or not (value2.startTime < var1.startTime)
                then
                    continue
                end
                table.insert(tbl2, value)
                if hasNavigationCommitted(value2) then
                    tbl3[value] = true
                end
            end

            if #tbl2 == 0 then
                return arg1
            end
            local var2 = table.clone(arg1)
            for _, value in tbl2 do
                var2[value] = nil
            end
            return var2
        end)

        for _, value in tbl2 do
            tbl1[value] = true
            if tbl3[value] then
                logTTIDiscard(value, "superseded")
            end
        end
    end
end
