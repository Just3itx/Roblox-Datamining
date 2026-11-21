-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local Types = scriptParentParentParent.Types
local Rodux = require(scriptParentParentParentParent.Rodux)

local setContactsInStore = require(script.Parent.utils.setContactsInStore)
local updateContactsInStore = require(script.Parent.utils.updateContactsInStore)
local _ActionTypes = require(Types.ActionTypes)
local _ReducerTypes = require(Types.ReducerTypes)

local tbl1 = {}

return function(arg1)
    local networkingContacts = arg1.networkingContacts

    local createReducer = Rodux.createReducer
    local tbl2 = tbl1
    local tbl3 = {}
    tbl3[networkingContacts.FindContactFriends.Succeeded.name] = function(_, arg2)
        return setContactsInStore(arg2)
    end

    tbl3[networkingContacts.GetContactEntitiesByContactId.Succeeded.name] = function(arg2, arg3)
        return updateContactsInStore(arg2, arg3)
    end

    return createReducer(tbl2, tbl3)
end
