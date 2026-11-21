-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local createFaeFeatureAccessStore = require(script.createFaeFeatureAccessStore)
local useFaeFeatureAccess = require(script.useFaeFeatureAccess)

local getFaeFeatureAccessStore = createFaeFeatureAccessStore()

return {
    getFaeFeatureAccessStore = function()
        return getFaeFeatureAccessStore
    end,
    useFaeFeatureAccess = function()
        return useFaeFeatureAccess(getFaeFeatureAccessStore)
    end
}
