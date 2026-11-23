-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:00:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Promise = require(AppChatParent.Promise)
local SharedFlags = require(AppChatParent.SharedFlags)
local Sources = require(AppChatParent.SocialLuaAnalytics).Analytics.Enums.Sources

local getProfileTrustedFriendActions = require(AppChat.Http.getProfileTrustedFriendActions)

local FFlagProfilePlatformAddTC = SharedFlags.FFlagProfilePlatformAddTC

local function createTrustedFriendAction(rawActionType: string, actionType: string, isDisabled: boolean, modalVariantOverride: string?) -- Luacid: Inlined by compiler; 6 call sites recovered
    return {
        rawActionType = rawActionType,
        actionType = actionType,
        isDisabled = isDisabled,
        modalVariantOverride = modalVariantOverride
    }
end

local function normalizeTrustedFriendAction(tbl1)
    for _, value in tbl1 do
        if value == "RemoveTrustedConnection" then
            return createTrustedFriendAction(value, "RemoveTrustedConnection", false, nil)
        end
        if value == "AddTrustedConnection" then
            if FFlagProfilePlatformAddTC then
                return createTrustedFriendAction(value, "AddTrustedConnection", false, nil)
            end
        else
            if value == "AddTrustedConnectionViaLink" then
                return createTrustedFriendAction(value, "AddTrustedConnection", false, Sources.ShareLinkSender)
            end

            if value == "PendingTrustedConnection" then
                if FFlagProfilePlatformAddTC then
                    return createTrustedFriendAction(value, "AddTrustedConnection", true, nil)
                end
            elseif value == "AddIncomingTrustedConnection" then
                if FFlagProfilePlatformAddTC then
                    return createTrustedFriendAction(value, "AddIncomingTrustedConnection", false, nil)
                end
            elseif value == "PendingIncomingTrustedConnection" then
                return createTrustedFriendAction(value, "AddIncomingTrustedConnection", true, nil)
            end
        end
    end

    return nil
end

local function getTrustedFriendAction(str1: string)
    if str1 == "" then
        return Promise.resolve(nil)
    end

    return getProfileTrustedFriendActions(str1):andThen(function(arg1)
        return (normalizeTrustedFriendAction(arg1))
    end):catch(function()
        return nil
    end)
end

return getTrustedFriendAction
