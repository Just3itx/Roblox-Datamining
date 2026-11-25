-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCommonParent = script:FindFirstAncestor("SocialCommon").Parent

local Dash = require(SocialCommonParent.Dash)

return function(tbl1)
    return Dash.join(tbl1, { name = tbl1.username, gameInstanceId = tbl1.gameId })
end
