-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Signals = require(AppChatParent.Signals)
local useSignalBinding = require(AppChatParent.SignalsReact).useSignalBinding
local UserProfiles = require(AppChatParent.UserProfiles)
local React = require(AppChatParent.React)
local _types = require(AppChat.types)
local useFoundationPresence = require(script.Parent.useFoundationPresence)

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

local function useUserData(str1: string)
    local var1 = UserProfiles.Stores.UserProfileStore.get()
    local var2 = if str1 and str1 ~= "" then var1.fetchNamesByUserIds({ str1 }) else nil

    local computed = Signals.createComputed(function(arg1): boolean
        return not var2 or var2(arg1).status ~= "success"
    end)
    local isLoading = useSignalBinding(computed)

    local userProfileNameGetter = createUserProfileNameGetter(var2, computed, function(arg1)
        local displayName = arg1.getDisplayName(false)
        local username = arg1.getUsername(false)
        return displayName or username
    end)
    local displayName = useSignalBinding(userProfileNameGetter)

    local userProfileNameGetter2 = createUserProfileNameGetter(var2, computed, function(arg1)
        return arg1.getUsername(false)
    end)
    local username = useSignalBinding(userProfileNameGetter2)

    local userProfileNameGetter3 = createUserProfileNameGetter(var2, computed, function(arg1)
        return arg1.getCombinedName(false)
    end)
    local combinedName = useSignalBinding(userProfileNameGetter3)

    local var7 = useFoundationPresence(str1)

    return React.useMemo(function()
        return {
            isLoading = isLoading,
            id = tonumber(str1) or -1,
            displayName = displayName,
            combinedName = combinedName,
            username = username,
            presenceText = var7.presenceText,
            presence = var7.presence
        }
    end, { str1, var7 })
end

return useUserData
