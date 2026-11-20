-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:30:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local React = require(scriptParentParentParentParent.React)
local SceneView = require(script.Parent.Parent.SceneView)

local function SwitchView(arg1)
    local state = arg1.navigation.state
    local key = state.routes[state.index].key
    local descriptor = arg1.descriptors[key]
    local component = descriptor.getComponent()

    return React.createElement(
        SceneView,
        {
            component = component,
            navigation = descriptor.navigation,
            screenProps = arg1.screenProps
        }
    )
end
return SwitchView
