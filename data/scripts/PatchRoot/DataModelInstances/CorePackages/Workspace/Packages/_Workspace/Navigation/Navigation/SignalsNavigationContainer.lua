-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local React = require(scriptParentParent.React)
local Context = require(scriptParentParent.RoactNavigation).Context
local useSignalState = require(scriptParentParent.SignalsReact).useSignalState

local _createSignalsNavigationObject = require(script.Parent.createSignalsNavigationObject)

local function SignalsNavigationContainer(tbl1)
    local value = useSignalState(tbl1.navigation.getNavigation)

    React.useEffect(function()
        tbl1.navigation.notifyEvents()
    end)

    return React.createElement(Context.Provider, { value = value }, tbl1.children)
end

return SignalsNavigationContainer
