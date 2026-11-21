-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local Rodux = require(scriptParentParentParent.Rodux)
local _ContactTypes = require(scriptParentParent.Types.ContactTypes)
local ActionDomain = require(script.Parent.ActionDomain)

return Rodux.makeActionCreator(ActionDomain .. script.Name, function(payload)
    return { payload = payload }
end)
