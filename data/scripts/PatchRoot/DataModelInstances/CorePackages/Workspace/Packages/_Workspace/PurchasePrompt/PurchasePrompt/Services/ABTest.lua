-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePromptParent = script:FindFirstAncestor("PurchasePrompt").Parent

local IXPServiceWrapper = require(PurchasePromptParent.IxpServiceWrapper).IXPServiceWrapper

local module = {}

function module.new()
    local module2 = {}

    setmetatable(module2, {
        __tostring = function(): string
            return "Service(ABTest)"
        end
    })

    function module2.getLayerData(arg1)
        return IXPServiceWrapper:GetLayerData(arg1)
    end

    function module2.logUserLayerExposure(arg1)
        IXPServiceWrapper:LogUserLayerExposure(arg1)
    end

    return module2
end

return module
