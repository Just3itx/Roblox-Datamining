-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:51:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local UnifiedEventLogConstants = require(script.Parent.Parent.UnifiedEventLogConstants)

local getSelectionList = {}

return {
    addToSelectionList = function(tbl2)
        table.insert(getSelectionList, tbl2)
    end,
    removeFromSelectionList = function(tbl2)
        local var1 = UnifiedEventLogConstants.ATTRIBUTE_PREFIX .. "itemId"
        local var2 = UnifiedEventLogConstants.ATTRIBUTE_PREFIX .. "itemType"

        for value, value2 in getSelectionList do
            if value2[var1] == tbl2[var1] and value2[var2] == tbl2[var2] then
                table.remove(getSelectionList, value)
                return
            end
        end
    end,
    getSelectionList = function()
        return getSelectionList
    end,
    clearSelectionList = function()
        getSelectionList = {}
    end
}
