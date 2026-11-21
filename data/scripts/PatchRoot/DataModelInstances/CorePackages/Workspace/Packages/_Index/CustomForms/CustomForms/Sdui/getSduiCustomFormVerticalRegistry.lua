-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:41:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function createSduiCustomFormVerticalRegistry()
    local tbl1 = ({})

    return {
        getVertical = function(str1: string)
            return tbl1[str1]
        end,
        registerVertical = function(str1: string, tbl2)
            tbl1[str1] = tbl2
        end,
        debug_clear = function()
            table.clear(tbl1)
        end
    }
end
local var1 = nil
local function getSduiCustomFormVerticalRegistry()
    if var1 == nil then
        var1 = createSduiCustomFormVerticalRegistry()
    end
    return var1
end

return getSduiCustomFormVerticalRegistry
