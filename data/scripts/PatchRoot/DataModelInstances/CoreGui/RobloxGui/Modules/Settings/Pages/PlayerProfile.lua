-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxGui = game:GetService("CoreGui").RobloxGui

local ReactPageFactory = require(RobloxGui.Modules.Settings.ReactPageFactory)

local PlayerProfileContainer = require(script.PlayerProfileContainer)

function createPlayerProfilePage()
    local var1 = ReactPageFactory:createNewPage("PlayerProfile")

    var1:setPage(PlayerProfileContainer)

    return var1
end

return createPlayerProfilePage()
