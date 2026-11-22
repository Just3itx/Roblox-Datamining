-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")

local function isStudio(): boolean
    return RunService:IsStudio()
end

return isStudio
