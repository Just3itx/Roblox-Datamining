-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:50:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local SquadExternalContractContext = require(script.Parent.SquadExternalContractContext)
local _SquadContractType = require(script.Parent.SquadContractType)
local SquadViewFlags = require(script.Parent.SquadViewFlags)

local Analytics = require(SquadsCore.Analytics)
local _SquadLocationEnum = require(SquadsCore.Enums.SquadLocationEnum)
local _SquadExperienceInviteSource = require(SquadsCore.Enums.SquadExperienceInviteSource)
local useCurrentSquadId = require(SquadsCore.Hooks).useCurrentSquadId

local Cryo = require(SquadsCoreParent.Cryo)
local React = require(SquadsCoreParent.React)
local SharedFlags = require(SquadsCoreParent.SharedFlags)

local FFlagEnableSquadTopBannerWideMode = SharedFlags.FFlagEnableSquadTopBannerWideMode
local FFlagEnableSquadRegroupExperimentation = SharedFlags.FFlagEnableSquadRegroupExperimentation

return function(tbl1)
    local var1, var2 = React.useState(SquadViewFlags.None)

    local var3 = if FFlagEnableSquadTopBannerWideMode then tbl1.contract.useSquadTopBannerManager() else React.useMemo(function()
        return {
            disableSquadTopBanner = function(_, _) end,
            useSquadTopBannerDisabled = function(): boolean
                return false
            end
        }
    end, {})

    local var4 = React.useMemo(Analytics.Analytics, {})
    local squadId = useCurrentSquadId()
    local fireSquadAnalytics = React.useCallback(function(arg1, arg2)
        arg2 = Cryo.Dictionary.join(arg2, { squadId = squadId, squadLocation = tbl1.squadLocation })

        var4.fireAnalyticsEvent(arg1, arg2)
    end, { squadId, tbl1.squadLocation })

    local value = {
        closeSquadPrompt = tbl1.contract.closeSquadPrompt,
        createFriendConversation = tbl1.contract.createFriendConversation,
        createConversation = tbl1.contract.createConversation,
        disableSquadTopBanner = var3.disableSquadTopBanner,
        fetchParentChannelDetails = tbl1.contract.fetchParentChannelDetails,
        fireSquadAnalytics = fireSquadAnalytics,
        inviteToParentChannel = tbl1.contract.inviteToParentChannel,
        navigateIntoSquadLobby = tbl1.contract.navigateIntoSquadLobby,
        removeUserFromParentChannel = tbl1.contract.removeUserFromParentChannel,
        setSquadPrompt = tbl1.contract.setSquadPrompt,
        showSearchOverlay = tbl1.contract.showSearchOverlay,
        squadLocation = tbl1.squadLocation,
        updateSquadViewFlags = React.useCallback(function(num1: number, bool1: boolean)
            if bool1 then
                var2(function(arg1): number
                    return bit32.bor(arg1, num1)
                end)

                return
            end

            var2(function(arg1): number
                return bit32.band(arg1, bit32.bnot(num1))
            end)
        end, {}),
        useGetConversationFromId = tbl1.contract.useGetConversationFromId,
        useIsChatUserMessagesEnabled = tbl1.contract.useIsChatUserMessagesEnabled,
        useParentChannelHasGroupUp = tbl1.contract.useParentChannelHasGroupUp,
        useParentChannelHasSquadAccess = tbl1.contract.useParentChannelHasSquadAccess,
        useParentChannelIsPartyVoiceEligible = tbl1.contract.useParentChannelIsPartyVoiceEligible,
        useParentChannelTitleSelector = tbl1.contract.useParentChannelTitleSelector,
        useSquadRootView = tbl1.contract.useSquadRootView,
        useSquadTopBannerDisabled = var3.useSquadTopBannerDisabled,
        useIsChatEnabled = tbl1.contract.useIsChatEnabled,
        useIsLoadingChatSettings = tbl1.contract.useIsLoadingChatSettings,
        useSquadViewFlags = React.useCallback(function()
            return var1
        end, { var1 }),
        shouldShowOSAForConversation = tbl1.contract.shouldShowOSAForConversation,
        showGroupOSADialog = tbl1.contract.showGroupOSADialog
    }

    if FFlagEnableSquadRegroupExperimentation and tbl1.contract.createExperienceInvite then
        function value.createExperienceInvite(str1: string, arg1)
            return tbl1.contract.createExperienceInvite(str1, value, arg1)
        end
    end

    return React.createElement(SquadExternalContractContext.Provider, { value = value }, tbl1.children)
end
