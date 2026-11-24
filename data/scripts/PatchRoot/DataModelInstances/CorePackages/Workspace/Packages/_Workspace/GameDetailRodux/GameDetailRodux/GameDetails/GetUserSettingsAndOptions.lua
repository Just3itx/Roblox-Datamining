-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:01:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailRoduxParent = script:FindFirstAncestor("GameDetailRodux").Parent

local Url = require(GameDetailRoduxParent.Http).Url

return function(arg1)
    return arg1(`{Url.APIS_URL}user-settings-api/v1/user-settings/settings-and-options`, "GET")
end
