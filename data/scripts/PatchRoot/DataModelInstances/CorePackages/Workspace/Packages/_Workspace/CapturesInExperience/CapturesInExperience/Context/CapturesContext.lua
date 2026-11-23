-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:50:38Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParentParent = script.Parent.Parent.Parent

local Dash = require(scriptParentParentParent.Dash)
return require(scriptParentParentParent.React).createContext(
    {
        fireAnalyticsEvent = Dash.noop,
        chromeEnabled = nil,
        openGallery = nil
    }
)
