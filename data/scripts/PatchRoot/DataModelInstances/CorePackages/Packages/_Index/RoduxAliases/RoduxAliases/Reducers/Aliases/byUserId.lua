-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local Rodux = require(scriptParentParentParentParent.Rodux)
local llama = require(scriptParentParentParentParent.llama)

local Actions = scriptParentParentParent.Actions
local AliasUpdated = require(Actions.AliasUpdated)
local AliasRemoved = require(Actions.AliasRemoved)
local ReceivedCanShowUserAlias = require(Actions.ReceivedCanShowUserAlias)

local _RoduxAliasesTypes = require(scriptParentParentParent.RoduxAliasesTypes)

local function addUserIdsToState(arg1, tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    return llama.Dictionary.join(arg1, tbl1)
end

local function addUsersIdsToInternalState(arg1, tbl1)
    local _internalHiddenData = addUserIdsToState(arg1._INTERNAL_HIDDEN_DATA, tbl1)

    return llama.Dictionary.join(arg1, { _INTERNAL_HIDDEN_DATA = _internalHiddenData })
end

local tbl1 = { ShowUserAlias = true }

return function(arg1)
    local aliasNetworking = arg1.aliasNetworking

    local createReducer = Rodux.createReducer
    local tbl2 = tbl1
    local tbl3 = {}
    tbl3[AliasUpdated.name] = function(arg2, arg3)
        assert(type(arg3.payload.userId) == "string", "Expected userId to be a string")
        assert(type(arg3.payload.newAlias) == "string", "Expected newAlias to be a string")

        local tbl4 = {}
        tbl4[arg3.payload.userId] = arg3.payload.newAlias

        if arg2.ShowUserAlias or arg2.ShowUserAlias == nil then
            return addUserIdsToState(arg2, tbl4)
        end
        return addUsersIdsToInternalState(arg2, tbl4)
    end

    tbl3[AliasRemoved.name] = function(arg2, arg3)
        assert(type(arg3.payload.userId) == "string", "Expected userId to be a string")

        local tbl4 = {}
        tbl4[arg3.payload.userId] = llama.None

        if arg2.ShowUserAlias or arg2.ShowUserAlias == nil then
            return addUserIdsToState(arg2, tbl4)
        end
        return addUsersIdsToInternalState(arg2, tbl4)
    end

    tbl3[ReceivedCanShowUserAlias.name] = function(arg2, arg3)
        assert(type(arg3.payload.showUserAlias) == "boolean", "Expected showUserAlias to be a boolean")

        if arg3.payload.showUserAlias == arg2.ShowUserAlias then
            return arg2
        elseif arg3.payload.showUserAlias then
            return llama.Dictionary.join(
                arg2._INTERNAL_HIDDEN_DATA or {},
                {
                    ShowUserAlias = arg3.payload.showUserAlias,
                    _INTERNAL_HIDDEN_DATA = llama.None
                }
            )
        end

        return {
            ShowUserAlias = arg3.payload.showUserAlias,
            _INTERNAL_HIDDEN_DATA = llama.Dictionary.join(arg2, { ShowUserAlias = llama.None, _INTERNAL_HIDDEN_DATA = llama.None })
        }
    end

    tbl3[aliasNetworking.GetTagsFromUserIds.Succeeded.name] = function(arg2, arg3)
        local tbl4 = {}
        for _, value in ipairs(arg3.responseBody) do
            local targetUserId = value.targetUserId
            tbl4[tostring(targetUserId)] = value.targetUserTag
        end

        if arg2.ShowUserAlias or arg2.ShowUserAlias == nil then
            return addUserIdsToState(arg2, tbl4)
        end
        return addUsersIdsToInternalState(arg2, tbl4)
    end

    tbl3[aliasNetworking.SetUserTag.Succeeded.name] = function(arg2, arg3)
        local userTag = arg3.postBody.userTag
        local targetUserId = arg3.postBody.targetUserId

        return llama.Dictionary.join(arg2, { [tostring(targetUserId)] = userTag })
    end

    return createReducer(tbl2, tbl3)
end
