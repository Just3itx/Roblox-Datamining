-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:40:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxAliasesParent = script:FindFirstAncestor("RoduxAliases").Parent
local Rodux = require(RoduxAliasesParent.Rodux)
local ActionDomain = require(script.Parent.ActionDomain)

return Rodux.makeActionCreator(ActionDomain .. script.Name, function(showUserAlias)
    return {
        payload = { showUserAlias = showUserAlias }
    }
end)
