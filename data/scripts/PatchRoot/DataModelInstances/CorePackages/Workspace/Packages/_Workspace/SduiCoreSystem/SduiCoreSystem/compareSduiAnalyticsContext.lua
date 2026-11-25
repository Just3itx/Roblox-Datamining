-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:51:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local tutils = require(SduiCoreSystemParent.tutils)

local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)

local tbl1 = { analyticsData = true, ancestorAnalyticsData = true }

return function(arg1, arg2)
    if arg1 == arg2 then
        return true
    end

    for value in tbl1 do
        local var1 = arg1[value]
        local var2 = arg2[value]
        if typeof(var1) == "table" and typeof(var2) == "table" then
            if not tutils.shallowEqual(var1, var2) then
                return false
            end
        elseif var1 and not var2 or var2 and not var1 then
            return false
        end
    end

    return tutils.shallowEqual(arg1, arg2, tbl1)
end
