-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecyclerReact").Flags).FFlagViewRecyclerReact084
local FFlagViewRecyclerReact08 = require(script:FindFirstAncestor("ViewRecyclerReact").Flags).FFlagViewRecyclerReact08
local ViewRecyclerReact = script:FindFirstAncestor("ViewRecyclerReact")
local ViewRecycler = require(ViewRecyclerReact.Parent.ViewRecycler)

local CompositionPlacement = require(script.Parent.CompositionPlacement)
local React = require(ViewRecyclerReact.Parent.React)
local RecyclableView = require(script.Parent.RecyclableView)
local RecyclableViewHost = require(ViewRecyclerReact.ReactAdapter.RecyclableViewHost)
local RecyclableViewRegistry = require(script.Parent.RecyclableViewRegistry)
local SignalsExperimental = require(ViewRecyclerReact.Parent.SignalsExperimental)

local VacantHosts = if FFlagViewRecyclerReact084 then require(ViewRecyclerReact.Parent.ViewRecyclerRoblox).Internal.VacantHosts else nil

local createElement = React.createElement

local tbl1 = {}

if FFlagViewRecyclerReact084 then
    function tbl1.new(callback: (...any) -> (...any), num1: number?)
        local tbl2 = ({})
        local num2 = 1
        local bool1 = false
        local var1 = nil
        local var2 = num1
        local tbl3 = {}
        local tbl4 = ({})

        local tbl5 = {
            onPoolChanged = function(arg1)
                if #tbl3 == 0 then
                    return
                end
                local tbl5 = {
                    kind = ViewRecycler.Diagnostics.EventKind.PoolChanged,
                    action = arg1.action,
                    itemViewType = arg1.viewType,
                    occupiedDelta = arg1.occupiedDelta,
                    vacantDelta = arg1.vacantDelta,
                    totalDelta = arg1.totalDelta
                }
                for _, value in table.clone(tbl3) do
                    value(tbl5)
                end
            end
        }
        local compositionPlacement = nil
        local vacantHosts = VacantHosts.new()

        local function notifyChanged() -- Luacid: Inlined by compiler; 2 call sites recovered
            if not bool1 then
                callback()
            end
        end

        local tbl6 = {
            allocateId = function(): number
                assert(not bool1, "RecyclingRoot: cannot allocate after destroy")
                local num3 = num2
                num2 += 1
                return num3
            end,
            addHosts = function(arg1, arg2, arg3)
                assert(not bool1, "RecyclingRoot: cannot add hosts after destroy")
                local bool2 = false
                for _, value in arg1 do
                    assert(tbl2[value] == nil, "RecyclingRoot: resource host is already registered")
                    local tbl6 = tbl2
                    local tbl7 = {
                        key = arg2(value),
                        render = arg3(value)
                    }
                    tbl6[value] = tbl7
                    bool2 = true
                end

                if bool2 then
                    notifyChanged()
                end
            end,
            removeHosts = function(arg1)
                local bool2 = false
                for _, value in arg1 do
                    if tbl2[value] ~= nil then
                        tbl2[value] = nil
                        bool2 = true
                    end
                end

                if bool2 then
                    notifyChanged()
                end
            end
        }

        return {
            getScope = function()
                assert(not bool1, "RecyclingRoot: cannot get a Recycling scope after destroy")
                if var1 ~= nil then
                    return var1
                end

                tbl5.adapter = {
                    create = function(arg1)
                        assert(RecyclableViewRegistry.isRegistered(arg1), "RecyclingScope: cannot create an unregistered Recyclable view type")

                        return RecyclableView(tbl6.allocateId(), arg1, nil, compositionPlacement)
                    end,
                    destroy = function(arg1)
                        arg1.destroy()
                    end,
                    onCreated = function(arg1)
                        tbl6.addHosts(arg1, function(arg2): string
                            return `RecyclableView{arg2.id}`
                        end, function(itemView)
                            return function(createPortal)
                                return createElement(RecyclableViewHost, { itemView = itemView, createPortal = createPortal })
                            end
                        end)
                    end,
                    onEvicted = function(arg1)
                        tbl6.removeHosts(arg1)
                    end,
                    batch = SignalsExperimental.batch,
                    isDestroyed = function(arg1)
                        return arg1.isHostDestroyed()
                    end
                }
                local recyclingScope = ViewRecycler.Adapter.createRecyclingScope(tbl5)
                local tbl7 = {
                    bind = function(arg1)
                        local var3 = table.clone(arg1)
                        var3.capacity = var2
                        return recyclingScope.bind(var3)
                    end,
                    dispose = recyclingScope.dispose
                }

                var1 = tbl7
                VacantHosts.register(tbl7, vacantHosts)
                compositionPlacement = CompositionPlacement.new(tbl7)
                return var1
            end,
            setMaxPoolSize = function(arg1)
                if arg1 == var2 then
                    return
                end
                var2 = arg1
                if var1 == nil then
                    return
                end

                var1.bind({ releases = {}, requests = {} })
            end,
            observePool = function(arg1)
                local var3 = tbl4[arg1]
                if var3 == nil then
                    table.insert(tbl3, arg1)
                end
                tbl4[arg1] = (var3 or 0) + 1
                local bool2 = true
                return function()
                    if not bool2 then
                        return
                    end
                    bool2 = false
                    local var4 = tbl4[arg1] - 1
                    if var4 > 0 then
                        tbl4[arg1] = var4
                        return
                    end
                    tbl4[arg1] = nil
                    table.remove(tbl3, table.find(tbl3, arg1))
                end
            end,
            getPortalChildren = function(arg1)
                local portalChildren = {}
                for _, value in tbl2 do
                    portalChildren[value.key] = value.render(arg1)
                end
                return portalChildren
            end,
            setVacantHostParent = function(arg1)
                if not bool1 then
                    vacantHosts.setParent(arg1)
                end
            end,
            destroy = function()
                if bool1 then
                    return
                end
                bool1 = true
                if compositionPlacement ~= nil then
                    compositionPlacement.destroy()
                end
                compositionPlacement = nil
                if var1 ~= nil then
                    var1.dispose()
                end
                var1 = nil
                vacantHosts.destroy()
                table.clear(tbl2)
            end
        }
    end
