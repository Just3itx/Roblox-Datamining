-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local React = require(scriptParentParentParent.dependencies).React

local DiscoverabilityContext = require(scriptParentParentParent.Components.DiscoverabilityContext.DiscoverabilityContext)

local DiscoverabilityOverlayContainer = require(scriptParentParentParent.Components.DiscoverabilityOverlay.DiscoverabilityOverlayContainer)

local function DiscoverabilityOverlayEntryPoint(arg1)
    return React.createElement(DiscoverabilityContext(DiscoverabilityOverlayContainer), arg1)
end

return DiscoverabilityOverlayEntryPoint
