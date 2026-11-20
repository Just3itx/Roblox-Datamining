-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)
local Object = require(scriptParentParent.LuauPolyfill).Object

local console = require(scriptParentParent.Shared).console

local enableAllocationTrims = require(scriptParentParent.Shared).ReactFeatureFlags.enableAllocationTrims

local ReactNoopUpdateQueue = require(script.Parent.ReactNoopUpdateQueue)
local tbl1 = {}

local __DEV__ = ReactGlobals.__DEV__
local __COMPAT_WARNINGS__ = ReactGlobals.__COMPAT_WARNINGS__

if __DEV__ then
    Object.freeze(tbl1)
end

local UninitializedState = require(scriptParentParent.Shared).UninitializedState

local function trimPath(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = string.match(str1, "%.%u[%.%w]-$")
    if var1 then
        return string.gsub(var1, "^%.", "")
    end

    return str1
end

local function warnAboutExistingLifecycle(__componentName, arg1, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
    console.warn(
        "%s already defined '%s', but it also defining the deprecated Roact method '%s'. %s should only implement one of these methods, preferably using the non-deprecated name.",
        __componentName,
        arg2,
        arg1,
        __componentName
    )
end

local function warnAboutDeprecatedLifecycleName(arg1, arg2, arg3) -- Luacid: unused: defined but never referenced
    if __DEV__ and __COMPAT_WARNINGS__ then
        local var1, var2 = debug.info(3, "sln")
        local warn = console.warn
        local file = trimPath(var1)
        warn(
            "%s is using method '%s', which is no longer supported and should be updated to '%s'\nFile: %s:%s",
            arg1,
            arg2,
            arg3,
            file,
            tostring(var2)
        )
    end
end

local tbl2 = {
    didMount = "componentDidMount",
    shouldUpdate = "shouldComponentUpdate",
    willUpdate = "UNSAFE_componentWillUpdate",
    didUpdate = "componentDidUpdate",
    willUnmount = "componentWillUnmount"
}

local function handleNewLifecycle<T>(arg1, arg2, arg3: T)
    if tbl2[arg2] ~= nil then
        if arg1[tbl2[arg2]] ~= nil then
            warnAboutExistingLifecycle(arg1.__componentName, arg2, tbl2[arg2])
        elseif arg2 == "willUpdate" and arg1.componentWillUpdate then
            warnAboutExistingLifecycle(arg1.__componentName, arg2, "UNSAFE_componentWillUpdate")
        else
            local __componentName = arg1.__componentName

            local var1 = tbl2[arg2]

            if __DEV__ and __COMPAT_WARNINGS__ then
                local var2, var3 = debug.info(3, "sln")
                console.warn(
                    "%s is using method '%s', which is no longer supported and should be updated to '%s'\nFile: %s:%s",
                    __componentName,
                    arg2,
                    var1,
                    trimPath(var2),
                    tostring(var3)
                )
            end
        end
        arg2 = tbl2[arg2]
    end
    rawset(arg1, arg2, arg3)
end

local Component = setmetatable({ __componentName = "Component" }, {
    __newindex = handleNewLifecycle,
    __index = { isReactComponent = true },
    __tostring = function(arg1)
        return arg1.__componentName
    end
})

local num1 = if ReactGlobals.__TESTEZ_RUNNING_TEST__ then 0 else 900
local num2 = 1
local var2 = table.create(num1)
for _ = 1, num1 do
    table.insert(
        var2,
        {
            props = nil,
            context = nil,
            state = UninitializedState,
            __refs = tbl1,
            __updater = ReactNoopUpdateQueue
        }
    )
end

local function setStateInInit(arg1, arg2, nil1: nil)
    if __DEV__ and nil1 ~= nil then
        console.warn(
            "Received a `callback` argument to `setState` during initialization of \"%s\". The callback behavior is not supported when using `setState` in `init`.\n\nConsider defining similar behavior in a `compontentDidMount` method instead.",
            arg1.__componentName
        )
    end

    local var3 = arg2 and type(arg2)
    if arg2 == nil or var3 ~= "table" and var3 ~= "function" then
        error(
            "setState(...): takes an object of state variables to update or a function which returns an object of state variables."
        )
    end

    local state = arg1.state

    if var3 == "function" then
        arg2 = arg2(state, arg1.props)
    end

    if enableAllocationTrims then
        arg1.state = if type(state) == "table" and getmetatable(state) == nil then Object.assign(table.clone(state), arg2) else Object.assign({}, state, arg2)
        return
    end

    arg1.state = Object.assign({}, state, arg2)
end

function Component.extend(arg1, arg2)
    if arg2 == nil then
        if __COMPAT_WARNINGS__ then
            console.warn(
                "Component:extend() accepting no arguments is deprecated, and will not be supported in a future version of Roact. Please provide an explicit name."
            )
            arg2 = ""
        else
            arg2 = ""
        end
    elseif type(arg2) ~= "string" then
        error("Component class name must be a string")
    end

    local module = {
        __componentName = arg2,
        setState = arg1.setState,
        forceUpdate = arg1.forceUpdate,
        init = nil
    }

    module.__index = module

    function module.__ctor(props, context, arg3)
        local tbl3

        if num2 <= num1 then
            tbl3 = var2[num2]

            tbl3.props = props
            tbl3.context = context

            var2[num2] = nil
            num2 += 1
        else
            tbl3 = {
                props = props,
                context = context,
                state = UninitializedState,
                __refs = tbl1,
                __updater = arg3 or ReactNoopUpdateQueue
            }
        end

        local self = setmetatable(tbl3, module)

        if module.init and type(module.init) == "function" then
            self.setState = setStateInInit

            module.init(self, props, context)

            self.setState = nil
        end

        return self
    end

    setmetatable(module, (getmetatable(arg1)))

    return module
end

function Component.setState(arg1, arg2, arg3)
    if arg2 ~= nil and type(arg2) ~= "table" and type(arg2) ~= "function" then
        error(
            "setState(...): takes an object of state variables to update or a function which returns an object of state variables."
        )
    end

    arg1.__updater.enqueueSetState(arg1, arg2, arg3, "setState")
end

function Component.forceUpdate(arg1, arg2)
    arg1.__updater.enqueueForceUpdate(arg1, arg2, "forceUpdate")
end

if __DEV__ then
    local tbl3 = {
        isMounted = {
            "isMounted",
            "Instead, make sure to clean up subscriptions and pending requests in componentWillUnmount to prevent memory leaks."
        },
        replaceState = {
            "replaceState",
            "Refactor your code to use setState instead (see https://github.com/facebook/react/issues/3236)."
        }
    }

    local function func1(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
        Component[arg1] = function()
            console.warn("%s(...) is deprecated in plain JavaScript React classes. %s", arg2[1], arg2[2])

            return nil
        end
    end

    for value, _ in tbl3 do
        if tbl3[value] ~= nil then
            func1(value, tbl3[value])
        end
    end
end

local PureComponent = Component:extend("PureComponent")

PureComponent.extend = Component.extend

setmetatable(PureComponent, {
    __newindex = handleNewLifecycle,
    __index = { isReactComponent = true, isPureReactComponent = true },
    __tostring = function(arg1)
        return arg1.__componentName
    end
})

return { Component = Component, PureComponent = PureComponent }
