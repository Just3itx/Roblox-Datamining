-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:31:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local Http = require(AvatarExperienceCommonParent.Http)
local HttpClient = require(AvatarExperienceCommonParent.HttpClient)

local function getCurrentlyWearingSavedOutfitId(network)
    local url = `{Http.Url.AVATAR_URL}v1/avatar/currently-wearing-saved-outfit`

    return HttpClient.asPromise(
        HttpClient.fetch({
            method = "GET",
            url = url,
            analyticsKey = "avatar-experience.get-currently-wearing-saved-outfit",
            legacy = true,
            network = network,
            decode = function(tbl1)
                local savedOutfitId = tbl1.savedOutfitId
                if savedOutfitId ~= nil then
                    return tostring(savedOutfitId)
                end

                return nil
            end
        })
    )
end
return getCurrentlyWearingSavedOutfitId
