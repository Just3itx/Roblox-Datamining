-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatformParent = script:FindFirstAncestor("ProfilePlatform").Parent
local React = require(ProfilePlatformParent.React)

local ImpressionsTagUtility = require(ProfilePlatformParent.Impressions).ImpressionsTagUtility

local function useSetupImpressionsTileTagging(arg1, str1: string, num1: number)
    React.useEffect(function()
        ImpressionsTagUtility.AddTag(arg1, str1, num1)
        return function()
            ImpressionsTagUtility.RemoveTag(arg1, str1, num1)
        end
    end, { arg1, str1, num1 })
end
return useSetupImpressionsTileTagging
