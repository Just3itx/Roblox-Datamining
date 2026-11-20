-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecyclerReact").Flags).FFlagViewRecyclerReact084
local FFlagViewRecyclerReact08 = require(script:FindFirstAncestor("ViewRecyclerReact").Flags).FFlagViewRecyclerReact08
local ViewRecyclerReact = script:FindFirstAncestor("ViewRecyclerReact")
local _ViewRecycler = require(ViewRecyclerReact.Parent.ViewRecycler)

local React = require(ViewRecyclerReact.Parent.React)
local RecyclingRoot = require(ViewRecyclerReact.ReactAdapter.Private.RecyclingRoot)
local RecyclingScopeContext = require(ViewRecyclerReact.ReactAdapter.Private.RecyclingScopeContext)

local createElement = React.createElement
local PoolObserver, withPoolObserver

if FFlagViewRecyclerReact084 then
    PoolObserver = function(tbl1)
        local observePool = tbl1.observePool
        local diagnostics = tbl1.diagnostics
        React.useLayoutEffect(function()
            if diagnostics == nil then
                return nil
            end
            return observePool(diagnostics)
        end, { observePool, diagnostics })
        return nil
    end

    withPoolObserver = function(observePool: (...any) -> (...any), diagnostics, arg1)
        return createElement(
            React.Fragment,
            nil,
            createElement(PoolObserver, { observePool = observePool, diagnostics = diagnostics }),
            createElement(React.Fragment, nil, arg1)
        )
    end
else
    PoolObserver = nil
    withPoolObserver = nil
    if FFlagViewRecyclerReact08 then
        PoolObserver = function(tbl1)
            local observePool = tbl1.observePool
            local diagnostics = tbl1.diagnostics
            React.useLayoutEffect(function()
                if diagnostics == nil then
                    return nil
                end
                return observePool(diagnostics)
            end, { observePool, diagnostics })
            return nil
        end

        withPoolObserver = function(observePool: (...any) -> (...any), diagnostics, arg1)
            return createElement(
                React.Fragment,
                nil,
                createElement(PoolObserver, { observePool = observePool, diagnostics = diagnostics }),
                createElement(React.Fragment, nil, arg1)
            )
        end
    end
end

