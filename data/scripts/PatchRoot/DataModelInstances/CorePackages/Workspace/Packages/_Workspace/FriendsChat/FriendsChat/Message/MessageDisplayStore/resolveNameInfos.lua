-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:20:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local UserProfileStore = require(FriendsChatParent.UserProfiles).Stores.UserProfileStore

local _NameInfo = require(script.Parent.NameInfo)

local function resolveProfileNameInfo(arg1, arg2)
    if arg1 == nil or arg1.names == nil then
        return { name = nil, username = nil }
    end

    local getCombinedName = arg1.names.getCombinedName
    local getDisplayName = arg1.names.getDisplayName
    local getUsername = arg1.names.getUsername
    local username = if getUsername then getUsername(arg2) else nil
    local combinedName = if getCombinedName then getCombinedName(arg2) else nil
    local displayName = if getDisplayName then getDisplayName(arg2) else nil

    if combinedName ~= nil and combinedName ~= "" then
        displayName = combinedName
    elseif displayName == nil or displayName == "" then
        displayName = username
    end
    return { name = displayName, username = username }
end

local function resolveNameInfos(tbl1, arg1)
    local tbl2 = {}
    local tbl3 = ({})
    local tbl4 = {}
    for _, value in tbl1 do
        if not tbl3[value] then
            tbl3[value] = true
            table.insert(tbl2, value)
            table.insert(tbl4, tostring(value))
        end
    end

    local var1 = UserProfileStore.get().fetchNamesByUserIds(tbl4)(arg1)
    local var2 = not (var1 and var1.data) and {} or var1.data

    local result = ({})
    for value, value2 in tbl2 do
        result[value2] = resolveProfileNameInfo(var2[value], arg1)
    end
    return result
end

return resolveNameInfos
