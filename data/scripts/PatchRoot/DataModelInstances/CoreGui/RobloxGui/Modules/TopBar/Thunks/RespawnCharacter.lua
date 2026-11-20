-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:17:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarEditorService = game:GetService("AvatarEditorService")
local Players = game:GetService("Players")

local scriptParentParent = script.Parent.Parent
return if require(scriptParentParent.Flags.FFlagTopBarDeprecateRespawnRodux) then nil else function(arg1)
    local state = arg1:getState()

    AvatarEditorService:BustAvatarFetchCache()

    if state.respawn.customCallback then
        state.respawn.customCallback:Fire()
        return
    end
    local character = Players.LocalPlayer.Character
    if character == nil then
        return
    end

    local humanoid = character:FindFirstChild("Humanoid")
    if humanoid ~= nil and humanoid:IsA("Humanoid") then
        humanoid.Health = 0
    end
end