return {
    create = function(tbl1) -- name: createRecyclingScope
        local createPortal = if tbl1 == nil then nil else tbl1.createPortal
        local var1

        if FFlagViewRecyclerReact084 then
            var1 = function(tbl2) -- name: CreatedRecyclingScope
                assert(createPortal ~= nil, "RecyclingScope requires a configured portal renderer")
                local _, var2 = React.useState(0)
                local var3 = React.useRef(0)
                local var4 = React.useRef(false)
                local var5 = React.useRef(false)
                local var6 = React.useState(function()
                    return RecyclingRoot.new(function()
                        if not var4.current then
                            var2(function(arg1): number
                                return arg1 + 1
                            end)
                        end
                    end, tbl2.maxPoolSize)
                end)

                local function destroyRootIfReady()
                    if var4.current and var3.current == 0 and not var5.current then
                        var5.current = true
                        var6.destroy()
                    end
                end

                local var7 = React.useState(function()
                    return table.freeze({
                        getScope = var6.getScope,
                        observePool = var6.observePool,
                        registerConsumer = function()
                            assert(not var5.current, "RecyclingScope: cannot register after destruction")
                            var4.current = false
                            local var7 = var3
                            var7.current += 1
                            local bool1 = true
                            return function()
                                if not bool1 then
                                    return
                                end
                                bool1 = false
                                local var8 = var3
                                var8.current -= 1
                                task.defer(destroyRootIfReady)
                            end
                        end
                    })
                end)

                React.useLayoutEffect(function()
                    var6.setMaxPoolSize(tbl2.maxPoolSize)
                end, { var6, tbl2.maxPoolSize })

                React.useEffect(function()
                    var4.current = false
                    return function()
                        var4.current = true
                        task.defer(destroyRootIfReady)
                    end
                end, { var6 })

                local ref = React.useCallback(function(arg1)
                    var6.setVacantHostParent(arg1)
                end, { var6 })

                local tbl3 = {
                    Consumers = withPoolObserver(var6.observePool, tbl2.diagnostics, tbl2.children),
                    ViewRecyclerVacantHostAnchor = createElement("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false, ref = ref })
                }

                for value, value2 in var6.getPortalChildren(createPortal) do
                    tbl3[value] = value2
                end
                return createElement(RecyclingScopeContext.Provider, { value = var7 }, tbl3)
            end
        else
            var1 = nil
            var1 = FFlagViewRecyclerReact08 and function(tbl2) -- name: CreatedRecyclingScope
                assert(createPortal ~= nil, "RecyclingScope requires a configured portal renderer")
                local _, var2 = React.useState(0)
                local var3 = React.useRef(0)
                local var4 = React.useRef(false)
                local var5 = React.useRef(false)
                local var6 = React.useState(function()
                    return RecyclingRoot.new(function()
                        if not var4.current then
                            var2(function(arg1): number
                                return arg1 + 1
                            end)
                        end
                    end, tbl2.maxPoolSize)
                end)

                local function destroyRootIfReady()
                    if var4.current and var3.current == 0 and not var5.current then
                        var5.current = true
                        var6.destroy()
                    end
                end

                local var7 = React.useState(function()
                    return table.freeze({
                        getScope = var6.getScope,
                        observePool = var6.observePool,
                        registerConsumer = function()
                            assert(not var5.current, "RecyclingScope: cannot register after destruction")
                            var4.current = false
                            local var7 = var3
                            var7.current += 1
                            local bool1 = true
                            return function()
                                if not bool1 then
                                    return
                                end
                                bool1 = false
                                local var8 = var3
                                var8.current -= 1
                                task.defer(destroyRootIfReady)
                            end
                        end
                    })
                end)

                React.useLayoutEffect(function()
                    var6.setMaxPoolSize(tbl2.maxPoolSize)
                end, { var6, tbl2.maxPoolSize })

                React.useEffect(function()
                    var4.current = false
                    return function()
                        var4.current = true
                        task.defer(destroyRootIfReady)
                    end
                end, { var6 })

                local tbl3 = {
                    Consumers = withPoolObserver(var6.observePool, tbl2.diagnostics, tbl2.children)
                }
                for value, value2 in var6.getPortalChildren(createPortal) do
                    tbl3[value] = value2
                end
                return createElement(RecyclingScopeContext.Provider, { value = var7 }, tbl3)
            end or var1
        end

        local function RecyclingScope(tbl2)
            local var2 = nil
            local var3 = nil
            local var4 = nil
            local var5 = nil
            local var6 = nil
            local destroyRootIfReady = nil
            local var7 = nil
            local children = nil
            local var8

            if FFlagViewRecyclerReact084 then
                var8 = React.useContext(RecyclingScopeContext)
                if var8 == nil then
                    return createElement(var1, tbl2)
                end
            else
                var8 = nil
                var2 = nil
                var3 = nil
                var4 = nil
                var5 = nil
                var6 = nil
                destroyRootIfReady = nil
                var7 = nil
                children = nil
                if FFlagViewRecyclerReact08 then
                    var8 = React.useContext(RecyclingScopeContext)
                    if var8 == nil then
                        return createElement(var1, tbl2)
                    end
                else
                    assert(createPortal ~= nil, "RecyclingScope requires a configured portal renderer")
                    local _, var9 = React.useState(0)
                    var2 = var9
                    var3 = React.useRef(0)
                    var4 = React.useRef(false)
                    var5 = React.useRef(false)
                    var6 = React.useState(function()
                        return RecyclingRoot.new(function()
                            if not var4.current then
                                var2(function(arg1): number
                                    return arg1 + 1
                                end)
                            end
                        end)
                    end)

                    destroyRootIfReady = function()
                        if var4.current and var3.current == 0 and not var5.current then
                            var5.current = true
                            var6.destroy()
                        end
                    end

                    var7 = React.useState(function()
                        return function()
                            assert(not var5.current, "RecyclingScope: cannot register after destruction")
                            var4.current = false
                            local var10 = var3
                            var10.current += 1
                            local bool1 = true
                            return function()
                                if not bool1 then
                                    return
                                end
                                bool1 = false
                                local var11 = var3
                                var11.current -= 1
                                task.defer(destroyRootIfReady)
                            end
                        end
                    end)
                    local var10 = React.useMemo(function()
                        return {
                            root = var6,
                            listOptions = {
                                maxPoolSize = tbl2.maxPoolSize,
                                diagnostics = tbl2.diagnostics
                            },
                            registerConsumer = var7
                        }
                    end, {
                        tbl2.maxPoolSize,
                        tbl2.diagnostics,
                        var7,
                        var6
                    })
                    React.useEffect(function()
                        var4.current = false
                        return function()
                            var4.current = true
                            task.defer(destroyRootIfReady)
                        end
                    end, { var6 })

                    children = {
                        Consumers = createElement(RecyclingScopeContext.Provider, { value = var10 }, tbl2.children)
                    }
                    for value, value2 in var6.getPortalChildren(createPortal) do
                        children[value] = value2
                    end
                end
            end

            local var9 = if FFlagViewRecyclerReact084 then withPoolObserver elseif FFlagViewRecyclerReact08 then withPoolObserver else createElement
            local var10 = if FFlagViewRecyclerReact084 then var8.observePool elseif FFlagViewRecyclerReact08 then var8.observePool else React.Fragment
            local diagnostics = if FFlagViewRecyclerReact084 then tbl2.diagnostics elseif FFlagViewRecyclerReact08 then tbl2.diagnostics else nil

            if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then
                children = tbl2.children
            end

            return var9(var10, diagnostics, children)
        end

        return RecyclingScope
    end
}
