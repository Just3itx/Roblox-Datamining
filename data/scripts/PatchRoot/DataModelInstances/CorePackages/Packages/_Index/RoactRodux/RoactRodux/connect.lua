-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Roact = require(script.Parent.Parent.Roact)
local shallowEqual = require(script.Parent.shallowEqual)
local join = require(script.Parent.join)
local StoreContext = require(script.Parent.StoreContext)

local function formatMessage(tbl1: {string}, arg1): string -- Luacid: Inlined by compiler; 3 call sites recovered
    return table.concat(tbl1, "\n"):format(unpack(arg1 or {}))
end

local function noop()
    return nil
end

local function makeStateUpdater(store) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(arg1, arg2, mappedStoreState)
        if mappedStoreState == nil then
            mappedStoreState = arg2.mapStateToProps(store:getState(), arg1)
        end

        return {
            mappedStoreState = mappedStoreState,
            propsForChild = join(arg1, mappedStoreState, arg2.mappedStoreDispatch)
        }
    end
end

local function connect(arg1, arg2)
    local var1 = debug.traceback()

    if arg1 ~= nil then
        assert(typeof(arg1) == "function", "mapStateToProps must be a function or nil!")
    else
        arg1 = noop
    end

    local str1 = typeof(arg2)
    if arg2 ~= nil then
        assert(str1 == "function" or str1 == "table", "mapDispatchToProps must be a function, table, or nil!")
    else
        arg2 = noop
    end

    return function(arg3)
        if arg3 == nil then
            local str2 = formatMessage(
                { "connect returns a function that must be passed a component.", "Check the connection at:", "%s" },
                { var1 }
            )

            error(str2, 2)
        end

        local str2 = ("RoduxConnection(%s)"):format(tostring(arg3))

        local var2 = Roact.Component:extend(str2)

        function var2.getDerivedStateFromProps(arg4, arg5)
            if arg5.stateUpdater ~= nil then
                return arg5.stateUpdater(arg4.innerProps, arg5)
            end
        end

        function var2.init(arg4, arg5)
            arg4.store = arg5.store

            if arg4.store == nil then
                local str3 = formatMessage({ "Cannot initialize Roact-Rodux connection without being a descendent of StoreProvider!", "Tried to wrap component %q", "Make sure there is a StoreProvider above this component in the tree." }, { tostring(arg3) })

                error(str3)
            end

            local state = arg4.store:getState()

            local var3 = arg1
            local var4 = var3(state, arg4.props.innerProps)
            local var5

            if typeof(var4) == "function" then
                var5 = var4(state, arg4.props.innerProps)
            else
                var5 = var4
                var4 = var3
            end

            if var5 ~= nil and typeof(var5) ~= "table" then
                local str3 = formatMessage({ "mapStateToProps must either return a table, or return another function that returns a table.", "Instead, it returned %q, which is of type %s." }, { tostring(var5), typeof(var5) })

                error(str3)
            end

            local function dispatch(...)
                return arg4.store:dispatch(...)
            end

            local var6 = nil
            if str1 == "table" then
                var6 = {}

                for k, value in pairs(arg2) do
                    assert(typeof(value) == "function", "mapDispatchToProps must contain function values")

                    var6[k] = function(...)
                        dispatch(value(...))
                    end
                end
            elseif str1 == "function" then
                var6 = arg2(dispatch)
            end

            local stateUpdater = makeStateUpdater(arg4.store)

            arg4.state = {
                stateUpdater = stateUpdater,
                mapStateToProps = var4,
                mappedStoreDispatch = var6,
                propsForChild = nil
            }

            local tbl1 = stateUpdater(arg4.props.innerProps, arg4.state, var5)

            for k, value in pairs(tbl1) do
                arg4.state[k] = value
            end
        end

        function var2.didMount(arg4)
            local function func1(arg5) -- Luacid: Inlined by compiler; 1 call site recovered
                arg4:setState(function(arg6, arg7)
                    local var3 = arg6.mapStateToProps(arg5, arg7.innerProps)

                    if shallowEqual(var3, arg6.mappedStoreState) then
                        return nil
                    end

                    return arg6.stateUpdater(arg7.innerProps, arg6, var3)
                end)
            end

            func1((arg4.store:getState()))

            arg4.storeChangedConnection = arg4.store.changed:connect(func1)
        end

        function var2.willUnmount(arg4)
            if arg4.storeChangedConnection then
                arg4.storeChangedConnection:disconnect()
                arg4.storeChangedConnection = nil
            end
        end

        function var2.render(arg4)
            return Roact.createElement(arg3, arg4.state.propsForChild)
        end

        local var3 = Roact.Component:extend(str2)

        function var3.render(arg4)
            return Roact.createElement(StoreContext.Consumer, {
                render = function(store)
                    return Roact.createElement(var2, { innerProps = arg4.props, store = store })
                end
            })
        end

        return var3
    end
end

return connect
