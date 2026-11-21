-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local Types = scriptParentParentParent.Types
local Rodux = require(scriptParentParentParentParent.Rodux)
local Dash = require(scriptParentParentParentParent.Dash)
local _ActionTypes = require(Types.ActionTypes)
local _ReducerTypes = require(Types.ReducerTypes)
local getDeepValue = require(scriptParentParentParentParent.LuaSocialLibrariesDeps).SocialLibraries.config({}).Dictionary.getDeepValue
local tbl1 = {}

return function(arg1)
    local networkingContacts = arg1.networkingContacts

    local createReducer = Rodux.createReducer
    local tbl2 = tbl1
    local tbl3 = {}
    tbl3[networkingContacts.UploadContactsByUser.Succeeded.name] = function(_, arg2)
        if not getDeepValue(arg2, "responseBody.matchedContactFields") then
            return {}
        end

        local result = {}

        Dash.forEach(arg2.responseBody.matchedContactFields, function(arg3)
            if not result[arg3.idAssignedByFE] then
                result[arg3.idAssignedByFE] = {}
            end

            result[arg3.idAssignedByFE][arg3.userContactId] = true
        end)

        return result
    end

    return createReducer(tbl2, tbl3)
end
