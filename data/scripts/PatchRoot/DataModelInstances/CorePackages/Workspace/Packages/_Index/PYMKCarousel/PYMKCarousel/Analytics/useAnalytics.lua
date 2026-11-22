-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local React = require(scriptParentParent.dependencies).React
local PYMKCarouselAnalyticsContext = require(script.Parent.PYMKCarouselAnalyticsContext)

return function()
    return React.useContext(PYMKCarouselAnalyticsContext)
end
