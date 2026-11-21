-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:50:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AppStorageUtilities = require(AuthCommon.Utils.AppStorageUtilities)
local _PreviousAccountEntry = require(AuthCommon.Utils.PreviousAccountEntry)
local prunePreviousAccountsList = require(AuthCommon.Utils.prunePreviousAccountsList)
local AuthCommonParent = AuthCommon.Parent
local Cryo = require(AuthCommonParent.Cryo)
local FFlagFixPreviousAccountsListEntries = require(AuthCommonParent.SharedFlags).FFlagFixPreviousAccountsListEntries

local function ensureLoginEntry(userId: string, tbl1): boolean
    if userId == nil or userId == "" or userId == "0" or userId == "-1" then
        return false
    end
    if tbl1.username == nil or tbl1.username == "" then
        return false
    end

    local displayName = if tbl1.displayName and tbl1.displayName ~= "nil" then tbl1.displayName else nil
    local previousAccountsList = AppStorageUtilities.getPreviousAccountsList()
    local previousAccount = previousAccountsList[userId]
    if not previousAccount then
        previousAccountsList[userId] = {
            userId = userId,
            userIdentifier = tbl1.username,
            username = tbl1.username,
            displayName = displayName,
            signInTimestamp = os.time(),
            showInAccountPicker = true
        }
        AppStorageUtilities.setPreviousAccountsList(previousAccountsList)
        prunePreviousAccountsList()
        return true
    end

    local tbl2 = {
        username = tbl1.username,
        displayName = displayName
    }
    if FFlagFixPreviousAccountsListEntries then
        tbl2.userId = userId
    end
    previousAccountsList[userId] = Cryo.Dictionary.join(previousAccount, tbl2)
    AppStorageUtilities.setPreviousAccountsList(previousAccountsList)
    return true
end

return ensureLoginEntry
