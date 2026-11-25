-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:00:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local RobloxTranslator = require(scriptParentParentParent.RobloxTranslator)

local function getPeopleHeaderLabel()
    return RobloxTranslator:FormatByKey("InGame.PlayerList.Players")
end

return getPeopleHeaderLabel
