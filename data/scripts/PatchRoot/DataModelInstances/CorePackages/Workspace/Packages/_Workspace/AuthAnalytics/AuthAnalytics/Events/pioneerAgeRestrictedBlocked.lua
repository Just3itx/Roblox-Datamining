-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:31:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local checkAndSendEvent = require(scriptParentParent.Utils.checkAndSendEvent)

return function(str1: string, source: string)
    checkAndSendEvent(str1, "pioneerAgeRestrictedBlocked", { source = source })
end
