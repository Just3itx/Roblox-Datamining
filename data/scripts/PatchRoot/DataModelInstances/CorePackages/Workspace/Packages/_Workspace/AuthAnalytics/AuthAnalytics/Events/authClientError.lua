-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local checkAndSendEvent = require(scriptParentParent.Utils.checkAndSendEvent)
local bool1 = game:DefineFastFlag("ClientErrorAdditionalArgs", false)

return function(str1: string, state: string, url: string?, origin: string?)
    local tbl1 = {}

    if state then
        tbl1.state = state
    end

    if bool1 and url then
        tbl1.url = url
    end

    if bool1 and origin then
        tbl1.origin = origin
    end

    checkAndSendEvent(str1, "authClientError", tbl1)
end
