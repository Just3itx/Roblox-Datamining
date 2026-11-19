-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T03:31:01Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local Chat = game:GetService("Chat")
game:DefineFastFlag("DebugExpChatAlwaysRunTCS", false)

local bool1 = game:DefineFastFlag("ExpChatMigrationReplicationFix", false)

local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")
local IsAutoMigrated = Chat.IsAutoMigrated

if game:GetService("RunService"):IsServer() then
    RobloxReplicatedStorage:SetAttribute("ChatMigratedToExpChat", Chat.IsAutoMigrated)

    Chat:GetPropertyChangedSignal("IsAutoMigrated"):Connect(function()
        RobloxReplicatedStorage:SetAttribute("ChatMigratedToExpChat", Chat.IsAutoMigrated)
        IsAutoMigrated = Chat.IsAutoMigrated
    end)
else
    IsAutoMigrated = RobloxReplicatedStorage:GetAttribute("ChatMigratedToExpChat") == true
    RobloxReplicatedStorage:GetAttributeChangedSignal("ChatMigratedToExpChat"):Connect(function()
        IsAutoMigrated = RobloxReplicatedStorage:GetAttribute("ChatMigratedToExpChat") == true
        Chat.IsAutoMigrated = IsAutoMigrated
    end)
end

local function IsChatAutoMigrated(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return if game:GetEngineFeature("ChatServiceCompatibilityForAll") then true elseif bool1 and game:GetEngineFeature("TCSMigrationReplicationFix") then Chat.IsAutoMigrated else IsAutoMigrated
end

return function(): boolean
    return IsChatAutoMigrated() or game:GetFastFlag("DebugExpChatAlwaysRunTCS")
end
