-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:31:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent
local Url = require(AuthCommonParent.Http).Url

return function(arg1, str1: string)
    return arg1(string.format("%sv2/games/%s/media", Url.GAME_URL, str1), "GET")
end
