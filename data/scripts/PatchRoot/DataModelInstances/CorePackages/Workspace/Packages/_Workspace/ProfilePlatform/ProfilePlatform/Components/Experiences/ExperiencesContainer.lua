-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local useProfileJsonComponent = require(ProfilePlatform.Hooks.useProfileJsonComponent)
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)
local Cryo = require(ProfilePlatformParent.Cryo)
local Enums = require(ProfilePlatform.Common.Enums)
local RoactUtils = require(ProfilePlatformParent.RoactUtils)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector

local getDeepValue = require(ProfilePlatformParent.LuaSocialLibrariesDeps).SocialLibraries.config({}).Dictionary.getDeepValue
local NetworkingGames = require(ProfilePlatform.Networking.NetworkingGames)

local Experiences = require(ProfilePlatform.Components.Experiences.Experiences)
local ExperiencesSkeleton = require(ProfilePlatform.Components.Experiences.ExperiencesSkeleton)
local FetchGameVotes = require(ProfilePlatformParent.GameVotesRodux).GameVotes.FetchGameVotes
local myRoduxNetworkingImpl = require(ProfilePlatform.Networking.myRoduxNetworkingImpl)

local FFlagEnableCommunityProfileLoadingSkeletons = require(ProfilePlatform.Flags.FFlagEnableCommunityProfileLoadingSkeletons)

local tbl1 = {}

local function ExperiencesContainer(tbl2)
    local var1 = useProfileJsonComponent(Enums.Components.Experiences)
    local var2, var3 = React.useState(not not FFlagEnableCommunityProfileLoadingSkeletons)

    local var4 = var1.experiences or tbl1

    local var5 = React.useMemo(function()
        return Cryo.List.map(var4, function(arg1, _): string
            return tostring(arg1.universeId)
        end)
    end, { var4 })

    local var6 = useDispatch()

    React.useEffect(function()
        if Cryo.isEmpty(var5) then
            if FFlagEnableCommunityProfileLoadingSkeletons then
                var3(false)
            end

            return
        end

        var6(NetworkingGames.GetExperiencesDetails.API(var5)):catch(function(_) end):finally(function()
            if FFlagEnableCommunityProfileLoadingSkeletons then
                var3(false)
            end
        end)
        for _, value in var5 do
            var6(FetchGameVotes.Fetch(myRoduxNetworkingImpl, value)):catch(function(_) end)
        end
    end, { var5 })
    local var7 = useSelector(function(arg1)
        return getDeepValue(arg1, "ProfilePlatform.Games.byGameId") or tbl1
    end)

    local experienceDetails = React.useMemo(function()
        local result = {}
        for _, value in var5 do
            if var7[value] then
                table.insert(result, var7[value])
            end
        end
        return result
    end, { var5, var7 })

    if FFlagEnableCommunityProfileLoadingSkeletons and var2 then
        return React.createElement(ExperiencesSkeleton, { layoutOrder = tbl2.layoutOrder, numSkeletons = #var4 })
    elseif #experienceDetails == 0 then
        return nil
    end

    return React.createElement(Experiences, { layoutOrder = tbl2.layoutOrder, experienceDetails = experienceDetails })
end

return ExperiencesContainer
