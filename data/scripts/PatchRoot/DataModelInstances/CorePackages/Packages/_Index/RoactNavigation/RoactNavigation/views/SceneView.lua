-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:30:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent

local React = require(scriptParentParentParent.React)
local NavigationContext = require(scriptParent.NavigationContext)

local var1 = React.PureComponent:extend("SceneView")

function var1.render(arg1)
    local screenProps = arg1.props.screenProps
    local component = arg1.props.component
    local navigation = arg1.props.navigation

    return React.createElement(
        NavigationContext.Provider,
        { value = navigation },
        {
            Scene = React.createElement(component, { screenProps = screenProps, navigation = navigation })
        }
    )
end

return var1
