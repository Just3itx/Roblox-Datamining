-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SceneUnderstanding = script:FindFirstAncestor("SceneUnderstanding")

local isWirable = require(SceneUnderstanding.wiring.isWirable)
local _types = require(SceneUnderstanding.wiring.types)

local function toWirableInstance(arg1)
    return if arg1 and isWirable(arg1) then arg1 else nil
end

return toWirableInstance
