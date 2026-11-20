-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecyclerReact = script:FindFirstAncestor("ViewRecyclerReact")

local Axis = require(ViewRecyclerReact.Parent.ViewRecycler).Axis
local ItemHooks = require(ViewRecyclerReact.ReactAdapter.ItemHooks)
local React = require(ViewRecyclerReact.Parent.React)
local RecyclableViewReadiness = require(ViewRecyclerReact.ReactAdapter.RecyclableViewReadiness)
local SignalsReact = require(ViewRecyclerReact.Parent.SignalsReact)
local _VirtualList = require(ViewRecyclerReact.ReactAdapter.VirtualList)
local createRecyclableView = require(ViewRecyclerReact.ReactAdapter.createRecyclableView)

local createElement = React.createElement

local function createItemViewType(tbl1)
    local component = tbl1.component
    return createRecyclableView(function(arg1)
        local var1 = ItemHooks.useRecyclingAssignment()
        local var2 = SignalsReact.useSignalState(var1)
        local var3 = SignalsReact.useSignalState(ItemHooks.useRecyclingIndex())
        local var4 = React.useRef(nil)
        local var5 = React.useRef(nil)
        if var2 ~= nil then
            var4.current = var2
        end
        if var3 ~= nil then
            var5.current = var3
        end
        local current = var4.current
        local current2 = var5.current
        if current == nil or current2 == nil then
            return nil
        end
        return createElement(component, { item = current.value, index = current2, pending = arg1.pending })
    end, {
        readiness = tbl1.readiness or RecyclableViewReadiness.ReadyOnCommit,
        hideWhilePending = tbl1.hideWhilePending
    })
end

return {
    create = function(arg1)
        return function(tbl1)
            assert(type(tbl1) == "table", "createVirtualList: definition must be a table")
            local func1

            if tbl1.itemComponent ~= nil then
                assert(type(tbl1.itemComponent) == "function", "createVirtualList: itemComponent must be a React component")

                assert(tbl1.itemComponents == nil, "createVirtualList: choose one definition form")
                func1 = createItemViewType(
                    {
                        component = tbl1.itemComponent,
                        readiness = tbl1.readiness,
                        hideWhilePending = tbl1.hideWhilePending
                    }
                )
            else
                local itemComponents = tbl1.itemComponents
                local getItemComponent = tbl1.getItemComponent
                assert(
                    type(itemComponents) == "table" and #itemComponents > 0,
                    "createVirtualList: itemComponents must be a non-empty array"
                )

                assert(type(getItemComponent) == "function", "createVirtualList: getItemComponent must be a function")
                local tbl2 = ({})
                for _, itemComponent in itemComponents do
                    local component = itemComponent.component
                    assert(type(component) == "function", "createVirtualList: component must be a React component")
                    assert(tbl2[component] == nil, "createVirtualList: each component may be declared only once")

                    tbl2[component] = createItemViewType(itemComponent)
                end
                func1 = function(arg2, arg3)
                    local itemComponent = getItemComponent(arg2, arg3)
                    local var1 = tbl2[itemComponent]
                    assert(var1 ~= nil, "createVirtualList: getItemComponent returned an undeclared component")
                    return var1
                end
            end

            local function SpecializedVirtualList(arg2)
                assert(arg2.pinnedStartItem == nil and arg2.pinnedEndItem == nil, "createVirtualList: pinned Items require VirtualList")

                local var1 = table.clone(arg2)
                var1.axis = arg2.axis or Axis.Y
                var1.itemType = func1
                return createElement(arg1, var1)
            end

            return SpecializedVirtualList
        end
    end
}
