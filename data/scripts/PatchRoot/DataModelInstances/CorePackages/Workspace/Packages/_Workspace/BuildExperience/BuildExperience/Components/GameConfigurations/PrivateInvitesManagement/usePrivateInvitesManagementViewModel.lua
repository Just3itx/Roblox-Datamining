-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:50:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization

local getPrivatePlaytestersStore = require(BuildExperienceParent.DataHydration.PrivatePlaytesters).getPrivatePlaytestersStore
local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local sendBuildExperienceEvent = require(BuildExperience.Telemetry.sendBuildExperienceEvent)
local useBuildPageImpression = require(BuildExperience.Telemetry.useBuildPageImpression)
local FFlagBuildExperiencePageImpressions = require(BuildExperience.Flags.FFlagBuildExperiencePageImpressions)
local _PrivateInvitesManagementView = require(script.Parent.PrivateInvitesManagementView)

local function usePrivateInvitesManagementViewModel(tbl1)
    local privatePlaytestersStore = getPrivatePlaytestersStore(false)
    local var1 = React.useMemo(function()
        return privatePlaytestersStore.getAndFetchInvitedPlayers(tbl1.universeId)
    end, { privatePlaytestersStore, tbl1.universeId })
    local userIds = SignalsReact.useSignalState(var1.players)
    local userIdsLen = #userIds
    local maxInvites = privatePlaytestersStore.MAX_INVITES
    local var3 = useLocalization({
        count = {
            LocalizationStrings.PRIVATE_INVITES_COUNT,
            COUNT = userIdsLen,
            MAX_INVITES = maxInvites
        },
        inviteButton = LocalizationStrings.PRIVATE_INVITES_INVITE_BUTTON,
        subtitle = {
            LocalizationStrings.PRIVATE_INVITES_SUBTITLE,
            MAX_INVITES = maxInvites
        },
        title = LocalizationStrings.PRIVATE_INVITES_TITLE
    })
    local inviteButton = var3.inviteButton
    local count = var3.count
    local subtitle = var3.subtitle
    local title = var3.title
    local universeId = tbl1.universeId

    local var4 = React.useRef(false)
    React.useEffect(function()
        if var4.current then
            return
        end
        var4.current = true
        sendBuildExperienceEvent("PLAYTEST_MANAGEMENT_IMPRESSION", { universeId = universeId })
    end, { universeId })
    if FFlagBuildExperiencePageImpressions then
        useBuildPageImpression("invite-management", { universeId = universeId })
    end

    local removingUserIds, var6 = React.useState({})

    local onRemove = React.useCallback(function(num2: number)
        var6(function(arg1)
            local var7 = table.clone(arg1)
            var7[num2] = true
            return var7
        end)
        privatePlaytestersStore.removeInvite(universeId, num2):andThen(function()
            sendBuildExperienceEvent("PLAYTESTER_REMOVED", { universeId = universeId })
        end):finally(function()
            var6(function(arg1)
                local var7 = table.clone(arg1)
                var7[num2] = nil
                return var7
            end)
        end)
    end, { privatePlaytestersStore, universeId })

    local onOpenInvitePicker = React.useCallback(function()
        sendBuildExperienceEvent("ADD_TO_PLAYTEST_CLICK", { universeId = universeId }, { source = "management_page" })

        tbl1.onOpenInvitePicker()
    end, { universeId, tbl1.onOpenInvitePicker })

    return {
        title = title,
        countText = count,
        subtitle = subtitle,
        inviteButtonText = inviteButton,
        userIds = userIds,
        removingUserIds = removingUserIds,
        onRemove = onRemove,
        isInviteDisabled = maxInvites <= userIdsLen,
        onOpenInvitePicker = onOpenInvitePicker,
        layoutOrder = tbl1.layoutOrder,
        testId = tbl1.testId
    }
end

return usePrivateInvitesManagementViewModel
