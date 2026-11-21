-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:11:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local React = require(scriptParentParent.dependencies).React
local DiscoverabilityModalAnalyticsContext = require(script.Parent.DiscoverabilityModalAnalyticsContext)

return function()
    return React.useContext(DiscoverabilityModalAnalyticsContext)
end
