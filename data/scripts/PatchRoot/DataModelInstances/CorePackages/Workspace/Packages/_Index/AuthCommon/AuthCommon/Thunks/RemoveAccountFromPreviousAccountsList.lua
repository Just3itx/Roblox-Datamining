-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:50:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AppStorageUtilities = require(AuthCommon.Utils.AppStorageUtilities)

return function(str1: string)
    local previousAccountsList = AppStorageUtilities.getPreviousAccountsList()
    if previousAccountsList[str1] ~= nil then
        previousAccountsList[str1] = nil
        AppStorageUtilities.setPreviousAccountsList(previousAccountsList)
        AppStorageUtilities.flush()
    end
end
