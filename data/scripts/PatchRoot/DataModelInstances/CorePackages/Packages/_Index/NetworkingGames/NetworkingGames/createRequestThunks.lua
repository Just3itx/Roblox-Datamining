-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local networkRequests = script.Parent.networkRequests

local createGetExperiencesPlayabilityStatus = require(networkRequests.createGetExperiencesPlayabilityStatus)
local createGetExperiencesProductInfo = require(networkRequests.createGetExperiencesProductInfo)
local createGetExperiencesDetails = require(networkRequests.createGetExperiencesDetails)
local createGetExperienceMedia = require(networkRequests.createGetExperienceMedia)

return function(arg1)
    return {
        GetExperiencesPlayabilityStatus = createGetExperiencesPlayabilityStatus(arg1),
        GetExperiencesProductInfo = createGetExperiencesProductInfo(arg1),
        GetExperiencesDetails = createGetExperiencesDetails(arg1),
        GetExperienceMedia = createGetExperienceMedia(arg1)
    }
end
