-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:21:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local Rodux = require(scriptParentParentParent.Rodux)
local _ReducerTypes = require(scriptParentParent.Types.ReducerTypes)

local tbl1 = { canUploadContacts = nil }

return function(arg1)
    local networkingUserSettings = arg1.networkingUserSettings

    local createReducer = Rodux.createReducer
    local tbl2 = tbl1
    local tbl3 = {}
    tbl3[networkingUserSettings.GetUserSettings.Succeeded.name] = function(_, arg2)
        return {
            canUploadContacts = arg2.responseBody and arg2.responseBody.canUploadContacts
        }
    end

    tbl3[networkingUserSettings.UpdateUserSettings.Succeeded.name] = function(arg2, arg3)
        return if arg3.postBody and arg3.postBody.canUploadContacts ~= nil then {
            canUploadContacts = arg3.postBody.canUploadContacts
        } else arg2
    end

    return createReducer(tbl2, tbl3)
end
