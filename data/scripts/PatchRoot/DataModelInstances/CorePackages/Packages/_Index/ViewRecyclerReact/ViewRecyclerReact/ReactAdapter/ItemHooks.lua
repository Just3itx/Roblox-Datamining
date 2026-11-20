-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecyclerReact").Flags).FFlagViewRecyclerReact084
local ViewRecyclerReact = script:FindFirstAncestor("ViewRecyclerReact")

local React = require(ViewRecyclerReact.Parent.React)
local RecyclableViewContext = require(ViewRecyclerReact.ReactAdapter.Private.RecyclableViewContext)
local Signals = require(ViewRecyclerReact.Parent.Signals)

local tbl1 = {}

local function initialize(initialState) -- Luacid: Inlined by compiler; 6 call sites recovered
    if type(initialState) == "function" then
        return (initialState())
    end

    return initialState
end

local function useRecyclableViewContext() -- Luacid: Inlined by compiler; 5 call sites recovered
    local var1 = React.useContext(RecyclableViewContext)
    assert(type(var1) == "table", "Recycling hooks must be called within a Recyclable view")
    return var1
end

function tbl1.useRecyclingItem()
    local var1 = useRecyclableViewContext()
    return var1.itemSignal
end

function tbl1.useRecyclingAssignment()
    local var1 = useRecyclableViewContext()
    return var1.assignmentSignal
end

function tbl1.useRecyclingIndex()
    local var1 = useRecyclableViewContext()
    return var1.indexSignal
end

local function sameValues(values, tbl2) -- Luacid: Inlined by compiler; 4 call sites recovered
    if #values ~= #tbl2 then
        return false
    end
    for value, value2 in tbl2 do
        if values[value] ~= value2 then
            return false
        end
    end
    return true
end

