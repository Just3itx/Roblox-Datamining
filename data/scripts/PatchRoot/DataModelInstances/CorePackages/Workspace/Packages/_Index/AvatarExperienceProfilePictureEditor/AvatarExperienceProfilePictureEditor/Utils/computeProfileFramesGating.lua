-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:50:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function shouldShowProfileFrames(bool1: boolean, bool2: boolean, bool3: boolean): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return if bool1 then not bool2 or bool3 else false
end

local function computeProfileFramesGating(bool1: boolean, bool2: boolean, bool3: boolean, bool4: boolean, ampAccessError: boolean)
    local shouldShowFrames = shouldShowProfileFrames(bool1, bool2, bool3)
    return {
        shouldShowFrames = shouldShowFrames,
        shouldShowUpsell = shouldShowFrames and bool4 and not ampAccessError,
        canEquipFrame = shouldShowFrames and bool3 and not ampAccessError,
        ampAccessError = ampAccessError
    }
end

return computeProfileFramesGating
