-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local SetAliasAnalyticsContext = require(script.Parent.SetAliasAnalyticsContext)
local React = require(scriptParentParent.dependencies).React

return function()
    return React.useContext(SetAliasAnalyticsContext)
end
