-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Url = require(scriptParentParent.Network.Url)

local function constructGameLinkUrl(num1: number): string
    return `{Url.DOMAIN}games/{num1}`
end

return constructGameLinkUrl
