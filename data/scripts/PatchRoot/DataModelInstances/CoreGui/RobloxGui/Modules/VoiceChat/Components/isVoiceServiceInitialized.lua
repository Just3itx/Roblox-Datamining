-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local CorePackages = game:GetService("CorePackages")
local _Promise = require(CorePackages.Packages.Promise)

local default = require(RobloxGui.Modules.VoiceChat.VoiceChatServiceManager).default

return function()
    return default:asyncInit()
end
