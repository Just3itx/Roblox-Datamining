-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local checkAndSendEvent = require(scriptParentParent.Utils.checkAndSendEvent)

return function(str1: string, tbl1, tbl2, tbl3)
    local tbl4 = {
        validSessionUserIds = `[{table.concat(tbl1, ",")}]`,
        shownUserIds = `[{table.concat(tbl2, ",")}]`,
        appStoragePreviousUserIds = `[{table.concat(tbl3, ",")}]`
    }

    checkAndSendEvent(str1, "authAccountPickerAccountsFetched", tbl4)
end
