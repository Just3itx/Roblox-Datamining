-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AccountUpgrade = script:FindFirstAncestor("AccountUpgrade")

local AccountUpgradeFlow = require(AccountUpgrade.AccountUpgradeFlow)
local getPioneerAccountUpgradeAvailability = require(script.Parent.getPioneerAccountUpgradeAvailability)

local tbl1 = {
    [AccountUpgradeFlow.Pioneer] = getPioneerAccountUpgradeAvailability,
    [AccountUpgradeFlow.PioneerU13] = getPioneerAccountUpgradeAvailability
}

local function getAvailability(arg1)
    local var1 = tbl1[arg1]
    assert(var1 ~= nil, `Unsupported account upgrade flow: {arg1}`)
    return var1()
end

return getAvailability
