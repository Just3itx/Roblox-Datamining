-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local dependencies = require(scriptParentParent.dependencies)

local ContactsProtocol = require(scriptParentParentParent.ContactsProtocol).ContactsProtocol
local AppStorageService = game:GetService("AppStorageService")

local useSelector = dependencies.useSelector
local useDispatch = dependencies.useDispatch
local useEffectOnce = dependencies.useEffectOnce
local AutoSyncContacts = require(scriptParentParent.Networking.AutoSyncContacts)

return function(bool1: boolean?, arg1)
    local var1 = useDispatch()
    local var2 = useSelector(function(arg2)
        return arg2.LocalUserId
    end)
    useEffectOnce(arg1 or function()
        var1(AutoSyncContacts(var2, ContactsProtocol.default, AppStorageService))
    end, bool1)
end
