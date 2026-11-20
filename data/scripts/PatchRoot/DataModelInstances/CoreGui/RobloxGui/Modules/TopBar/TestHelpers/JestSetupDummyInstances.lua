-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:11:37Z
-- Luau bytecode version: 14 | Luau type version: 3
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

if not RobloxGui:FindFirstChild("Sounds") then
    local sounds = Instance.new("Folder")
    sounds.Name = "Sounds"
    sounds.Parent = RobloxGui
end
