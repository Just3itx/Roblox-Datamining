-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Roact = require(scriptParentParent.Roact)
local Immutable = require(scriptParentParent.AppCommonLib).Immutable
local Symbol = require(scriptParentParent.AppCommonLib).Symbol

local RoactServicesContext = require(script.Parent.RoactServicesContext)
local _RoactServicesTypes = require(script.Parent.RoactServicesTypes)

local ServiceProvider = Roact.PureComponent:extend("ServiceProvider")
local module = { ServiceProvider = ServiceProvider }

function ServiceProvider.init(tbl1, tbl2)
    local services = {}
    if tbl2 and tbl2.services then
        assert(tbl2.services, "Expected some services to connect, found none")
        assert(type(tbl2.services) == "table", "Expected the provided services to be a map")
        for k, value in pairs(tbl2.services) do
            if type(k) == "table" then
                k.set(services, value)
            end
        end
    end
    tbl1:setState({ services = services })
end

function ServiceProvider.render(arg1)
    return Roact.createElement(
        RoactServicesContext.Provider,
        {
            value = arg1.state.services
        },
        Roact.oneChild(arg1.props[Roact.Children])
    )
end

function module.createService(str1: string)
    assert(type(str1) == "string", "Expected serviceName to be a string")
    local var2 = Symbol.named(str1)

    return {
        get = function(arg1)
            return if arg1 then arg1[var2] else nil
        end,
        set = function(arg1, arg2)
            arg1[var2] = arg2
        end
    }
end

function module.connect(arg1)
    assert(arg1 ~= nil, "Expected some services to connect, found none.")
    return function(arg2)
        assert(arg2 ~= nil, "Expected a component to connect, found none.")

        local tbl1 = ({})
        local str1 = ("Services(%s)"):format(tostring(arg2))

        local var2 = Roact.PureComponent:extend(str1)

        function var2.init(_, arg3)
            for k, value in pairs(arg1) do
                assert(type(k) == "string", string.format("serviceMap must be indexed by strings, not %s", type(k)))

                assert(type(value) == "table", "serviceMap must have a service created by createService()")
                assert(type(value.get) == "function", "serviceMap must have a service created by createService()")
                assert(arg3.innerProps[k] == nil, "Naming conflict with prop : " .. k)
                tbl1[k] = value.get(arg3.services)
            end
        end

        function var2.render(arg3)
            local var3 = Immutable.JoinDictionaries(arg3.props.innerProps, tbl1)
            return Roact.createElement(arg2, var3)
        end

        local var3 = Roact.PureComponent:extend("ConnectionWrapper")

        function var3.render(arg3)
            return Roact.createElement(RoactServicesContext.Consumer, {
                render = function(services)
                    return Roact.createElement(var2, { innerProps = arg3.props, services = services })
                end
            })
        end

        return var3
    end
end

return module
