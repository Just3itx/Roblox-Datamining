-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent
local createSignal = require(InExperienceShopParent.Signals).createSignal

return function()
    local getEnabled, setEnabled = createSignal(false)

    local var3, setStatusIndicatorEnabled = createSignal(false)
    local var5, setFreeTrialStatusIndicatorEnabled = createSignal(false)
    local getIconInstance, setIconInstance = createSignal(nil)

    return {
        getEnabled = getEnabled,
        setEnabled = setEnabled,
        getStatusIndicatorEnabled = function(arg1)
            return var3(arg1) or var5(arg1)
        end,
        setStatusIndicatorEnabled = setStatusIndicatorEnabled,
        setFreeTrialStatusIndicatorEnabled = setFreeTrialStatusIndicatorEnabled,
        getIconInstance = getIconInstance,
        setIconInstance = setIconInstance
    }
end
