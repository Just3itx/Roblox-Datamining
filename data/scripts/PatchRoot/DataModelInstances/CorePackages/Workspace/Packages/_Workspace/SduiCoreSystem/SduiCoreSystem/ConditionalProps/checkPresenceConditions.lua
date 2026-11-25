-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:51:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")

local SduiConditionKey = require(SduiCoreSystem.ConditionalProps.SduiConditionalPropTypes).SduiConditionKey

local function checkPresenceConditions(tbl1, tbl2)
    local result = ({})
    if not tbl1 then
        return result
    end
    assert(tbl1, "allConditionalProps must exist")
    for value, value2 in tbl1 do
        local var1 = nil
        if value2.conditions then
            for k, condition in value2.conditions do
                if k ~= SduiConditionKey.friendInGame then
                    continue
                end

                var1 = true

                local var2 = tbl2[tostring(condition)]
                if var2 then
                    local bool1 = false

                    for _ in var2 do
                        bool1 = true
                        break
                    end

                    if bool1 then
                        var1 = false
                    end
                end

                if var1 then
                    break
                end
            end
        end

        result[value] = var1
    end
    return result
end

return checkPresenceConditions
