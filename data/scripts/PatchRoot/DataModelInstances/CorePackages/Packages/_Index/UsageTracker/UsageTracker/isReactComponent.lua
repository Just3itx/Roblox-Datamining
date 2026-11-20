-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UsageTrackerParent = script:FindFirstAncestor("UsageTracker").Parent
local ReactIs = require(UsageTrackerParent.ReactIs)

local function isReactComponent(arg1)
    local success, result = pcall(ReactIs.isValidElementType, arg1)
    if success and result then
        if typeof(arg1) == "function" then
            local var1, var2 = debug.info(arg1, "a")
            local bool1 = string.sub(debug.info(arg1, "n"), 1, 3) == "use"

            if var1 == 1 and not (var2 or bool1) then
                return true
            end
        elseif typeof(arg1) == "table" then
            return true
        end
    end
    return false
end

return isReactComponent
