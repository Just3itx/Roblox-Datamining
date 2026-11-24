-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local t = require(DataHydrationParent.t)

local _store = require(script.Parent.Types.store)

local var1 = t.interface(
    {
        canFund = t.boolean,
        fundingSource = t.union(t.literal("ad_credit"), t.literal("robux"), t.literal("none"))
    }
)
local function decodeAdCampaignCheckFundsResult(arg1)
    local var2, var3 = var1(arg1)
    if not var2 then
        return nil, "Invalid ad campaign check funds response: " .. tostring(var3)
    end

    return arg1, nil
end

return decodeAdCampaignCheckFundsResult