elseif FFlagViewRecyclerReact08 then
    function tbl1.new(callback: (...any) -> (...any), num1: number?)
        local tbl2 = ({})
        local num2 = 1
        local bool1 = false
        local var1 = nil
        local var2 = num1
        local tbl3 = {}
        local tbl4 = ({})

        local tbl5 = {
            onPoolChanged = function(arg1)
                if #tbl3 == 0 then
                    return
                end
                local tbl5 = {
                    kind = ViewRecycler.Diagnostics.EventKind.PoolChanged,
                    action = arg1.action,
                    itemViewType = arg1.viewType,
                    occupiedDelta = arg1.occupiedDelta,
                    vacantDelta = arg1.vacantDelta,
                    totalDelta = arg1.totalDelta
                }
                for _, value in table.clone(tbl3) do
                    value(tbl5)
                end
            end
        }
        local compositionPlacement = nil

        local function notifyChanged() -- Luacid: Inlined by compiler; 2 call sites recovered
            if not bool1 then
                callback()
            end
        end

        local tbl6 = {
            allocateId = function(): number
                assert(not bool1, "RecyclingRoot: cannot allocate after destroy")
                local num3 = num2
                num2 += 1
                return num3
            end,
            addHosts = function(arg1, arg2, arg3)
                assert(not bool1, "RecyclingRoot: cannot add hosts after destroy")
                local bool2 = false
                for _, value in arg1 do
                    assert(tbl2[value] == nil, "RecyclingRoot: resource host is already registered")
                    local tbl6 = tbl2
                    local tbl7 = {
                        key = arg2(value),
                        render = arg3(value)
                    }
                    tbl6[value] = tbl7
                    bool2 = true
                end

                if bool2 then
                    notifyChanged()
                end
            end,
            removeHosts = function(arg1)
                local bool2 = false
                for _, value in arg1 do
                    if tbl2[value] ~= nil then
                        tbl2[value] = nil
                        bool2 = true
                    end
                end

                if bool2 then
                    notifyChanged()
                end
            end
        }

        return {
            getScope = function()
                assert(not bool1, "RecyclingRoot: cannot get a Recycling scope after destroy")
                if var1 ~= nil then
                    return var1
                end

                tbl5.adapter = {
                    create = function(arg1)
                        assert(RecyclableViewRegistry.isRegistered(arg1), "RecyclingScope: cannot create an unregistered Recyclable view type")

                        return RecyclableView(tbl6.allocateId(), arg1, nil, compositionPlacement)
                    end,
                    destroy = function(arg1)
                        arg1.destroy()
                    end,
                    onCreated = function(arg1)
                        tbl6.addHosts(arg1, function(arg2): string
                            return `RecyclableView{arg2.id}`
                        end, function(itemView)
                            return function(createPortal)
                                return createElement(RecyclableViewHost, { itemView = itemView, createPortal = createPortal })
                            end
                        end)
                    end,
                    onEvicted = function(arg1)
                        tbl6.removeHosts(arg1)
                    end,
                    batch = SignalsExperimental.batch,
                    isDestroyed = function(arg1)
                        return arg1.isHostDestroyed()
                    end
                }
                local recyclingScope = ViewRecycler.Adapter.createRecyclingScope(tbl5)
                local tbl7 = {
                    bind = function(arg1)
                        local var3 = table.clone(arg1)
                        var3.capacity = var2
                        return recyclingScope.bind(var3)
                    end,
                    dispose = recyclingScope.dispose
                }

                var1 = tbl7
                compositionPlacement = CompositionPlacement.new(tbl7)
                return var1
            end,
            setMaxPoolSize = function(arg1)
                if arg1 == var2 then
                    return
                end
                var2 = arg1
                if var1 == nil then
                    return
                end

                var1.bind({ releases = {}, requests = {} })
            end,
            observePool = function(arg1)
                local var3 = tbl4[arg1]
                if var3 == nil then
                    table.insert(tbl3, arg1)
                end
                tbl4[arg1] = (var3 or 0) + 1
                local bool2 = true
                return function()
                    if not bool2 then
                        return
                    end
                    bool2 = false
                    local var4 = tbl4[arg1] - 1
                    if var4 > 0 then
                        tbl4[arg1] = var4
                        return
                    end
                    tbl4[arg1] = nil
                    table.remove(tbl3, table.find(tbl3, arg1))
                end
            end,
            getPortalChildren = function(arg1)
                local portalChildren = {}
                for _, value in tbl2 do
                    portalChildren[value.key] = value.render(arg1)
                end
                return portalChildren
            end,
            destroy = function()
                if bool1 then
                    return
                end
                bool1 = true
                if compositionPlacement ~= nil then
                    compositionPlacement.destroy()
                end
                compositionPlacement = nil
                if var1 ~= nil then
                    var1.dispose()
                end
                var1 = nil
                table.clear(tbl2)
            end
        }
    end
