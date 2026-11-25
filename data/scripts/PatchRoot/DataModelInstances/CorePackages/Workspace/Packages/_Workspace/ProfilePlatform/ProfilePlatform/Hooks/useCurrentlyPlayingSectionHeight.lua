-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatformParent = script:FindFirstAncestor("ProfilePlatform").Parent
local useTokens = require(ProfilePlatformParent.Foundation).Hooks.useTokens
local FFlagJoinabilityCTAContextCopy = require(ProfilePlatformParent.SharedFlags).FFlagJoinabilityCTAContextCopy

return function(arg1)
    local var1 = useTokens()
    if arg1 == nil or arg1.universeId == nil then
        return 0
    end

    local var2 = var1.Size.Size_1000 + 2 * var1.Padding.Large
    if FFlagJoinabilityCTAContextCopy then
        local joinability = arg1.joinability
        if joinability == "Joinable" or joinability == "NotJoinable" then
            var2 += var1.Typography.BodyMedium.FontSize + var1.Gap.XSmall
        end
    end
    return var2
end
