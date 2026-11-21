-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:50:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AppStorageUtilities = require(AuthCommon.Utils.AppStorageUtilities)
local User = require(AuthCommon.Thunks.User)
local AuthCommonParent = AuthCommon.Parent
local Cryo = require(AuthCommonParent.Cryo)
local FFlagFixPreviousAccountsListEntries = require(AuthCommonParent.SharedFlags).FFlagFixPreviousAccountsListEntries

return function()
    local localStorage = User.fromLocalStorage()
    if localStorage == nil or localStorage.userId == -1 or localStorage.username == nil or localStorage.username == "" then
        return
    end

    local previousAccountsList = AppStorageUtilities.getPreviousAccountsList()
    local userId = tostring(localStorage.userId)
    local tbl1 = {
        username = localStorage.username,
        displayName = if not localStorage.displayName or localStorage.displayName == "nil" then "" else localStorage.displayName,
        timestamp = os.time()
    }
    if FFlagFixPreviousAccountsListEntries then
        tbl1.userId = userId
        previousAccountsList[userId] = Cryo.Dictionary.join(previousAccountsList[userId] or {}, tbl1)
    else
        previousAccountsList[userId] = tbl1
    end
    AppStorageUtilities.setPreviousAccountsList(previousAccountsList)
    AppStorageUtilities.flush()
end
