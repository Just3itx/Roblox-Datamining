-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:50:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local SquadLocationEnum = require(SquadsCore.Enums.SquadLocationEnum)
local SquadRootViewType = require(SquadsCore.Enums.SquadRootViewType)

local _LuauPolyfill = require(SquadsCoreParent.LuauPolyfill)
local Promise = require(SquadsCoreParent.Promise)
local React = require(SquadsCoreParent.React)
local SharedFlags = require(SquadsCoreParent.SharedFlags)
local _SquadExperienceInviteSource = require(SquadsCore.Enums.SquadExperienceInviteSource)
local FFlagEnableSquadRegroupExperimentation = SharedFlags.FFlagEnableSquadRegroupExperimentation

return (React.createContext({
    closeSquadPrompt = function() end,
    createConversation = function(_, _, _, _: string?)
        return function(_)
            return Promise.reject("No createConversation function supplied.")
        end
    end,
    createFriendConversation = function(_: string, _) end,
    createExperienceInvite = FFlagEnableSquadRegroupExperimentation and function(_: string, _)
        return function(_)
            return Promise.reject("No createExperienceInvite function supplied.")
        end
    end or nil,
    disableSquadTopBanner = function(_: string, _: boolean) end,
    fetchParentChannelDetails = function(_, _)
        return nil
    end,
    fireSquadAnalytics = function<T, U>(arg1: T, arg2: U): (T, U)
        return arg1, arg2
    end,
    inviteToParentChannel = function(_, _, _)
        return nil
    end,
    navigateIntoSquadLobby = function(_, _) end,
    removeUserFromParentChannel = function(_, _, _)
        return nil
    end,
    setSquadPrompt = function(_, _) end,
    showSearchOverlay = function(_, _) end,
    squadLocation = SquadLocationEnum.Unknown,
    updateSquadViewFlags = function(_, _) end,
    useGetConversationFromId = function(_: string)
        return nil
    end,
    useIsChatEnabled = function(): boolean
        return false
    end,
    useIsLoadingChatSettings = function(): boolean
        return false
    end,
    useParentChannelHasGroupUp = function(_: string): boolean
        return false
    end,
    useParentChannelHasSquadAccess = function(_: string): boolean
        return false
    end,
    useParentChannelIsPartyVoiceEligible = function(_: string)
        return nil
    end,
    useParentChannelTitleSelector = function(_: string): string
        return ""
    end,
    useSquadRootView = function()
        return SquadRootViewType.None
    end,
    useSquadTopBannerDisabled = function(): boolean
        return false
    end,
    useSquadViewFlags = function(): number
        return 0
    end,
    shouldShowOSAForConversation = function(): boolean
        return false
    end,
    showGroupOSADialog = nil
}))
