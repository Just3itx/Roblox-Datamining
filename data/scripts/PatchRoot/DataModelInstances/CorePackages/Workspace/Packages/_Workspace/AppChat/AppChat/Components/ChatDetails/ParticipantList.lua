-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:01:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local SocialLibraries = require(AppChat.SocialLibraries)
local Cryo = require(AppChatParent.Cryo)
local DataHydration = require(AppChatParent.DataHydration)
local React = require(AppChatParent.React)
local Signals = require(AppChatParent.Signals)
local SignalsReact = require(AppChatParent.SignalsReact)
local UserModel = require(AppChatParent.UserLib).Models.UserModel
local memo = React.memo
local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization

local Logger = require(script.Parent.Logger)
local presenceSortComparator = SocialLibraries.Utils.presenceSortComparator

local SortedList = SocialLibraries.Components.SortedList
local ParticipantEntryRightFrame = require(script.Parent.ParticipantEntryRightFrame)
local ParticipantEntry = require(script.Parent.ParticipantEntry)
local FFlagAppChatPresenceStoreMigration = require(AppChat.Flags.FFlagAppChatPresenceStoreMigration)
local FFlagDebugAppChatEnableDomLocators = require(AppChat.Flags.FFlagDebugAppChatEnableDomLocators)
local DomLocators = require(AppChat.Utils.DomLocators)
local PresenceType = if FFlagAppChatPresenceStoreMigration then DataHydration.Presence.PresenceEnums.PresenceType else nil
local var1 = if FFlagAppChatPresenceStoreMigration then DataHydration.Presence.PresenceStore.get() else nil
local tbl1

if FFlagAppChatPresenceStoreMigration then
    tbl1 = {}
    tbl1[PresenceType.Offline] = UserModel.PresenceType.OFFLINE
    tbl1[PresenceType.Online] = UserModel.PresenceType.ONLINE
    tbl1[PresenceType.InGame] = UserModel.PresenceType.IN_GAME
    tbl1[PresenceType.InStudio] = UserModel.PresenceType.IN_STUDIO
else
    tbl1 = nil
end

local tbl2 = {
    entries = {},
    entryHeight = 64,
    onEntryActivated = function(_, _)
        Logger:warning("onEntryActivated was not passed to ParticipantList")
    end,
    pendingKey = "Feature.Chat.Label.Pending",
    invitedKey = "Feature.SettingsHub.Label.Invited",
    sortComparator = presenceSortComparator,
    LayoutOrder = 0
}

function ParticipantList(tbl3)
    local var2 = Cryo.Dictionary.join(tbl2, tbl3)
    local onEntryActivated = var2.onEntryActivated or tbl2.onEntryActivated
    local var3 = React.useRef({})

    local var4 = useLocalization({ pendingLabelText = var2.pendingKey, invitedLabelText = var2.invitedKey })
    local var5

    if FFlagAppChatPresenceStoreMigration then
        local var6 = React.useMemo(function()
            return Signals.createComputed(function(arg1)
                local result = ({})
                for _, value in pairs(var2.entries) do
                    local str1 = tostring(value.id)
                    local var6 = var1.GetPresenceByUserId(str1).data(arg1)
                    if var6 then
                        result[str1] = tbl1[var6.userPresenceType]
                    end
                end
                return result
            end)
        end, { var2.entries })

        var5 = SignalsReact.useSignalState(var6)
    else
        var5 = nil
    end

    local function func1(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
        if var3.current[str1] == nil then
            var3.current[str1] = React.createRef()
        end

        return var3.current[str1]
    end

    local function renderEntry(arg1, _)
        local isInvited = arg1.metadata and arg1.metadata.isInvited
        local str1 = tostring(arg1.id)
        local tbl4 = {
            userId = arg1.id,
            statusText = if isInvited then var4.invitedLabelText else nil
        }
        local var6 = func1(str1)
        local bool1 = var2.activeParticipantId == str1
        function tbl4.onActivated()
            if not bool1 then
                onEntryActivated(arg1, var6)
            end
        end

        return React.createElement(ParticipantEntry, tbl4, arg1.children)
    end

    local entries = {}

    for _, value in pairs(var2.entries) do
        local tbl5 = ({})
        if FFlagAppChatPresenceStoreMigration then
            local var6 = if var5 then var5[tostring(value.id)] or nil else nil
            tbl5.presence = var6
        end
        local shouldShowDots = not value.isLocalUser
        local isPending = value.metadata and value.metadata.isPending
        if shouldShowDots or isPending then
            local tbl6 = {
                labelText = if isPending then var4.pendingLabelText else nil,
                shouldShowDots = shouldShowDots,
                testId = if FFlagDebugAppChatEnableDomLocators and shouldShowDots then DomLocators.chatDetailsParticipantMoreButton(value.displayName) else nil
            }

            if shouldShowDots then
                local id = value.id
                local dotsRef = func1(tostring(id))
                tbl6.dotsRef = dotsRef
                function tbl6.onDotsActivated()
                    onEntryActivated(value, dotsRef)
                end
            else
                tbl6.dotsRef = nil
                tbl6.onDotsActivated = nil
            end

            tbl5.children = {
                rightFrame = React.createElement(ParticipantEntryRightFrame, tbl6)
            }
        end

        table.insert(entries, Cryo.Dictionary.join(tbl5, value))
    end

    return React.createElement(SortedList, {
        entries = entries,
        entryHeight = var2.entryHeight,
        renderEntry = renderEntry,
        sortComparator = var2.sortComparator,
        LayoutOrder = var2.LayoutOrder
    })
end
return memo(ParticipantList)
