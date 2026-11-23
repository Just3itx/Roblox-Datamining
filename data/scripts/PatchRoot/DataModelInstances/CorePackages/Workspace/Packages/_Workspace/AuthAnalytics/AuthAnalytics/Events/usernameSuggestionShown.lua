-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local checkAndSendEvent = require(scriptParentParent.Utils.checkAndSendEvent)

return function(str1: string, state: string, tbl1, field: string)
    assert(type(tbl1) == "table", "Expected suggestions to be a table")

    local tbl2 = {
        state = state,
        suggestions = `[{table.concat(tbl1, ",")}]`,
        field = field
    }

    checkAndSendEvent(str1, "usernameSuggestionShown", tbl2)
end
