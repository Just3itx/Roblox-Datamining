-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Logger = require(AppChatParent.Loggers).Logger
local React = require(AppChatParent.React)
local useLocalUserId = require(AppChatParent.RobloxAppHooks).useLocalUserId
local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector
local Foundation = require(AppChatParent.Foundation)
local FFlagEnableBlackbirdCheck = require(AppChatParent.SharedFlags).FFlagEnableBlackbirdCheck
local FFlagUserTileUnfilteredChatIndicator = require(AppChatParent.SharedFlags).FFlagUserTileUnfilteredChatIndicator
local escapeRichFormatting = require(AppChatParent.InlineRichText).escapeRichFormatting
local useIsRobloxSubscriber = require(AppChatParent.UserProfiles).Hooks.useIsRobloxSubscriber
local UserTile = require(AppChatParent.UserTile).UserTile
local LayoutMode = require(AppChatParent.UserTile).LayoutMode
local RoduxPresence = require(AppChat.Http.RoduxPresence)
local FFlagAppChatPresenceStoreMigration = require(AppChat.Flags.FFlagAppChatPresenceStoreMigration)
local DataHydration = require(AppChatParent.DataHydration)
local Signals = require(AppChatParent.Signals)
local SignalsReact = require(AppChatParent.SignalsReact)

local var1 = Logger:new(script.Name)

local useFoundationPresence = require(AppChat.Hooks.useFoundationPresence)

local PresenceType = RoduxPresence.Enums.PresenceType
local UserPresence = Foundation.Enums.UserPresence
local PresenceType2 = if FFlagAppChatPresenceStoreMigration then DataHydration.Presence.PresenceEnums.PresenceType else nil
local var2 = if FFlagAppChatPresenceStoreMigration then DataHydration.Presence.PresenceStore.get() else nil

local function groupPresenceAggregateEquals(tbl1, tbl2): boolean
    return tbl1.hasInExperienceUser == tbl2.hasInExperienceUser and tbl1.hasOnlineUser == tbl2.hasOnlineUser
end

local function getParticipantId(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    if type(arg1) == "table" then
        local var3 = arg1.id or arg1.userId
        if var3 ~= nil then
            return tostring(var3)
        end

        return nil
    elseif arg1 ~= nil then
        return tostring(arg1)
    else
        return nil
    end
end

local function getNonEmptyLocalUserId(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    if arg1 == nil or arg1 == "" then
        return nil
    end

    return tostring(arg1)
end

local function ConversationFacePileInner(tbl1)
    local conversationId = tbl1.conversationId
    local var3 = useLocalUserId()
    local nonEmptyLocalUserId = getNonEmptyLocalUserId(tbl1.localUserId) or getNonEmptyLocalUserId(var3) or ""

    local var4 = React.useCallback(function(arg1)
        if arg1 and arg1.ChatAppReducer and arg1.ChatAppReducer.Conversations then
            return arg1.ChatAppReducer.Conversations[conversationId]
        end

        return nil
    end, { conversationId })
    local var5 = useSelector(var4)

    local var6 = if FFlagAppChatPresenceStoreMigration then nil else useSelector(function(arg1)
        if arg1 and arg1.ChatAppReducer and arg1.ChatAppReducer.Presence then
            return arg1.ChatAppReducer.Presence.byUserId
        end

        return nil
    end)

    local var7 = tbl1.participants or not var5 and {} or not var5.participants and {} or var5.participants

    local tbl2 = {}
    if #var7 == 1 then
        table.insert(tbl2, nonEmptyLocalUserId)
    else
        for _, value in var7 do
            local participantId = getParticipantId(value)

            if participantId and tostring(participantId) ~= tostring(nonEmptyLocalUserId) then
                table.insert(tbl2, participantId)
            end
        end
    end

    local var8 = if FFlagAppChatPresenceStoreMigration then React.useMemo(function()
        return Signals.createComputed(function(arg1)
            local bool1 = false
            local bool2 = false

            for _, value in tbl2 do
                local var8 = var2.GetPresenceByUserId(value).data(arg1)
                if not var8 then
                    continue
                end

                local userPresenceType = var8.userPresenceType

                if userPresenceType == PresenceType2.InGame or userPresenceType == PresenceType2.InStudio then
                    bool1 = true
                elseif userPresenceType == PresenceType2.Online then
                    bool2 = true
                end
            end

            return { hasInExperienceUser = bool1, hasOnlineUser = bool2 }
        end, groupPresenceAggregateEquals)
    end, { table.concat(tbl2, ",") }) else nil

    local var9 = if FFlagAppChatPresenceStoreMigration then SignalsReact.useSignalState(var8) else nil
    local userId = tbl2[1] or nonEmptyLocalUserId
    local var11 = useFoundationPresence(userId)

    local none = UserPresence.None
    if #tbl2 >= 2 then
        local bool1 = false
        local bool2 = false

        if FFlagAppChatPresenceStoreMigration then
            if var9 then
                bool1 = var9.hasInExperienceUser
            else
                bool1 = false
            end

            if var9 then
                bool2 = var9.hasOnlineUser
            else
                bool2 = false
            end
        else
            for _, value in tbl2 do
                if not (var6 and var6[value]) then
                    continue
                end

                local userPresenceType = var6[value].userPresenceType
                if userPresenceType == PresenceType.InGame or userPresenceType == PresenceType.InStudio then
                    bool1 = true
                elseif userPresenceType == PresenceType.Online then
                    bool2 = true
                end
            end
        end

        if bool1 then
            none = UserPresence.InExperience
        elseif bool2 then
            none = UserPresence.Active
        end
    else
        none = var11.presence
    end

    local var12 = nil
    if FFlagEnableBlackbirdCheck and #var7 == 2 then
        for _, value in var7 do
            local participantId = getParticipantId(value)

            if participantId and tostring(participantId) ~= tostring(nonEmptyLocalUserId) then
                var12 = tostring(participantId)
                break
            end
        end
    end

    local var13 = useIsRobloxSubscriber(var12)

    local createElement = React.createElement
    local var14 = UserTile
    local tbl3 = {
        userId = userId,
        facePileSecondUserId = tbl2[2] or nil,
        layoutMode = LayoutMode.wide,
        title = if tbl1.titleText then escapeRichFormatting(tbl1.titleText) else tbl1.titleText,
        subtitle = if tbl1.subtitleText then escapeRichFormatting(tbl1.subtitleText) else tbl1.subtitleText,
        titleStyle = tbl1.titleStyle,
        subtitleStyle = tbl1.subtitleStyle,
        userPresenceType = none,
        onActivated = tbl1.onActivated,
        selectable = tbl1.selectable,
        customTextTruncation = Enum.TextTruncate.SplitWord,
        trustedConnectionIndicatorEnabled = tbl1.trustedConnectionIndicatorEnabled,
        isRobloxSubscriber = 0,
        shouldShowUnfilteredChatIndicator = 0
    }

    if not FFlagEnableBlackbirdCheck then
        var13 = nil
    end

    tbl3.isRobloxSubscriber = var13
    tbl3.shouldShowUnfilteredChatIndicator = if FFlagUserTileUnfilteredChatIndicator then tbl1.shouldShowUnfilteredChatIndicator else nil
    return createElement(var14, tbl3)
end

local function ConversationFacePile(tbl1)
    local conversationId = tbl1.conversationId
    if not conversationId or conversationId == "" then
        var1:warning("conversationId cannot be nil nor an empty string")
        return nil
    end

    local var3 = table.clone(tbl1)
    var3.conversationId = conversationId
    return React.createElement(ConversationFacePileInner, var3)
end

return ConversationFacePile
