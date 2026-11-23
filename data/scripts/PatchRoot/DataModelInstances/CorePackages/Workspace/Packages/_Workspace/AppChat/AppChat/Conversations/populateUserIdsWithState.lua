-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local populateListFromIds = require(AppChat.SocialLibraries).populate.populateListFromIds
local getDeepValue = require(AppChat.Utils.getDeepValue)

return function(arg1, arg2)
    local deepValue = getDeepValue(arg1, "Users") or {}

    return populateListFromIds(arg2, deepValue)
end
