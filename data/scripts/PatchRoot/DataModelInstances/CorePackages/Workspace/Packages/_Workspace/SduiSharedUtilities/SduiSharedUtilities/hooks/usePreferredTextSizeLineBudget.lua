-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")
local SduiSharedUtilitiesParent = SduiSharedUtilities.Parent

local React = require(SduiSharedUtilitiesParent.React)
local SignalsReact = require(SduiSharedUtilitiesParent.SignalsReact)
local TextSize = require(SduiSharedUtilitiesParent.TextSize)
local getPreferredTextSizeLineBudget = require(SduiSharedUtilities.getPreferredTextSizeLineBudget)

local function usePreferredTextSizeLineBudget(num1: number?)
    local var1 = React.useCallback(function(arg1)
        local var1 = TextSize.getTextSizeStore(arg1).getTextSizeOffset(arg1)
        return getPreferredTextSizeLineBudget(var1, num1)
    end, { num1 })

    return SignalsReact.useSignalState(var1)
end

return usePreferredTextSizeLineBudget
