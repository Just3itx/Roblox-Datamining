-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)

local console = require(scriptParentParent.Shared).console

local _ReactInternalTypes = require(script.Parent.ReactInternalTypes)

local ReactCurrentFiber = require(script.Parent.ReactCurrentFiber)
local resetCurrentFiber = ReactCurrentFiber.resetCurrentFiber
local setCurrentFiber = ReactCurrentFiber.setCurrentFiber
local getComponentName = require(scriptParentParent.Shared).getComponentName
local StrictMode = require(script.Parent.ReactTypeOfMode).StrictMode

local tbl1 = {
    recordUnsafeLifecycleWarnings = function(_, _) end,
    flushPendingUnsafeLifecycleWarnings = function() end,
    recordLegacyContextWarning = function(_, _) end,
    flushLegacyContextWarning = function() end,
    discardPendingWarnings = function() end
}

if ReactGlobals.__DEV__ then
    local function _(arg1) -- Luacid: unused: defined but never referenced
        local var1 = nil

        while arg1 ~= nil do
            if bit32.band(arg1.mode, StrictMode) ~= 0 then
                var1 = arg1
            end

            arg1 = arg1.return_
        end

        return var1
    end

    local function func1(tbl2): string
        local tbl3 = {}
        for value, _ in tbl2 do
            table.insert(tbl3, value)
        end
        table.sort(tbl3)
        return table.concat(tbl3, ", ")
    end

    local tbl2 = {}
    local tbl3 = {}
    local tbl4 = {}
    local tbl5 = {}
    local tbl6 = {}
    local tbl7 = {}

    local tbl8 = {}

    function tbl1.recordUnsafeLifecycleWarnings(arg1, arg2)
        if tbl8[arg1.type] then
            return
        end

        if typeof(arg2.componentWillMount) == "function" then
            table.insert(tbl2, arg1)
        end

        if bit32.band(arg1.mode, StrictMode) ~= 0 and typeof(arg2.UNSAFE_componentWillMount) == "function" then
            table.insert(tbl3, arg1)
        end

        if typeof(arg2.componentWillReceiveProps) == "function" then
            table.insert(tbl4, arg1)
        end

        if bit32.band(arg1.mode, StrictMode) ~= 0 and typeof(arg2.UNSAFE_componentWillReceiveProps) == "function" then
            table.insert(tbl5, arg1)
        end

        if typeof(arg2.componentWillUpdate) == "function" then
            table.insert(tbl6, arg1)
        end

        if bit32.band(arg1.mode, StrictMode) ~= 0 and typeof(arg2.UNSAFE_componentWillUpdate) == "function" then
            table.insert(tbl7, arg1)
        end
    end

    function tbl1.flushPendingUnsafeLifecycleWarnings()
        local tbl9 = {}
        if #tbl2 > 0 then
            for _, value in tbl2 do
                tbl9[getComponentName(value.type) or "Component"] = true
                tbl8[value.type] = true
            end
            table.clear(tbl2)
        end

        local tbl10 = {}
        if #tbl3 > 0 then
            for _, value in tbl3 do
                tbl10[getComponentName(value.type) or "Component"] = true
                tbl8[value.type] = true
            end
            table.clear(tbl3)
        end

        local tbl11 = {}
        if #tbl4 > 0 then
            for _, value in tbl4 do
                tbl11[getComponentName(value.type) or "Component"] = true
                tbl8[value.type] = true
            end

            table.clear(tbl4)
        end

        local tbl12 = {}
        if #tbl5 > 0 then
            for _, value in tbl5 do
                tbl12[getComponentName(value.type) or "Component"] = true
                tbl8[value.type] = true
            end

            table.clear(tbl5)
        end

        local tbl13 = {}
        if #tbl6 > 0 then
            for _, value in tbl6 do
                tbl13[getComponentName(value.type) or "Component"] = true
                tbl8[value.type] = true
            end

            table.clear(tbl6)
        end

        local tbl14 = {}
        if #tbl7 > 0 then
            for _, value in tbl7 do
                tbl14[getComponentName(value.type) or "Component"] = true
                tbl8[value.type] = true
            end

            table.clear(tbl7)
        end

        if next(tbl10) ~= nil then
            local components = func1(tbl10)
            console.error(
                "Using UNSAFE_componentWillMount in strict mode is not recommended and may indicate bugs in your code. See https://reactjs.org/link/unsafe-component-lifecycles for details.\n\n* Move code with side effects to componentDidMount, and set initial state in the constructor.\n\nPlease update the following components: %s",
                components
            )
        end

        if next(tbl12) ~= nil then
            local components = func1(tbl12)
            console.error(
                "Using UNSAFE_componentWillReceiveProps in strict mode is not recommended and may indicate bugs in your code. See https://reactjs.org/link/unsafe-component-lifecycles for details.\n\n* Move data fetching code or side effects to componentDidUpdate.\n* If you're updating state whenever props change, refactor your code to use memoization techniques or move it to static getDerivedStateFromProps. Learn more at: https://reactjs.org/link/derived-state\n\nPlease update the following components: %s",
                components
            )
        end

        if next(tbl14) ~= nil then
            local components = func1(tbl14)
            console.error(
                "Using UNSAFE_componentWillUpdate in strict mode is not recommended and may indicate bugs in your code. See https://reactjs.org/link/unsafe-component-lifecycles for details.\n\n* Move data fetching code or side effects to componentDidUpdate.\n\nPlease update the following components: %s",
                components
            )
        end

        if next(tbl9) ~= nil then
            local components = func1(tbl9)

            console.warn(
                "componentWillMount has been renamed, and is not recommended for use. See https://reactjs.org/link/unsafe-component-lifecycles for details.\n\n* Move code with side effects to componentDidMount, and set initial state in the constructor.\n* Rename componentWillMount to UNSAFE_componentWillMount to suppress this warning in non-strict mode. In React 18.x, only the UNSAFE_ name will work.\n\nPlease update the following components: %s",
                components
            )
        end

        if next(tbl11) ~= nil then
            local components = func1(tbl11)

            console.warn(
                "componentWillReceiveProps has been renamed, and is not recommended for use. See https://reactjs.org/link/unsafe-component-lifecycles for details.\n\n* Move data fetching code or side effects to componentDidUpdate.\n* If you're updating state whenever props change, refactor your code to use memoization techniques or move it to static getDerivedStateFromProps. Learn more at: https://reactjs.org/link/derived-state\n* Rename componentWillReceiveProps to UNSAFE_componentWillReceiveProps to suppress this warning in non-strict mode. In React 18.x, only the UNSAFE_ name will work.\n\nPlease update the following components: %s",
                components
            )
        end

        if next(tbl13) ~= nil then
            local components = func1(tbl13)

            console.warn(
                "componentWillUpdate has been renamed, and is not recommended for use. See https://reactjs.org/link/unsafe-component-lifecycles for details.\n\n* Move data fetching code or side effects to componentDidUpdate.\n* Rename componentWillUpdate to UNSAFE_componentWillUpdate to suppress this warning in non-strict mode. In React 18.x, only the UNSAFE_ name will work.\n\nPlease update the following components: %s",
                components
            )
        end
    end

    local tbl9 = ({})

    local tbl10 = {}

    function tbl1.recordLegacyContextWarning(arg1, arg2)
        local var1 = arg1
        local var2 = nil

        while arg1 ~= nil do
            if bit32.band(arg1.mode, StrictMode) ~= 0 then
                var2 = arg1
            end

            arg1 = arg1.return_
        end

        if var2 == nil then
            console.error(
                "Expected to find a StrictMode component in a strict mode tree. This error is likely caused by a bug in React. Please file an issue."
            )
            return
        end

        if tbl10[var1.type] then
            return
        end

        local tbl11 = tbl9[var2]

        if typeof(var1.type) == "function"
            or var1.type.contextTypes == nil
                and var1.type.childContextTypes == nil
                and (arg2 == nil or typeof(arg2.getChildContext) ~= "function")
        then
            return
        end

        if tbl11 == nil then
            tbl11 = {}

            tbl9[var2] = tbl11
        end
        table.insert(tbl11, var1)
    end

    function tbl1.flushLegacyContextWarning()
        for _, value in tbl9 do
            if #value == 0 then
                return
            end
            local var1 = value[1]

            local tbl11 = {}
            for _, value2 in value do
                tbl11[getComponentName(value2.type) or "Component"] = true
                tbl10[value2.type] = true
            end

            local str1 = func1(tbl11)

            local success, result = pcall(function()
                setCurrentFiber(var1)
                console.error(
                    "Legacy context API has been detected within a strict-mode tree.\n\nThe old API will be supported in all 16.x releases, but applications using it should migrate to the new version.\n\nPlease update the following components: %s\n\nLearn more about this warning here: https://reactjs.org/link/legacy-context",
                    str1
                )
            end)

            resetCurrentFiber()

            if not success then
                error(result)
            end
        end
    end

    function tbl1.discardPendingWarnings()
        table.clear(tbl2)
        table.clear(tbl3)
        table.clear(tbl4)
        table.clear(tbl5)
        table.clear(tbl6)
        table.clear(tbl7)
        table.clear(tbl9)
    end
end

return tbl1
