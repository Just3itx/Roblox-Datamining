-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:40:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecyclerReact").Flags).FFlagViewRecyclerReact084
local FFlagViewRecyclerReact08 = require(script:FindFirstAncestor("ViewRecyclerReact").Flags).FFlagViewRecyclerReact08
local ViewRecyclerReact = script:FindFirstAncestor("ViewRecyclerReact")
local _ViewRecycler = require(ViewRecyclerReact.Parent.ViewRecycler)
local _ViewRecyclerRoblox = require(ViewRecyclerReact.Parent.ViewRecyclerRoblox)

local React = require(ViewRecyclerReact.Parent.React)
local RecyclableViewRegistry = require(ViewRecyclerReact.ReactAdapter.Private.RecyclableViewRegistry)

local RecyclingScopeContext = require(ViewRecyclerReact.ReactAdapter.Private.RecyclingScopeContext)
local RecyclingScope = require(ViewRecyclerReact.ReactAdapter.RecyclingScope)

local _Signals = require(ViewRecyclerReact.Parent.Signals)

local VirtualListShell = require(ViewRecyclerReact.ReactAdapter.Private.VirtualListShell)

local _createPinnedItem = require(ViewRecyclerReact.ReactAdapter.createPinnedItem)
local useReconciledDataSource = require(ViewRecyclerReact.ReactAdapter.Private.useReconciledDataSource)
local useVirtualList = require(ViewRecyclerReact.ReactAdapter.Private.useVirtualList)

local createElement = React.createElement

return {
    create = function(tbl1) -- name: createVirtualList
        local var1 = RecyclingScope.create(tbl1)

        local function VirtualListRenderer(arg1)
            local var2 = useVirtualList(arg1)

            if arg1.scrollingFrame ~= nil then
                return nil
            end
            return createElement(VirtualListShell, var2)
        end

        local var2 = nil
        local DeclarativeVirtualList = nil
        local DataSourceVirtualList = nil
        if FFlagViewRecyclerReact084 then
            var2 = React.memo(function(arg1)
                return createElement(
                    var1,
                    {
                        maxPoolSize = arg1.maxPoolSize,
                        diagnostics = arg1.diagnostics
                    },
                    {
                        List = createElement(VirtualListRenderer, arg1)
                    }
                )
            end)
        else
            DeclarativeVirtualList = function(arg1)
                local dataSource = useReconciledDataSource(arg1.data.items, arg1.data.getItemKey)
                local var4 = table.clone(arg1)
                var4.data = nil
                var4.dataSource = dataSource
                return createElement(VirtualListRenderer, var4)
            end

            DataSourceVirtualList = function(arg1)
                local var3 = table.clone(arg1)
                var3.dataSource = arg1.data
                var3.data = nil
                return createElement(VirtualListRenderer, var3)
            end
        end

        local function VirtualList(arg1)
            local var3 = if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then nil else React.useContext(RecyclingScopeContext)
            local data = arg1.data
            assert(data ~= nil, "VirtualList: `data` is required")
            assert(arg1.itemType ~= nil, "VirtualList: `itemType` is required")
            if not RecyclableViewRegistry.isRegistered(arg1.itemType) then
                assert(type(arg1.itemType) == "function", "VirtualList: `itemType` must be a Recyclable view type or selector")

                local getItemCount = data.getItemCount
                local item = if type(getItemCount) == "function" and data.getItemCount() > 0 then data.getItem(1) elseif type(data.items) == "table" then data.items[1] else nil

                if item ~= nil then
                    assert(
                        RecyclableViewRegistry.isRegistered(arg1.itemType(item, 1)),
                        "VirtualList: `itemType` selector must return a Recyclable view type"
                    )
                end
            end

            local var4 = nil
            local element = nil
            if FFlagViewRecyclerReact084 then
                if type(data) == "table"
                    and type(data.getItemCount) == "function"
                    and type(data.getItem) == "function"
                    and type(data.getItemKey) == "function"
                then
                    var4 = type(data.subscribe) == "function"
                else
                    var4 = false
                end
            elseif type(data) == "table"
                and type(data.getItemCount) == "function"
                and type(data.getItem) == "function"
                and type(data.getItemKey) == "function"
                and type(data.subscribe) == "function"
            then
                element = createElement(DataSourceVirtualList, arg1)
            else
                local bool1 = type(data) == "table" and type(data.items) == "table" and type(data.getItemKey) == "function"
                assert(bool1, "VirtualList: `data` must be a DataSource or { items, getItemKey }")

                element = createElement(DeclarativeVirtualList, arg1)
            end

            if not (if FFlagViewRecyclerReact084 then var4 else FFlagViewRecyclerReact08) then
                if FFlagViewRecyclerReact084 then
                    local bool1 = type(data) == "table" and type(data.items) == "table" and type(data.getItemKey) == "function"
                    assert(bool1, "VirtualList: `data` must be a DataSource or { items, getItemKey }")
                elseif var3 ~= nil then
                    assert(arg1.maxPoolSize == nil, "VirtualList: configure maxPoolSize on RecyclingScope")
                    return element
                end
            end

            if not FFlagViewRecyclerReact084 then
                return createElement(var1, { maxPoolSize = arg1.maxPoolSize, diagnostics = arg1.diagnostics }, { List = element })
            end

            local var5 = useReconciledDataSource(if var4 then nil else data.items, if var4 then nil else data.getItemKey)

            local var6 = table.clone(arg1)
            var6.data = nil
            if var4 then
                var5 = data
            end

            var6.dataSource = var5
            return createElement(var2, var6)
        end

        return VirtualList
    end
}
