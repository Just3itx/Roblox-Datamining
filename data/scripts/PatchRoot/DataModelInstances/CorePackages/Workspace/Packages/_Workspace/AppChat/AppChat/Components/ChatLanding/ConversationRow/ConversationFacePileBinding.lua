-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local DataHydration = require(AppChatParent.DataHydration)
local Foundation = require(AppChatParent.Foundation)
local React = require(AppChatParent.React)
local _Signals = require(AppChatParent.Signals)
local SignalsReact = require(AppChatParent.SignalsReact)

local FFlagAppChatUseProfileFrameThumbnail = require(AppChat.Flags.FFlagAppChatUseProfileFrameThumbnail)
local FFlagAppChatBindingFacePileUserTileParity = require(AppChat.Flags.FFlagAppChatBindingFacePileUserTileParity)
local GetConversationStore = require(AppChat.Stores.GetConversationStore)
local getStandardSizeAvatarHeadShotRbxthumb = require(AppChatParent.UserLib).Utils.getStandardSizeAvatarHeadShotRbxthumb

local Avatar = Foundation.Avatar
local AvatarSize = Foundation.Enums.AvatarSize
local Image = Foundation.Image
local View = Foundation.View
local useCumulativeBackground = Foundation.Hooks.useCumulativeBackground
local var1 = DataHydration.Presence.PresenceStore.get()
local PresenceType = DataHydration.Presence.PresenceEnums.PresenceType

