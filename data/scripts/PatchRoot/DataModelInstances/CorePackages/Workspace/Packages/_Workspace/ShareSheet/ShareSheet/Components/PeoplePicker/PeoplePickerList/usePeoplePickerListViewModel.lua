-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheet = script:FindFirstAncestor("ShareSheet")
local ShareSheetParent = ShareSheet.Parent

local React = require(ShareSheetParent.React)
local Signals = require(ShareSheetParent.Signals)
local SignalsReact = require(ShareSheetParent.SignalsReact)

local Array = require(ShareSheetParent.LuauPolyfill).Array

local useLocalization = require(ShareSheetParent.Localization).Hooks.useLocalization
local UserProfile = require(ShareSheetParent.DataHydration.UserProfile)
local ShareSheetConstants = require(ShareSheet.ShareSheetConstants)
local formatPeoplePickerUserInfo = require(ShareSheet.Utils.formatPeoplePickerUserInfo)
local matchesQuery = require(ShareSheet.Utils.matchesQuery)
local Recipient = require(ShareSheet.Recipients.Recipient)

local Players = game:GetService("Players")

local function getUserInfoResult(str1: string?) -- Luacid: Inlined by compiler; 2 call sites recovered
    if str1 ~= nil and str1 ~= "" then
        return (UserProfile.getAndFetchUserInfo(str1))
    end

    return nil
end

local function readUserInfo(arg1, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
    if arg1 == nil then
        return nil, false
    end
    return arg1.info(arg2), arg1.status(arg2) == "NotReady"
end

local function getRowUserIds(arg1, str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    local participantIds = Recipient.getParticipantIds(arg1, str1)
    return participantIds[1] or str1, participantIds[2]
end

local function filterRecipientsByQuery(recipients, filterQuery: string, displayNamesByConversationId, descriptionsByConversationId)
    if filterQuery == "" then
        return recipients
    end
    local str1 = string.lower(filterQuery)
    return Array.filter(recipients, function(arg1)
        return matchesQuery(str1, displayNamesByConversationId[arg1.id] or "", descriptionsByConversationId[arg1.id] or "")
    end)
end

local function getDisplayNames(arg1, recipients, tbl1, displayName: string)
    local descriptionsByConversationId = ({})
    local displayNamesByConversationId = ({})
    local bool1 = false
    local loadingConversationIds = ({})
    for _, recipient in recipients do
        local id = recipient.id
        local name = Recipient.getName(recipient, arg1)
        local var1 = tbl1[id]
        if var1 then
            local var2, bool2 = readUserInfo(var1.primary, arg1)
            local var3, bool3 = readUserInfo(var1.second, arg1)
            local bool4 = bool2 or bool3
            if bool4 then
                bool1 = true
            end

            local tbl5 = { displayName = displayName }
            local tbl6 = {}
            if var2 then
                table.insert(tbl6, var2)
            else
                table.insert(tbl6, tbl5)
            end
            if var1.second ~= nil then
                if var3 then
                    table.insert(tbl6, var3)
                else
                    table.insert(tbl6, tbl5)
                end
            end
            if name == "" then
                if bool4 then
                    loadingConversationIds[id] = true
                else
                    name = formatPeoplePickerUserInfo.formatTitle(tbl6)
                end
            end
            if not bool4 then
                descriptionsByConversationId[id] = formatPeoplePickerUserInfo.formatDescription(tbl6)
            end
        end
        displayNamesByConversationId[id] = name
    end
    return {
        descriptionsByConversationId = descriptionsByConversationId,
        displayNamesByConversationId = displayNamesByConversationId,
        isLoading = bool1,
        loadingConversationIds = loadingConversationIds
    }
end

local function useConversationDisplayNames(recipients, str1: string, unknownUser: string)
    local var1 = React.useMemo(function()
        local result = ({})
        for _, recipient in recipients do
            local var1, var2 = getRowUserIds(recipient, str1)
            local id = recipient.id
            result[id] = {
                primary = getUserInfoResult(var1),
                second = getUserInfoResult(var2)
            }
        end
        return result
    end, { str1, recipients })

    local var2 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            return (getDisplayNames(arg1, recipients, var1, unknownUser))
        end)
    end, { recipients, unknownUser, var1 })

    return SignalsReact.useSignalState(var2)
end

local function usePeoplePickerListViewModel(tbl1)
    local str1 = tostring(Players.LocalPlayer and Players.LocalPlayer.UserId or 0)
    local var1 = useLocalization({ unknownUser = "Feature.Chat.Label.UnknownUser" })

    local var2 = useConversationDisplayNames(tbl1.recipients, str1, var1.unknownUser)
    local displayNamesByConversationId = var2.displayNamesByConversationId
    local var3 = React.useMemo(function()
        return filterRecipientsByQuery(
            tbl1.recipients,
            tbl1.filterQuery,
            displayNamesByConversationId,
            var2.descriptionsByConversationId
        )
    end, {
        displayNamesByConversationId,
        var2.descriptionsByConversationId,
        tbl1.filterQuery,
        tbl1.recipients
    })

    local items = React.useMemo(function()
        local var4 = table.create(#var3)
        for value, value2 in var3 do
            local id = value2.id
            local primaryUserId, secondUserId = getRowUserIds(value2, str1)
            local tbl2 = {
                description = var2.descriptionsByConversationId[id],
                displayName = displayNamesByConversationId[id],
                id = id,
                isLoading = var2.loadingConversationIds[id] == true,
                isSelected = tbl1.selectedConversationIds[id] == true,
                primaryUserId = primaryUserId,
                secondUserId = secondUserId
            }
            var4[value] = tbl2
        end

        return var4
    end, {
        var2.descriptionsByConversationId,
        var2.loadingConversationIds,
        displayNamesByConversationId,
        str1,
        tbl1.selectedConversationIds,
        var3
    })

    local var5 = tbl1.isLoading or var2.isLoading and #items == 0

    return {
        items = items,
        shouldShowEmptyState = #items == 0 and not var5,
        skeletonCount = if var5 then ShareSheetConstants.FIntShareSheetNumAvatarSkeletons else 0
    }
end

return usePeoplePickerListViewModel
