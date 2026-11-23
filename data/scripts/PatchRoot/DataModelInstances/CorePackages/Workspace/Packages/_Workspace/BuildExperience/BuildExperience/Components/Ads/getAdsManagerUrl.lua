-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:10:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local UrlBuilder = require(BuildExperienceParent.UrlBuilder).UrlBuilder

local string2 = UrlBuilder.fromString("create:advertise")
local string3 = UrlBuilder.fromString("create:advertise/manage")

local function getDefaultAdsManagerUrl()
    return string2()
end

return {
    getDefaultAdsManagerUrl = getDefaultAdsManagerUrl,
    getAdsManagerUrl = function(universeId: number?)
        if universeId == nil or universeId <= 0 then
            return getDefaultAdsManagerUrl()
        end

        return UrlBuilder.addQueryString(string3(), { universeId = universeId })
    end
}
