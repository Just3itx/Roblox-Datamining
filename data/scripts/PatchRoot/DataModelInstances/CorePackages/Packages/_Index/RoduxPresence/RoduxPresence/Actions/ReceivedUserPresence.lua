-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local Rodux = require(scriptParentParentParent.Rodux)
local ActionDomain = require(script.Parent.ActionDomain)

return Rodux.makeActionCreator(ActionDomain .. script.Name, function(payload)
    return { payload = payload }
end)
