-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local LoginResult = require(AuthCommon.Models.LoginResult)
local AppStorageUtilities = require(AuthCommon.Utils.AppStorageUtilities)
local _PreviousAccountEntry = require(AuthCommon.Utils.PreviousAccountEntry)
local prunePreviousAccountsList = require(AuthCommon.Utils.prunePreviousAccountsList)
local AuthCommonParent = AuthCommon.Parent
local Cryo = require(AuthCommonParent.Cryo)

local function recordLogin(arg1, loginMethod: string, userIdentifier: string?): boolean
    if arg1.user.id == nil or arg1.user.id == "0" then
        return false
    end
    if arg1.user.name == nil or arg1.user.name == "" then
        return false
    end
    local previousAccountsList = AppStorageUtilities.getPreviousAccountsList()

    if userIdentifier == nil then
        userIdentifier = arg1.user.name
    end

    local num1 = os.time()
    local var1 = LoginResult.hasTwoStepData(arg1)

    if var1 then
        num1 = nil
    end

    local tbl1 = {
        userId = arg1.user.id,
        userIdentifier = userIdentifier,
        loginMethod = loginMethod,
        username = arg1.user.name,
        signInTimestamp = num1,
        showInAccountPicker = true
    }

    local previousAccount = previousAccountsList[arg1.user.id]
    if previousAccount ~= nil then
        if not var1 then
            tbl1.signOutTimestamp = Cryo.None
        end

        previousAccountsList[arg1.user.id] = Cryo.Dictionary.join(previousAccount, tbl1)
    else
        previousAccountsList[arg1.user.id] = tbl1
    end
    AppStorageUtilities.setPreviousAccountsList(previousAccountsList)
    prunePreviousAccountsList()
    return true
end

return recordLogin
