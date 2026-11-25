-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:00:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local RunService = game:GetService("RunService")

local RequestType = require(scriptParentParent.Enums.RequestType)

local function isMockingPurchases(avatarCreationFee): boolean
    return RunService:IsStudio() and avatarCreationFee ~= RequestType.AvatarCreationFee
end

return isMockingPurchases
