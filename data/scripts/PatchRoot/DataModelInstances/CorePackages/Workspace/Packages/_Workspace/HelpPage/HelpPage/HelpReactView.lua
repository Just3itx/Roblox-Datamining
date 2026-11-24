-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local React = require(scriptParentParent.React)
local HelpPageContainer = require(scriptParent.Components.HelpPageContainer)
local KeybindContextProvider = require(scriptParent.Context.KeybindContextProvider)

local function _createPageView()
    return React.createElement(KeybindContextProvider, nil, { HelpPageContainer = React.createElement(HelpPageContainer) })
end

return _createPageView