else
    function tbl1.new(callback: (...any) -> (...any), _: number?)
        local tbl2 = ({})
        local num1 = 1
        local bool1 = false
        local var1 = nil

        local function notifyChanged() -- Luacid: Inlined by compiler; 2 call sites recovered
            if not bool1 then
                callback()
            end
        end

        local tbl3 = {
            allocateId = function(): number
                assert(not bool1, "RecyclingRoot: cannot allocate after destroy")
                local num2 = num1
                num1 += 1
                return num2
            end,
            addHosts = function(arg1, arg2, arg3)
                assert(not bool1, "RecyclingRoot: cannot add hosts after destroy")
                local bool2 = false
                for _, value in arg1 do
                    assert(tbl2[value] == nil, "RecyclingRoot: resource host is already registered")
                    local tbl3 = tbl2
                    local tbl4 = {
                        key = arg2(value),
                        render = arg3(value)
                    }
                    tbl3[value] = tbl4
                    bool2 = true
                end

                if bool2 then
                    notifyChanged()
                end
            end,
            removeHosts = function(arg1)
                local bool2 = false
                for _, value in arg1 do
                    if tbl2[value] ~= nil then
                        tbl2[value] = nil
                        bool2 = true
                    end
                end

                if bool2 then
                    notifyChanged()
                end
            end
        }

        return {
            getScope = function(tbl4)
                assert(not bool1, "RecyclingRoot: cannot get a Recycling scope after destroy")
                if var1 ~= nil then
                    return var1
                end

                local maxPoolSize = tbl4.maxPoolSize
                local recyclingScope = ViewRecycler.Adapter.createRecyclingScope({
                    onPoolChanged = tbl4.diagnostics ~= nil and function(arg1)
                        tbl4.diagnostics({
                            kind = ViewRecycler.Diagnostics.EventKind.PoolChanged,
                            action = arg1.action,
                            itemViewType = arg1.viewType,
                            occupiedDelta = arg1.occupiedDelta,
                            vacantDelta = arg1.vacantDelta,
                            totalDelta = arg1.totalDelta
                        })
                    end or nil,
                    adapter = {
                        create = function(arg1)
                            local metadata = RecyclableViewRegistry.getMetadata(arg1)
                            assert(metadata ~= nil, "RecyclingScope: cannot create an unregistered Recyclable view type")

                            return RecyclableView(tbl3.allocateId(), arg1, nil, metadata.readiness, metadata.hideWhilePending)
                        end,
                        destroy = function(arg1)
                            arg1.destroy()
                        end,
                        onCreated = function(arg1)
                            tbl3.addHosts(arg1, function(arg2): string
                                return `RecyclableView{arg2.id}`
                            end, function(itemView)
                                return function(createPortal)
                                    return createElement(RecyclableViewHost, { itemView = itemView, createPortal = createPortal })
                                end
                            end)
                        end,
                        onEvicted = function(arg1)
                            tbl3.removeHosts(arg1)
                        end,
                        batch = SignalsExperimental.batch
                    }
                })
                var1 = {
                    bind = function(arg1)
                        local var2 = table.clone(arg1)
                        if var2.updateCapacity then
                            maxPoolSize = var2.capacity
                            var2.updateCapacity = nil
                        elseif var2.capacity == nil then
                            var2.capacity = maxPoolSize
                        else
                            maxPoolSize = var2.capacity
                        end
                        return recyclingScope.bind(var2)
                    end,
                    dispose = recyclingScope.dispose
                }

                return var1
            end,
            getPortalChildren = function(arg1)
                local portalChildren = {}
                for _, value in tbl2 do
                    portalChildren[value.key] = value.render(arg1)
                end
                return portalChildren
            end,
            destroy = function()
                if bool1 then
                    return
                end
                bool1 = true
                if var1 ~= nil then
                    var1.dispose()
                end
                var1 = nil
                table.clear(tbl2)
            end
        }
    end
end

return tbl1
