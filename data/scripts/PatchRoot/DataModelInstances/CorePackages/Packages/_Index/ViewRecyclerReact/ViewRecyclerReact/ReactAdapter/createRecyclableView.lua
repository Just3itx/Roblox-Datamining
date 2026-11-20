-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecyclerReact").Flags).FFlagViewRecyclerReact084
local FFlagViewRecyclerReact08 = require(script:FindFirstAncestor("ViewRecyclerReact").Flags).FFlagViewRecyclerReact08
local ViewRecyclerReact = script:FindFirstAncestor("ViewRecyclerReact")

local ComposedRecyclableView = require(ViewRecyclerReact.ReactAdapter.Private.ComposedRecyclableView)

local _CompositionPlacement = require(ViewRecyclerReact.ReactAdapter.Private.CompositionPlacement)
local CompositionPlacementSuspended = require(ViewRecyclerReact.ReactAdapter.Private.CompositionPlacementSuspended)
local React = require(ViewRecyclerReact.Parent.React)

local RecyclableViewContext = require(ViewRecyclerReact.ReactAdapter.Private.RecyclableViewContext)
local RecyclableViewReadiness = require(ViewRecyclerReact.ReactAdapter.RecyclableViewReadiness)
local RecyclableViewRegistry = require(ViewRecyclerReact.ReactAdapter.Private.RecyclableViewRegistry)

local Signals = require(ViewRecyclerReact.Parent.Signals)
local SignalsReact = require(ViewRecyclerReact.Parent.SignalsReact)
local selectViewType = require(ViewRecyclerReact.ReactAdapter.Private.selectViewType)

local signal = nil
local signal2 = nil
local signal3 = nil
local signal4 = nil
local signal5 = nil
local InlineRecyclableView = nil
local var1 = nil
local RecyclableViewComponent = nil
if not FFlagViewRecyclerReact084 then
    signal = nil
    signal2 = nil
    signal3 = nil
    signal4 = nil
    signal5 = nil
    InlineRecyclableView = nil
    var1 = nil
    RecyclableViewComponent = nil
    if not FFlagViewRecyclerReact08 then
        signal = Signals.createSignal(true)
        signal2 = Signals.createSignal(false)
        signal3 = Signals.createSignal(nil)
        signal4 = Signals.createSignal(nil)
        signal5 = Signals.createSignal(nil)

        InlineRecyclableView = function(tbl1)
            local var2 = React.useState(function()
                local var2, set = Signals.createSignal({ get = tbl1.itemSignal })

                local itemKeySignal = Signals.createSignal({})

                return {
                    context = {
                        placement = signal5,
                        assignmentSignal = signal3,
                        indexSignal = signal4,
                        itemSignal = function(arg1)
                            return var2(arg1).get(arg1)
                        end,
                        itemKeySignal = itemKeySignal
                    },
                    set = set,
                    source = tbl1.itemSignal
                }
            end)
            if var2.source ~= tbl1.itemSignal then
                var2.source = tbl1.itemSignal
                var2.set({ get = tbl1.itemSignal })
            end
            local var3 = React.useState(function()
                return {
                    binding = React.createBinding(false)
                }
            end)

            local metadata = RecyclableViewRegistry.getMetadata(tbl1.viewType)
            assert(metadata ~= nil, "createRecyclableView: unknown Recyclable view type")
            return React.createElement(RecyclableViewContext.Provider, {
                value = var2.context
            }, {
                Content = React.createElement(metadata.signalComponent, { itemSignal = var2.context.itemSignal, pending = var3.binding })
            })
        end

        var1 = React.memo(function(tbl1) -- name: InlineActiveRecyclableView
            if not SignalsReact.useSignalState(tbl1.active) then
                return nil
            end
            return React.createElement(InlineRecyclableView, tbl1)
        end)
        RecyclableViewComponent = function(tbl1)
            local var2 = React.useContext(RecyclableViewContext)
            local bool1 = var2 == false
            if bool1 or var2 == CompositionPlacementSuspended then
                var2 = nil
            end

            local var3 = if var2 == nil then signal5 else var2.placement

            local var4 = React.useState(function()
                return {}
            end)
            local var5 = React.useRef(nil)
            local var6 = React.useRef(nil)
            local var7 = React.useRef(tbl1.itemSignal)
            var7.current = tbl1.itemSignal
            local var8 = React.useRef(tbl1.active)
            var8.current = tbl1.active
            local viewType = tbl1.viewType

            React.useLayoutEffect(function()
                local var9 = nil
                local effect = Signals.createEffect(function(arg1)
                    local var10 = var3(arg1)
                    if var10 == var9 then
                        return
                    end
                    var9 = var10
                    local current = var6.current
                    if current ~= nil then
                        var6.current = nil
                        current.unregister()
                    end
                    if var2 ~= nil and var10 ~= nil then
                        var6.current = var10.register(viewType, var4, var2.assignmentSignal, var7.current, var5.current, var8.current)
                    end
                end)

                return function()
                    effect()
                    local current = var6.current
                    if current ~= nil then
                        var6.current = nil
                        current.unregister()
                    end
                end
            end, {
                var2,
                var3,
                var4,
                viewType
            })
            local itemSignal = tbl1.itemSignal
            React.useLayoutEffect(function()
                local current = var6.current
                if current ~= nil then
                    current.setItemSignal(itemSignal)
                end
            end, { itemSignal })

            local active = tbl1.active
            React.useLayoutEffect(function()
                local current = var6.current
                if current ~= nil then
                    current.setActive(active)
                end
            end, { active })

            local ref = React.useCallback(function(current)
                var5.current = current
                local current2 = var6.current
                if current2 ~= nil then
                    current2.setPlaceholder(current)
                end
            end, {})

            if bool1 then
                return React.createElement(var1, { active = active, itemSignal = itemSignal, viewType = viewType })
            end

            return React.createElement("Frame", {
                Name = "RecyclableView",
                AutomaticSize = Enum.AutomaticSize.XY,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2.new(),
                ref = ref
            })
        end
    end
