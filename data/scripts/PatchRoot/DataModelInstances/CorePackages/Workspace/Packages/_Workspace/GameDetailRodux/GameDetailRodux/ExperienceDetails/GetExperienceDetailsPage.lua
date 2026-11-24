-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailRoduxParent = script:FindFirstAncestor("GameDetailRodux").Parent

local Url = require(GameDetailRoduxParent.Http).Url
local var1 = require(GameDetailRoduxParent.UrlBuilder).UrlBuilder.new({
    base = Url.APIS_URL,
    path = "experience-details-api/v1/get-experience-details",
    query = { universeId = "{universeId}" }
})

return function(arg1, universeId: string)
    assert(type(universeId) == "string", "GetExperienceDetailsPage request expects universeId to be a string")
    return arg1(var1({ universeId = universeId }), "GET")
end
