-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)

local RoactUtils = require(ProfilePlatformParent.RoactUtils)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useEffectOnMount = RoactUtils.Hooks.useEffectOnMount

local getDeepValue = require(ProfilePlatformParent.LuaSocialLibrariesDeps).SocialLibraries.config({}).Dictionary.getDeepValue

local useProfileJsonComponent = require(ProfilePlatform.Hooks.useProfileJsonComponent)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local Enums = require(ProfilePlatform.Common.Enums)

local HorizontalPageMargin = require(ProfilePlatformParent.UIBlox).App.Container.HorizontalPageMargin

local NetworkingGames = require(ProfilePlatform.Networking.NetworkingGames)

local ContextualGeneric = require(script.Parent.ContextualGeneric)
local ContextualPresence = require(script.Parent.ContextualPresence)
local ContextualMutualFriends = require(script.Parent.ContextualMutualFriends)
local ContextualPlayedTogether = require(script.Parent.ContextualPlayedTogether)

local function ContextualInformationContainer(tbl1)
    local sourceInfo = useProfileWrapperContext().sourceInfo

    local contextualInformation = (useProfileJsonComponent(Enums.Components.UserProfileHeader) or {}).contextualInformation
    local context = contextualInformation.context
    local contextDetails = contextualInformation.contextDetails
    local var1 = if context == Enums.ContextualTypes.SentFromExperience then contextDetails[context].sourceUniverseId elseif context == Enums.ContextualTypes.PlayedTogether then contextDetails[context].mostFrequentUniverseId else nil
    local var2 = useDispatch()
    useEffectOnMount(function()
        if context == Enums.ContextualTypes.SentFromExperience or context == Enums.ContextualTypes.PlayedTogether then
            var2(NetworkingGames.GetExperiencesDetails.API({ var1 })):catch(function(_) end)
        end
    end)

    local experienceName = useSelector(function(arg1)
        return getDeepValue(arg1, `ProfilePlatform.Games.byGameId.{tostring(var1)}.name`) or ""
    end)

    local iconOverride = getDeepValue(sourceInfo, "contextualOverride.icon")
    local textOverride = getDeepValue(sourceInfo, "contextualOverride.text")
    local element

    if context == Enums.ContextualTypes.Presence then
        element = React.createElement(ContextualPresence)
    elseif context == Enums.ContextualTypes.MutualFriends then
        local contextDetail = contextDetails[context]

        element = React.createElement(
            ContextualMutualFriends,
            {
                mutualFriends = contextDetail.mutualFriends,
                mutualFriendsCount = contextDetail.mutualFriendsCount
            }
        )
    elseif context == Enums.ContextualTypes.PlayedTogether then
        element = React.createElement(ContextualPlayedTogether, { experienceName = experienceName })
    else
        element = React.createElement(
            ContextualGeneric,
            {
                contextualType = context,
                experienceName = experienceName,
                iconOverride = iconOverride,
                textOverride = textOverride
            }
        )
    end
    return React.createElement(
        HorizontalPageMargin,
        {
            size = tbl1.size,
            layoutOrder = tbl1.layoutOrder,
            useAutomaticSizing = true,
            backgroundTransparency = 1
        },
        { contextualInformation = element }
    )
end

return ContextualInformationContainer
