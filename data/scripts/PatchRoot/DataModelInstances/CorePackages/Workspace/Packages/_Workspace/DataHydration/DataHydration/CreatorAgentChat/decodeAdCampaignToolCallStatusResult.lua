-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:21:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local t = require(DataHydrationParent.t)

local _store = require(script.Parent.Types.store)

local var1 = t.interface({
    status = t.union(t.literal("none"), t.literal("processing"), t.literal("created"), t.literal("failed")),
    campaignId = t.optional(t.string)
})

local function decodeAdCampaignToolCallStatusResult(arg1)
    local var2, var3 = var1(arg1)
    if not var2 then
        return nil, "Invalid ad campaign tool-call status response: " .. tostring(var3)
    elseif arg1.status == "" or arg1.campaignId == "" then
        return nil, "Invalid ad campaign tool-call status response: status and campaignId must be non-empty"
    end
    return arg1, nil
end

return decodeAdCampaignToolCallStatusResult
