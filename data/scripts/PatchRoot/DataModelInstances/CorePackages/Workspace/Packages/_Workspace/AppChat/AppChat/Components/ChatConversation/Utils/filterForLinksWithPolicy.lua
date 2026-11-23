-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:50:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local ArgCheck = require(AppChatParent.ArgCheck)

local filterForLinks = require(script.Parent.filterForLinks)

local tbl1 = {
    "roblox.com",
    "sitetest%d%.robloxlabs.com",
    "gametest%d%.robloxlabs.com",
    "roblox.cn",
    "roblox.qq.com",
    "roblox%-cn.com"
}

return function(arg1)
    ArgCheck.isType(arg1, "table", "filterForLinks.text")

    return filterForLinks(arg1, tbl1)
end
