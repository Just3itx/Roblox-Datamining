-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent
local AppStorageUtilities = require(AuthCommon.Utils.AppStorageUtilities)
local Cryo = require(AuthCommonParent.Cryo)

local function record2svCompletion(str1: string): boolean
    if str1 == nil or str1 == "0" then
        return false
    end
    local previousAccountsList = AppStorageUtilities.getPreviousAccountsList()
    local previousAccount = previousAccountsList[str1]
    if not previousAccount then
        return false
    end

    previousAccountsList[str1] = Cryo.Dictionary.join(previousAccount, { signInTimestamp = os.time() })
    AppStorageUtilities.setPreviousAccountsList(previousAccountsList)
    return true
end

return record2svCompletion
