-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TimeToInteractiveTrackerParent = script:FindFirstAncestor("TimeToInteractiveTracker").Parent

local _types = require(script.Parent.Parent.types)

local now = require(script.Parent.Parent.Parent.Utils.now)
local FFlagLuaAppNavTTIMeasurementV2 = require(TimeToInteractiveTrackerParent.SharedFlags).FFlagLuaAppNavTTIMeasurementV2

return function(callback, tbl1): (string, boolean?) -> ()
    local tbl2 = ({})

    return function(str1: string, bool1: boolean?)
        if FFlagLuaAppNavTTIMeasurementV2 and tbl1 then
            tbl1[str1] = nil
        end

        callback(function(arg1)
            local var1 = arg1[str1]

            local startTime = now()

            local var3 = table.clone(arg1)
            var3[str1] = {
                startTime = startTime,
                endTime = nil,
                deltaMs = nil,
                sent = nil,
                metadata = var1 == nil and {} or table.clone(var1.metadata)
            }

            if bool1 then
                var3[str1].metadata.coldStart = not tbl2[str1]
                tbl2[str1] = true
            end

            return var3
        end)
    end
end
