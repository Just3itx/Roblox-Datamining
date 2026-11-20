-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:21:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Types = scriptParentParent.Types
local isPhoneVerified = require(scriptParentParent.Reducers.isPhoneVerified)
local userSettings = require(scriptParentParent.Reducers.userSettings)
local userSettingsMetadata = require(scriptParentParent.Reducers.userSettingsMetadata)

local _ReducerTypes = require(Types.ReducerTypes)

local tbl1 = {
    isPhoneVerified = false,
    userSettings = {},
    userSettingsMetadata = {}
}

return function(arg1)
    return function(arg2, arg3)
        local var1 = arg2 or tbl1

        local var2 = isPhoneVerified(arg1)
        local var3 = userSettings(arg1)
        local var4 = userSettingsMetadata(arg1)

        return {
            isPhoneVerified = var2(var1.isPhoneVerified, arg3),
            userSettings = var3(var1.userSettings, arg3),
            userSettingsMetadata = var4(var1.userSettingsMetadata, arg3)
        }
    end
end
