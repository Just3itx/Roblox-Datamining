-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent

local SelectedUsersContext = require(scriptParent.SelectedUsersContext)

local React = require(scriptParentParentParent.React)
local Cryo = require(scriptParentParentParent.Cryo)
local UserProfiles = require(scriptParentParentParent.UserProfiles)

return function(tbl1)
    local var1 = UserProfiles.Hooks.useUserProfilesFetch(
        {
            userIds = tbl1.preselectedUsers or {},
            query = UserProfiles.Queries.userProfilesCombinedNameByUserIds
        }
    )
    local var2 = React.useCallback(function(arg1)
        local result = ({})
        local str1 = ""
        for _, value in pairs(arg1) do
            if var1.data then
                str1 = UserProfiles.Selectors.getCombinedNameFromId(var1.data, value)
            end
            local tbl2 = {
                displayName = str1,
                layoutOrder = #result + 1,
                unremovable = tbl1.preselectedUsersUnremovable
            }
            result[value] = tbl2
        end

        return result
    end, nil)

    local var3 = React.useRef(tbl1.preselectedUsers and #tbl1.preselectedUsers or 0)

    local selectedFriends, var5 = React.useState(not tbl1.preselectedUsers and {} or var2(tbl1.preselectedUsers))

    local selectedFriendsSize, var7 = React.useState(tbl1.preselectedUsers and #tbl1.preselectedUsers or 0)

    local addFriend = React.useCallback(function(arg1, displayName)
        if tbl1.selectionLimit ~= nil and not (selectedFriendsSize < tbl1.selectionLimit) then
            return
        end

        var5(Cryo.Dictionary.join(selectedFriends, { [arg1] = { displayName = displayName, layoutOrder = var3.current } }))

        var3.current += 1
        var7(selectedFriendsSize + 1)
    end, { selectedFriends })

    local removeFriend = React.useCallback(function(arg1, arg2)
        var5(Cryo.Dictionary.join(selectedFriends, { [arg1] = Cryo.None }))
        var7(selectedFriendsSize - 1)
        if tbl1.onRemoveCallback then
            tbl1.onRemoveCallback(arg1, arg2)
        end
    end, { selectedFriends })

    local isFriendSelected = React.useCallback(function(arg1): boolean
        return selectedFriends[arg1] ~= nil
    end, { selectedFriends })

    return React.createElement(SelectedUsersContext.Provider, {
        value = React.useMemo(function()
            return {
                selectedFriendsSize = selectedFriendsSize,
                selectedFriends = selectedFriends,
                addFriend = addFriend,
                removeFriend = removeFriend,
                isFriendSelected = isFriendSelected,
                preselectedUsers = tbl1.preselectedUsers
            }
        end, {
            selectedFriends,
            addFriend,
            removeFriend,
            isFriendSelected
        })
    }, tbl1.children)
end
