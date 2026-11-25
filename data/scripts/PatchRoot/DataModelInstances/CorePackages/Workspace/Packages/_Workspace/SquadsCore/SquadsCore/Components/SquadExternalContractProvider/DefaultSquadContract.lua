-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local Promise = require(SquadsCoreParent.Promise)
local _SquadExperienceInviteSource = require(SquadsCore.Enums.SquadExperienceInviteSource)

local SquadRootViewType = require(SquadsCore.Enums.SquadRootViewType)

local _SquadContractType = require(script.Parent.SquadContractType)

return {
    closeSquadPrompt = function() end,
    createConversation = function(_, _, _, _: string?)
        return function(_)
            return Promise.reject("No createConversation function supplied.")
        end
    end,
    createFriendConversation = function(_: string, _) end,
    createExperienceInvite = require(SquadsCoreParent.SharedFlags).FFlagEnableSquadRegroupExperimentation and function(_: string, _, _)
        return function(_)
            return Promise.reject("No createExperienceInvite function supplied.")
        end
    end or nil,
    fetchParentChannelDetails = function(_, _)
        return nil
    end,
    inviteToParentChannel = function(_, _, _)
        return function(_)
            return nil
        end
    end,
    navigateIntoSquadLobby = function(_, _) end,
    removeUserFromParentChannel = function(_, _, _)
        return function(_)
            return nil
        end
    end,
    setSquadPrompt = function(_, _) end,
    showSearchOverlay = function(_, _) end,
    useIsChatEnabled = function(): boolean
        return false
    end,
    useGetConversationFromId = function(_)
        return nil
    end,
    useParentChannelHasGroupUp = function(_): boolean
        return false
    end,
    useParentChannelHasSquadAccess = function(_): boolean
        return false
    end,
    useParentChannelTitleSelector = function(_): string
        return ""
    end,
    useParentChannelIsPartyVoiceEligible = function(_)
        return nil
    end,
    useSquadRootView = function()
        return SquadRootViewType.None
    end,
    useSquadTopBannerManager = function()
        return {
            disableSquadTopBanner = function(_, _) end,
            useSquadTopBannerDisabled = function(): boolean
                return false
            end
        }
    end,
    useIsChatUserMessagesEnabled = function(): boolean
        return false
    end
}
