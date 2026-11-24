-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local React = require(FriendsChatParent.React)
local SharedFlags = require(FriendsChatParent.SharedFlags)
local UniversalAppPolicy = require(FriendsChatParent.UniversalAppPolicy)
local UserProfiles = require(FriendsChatParent.UserProfiles)

local FriendsChatTextMessage = require(script.Parent.Parent.Message.FriendsChatTextMessage)
local buildRowDisplay = require(script.Parent.Parent.Message.MessageDisplayStore.buildRowDisplay)
local FriendsChatOsaAcknowledgement = require(script.Parent.FriendsChatOsaAcknowledgement)

local FFlagFriendsChatDiscloseUpdateSecondVersion = SharedFlags.FFlagFriendsChatDiscloseUpdateSecondVersion

local UserProfileStore = UserProfiles.Stores.UserProfileStore

local function getProfileDisplayName(arg1, arg2)
    if arg1 == nil then
        return nil, false
    end
    if arg1.status == "failed" then
        return nil, true
    end

    local var1 = if arg1.data then arg1.data[1] else nil
    local names = if var1 then var1.names else nil

    if names == nil then
        return nil, false
    end

    local combinedName = if names.getCombinedName then names.getCombinedName(arg2) else nil

    if combinedName ~= nil and combinedName ~= "" then
        return combinedName, false
    end

    local displayName = if names.getDisplayName then names.getDisplayName(arg2) else nil

    if displayName ~= nil and displayName ~= "" then
        return displayName, false
    end

    return if names.getUsername then names.getUsername(arg2) else nil, false
end

local function buildDisplay(displayName: string?, bool1: boolean, localize, systemTextSize: number?)
    local var1 = UniversalAppPolicy.getAppFeaturePolicies().getCanSeeChatTerminology()
    local bool2 = bool1 or displayName == nil
    return buildRowDisplay({
        kind = "systemMessage",
        body = `{localize(
            var1
                and (bool2
                    and (if FFlagFriendsChatDiscloseUpdateSecondVersion then "Feature.Chat.Heading.FirstConversationWithThisUser" else "Feature.Chat.Heading.SafeChattingWithThisUser")
                    or FFlagFriendsChatDiscloseUpdateSecondVersion
                        and {
                            "Feature.Chat.Heading.FirstConversationWith",
                            displayName = displayName
                        }
                    or {
                        "Feature.Chat.Heading.SafeChattingWithUsername",
                        displayName = displayName
                    })
                or (if bool2 then "Feature.Chat.Heading.FirstInteractionWithThisPerson" else {
                    "Feature.Chat.Heading.FirstInteractionWith",
                    displayName = displayName
                })
        )}\n{localize(
            if var1 then "Feature.Chat.Description.InlineContextCardDescription" else "Feature.Chat.Description.OSAContextCardDescription"
        )}`,
        variant = "default"
    }, {}, { systemTextSize = systemTextSize })
end

local function FriendsChatOsaSystemMessage(tbl1)
    local guiObjectRef = React.useRef(nil)
    FriendsChatOsaAcknowledgement.useAcknowledgement(
        {
            conversationId = tbl1.conversationId,
            userId = tbl1.userId,
            guiObjectRef = guiObjectRef
        }
    )
    local var2 = React.useMemo(function()
        return UserProfileStore.get().fetchNamesByUserIds({ tbl1.userId })
    end, { tbl1.userId })
    local getDisplayId = React.useCallback(function(): string
        return `osa-system-message-{tbl1.conversationId}`
    end, { tbl1.conversationId })
    local getLayoutOrder = React.useCallback(function(): number
        return 0
    end, {})
    local getDisplayFromId = React.useCallback(function(_: string?, arg1, arg2)
        local displayName, bool1 = getProfileDisplayName(var2(arg1), arg1)
        return buildDisplay(
            displayName,
            bool1,
            if arg2 and arg2.localize then arg2.localize else tbl1.localize,
            if arg2 then arg2.systemTextSize else nil
        )
    end, { var2, tbl1.localize })

    return React.createElement(FriendsChatTextMessage, {
        getDisplayId = getDisplayId,
        getDisplayFromId = getDisplayFromId,
        getLayoutOrder = getLayoutOrder,
        chatWindowSettings = tbl1.chatWindowSettings,
        textTransparency = tbl1.textTransparency,
        isSpatialUIEnabled = tbl1.isSpatialUIEnabled,
        localize = tbl1.localize,
        guiObjectRef = guiObjectRef
    })
end

return FriendsChatOsaSystemMessage
