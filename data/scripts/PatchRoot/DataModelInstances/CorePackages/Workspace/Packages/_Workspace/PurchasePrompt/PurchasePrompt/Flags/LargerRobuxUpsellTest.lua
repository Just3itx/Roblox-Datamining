-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("InGameLargerRobuxUpsellIXP", false)
game:DefineFastFlag("InGameLargerRobuxUpsellIXPRolledOut", false)
game:DefineFastFlag("InGameLargerRobuxUpsellEnabled", false)
game:DefineFastString("InGameLargerRobuxUpsellIXPLayerParam", "isInExperiment")

local function isEnabledForAll(): boolean -- Luacid: Inlined by compiler; 5 call sites recovered
    return game:GetFastFlag("InGameLargerRobuxUpsellEnabled")
end

local function isRolledOut(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return isEnabledForAll() or game:GetFastFlag("InGameLargerRobuxUpsellIXPRolledOut")
end

local function isEnabled(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return isEnabledForAll() or game:GetFastFlag("InGameLargerRobuxUpsellIXP")
end

return {
    isEnabled = isEnabled,
    isEnabledForAll = isEnabledForAll,
    isUserEnrolled = function(arg1)
        if isEnabledForAll() then
            return true
        elseif not isEnabled() then
            return false
        else
            arg1 = arg1 or {}

            local fastString = game:GetFastString("InGameLargerRobuxUpsellIXPLayerParam")

            if arg1[fastString] == nil then
                return (isRolledOut())
            end

            return arg1[fastString]
        end
    end
}
