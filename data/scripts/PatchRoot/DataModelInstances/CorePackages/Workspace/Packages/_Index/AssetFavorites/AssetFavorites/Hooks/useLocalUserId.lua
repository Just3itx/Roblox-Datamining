-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local StudioService = if RunService:IsStudio() then game:GetService("StudioService") else nil

local function useLocalUserId(arg1)
    arg1 = arg1 or Players
    if arg1.LocalPlayer then
        return arg1.LocalPlayer.UserId
    elseif StudioService then
        return StudioService:GetUserId()
    end
    return 0
end

return useLocalUserId
