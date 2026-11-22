-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ImpressionsParent = script:FindFirstAncestor("Impressions").Parent

local React = require(ImpressionsParent.React)

local ImpressionsTagUtility = require(script.Parent.ImpressionsTagUtility)

return function(arg1, str1: string, num1: number?)
    React.useEffect(function()
        ImpressionsTagUtility.AddTag(arg1, str1, num1)

        return function()
            ImpressionsTagUtility.RemoveTag(arg1, str1, num1)
        end
    end, { arg1, str1, num1 })
end
