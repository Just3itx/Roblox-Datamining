-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:21:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local t = require(DataHydrationParent.t)

local _store = require(script.Parent.Types.store)
local FFlagBuildAgentAdCampaignCard = require(script.Parent.FFlagBuildAgentAdCampaignCard)

local var1 = t.interface({ campaignId = t.string, status = t.string, toolCallId = t.optional(t.string) })

local function decodeAdCampaignCreateResult(arg1)
    local var2, var3 = var1(arg1)
    if not var2 then
        return nil, "Invalid ad campaign create response: " .. tostring(var3)
    elseif arg1.campaignId == "" then
        return nil, "Invalid ad campaign create response: campaignId must be non-empty"
    elseif FFlagBuildAgentAdCampaignCard and (arg1.status == "" or arg1.toolCallId == "") then
        return nil, "Invalid ad campaign create response: status and toolCallId must be non-empty"
    end

    return arg1, nil
end

return decodeAdCampaignCreateResult