local function getParticipantId(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if type(arg1) == "table" then
        local var2 = arg1.id or arg1.userId
        if var2 ~= nil then
            return tostring(var2)
        end

        return nil
    elseif arg1 ~= nil then
        return tostring(arg1)
    else
        return nil
    end
end

local function getParticipantIds(tbl1, arg1)
    local var2 = tbl1.presentationSignal(arg1)
    local var3 = if var2.localUserId == nil then "" else tostring(var2.localUserId)
    local var4 = GetConversationStore(false).getConversation(tbl1.id, arg1)
    local var5 = (var4 == nil or var4.participants == nil) and {} or var4.participants

    local participantIds = {}

    if #var5 == 1 then
        table.insert(participantIds, var3)
        return participantIds
    end
    for _, value in var5 do
        local participantId = getParticipantId(value)

        if participantId ~= nil and participantId ~= var3 then
            table.insert(participantIds, participantId)
        end
    end

    return participantIds
end

local function getAvatarIds(tbl1, arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    local participantIds = getParticipantIds(tbl1, arg1)
    return {
        primary = participantIds[1] or "",
        secondary = participantIds[2]
    }
end

local function getHeadshotImage(userId: number, bool1: boolean, bool2: boolean?)
    if not bool1 or userId == 0 then
        return ""
    end
    return getStandardSizeAvatarHeadShotRbxthumb(tostring(userId), bool2)
end

local function ConversationFacePileBinding(tbl1)
    local var2 = Foundation.Hooks.useTokens()
    local shift300 = var2.Color.Shift.Shift_300

    local var3 = React.useCallback(function(tbl2, arg1): number
        return tonumber(getAvatarIds(tbl2, arg1).primary) or 0
    end, {})
    local var4 = React.useCallback(function(tbl2, arg1): number
        return tonumber(getAvatarIds(tbl2, arg1).secondary) or 0
    end, {})
    local var5 = React.useCallback(function(tbl2, arg1): boolean
        return getAvatarIds(tbl2, arg1).secondary ~= nil
    end, {})
    local var6 = React.useCallback(function(tbl2, arg1)
        for _, value in getParticipantIds(tbl2, arg1) do
            local var6 = var1.GetPresenceByUserId(value).data(arg1)
            if var6 == nil then
                continue
            end

            local userPresenceType = var6.userPresenceType

            if userPresenceType == PresenceType.InGame
                or userPresenceType == PresenceType.InStudio
                or userPresenceType == PresenceType.Online
            then
                return true
            end
        end

        return false
    end, {})

    local userId = SignalsReact.useSignalBinding(function(arg1)
        return var3(tbl1.itemSignal(arg1), arg1)
    end)
    local var7 = SignalsReact.useSignalBinding(function(arg1)
        return var4(tbl1.itemSignal(arg1), arg1)
    end)
    local hasSecondary = SignalsReact.useSignalBinding(function(arg1)
        return var5(tbl1.itemSignal(arg1), arg1)
    end)
    local var10 = SignalsReact.useSignalBinding(function(arg1)
        return var6(tbl1.itemSignal(arg1), arg1)
    end)
    local var11 = hasSecondary:map(function(arg1): boolean
        return not arg1
    end)

    local backgroundStyle = if FFlagAppChatBindingFacePileUserTileParity then useCumulativeBackground(var2.Color.Surface.Surface_0, shift300) else nil
    local presence = React.createElement(Image, {
        Image = "component_assets/circle_16",
        Position = UDim2.new(0.8536, var2.Stroke.Thicker, 0.8536, var2.Stroke.Thicker),
        Size = UDim2.new(0.125, 4, 0.125, 4),
        Visible = var10,
        ZIndex = 3,
        imageStyle = var2.Color.System.Success,
        stroke = {
            Thickness = var2.Stroke.Thicker,
            Color = var2.Color.Surface.Surface_100.Color3
        },
        tag = "anchor-center-center radius-circle bg-surface-100",
        testId = "conversation-face-pile-presence"
    })

    if not FFlagAppChatBindingFacePileUserTileParity then
        return React.createElement(View, {
            tag = "position-center-center anchor-center-center size-full"
        }, {
            Primary = React.createElement(Avatar, {
                backgroundStyle = shift300,
                includeProfileFrame = FFlagAppChatUseProfileFrameThumbnail,
                size = AvatarSize.Medium,
                testId = "conversation-face-pile-primary",
                userId = userId,
                Visible = var11
            }),
            Group = React.createElement(
                View,
                {
                    tag = "size-full",
                    testId = "conversation-face-pile-group",
                    Visible = hasSecondary
                },
                {
                    Primary = React.createElement(Avatar, {
                        AnchorPoint = Vector2.new(0, 1),
                        backplateStyle = var2.Color.Surface.Surface_0,
                        backgroundStyle = shift300,
                        Position = UDim2.fromScale(0, 1),
                        size = AvatarSize.Small,
                        testId = "conversation-face-pile-group-primary",
                        userId = userId,
                        ZIndex = 2
                    }),
                    Secondary = React.createElement(Avatar, {
                        AnchorPoint = Vector2.new(1, 0),
                        backplateStyle = var2.Color.Surface.Surface_0,
                        backgroundStyle = shift300,
                        Position = UDim2.fromScale(1, 0),
                        size = AvatarSize.Small,
                        testId = "conversation-face-pile-group-secondary",
                        userId = var7,
                        ZIndex = 1
                    })
                }
            ),
            Presence = presence
        })
    end

    local var13 = React.joinBindings({ userId = userId, hasSecondary = hasSecondary })
    local image = var13:map(function(tbl2)
        return getHeadshotImage(tbl2.userId, not tbl2.hasSecondary, FFlagAppChatUseProfileFrameThumbnail)
    end)
    local var8 = var13:map(function(tbl2)
        return getHeadshotImage(tbl2.userId, tbl2.hasSecondary)
    end)
    local var9 = React.joinBindings({ userId = var7, hasSecondary = hasSecondary }):map(function(tbl2)
        return getHeadshotImage(tbl2.userId, tbl2.hasSecondary)
    end)

    return React.createElement(View, {
        tag = "position-center-center anchor-center-center size-full"
    }, {
        Primary = React.createElement(
            View,
            { tag = "size-full", testId = "conversation-face-pile-primary", Visible = var11 },
            {
                Image = React.createElement(Image, {
                    backgroundStyle = shift300,
                    Image = image,
                    tag = "position-center-center anchor-center-center size-full aspect-1-1 radius-circle",
                    testId = "conversation-face-pile-primary--image"
                })
            }
        ),
        Group = React.createElement(
            View,
            { tag = "size-full", testId = "conversation-face-pile-group", Visible = hasSecondary },
            {
                Primary = React.createElement(Image, {
                    backgroundStyle = backgroundStyle,
                    Image = var8,
                    Size = UDim2.fromScale(0.7, 0.7),
                    tag = "position-bottom-left anchor-bottom-left aspect-1-1 radius-circle",
                    testId = "conversation-face-pile-group-primary--image",
                    ZIndex = 2
                }),
                Secondary = React.createElement(Image, {
                    backgroundStyle = backgroundStyle,
                    Image = var9,
                    Size = UDim2.fromScale(0.7, 0.7),
                    tag = "position-top-right anchor-top-right aspect-1-1 radius-circle",
                    testId = "conversation-face-pile-group-secondary--image",
                    ZIndex = 1
                })
            }
        ),
        Presence = presence
    })
end

return ConversationFacePileBinding
