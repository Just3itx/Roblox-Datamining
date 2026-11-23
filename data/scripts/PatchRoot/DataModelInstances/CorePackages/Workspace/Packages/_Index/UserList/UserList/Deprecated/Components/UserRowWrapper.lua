-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:20:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserListParent = script:FindFirstAncestor("UserList").Parent

local React = require(UserListParent.React)
local UserProfiles = require(UserListParent.UserProfiles)
local useEffect = React.useEffect
local UserProfileStore = UserProfiles.Stores.UserProfileStore
local UserPresence = require(UserListParent.Foundation).Enums.UserPresence
local useGetPresenceByUserId = require(UserListParent.FriendsCommon).Hooks.useGetPresenceByUserId
local PresenceType = require(UserListParent.DataHydration).Presence.PresenceEnums.PresenceType

local UserRow = require(script.Parent.UserRow)

local function UserRowWrapper(tbl1)
    local onActivated = React.useCallback(function()
        tbl1.onActivated(tbl1.userId)
    end, { tbl1.onActivated, tbl1.userId })

    local displayName, var3 = React.useState("")
    local username, var5 = React.useState("")

    useEffect(function()
        local fetchNamesByUserIds = UserProfileStore.get().fetchNamesByUserIds
        local tbl2 = { tostring(tbl1.userId) }

        fetchNamesByUserIds(tbl2, function(arg1)
            local status = arg1.status
            local data = arg1.data
            if status == "success" and #data > 0 and data[1] and data[1].names then
                local combinedName = data[1].names.getCombinedName(false)
                local username = data[1].names.getUsername(false)
                var3(combinedName)
                var5(username)
            end
        end)
    end, { tbl1.userId })

    local var6 = useGetPresenceByUserId(tbl1.userId)

    local userPresence = React.useMemo(function()
        local userPresenceType = var6 and var6.userPresenceType
        return if userPresenceType == PresenceType.Online
            or userPresenceType == PresenceType.InStudio
            or userPresenceType == PresenceType.InGame then UserPresence.Active else UserPresence.None
    end, { var6 })

    return React.createElement(UserRow, {
        userId = tbl1.userId,
        userPresence = userPresence,
        displayName = displayName,
        username = username,
        onActivated = onActivated
    })
end

return UserRowWrapper
