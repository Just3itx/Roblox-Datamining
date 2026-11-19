-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Components = script.Parent.Parent.Components

local Roact = require(CorePackages.Packages.Roact)
local Immutable = require(script.Parent.Parent.Immutable)
local DataContext = require(Components.DataContext)

return function(arg1, ...)
    if not arg1 then
        error("Expected component to be passed to connection, got nil.")
    end

    local tbl1 = ({})
    local select2 = select

    for i = 1, select2("#", ...) do
        local select = select
        tbl1[i] = select(i, ...)
    end

    local str1 = string.format("Consumer(%s)_DependsOn_%s", tostring(arg1), tbl1[1])
    local var1 = Roact.Component:extend(str1)

    function var1.init(arg2)
        local tbl2 = ({})
        for _, value in pairs(tbl1) do
            local var2 = arg2.props.DevConsoleData[value]
            if not var2 then
                local str2 = string.format("%s %s", tostring(value), "could not be found. Make sure DataProvider is above this consumer")

                error(str2)
                return
            end
            tbl2[value] = var2
        end

        arg2:setState(tbl2)
    end

    function var1.render(arg2)
        local var2 = Immutable.JoinDictionaries(arg2.props.componentProps, arg2.state)
        return Roact.createElement(arg1, var2)
    end

    local function DataConsumerWrapper(componentProps)
        return Roact.createElement(DataContext.Consumer, {
            render = function(devConsoleData)
                return Roact.createElement(var1, { componentProps = componentProps, DevConsoleData = devConsoleData })
            end
        })
    end

    return DataConsumerWrapper
end
