-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AccountUpgrade = script:FindFirstAncestor("AccountUpgrade")

local _AccountUpgradeField = require(AccountUpgrade.AccountUpgradeField)
local _FlowSpec = require(AccountUpgrade.FlowSpec)

local function resolveFieldStates(tbl1)
    local result = ({})

    for _, optionalField in ipairs(tbl1.spec.optionalFields) do
        result[optionalField] = { isUnlocked = true, blockingField = nil }
    end

    local var1 = nil

    for _, requiredField in ipairs(tbl1.spec.requiredFields) do
        result[requiredField] = {
            isUnlocked = var1 == nil,
            blockingField = var1
        }

        if not tbl1.isSatisfied[requiredField] and var1 == nil then
            var1 = requiredField
        end
    end

    return result
end

return resolveFieldStates
