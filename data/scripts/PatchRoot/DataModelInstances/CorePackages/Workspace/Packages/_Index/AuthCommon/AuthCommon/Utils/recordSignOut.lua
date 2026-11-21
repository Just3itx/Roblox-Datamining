-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AppStorageUtilities = require(AuthCommon.Utils.AppStorageUtilities)
local _PreviousAccountEntry = require(AuthCommon.Utils.PreviousAccountEntry)
local User = require(AuthCommon.Thunks.User)
local AuthCommonParent = AuthCommon.Parent
local Cryo = require(AuthCommonParent.Cryo)
local prunePreviousAccountsList = require(AuthCommon.Utils.prunePreviousAccountsList)

local function recordSignOut(tbl1, bool1: boolean?)
    local showInAccountPicker = bool1 or true
    local localStorage

    if not tbl1 then
        localStorage = User.fromLocalStorage()
        if localStorage == nil or localStorage.userId == -1 then
            return
        end
        if localStorage.username == nil or localStorage.username == "" then
            return
        end
    else
        localStorage = {
            userId = tbl1.user_id,
            username = tbl1.username,
            displayName = tbl1.display_name
        }
    end
    local previousAccountsList = AppStorageUtilities.getPreviousAccountsList()
    local userId = tostring(localStorage.userId)
    local previousAccount = previousAccountsList[userId]
    if previousAccount then
        previousAccountsList[userId] = Cryo.Dictionary.join(previousAccount, {
            userId = userId,
            username = localStorage.username,
            displayName = if not localStorage.displayName or localStorage.displayName == "nil" then "" else localStorage.displayName,
            signOutTimestamp = os.time(),
            showInAccountPicker = showInAccountPicker
        })
    else
        previousAccountsList[userId] = {
            userId = userId,
            username = localStorage.username,
            userIdentifier = localStorage.username,
            loginMethod = nil,
            signInTimestamp = nil,
            displayName = if not localStorage.displayName or localStorage.displayName == "nil" then "" else localStorage.displayName,
            signOutTimestamp = os.time(),
            showInAccountPicker = showInAccountPicker
        }
    end

    AppStorageUtilities.setPreviousAccountsList(previousAccountsList)
    prunePreviousAccountsList()
    return true
end

return recordSignOut
