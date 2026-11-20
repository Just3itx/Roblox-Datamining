-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:21:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local Rodux = require(scriptParentParentParent.Rodux)
local _ReducerTypes = require(scriptParentParent.Types.ReducerTypes)

local tbl1 = { prefillDiscoverabilitySetting = false }

return function(arg1)
    local networkingUserSettings = arg1.networkingUserSettings

    local createReducer = Rodux.createReducer
    local tbl2 = tbl1
    local tbl3 = {}
    tbl3[networkingUserSettings.GetUserSettingsMetadata.Succeeded.name] = function(_, arg2)
        return {
            prefillDiscoverabilitySetting = arg2.responseBody and arg2.responseBody.prefillDiscoverabilitySetting
        }
    end

    return createReducer(tbl2, tbl3)
end
