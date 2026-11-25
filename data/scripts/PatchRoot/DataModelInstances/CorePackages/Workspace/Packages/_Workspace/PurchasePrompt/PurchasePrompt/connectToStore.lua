-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:00:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePromptParent = script:FindFirstAncestor("PurchasePrompt").Parent
local RoactRodux = require(PurchasePromptParent.PurchasePromptDeps).RoactRodux

local function connectToStore(arg1, arg2)
    return function(getUnconnected)
        local var1 = RoactRodux.UNSTABLE_connect2(arg1, arg2)(getUnconnected)

        function var1.getUnconnected()
            return getUnconnected
        end

        return var1
    end
end

return connectToStore
