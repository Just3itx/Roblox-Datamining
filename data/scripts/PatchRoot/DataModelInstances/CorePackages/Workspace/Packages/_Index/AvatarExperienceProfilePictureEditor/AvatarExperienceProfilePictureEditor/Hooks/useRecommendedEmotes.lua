-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent
local React = require(AvatarExperienceProfilePictureEditorParent.React)
local fetchInternal = require(AvatarExperienceProfilePictureEditor.Api.fetchInternal)
local getEmoteRecommendations = require(AvatarExperienceProfilePictureEditor.Shared.getEmoteRecommendations)
local Enums = require(AvatarExperienceProfilePictureEditor.Common.Enums)

local function useRecommendedEmotes()
    local recommendedEmotes, var2 = React.useState({})
    local isLoading, var4 = React.useState(true)
    local hasError, var6 = React.useState(false)

    React.useEffect(function()
        local bool1 = false
        local emoteRecommendationsUrl = getEmoteRecommendations.getEmoteRecommendationsUrl()

        fetchInternal(emoteRecommendationsUrl, Enums.RequestMethods.GET):andThen(function(arg1)
            if bool1 then
                return
            end
            var2(getEmoteRecommendations.parseEmoteRecommendationsResponse(arg1.responseBody))
            var4(false)
        end):catch(function()
            if bool1 then
                return
            end
            var6(true)
            var4(false)
        end)

        return function()
            bool1 = true
        end
    end, {})

    return { recommendedEmotes = recommendedEmotes, isLoading = isLoading, hasError = hasError }
end

return useRecommendedEmotes
