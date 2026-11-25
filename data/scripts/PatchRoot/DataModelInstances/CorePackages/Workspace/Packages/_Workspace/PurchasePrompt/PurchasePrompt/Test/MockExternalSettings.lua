-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _scriptParentParent = script.Parent.Parent

local PurchasePromptParent = script:FindFirstAncestor("PurchasePrompt").Parent
local Cryo = require(PurchasePromptParent.PurchasePromptDeps).Cryo

local tbl1 = { RestrictSales2 = false, Order66 = false }

local module = {}

function module.new(arg1, isTenFootInterface, arg3, arg4)
    local module2 = {}

    local var1 = Cryo.Dictionary.join(tbl1, arg3 or {})

    local function getMockFlag(luaUseThirdPartyPermissions, bool1: boolean) -- Luacid: Inlined by compiler; 1 call site recovered
        return if luaUseThirdPartyPermissions == nil then bool1 else luaUseThirdPartyPermissions
    end

    function module2.getPlatform()
        return arg4 or Enum.Platform.Windows
    end

    function module2.isStudio()
        return arg1 or false
    end

    function module2.isThirdPartyPurchaseAllowed()
        return var1.PermissionsServiceIsThirdPartyPurchaseAllowed
    end

    function module2.getLuaUseThirdPartyPermissions()
        return getMockFlag(var1.LuaUseThirdPartyPermissions, true)
    end

    function module2.getFlagBypassThirdPartySettingForRobloxPurchase()
        return var1.BypassThirdPartySettingForRobloxPurchase
    end

    function module2.getFlagRestrictSales2()
        return var1.RestrictSales2
    end

    function module2.getFlagOrder66()
        return var1.Order66
    end

    function module2.isTenFootInterface()
        return isTenFootInterface
    end

    function module2.getFFlagDisableRobuxUpsell()
        return var1.DisableRobuxUpsell
    end

    return module2
end

return module
