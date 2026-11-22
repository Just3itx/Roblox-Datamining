-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProgressLoading = script:FindFirstAncestor("ProgressLoading")

local createNetworking = require(ProgressLoading.createNetworking)
local buildPlayerLocalizationChoiceUrl = require(script.Parent.buildPlayerLocalizationChoiceUrl)

local function fetchPlayerLocalizationChoice(str1: string)
    local playerLocalizationChoiceUrl = buildPlayerLocalizationChoiceUrl(str1)
    return createNetworking(playerLocalizationChoiceUrl, "GET")
end

return fetchPlayerLocalizationChoice
