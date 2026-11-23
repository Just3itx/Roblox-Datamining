-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local function respawnAvatar(func1: (...any) -> (...any))
    local var1, var2 = func1()
    if not var1 then
        return
    end

    if var2 then
        var2:Fire()
        return
    end

    local localPlayer = Players.LocalPlayer
    if not localPlayer then
        return
    end

    local character = localPlayer.Character
    if not character then
        return
    end

    local humanoid = character:FindFirstChild("Humanoid")
    if humanoid and humanoid:IsA("Humanoid") then
        humanoid.Health = 0
    end
end

return respawnAvatar
