-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:20:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserListParent = script:FindFirstAncestor("UserList").Parent

local Signals = require(UserListParent.Signals)
local useSignalState = require(UserListParent.SignalsReact).useSignalState
local UserProfiles = require(UserListParent.UserProfiles)
local React = require(UserListParent.React)

local function createUserProfileNameGetter(arg1, computed, arg2) -- Luacid: Inlined by compiler; 3 call sites recovered
    return Signals.createComputed(function(arg3)
        if computed(arg3) then
            return ""
        end
        local var1 = arg1(arg3)
        if not var1.data or #var1.data == 0 then
            return ""
        end
        local names = var1.data[1].names
        return arg2(names) or ""
    end)
end

local function useUserDataValues(str1: string)
    local var1 = UserProfiles.Stores.UserProfileStore.get()
    local var2 = if str1 and str1 ~= "" then var1.fetchNamesByUserIds({ str1 }) else nil

    local computed = Signals.createComputed(function(arg1): boolean
        return not var2 or var2(arg1).status ~= "success"
    end)
    local isLoading = useSignalState(computed)

    local userProfileNameGetter = createUserProfileNameGetter(var2, computed, function(arg1)
        local displayName = arg1.getDisplayName(false)
        local username = arg1.getUsername(false)
        return displayName or username
    end)
    local displayName = useSignalState(userProfileNameGetter)

    local userProfileNameGetter2 = createUserProfileNameGetter(var2, computed, function(arg1)
        return arg1.getUsername(false)
    end)
    local username = useSignalState(userProfileNameGetter2)

    local userProfileNameGetter3 = createUserProfileNameGetter(var2, computed, function(arg1)
        return arg1.getCombinedName(false)
    end)
    local combinedName = useSignalState(userProfileNameGetter3)

    return React.useMemo(function()
        return {
            isLoading = isLoading or false,
            displayName = displayName or "",
            combinedName = combinedName or "",
            username = username or ""
        }
    end, {
        str1,
        isLoading,
        displayName,
        combinedName,
        username
    })
end

return useUserDataValues