local useRecyclingDependencies = nil
local readValues = nil
local useRecyclingToken = nil
if FFlagViewRecyclerReact084 then
    useRecyclingDependencies = function(tbl2)
        local var1 = table.create(#(tbl2 or {}) + 1)
        var1[1] = useRecyclableViewContext().itemKeySignal
        if tbl2 ~= nil then
            for _, value in tbl2 do
                table.insert(var1, value)
            end
        end
        return var1
    end

    readValues = function(tbl2, arg1)
        local var1 = table.create(#tbl2)
        for value, value2 in tbl2 do
            var1[value] = value2(arg1)
        end
        return var1
    end
else
    useRecyclingToken = function(tbl2)
        local itemKeySignal = useRecyclableViewContext().itemKeySignal
        local var1 = table.create(#(tbl2 or {}) + 1)
        var1[1] = itemKeySignal
        if tbl2 ~= nil then
            for _, value in tbl2 do
                table.insert(var1, value)
            end
        end

        local values = table.create(#var1)
        for value, value2 in var1 do
            values[value] = value2(false)
        end
        local tbl3, var3 = React.useState(function()
            return {
                token = {},
                values = values
            }
        end)

        if not sameValues(tbl3.values, values) then
            tbl3 = {
                token = {},
                values = values
            }
            var3(tbl3)
        end

        React.useLayoutEffect(function()
            return Signals.createEffect(function(arg1)
                local var2 = table.create(#var1)
                for value, value2 in var1 do
                    var2[value] = value2(arg1)
                end
                var3(function(arg2)
                    return if sameValues(arg2.values, var2) then arg2 else {
                        token = {},
                        values = var2
                    }
                end)
            end)
        end, var1)

        return tbl3.token
    end
end

function tbl1.useRecyclingState(initialState, tbl2, func1: ((...any) -> (...any))?)
    local var1 = nil
    local var2 = nil
    local var3 = nil
    if FFlagViewRecyclerReact084 then
        var1 = useRecyclingDependencies(tbl2)
        var2 = readValues(var1, false)
    else
        var3 = useRecyclingToken(tbl2)
    end
    local tbl3, var4 = React.useState(function()
        return {
            token = FFlagViewRecyclerReact084 and {} or var3,
            values = if FFlagViewRecyclerReact084 then var2 else nil,
            value = initialize(initialState)
        }
    end)

    local bool1

    if FFlagViewRecyclerReact084 then
        local values = tbl3.values
        local var5 = var2
        local bool2

        if #values == #var5 then
            bool2 = true

            for value, value2 in var5 do
                if values[value] ~= value2 then
                    bool2 = false
                    break
                end
            end
        else
            bool2 = false
        end

        bool1 = not bool2
    elseif tbl3.token == var3 then
        bool1 = false
    else
        bool1 = true
    end

    if bool1 then
        tbl3 = {
            token = FFlagViewRecyclerReact084 and {} or var3,
            values = if FFlagViewRecyclerReact084 then var2 else nil,
            value = initialize(initialState)
        }
        var4(tbl3)
    end

    local var5 = nil
    if FFlagViewRecyclerReact084 then
        var5 = React.useRef({ initialState = initialState, resetCallback = func1 })
        React.useLayoutEffect(function()
            var5.current = { initialState = initialState, resetCallback = func1 }
        end)
        React.useLayoutEffect(function()
            return Signals.createEffect(function(arg1)
                local values = readValues(var1, arg1)
                var4(function(arg2)
                    if sameValues(arg2.values, values) then
                        return arg2
                    end

                    return {
                        token = {},
                        values = values,
                        value = initialize(var5.current.initialState)
                    }
                end)
            end)
        end, var1)

        var3 = tbl3.token
    end
    local var6 = React.useRef(false)

    local var7 = if FFlagViewRecyclerReact084 then nil else React.useRef(func1)

    React.useLayoutEffect(function()
        if not FFlagViewRecyclerReact084 then
            var7.current = func1
            return
        end

        if not var6.current then
            var6.current = true
            return
        end

        local resetCallback = var5.current.resetCallback
        if resetCallback ~= nil then
            resetCallback()
        end
    end, { if FFlagViewRecyclerReact084 then var3 else func1 })

    local var8 = nil
    if not FFlagViewRecyclerReact084 then
        React.useLayoutEffect(function()
            if var6.current then
                local current = var7.current
                if current ~= nil then
                    current()
                end
            else
                var6.current = true
            end
        end, { var3 })

        var8 = var3
    end

    local var9 = React.useCallback(function(arg1)
        var4(function(arg2)
            if arg2.token ~= (if FFlagViewRecyclerReact084 then var3 else var8) then
                return arg2
            end

            local value = if type(arg1) == "function" then arg1(arg2.value) else arg1
            return {
                token = arg2.token,
                values = if FFlagViewRecyclerReact084 then arg2.values else nil,
                value = value
            }
        end)
    end, { if FFlagViewRecyclerReact084 then var3 else var8 })
    return tbl3.value, var9
end

function tbl1.useRecyclingSignal(initialState, tbl2, resetCallback: ((...any) -> (...any))?)
    local var1 = nil
    local var2 = nil
    if FFlagViewRecyclerReact084 then
        var1 = useRecyclingDependencies(tbl2)
    else
        var2 = useRecyclingToken(tbl2)
    end
    local var3 = React.useState(function()
        local getter, setter = Signals.createSignal((initialize(initialState)))
        return {
            getter = getter,
            setter = setter,
            values = if FFlagViewRecyclerReact084 then readValues(var1, false) else nil,
            unmounted = not FFlagViewRecyclerReact084 and nil,
            committedToken = if FFlagViewRecyclerReact084 then nil else var2
        }
    end)

    local var4 = nil
    local var5 = nil
    local var6 = nil
    if FFlagViewRecyclerReact084 then
        var4 = React.useRef({ initialState = initialState, resetCallback = resetCallback })
        React.useLayoutEffect(function()
            var4.current = { initialState = initialState, resetCallback = resetCallback }
        end)
        React.useLayoutEffect(function()
            var3.unmounted = false
            return function()
                var3.unmounted = true
            end
        end, { var3 })
        React.useLayoutEffect(function()
            return Signals.createEffect(function(arg1)
                local values = readValues(var1, arg1)

                if sameValues(var3.values, values) then
                    return
                end
                var3.values = values
                var3.setter((initialize(var4.current.initialState)))
                local resetCallback2 = var4.current.resetCallback
                if resetCallback2 ~= nil then
                    resetCallback2()
                end
            end)
        end, var1)
    else
        var5 = React.useRef(false)
        React.useLayoutEffect(function()
            if not var5.current then
                var5.current = true
                return
            end

            var3.committedToken = var2
            var3.setter((initialize(initialState)))
            if resetCallback ~= nil then
                resetCallback()
            end
        end, { var2 })

        var6 = var2
    end

    local var7 = React.useCallback(function(arg1)
        if if FFlagViewRecyclerReact084 then not var3.unmounted else var3.committedToken == var6 then
            var3.setter(arg1)
        end
    end, FFlagViewRecyclerReact084 and { var3 } or { var6, var3 })
    return var3.getter, var7
end

return table.freeze(tbl1)
