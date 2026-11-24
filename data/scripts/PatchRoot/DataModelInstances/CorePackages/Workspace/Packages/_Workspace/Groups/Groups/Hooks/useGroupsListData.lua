-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Groups = script:FindFirstAncestor("Groups")
local GroupsParent = Groups.Parent

local React = require(GroupsParent.React)
local SignalsReact = require(GroupsParent.SignalsReact)

local createGroupsListStore = require(Groups.Stores.createGroupsListStore)
local _Types = require(Groups.Common.Types)

local function useGroupsListData(str1: string?)
    local var1 = React.useMemo(function()
        return createGroupsListStore()
    end, {})

    local var2 = SignalsReact.useSignalState(var1.getState)

    React.useEffect(function()
        if str1 and str1 ~= "" then
            var1.fetchGroups(str1)

            return function()
                var1.reset()
            end
        end

        var1.reset()
    end, { var1, str1 })

    return var2
end

return useGroupsListData
