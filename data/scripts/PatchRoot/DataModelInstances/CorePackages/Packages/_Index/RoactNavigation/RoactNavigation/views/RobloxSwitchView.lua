-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:30:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent

local Object = require(scriptParentParentParent.LuauPolyfill).Object
local React = require(scriptParentParentParent.React)
local SceneView = require(scriptParent.SceneView)

local tbl1 = { keepVisitedScreensMounted = false }

local var1 = React.Component:extend("RobloxSwitchView")

function var1.getDerivedStateFromProps(arg1, arg2)
    local state = arg1.navigation.state
    local key = state.routes[state.index].key
    local descriptors = arg1.descriptors

    local keepVisitedScreensMounted = Object.assign(table.clone(tbl1), arg1.navigationConfig or {}).keepVisitedScreensMounted

    local visitedScreenKeys = {
        [key] = true
    }

    if keepVisitedScreensMounted and arg2.visitedScreenKeys then
        for k in arg2.visitedScreenKeys do
            if descriptors[k] ~= nil then
                visitedScreenKeys[k] = true
            end
        end
    end

    return { visitedScreenKeys = visitedScreenKeys }
end

function var1.init(arg1)
    arg1.state = {}
end

function var1.render(arg1)
    local state = arg1.props.navigation.state
    local screenProps = arg1.props.screenProps
    local descriptors = arg1.props.descriptors
    local visitedScreenKeys = arg1.state.visitedScreenKeys
    local key = state.routes[state.index].key

    local tbl2 = ({})
    for k, descriptor in descriptors do
        local bool1 = k == key

        if visitedScreenKeys[k] ~= true then
            continue
        end

        local var2 = "card_" .. k
        local createElement = React.createElement
        local tbl3 = {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            ClipsDescendants = false,
            BorderSizePixel = 0,
            Visible = bool1
        }
        local tbl4 = {
            Content = React.createElement(
                SceneView,
                {
                    component = descriptor.getComponent(),
                    navigation = descriptor.navigation,
                    screenProps = screenProps
                }
            )
        }
        tbl2[var2] = createElement("Frame", tbl3, tbl4)
    end

    return React.createElement("Folder", nil, tbl2)
end

return var1