end

local function createRecyclableView(signalComponent: (...any) -> (...any), tbl1)
    local tbl2 = tbl1 or {}
    local readiness = tbl2.readiness or RecyclableViewReadiness.ReadyOnAssignment
    assert(
        readiness == RecyclableViewReadiness.ReadyOnAssignment or readiness == RecyclableViewReadiness.ReadyOnCommit,
        "createRecyclableView: readiness must be ReadyOnAssignment or ReadyOnCommit"
    )

    local var3 = nil
    local var4

    if FFlagViewRecyclerReact084 then
        var4 = nil
    else
        var4 = nil
        var3 = nil
        if not FFlagViewRecyclerReact08 then
            var3 = {}
        end
    end

    local function RecyclableViewFacade(arg1)
        local active = arg1.active

        local var5 = nil
        local var6

        if FFlagViewRecyclerReact084 then
            var6 = React.useMemo(function()
                return selectViewType(active == nil or active, var4)
            end, { active })
        else
            var6 = nil
            var5 = nil
            if FFlagViewRecyclerReact08 then
                var6 = React.useMemo(function()
                    return selectViewType(active == nil or active, var4)
                end, { active })
            elseif type(active) == "function" then
                var5 = active
            elseif active == false then
                var5 = signal2
            else
                var5 = signal
            end
        end
        local createElement = React.createElement
        local var7 = if FFlagViewRecyclerReact084 then ComposedRecyclableView elseif FFlagViewRecyclerReact08 then ComposedRecyclableView else RecyclableViewComponent
        local tbl3 = { viewType = 0, itemSignal = 0, _definitionIdentity = 0, active = 0 }
        if not (FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08) then
            var6 = RecyclableViewFacade
        end

        tbl3.viewType = var6

        tbl3.itemSignal = arg1.itemSignal

        tbl3._definitionIdentity = if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then nil else var3

        if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then
            var5 = nil
        end

        tbl3.active = var5
        return createElement(var7, tbl3)
    end

    var4 = FFlagViewRecyclerReact084 and function(arg1): ((any) -> any)?
        return if arg1 then RecyclableViewFacade else nil
    end or FFlagViewRecyclerReact08 and function(arg1): ((any) -> any)?
        return if arg1 then RecyclableViewFacade else nil
    end or var4

    RecyclableViewRegistry.register(
        RecyclableViewFacade,
        {
            readiness = readiness,
            hideWhilePending = tbl2.hideWhilePending ~= false,
            signalComponent = signalComponent
        }
    )
    return RecyclableViewFacade
end

return createRecyclableView
