-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecyclerReact = script:FindFirstAncestor("ViewRecyclerReact")

local _CompositionPlacement = require(script.Parent.CompositionPlacement)
local React = require(ViewRecyclerReact.Parent.React)
local RecyclableViewContext = require(script.Parent.RecyclableViewContext)
local RecyclableViewRegistry = require(script.Parent.RecyclableViewRegistry)
local Signals = require(ViewRecyclerReact.Parent.Signals)
local SignalsReact = require(ViewRecyclerReact.Parent.SignalsReact)

local assignmentSignal = Signals.createSignal(nil)
local indexSignal = Signals.createSignal(nil)
local placement = Signals.createSignal(nil)

local function InlineRecyclableView(tbl1)
    local var1 = React.useState(function()
        local var1, set = Signals.createSignal({ get = tbl1.itemSignal })

        local itemKeySignal = Signals.createSignal({})

        return {
            context = {
                placement = placement,
                assignmentSignal = assignmentSignal,
                indexSignal = indexSignal,
                itemSignal = function(arg1)
                    return var1(arg1).get(arg1)
                end,
                itemKeySignal = itemKeySignal
            },
            set = set,
            source = tbl1.itemSignal
        }
    end)
    if var1.source ~= tbl1.itemSignal then
        var1.source = tbl1.itemSignal
        var1.set({ get = tbl1.itemSignal })
    end
    local var2 = React.useState(function()
        return {
            binding = React.createBinding(false)
        }
    end)

    return React.createElement(RecyclableViewContext.Provider, {
        value = var1.context
    }, {
        Content = React.createElement(tbl1.metadata.signalComponent, { itemSignal = var1.context.itemSignal, pending = var2.binding })
    })
end

local var1 = React.memo(function(tbl1) -- name: InlineSelectedRecyclableView
    local viewType = tbl1.viewType
    local var1 = React.useMemo(function()
        return function(arg1)
            local var1 = viewType(arg1)
            if var1 == nil then
                return nil
            end
            local metadata = RecyclableViewRegistry.getMetadata(var1)
            assert(metadata ~= nil, "createRecyclableView: unknown Recyclable view type")
            return metadata
        end
    end, { viewType })
    local metadata = SignalsReact.useSignalState(var1)
    if metadata == nil then
        return nil
    end
    return React.createElement(InlineRecyclableView, { metadata = metadata, itemSignal = tbl1.itemSignal })
end)

local function ComposedRecyclableView(tbl1)
    local var2 = React.useContext(RecyclableViewContext)
    local bool1 = var2 == false
    if bool1 then
        var2 = nil
    end

    local var3 = if var2 == nil then placement else var2.placement

    local var4 = React.useState(function()
        return {}
    end)
    local var5 = React.useRef(nil)
    local var6 = React.useRef(nil)
    local var7 = React.useRef(tbl1.itemSignal)
    var7.current = tbl1.itemSignal
    local var8 = React.useRef(tbl1.viewType)
    var8.current = tbl1.viewType

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
                var6.current = var10.register(var8.current, var4, var2.assignmentSignal, var7.current, var5.current)
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
    end, { var2, var3, var4 })

    local itemSignal = tbl1.itemSignal
    React.useLayoutEffect(function()
        local current = var6.current
        if current ~= nil then
            current.setItemSignal(itemSignal)
        end
    end, { itemSignal })

    local viewType = tbl1.viewType
    React.useLayoutEffect(function()
        local current = var6.current
        if current ~= nil then
            current.setViewType(viewType)
        end
    end, { viewType })

    local ref = React.useCallback(function(current)
        var5.current = current
        local current2 = var6.current
        if current2 ~= nil then
            current2.setPlaceholder(current)
        end
    end, {})

    if bool1 then
        return React.createElement(var1, { viewType = viewType, itemSignal = itemSignal })
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

return ComposedRecyclableView
