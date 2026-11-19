-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:10:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SharedFlagsParent = script:FindFirstAncestor("SharedFlags").Parent
local rolloutByApplicationId = require(SharedFlagsParent.AppCommonLib).rolloutByApplicationId

game:DefineFastInt("CharacterNameHandlerUserProfileApiRollout", 0)
game:DefineFastFlag("CharacterNameHandlerUserProfileApiEnabledForAll", false)

local function func1(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return game:GetFastFlag("CharacterNameHandlerUserProfileApiEnabledForAll")
end

local var1 = rolloutByApplicationId(function(): number
    return game:GetFastInt("CharacterNameHandlerUserProfileApiRollout")
end)
return function()
    return func1() or var1()
end
