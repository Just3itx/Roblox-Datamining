-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:40:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecyclerReact").Flags).FFlagViewRecyclerReact084
local FFlagViewRecyclerReact08 = require(script:FindFirstAncestor("ViewRecyclerReact").Flags).FFlagViewRecyclerReact08
local ViewRecyclerReact = script:FindFirstAncestor("ViewRecyclerReact")
local ViewRecyclerRoblox = require(ViewRecyclerReact.Parent.ViewRecyclerRoblox)

local React = require(ViewRecyclerReact.Parent.React)
local RecyclableViewContext = require(ViewRecyclerReact.ReactAdapter.Private.RecyclableViewContext)
local RecyclableViewReadiness = require(ViewRecyclerReact.ReactAdapter.RecyclableViewReadiness)
local RecyclableViewRegistry = require(ViewRecyclerReact.ReactAdapter.Private.RecyclableViewRegistry)
local ReparentableHost = ViewRecyclerRoblox.ReparentableHost
local _RecyclableView = require(ViewRecyclerReact.ReactAdapter.Private.RecyclableView)
local SignalsReact = require(ViewRecyclerReact.Parent.SignalsReact)

local createElement = React.createElement

local function CommitObserver(tbl1)
    local itemView = tbl1.itemView
    local var1 = SignalsReact.useSignalState(itemView.contentRevision)
    React.useLayoutEffect(function()
        itemView.commitContent(var1)
    end, { var1, itemView.commitContent })
    return nil
end

return (React.memo(function(tbl1) -- name: RecyclableViewHost
    local itemView = tbl1.itemView
    local signal = itemView.signal
    local var1 = itemView.portalFrame(false)
    assert(var1 ~= nil, "RecyclableViewHost: view host was destroyed before unmount")
    local value = React.useState(function()
        return {
            placement = itemView.compositionPlacement,
            assignmentSignal = signal,
            indexSignal = itemView.indexSignal,
            itemSignal = itemView.itemSignal,
            itemKeySignal = itemView.itemKeySignal
        }
    end)

    React.useLayoutEffect(function()
        local detachFromPlaceholder = if FFlagViewRecyclerReact084 then nil else not FFlagViewRecyclerReact08 and function(arg1) -- name: detachFromPlaceholder
            if var1.Parent == arg1 then
                ReparentableHost.detach(var1)
            end
        end or nil

        local bindHost = itemView.bindHost

        local tbl2 = {
            clearSelection = function()
                ReparentableHost.clearSelection(var1)
            end,
            detachFromPlaceholder = 0
        }

        if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then
            detachFromPlaceholder = nil
        end

        tbl2.detachFromPlaceholder = detachFromPlaceholder
        local var3 = bindHost(tbl2)

        return function()
            ReparentableHost.detach(var1)
            var3()
        end
    end, { itemView, var1 })

    local metadata = RecyclableViewRegistry.getMetadata(itemView.itemViewType)
    assert(metadata ~= nil, "RecyclableViewHost: unknown Recyclable view type")
    local content = React.useMemo(function()
        return createElement(metadata.signalComponent, { itemSignal = itemView.itemSignal, pending = itemView.pending })
    end, { itemView, metadata })

    local var4 = SignalsReact.useSignalState(itemView.hasItem)
    React.useLayoutEffect(function()
        if not var4 then
            return nil
        end
        itemView.setContentMounted(true)
        return function()
            itemView.setContentMounted(false)
        end
    end, { var4, itemView })
    local tbl2 = {}
    if var4 then
        tbl2.Content = content
    end
    if var4 and metadata.readiness == RecyclableViewReadiness.ReadyOnCommit then
        tbl2.Observer = createElement(CommitObserver, { itemView = itemView })
    end
    local element = createElement(RecyclableViewContext.Provider, { value = value }, tbl2)

    return tbl1.createPortal(element, var1)
end))
