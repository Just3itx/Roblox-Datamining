-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local dependencies = require(script.Parent.Parent.Parent.dependencies)
local Roact = dependencies.Roact
local RoactNavigation = dependencies.RoactNavigation

local value = {
    state = {
        params = {},
        routeName = "",
        key = ""
    },
    dispatch = function() end,
    goBack = function() end,
    addListener = function() end,
    isFocused = function() end,
    setParams = function() end,
    getParam = function() end
}

return function(element)
    return Roact.createElement(RoactNavigation.Provider, { value = value }, { Element = element })
end
