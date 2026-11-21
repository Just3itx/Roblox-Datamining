-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Types = scriptParentParent.Types
local byContactId = require(scriptParentParent.Reducers.Contacts.byContactId)
local byDeviceContactId = require(scriptParentParent.Reducers.Contacts.byDeviceContactId)
local hasSentRequest = require(scriptParentParent.Reducers.Contacts.hasSentRequest)
local _ReducerTypes = require(Types.ReducerTypes)
local deviceContactToRobloxContact = require(scriptParentParent.Reducers.Contacts.deviceContactToRobloxContact)

local tbl1 = {
    byContactId = {},
    byDeviceContactId = {},
    hasSentRequest = {},
    deviceContactToRobloxContact = {}
}

return function(arg1)
    local var1 = byContactId(arg1)
    local var2 = byDeviceContactId(arg1)
    local var3 = hasSentRequest(arg1)
    local var4 = deviceContactToRobloxContact(arg1)

    return function(arg2, arg3)
        local var5 = arg2 or tbl1
        return {
            byContactId = var1(var5.byContactId, arg3),
            byDeviceContactId = var2(var5.byDeviceContactId, arg3),
            hasSentRequest = var3(var5.hasSentRequest, arg3),
            deviceContactToRobloxContact = var4(var5.deviceContactToRobloxContact, arg3)
        }
    end
end
