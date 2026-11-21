-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AppStorageUtilities = require(AuthCommon.Utils.AppStorageUtilities)
local AuthCommonParent = AuthCommon.Parent
local Cryo = require(AuthCommonParent.Cryo)

local function updateLoginEntryData(str1: string, tbl1): boolean
    local previousAccountsList = AppStorageUtilities.getPreviousAccountsList()
    local previousAccount = previousAccountsList[str1]
    if previousAccount then
        previousAccountsList[str1] = Cryo.Dictionary.join(previousAccount, tbl1)
    end
    AppStorageUtilities.setPreviousAccountsList(previousAccountsList)
    return true
end

return updateLoginEntryData
