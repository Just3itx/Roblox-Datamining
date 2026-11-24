-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceSideSheet = script:FindFirstAncestor("InExperienceSideSheet")

local Enums = require(InExperienceSideSheet.Common.Enums)

local GetActionBindingsStore = require(InExperienceSideSheet.Stores.GetActionBindingsStore)

local function setIsRespawnEnabled(bool1: boolean)
    local sessionActionBinding = GetActionBindingsStore().sessionActionBindings[Enums.ActionBinding.Respawn]
    if sessionActionBinding then
        sessionActionBinding.setIsEnabled(bool1)
    end
end

return setIsRespawnEnabled
