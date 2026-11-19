-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Constants = require(CorePackages.Workspace.Packages.CoreScriptsCommon).Constants
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")

local GetServerType = Instance.new("RemoteFunction")
GetServerType.Name = "GetServerType"
GetServerType.Parent = RobloxReplicatedStorage

function GetServerType.OnServerInvoke()
    if game.PrivateServerId == "" then
        return Constants.STANDARD_SERVER
    end

    if game.PrivateServerOwnerId == 0 then
        return Constants.RESERVED_SERVER
    end

    return Constants.VIP_SERVER
end
