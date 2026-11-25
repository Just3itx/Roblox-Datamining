-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local isTenFootInterface = require(scriptParentParent.Parent.AppCommonLib).isTenFootInterface
local GetFFlagDisableRobuxUpsell = require(scriptParentParent.Flags.GetFFlagDisableRobuxUpsell)

local module = {}

function module.new()
    local module2 = {}

    setmetatable(module2, {
        __tostring = function(): string
            return "Service(ExternalSettings)"
        end
    })

    function module2.getPlatform(): Enum.Platform
        return UserInputService:GetPlatform()
    end

    function module2.isStudio(): boolean
        return RunService:IsStudio()
    end

    function module2.isThirdPartyPurchaseAllowed(): boolean
        local isThirdPartyPurchaseAllowed2 = true
        pcall(function()
            isThirdPartyPurchaseAllowed2 = game:GetService("PermissionsService"):GetIsThirdPartyPurchaseAllowed()
        end)
        return isThirdPartyPurchaseAllowed2
    end

    function module2.getLuaUseThirdPartyPermissions(): boolean
        return true
    end

    function module2.getFlagBypassThirdPartySettingForRobloxPurchase(): boolean
        return true
    end

    function module2.getFlagRestrictSales2()
        return settings():GetFFlag("RestrictSales2")
    end

    function module2.getFlagOrder66()
        return settings():GetFFlag("Order66")
    end

    function module2.isTenFootInterface()
        return isTenFootInterface()
    end

    function module2.getFFlagDisableRobuxUpsell()
        return GetFFlagDisableRobuxUpsell()
    end

    return module2
end

return module
