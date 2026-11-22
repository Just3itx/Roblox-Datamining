-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
local ProfileShareLinksParent = script:FindFirstAncestor("ProfileShareLinks").Parent
local ShareLinksNetworking = require(ProfileShareLinksParent.ShareLinksNetworking)

local configuredRoduxNetworking = require(script.Parent.configuredRoduxNetworking)

return {
    ShareLinksNetworking = ShareLinksNetworking.config({ roduxNetworking = configuredRoduxNetworking })
}
