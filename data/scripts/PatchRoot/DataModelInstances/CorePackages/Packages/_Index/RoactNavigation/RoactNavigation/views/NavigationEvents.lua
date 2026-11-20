-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local React = require(scriptParentParentParent.React)
local withNavigation = require(script.Parent.withNavigation)
local Events = require(scriptParentParent.Events)

local tbl1 = {
    [Events.WillFocus] = "onWillFocus",
    [Events.DidFocus] = "onDidFocus",
    [Events.WillBlur] = "onWillBlur",
    [Events.DidBlur] = "onDidBlur"
}

local var1 = React.Component:extend("NavigationEvents")

function var1.didMount(arg1)
    arg1:subscribeAll()
end

function var1.didUpdate(arg1, arg2)
    if arg1.props.navigation ~= arg2.navigation then
        arg1:removeAll()
        arg1:subscribeAll()
    end
end

function var1.willUnmount(arg1)
    arg1:removeAll()
end

function var1.getPropListener(arg1, arg2)
    return arg1.props[tbl1[arg2]]
end

function var1.subscribeAll(arg1)
    local navigation = arg1.props.navigation

    arg1.subscriptions = {}

    for value in tbl1 do
        arg1.subscriptions[value] = navigation.addListener(value, function(...)
            local propListener = arg1:getPropListener(value)
            if propListener then
                propListener(...)
            end
        end)
    end
end

function var1.removeAll(arg1)
    for value in tbl1 do
        local subscription = arg1.subscriptions[value]
        if subscription then
            subscription.remove()
            arg1.subscriptions[value] = nil
        end
    end
end

function var1.render(_)
    return nil
end

return withNavigation(var1)
