-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecyclerReact").Flags).FFlagViewRecyclerReact084
local FFlagViewRecyclerReact08 = require(script:FindFirstAncestor("ViewRecyclerReact").Flags).FFlagViewRecyclerReact08
local ViewRecyclerReact = script:FindFirstAncestor("ViewRecyclerReact")

local ComposedRecyclableView = require(ViewRecyclerReact.ReactAdapter.Private.ComposedRecyclableView)
local React = require(ViewRecyclerReact.Parent.React)
local RecyclableViewRegistry = require(ViewRecyclerReact.ReactAdapter.Private.RecyclableViewRegistry)
local Signals = require(ViewRecyclerReact.Parent.Signals)
local selectViewType = require(ViewRecyclerReact.ReactAdapter.Private.selectViewType)

local function RecyclableViewSwitch(tbl1)
    local selected = tbl1.selected
    local views = tbl1.views

    if FFlagViewRecyclerReact084 then
        local viewType = React.useMemo(function()
            for k, view in views do
                assert(
                    RecyclableViewRegistry.isRegistered(view),
                    `RecyclableViewSwitch: views.{k} is not a Recyclable view type`
                )
            end
            return selectViewType(selected, function(str1: string?)
                return if str1 == nil then nil else views[str1]
            end)
        end, { selected, views })

        return React.createElement(ComposedRecyclableView, { viewType = viewType, itemSignal = tbl1.itemSignal })
    end

    if FFlagViewRecyclerReact08 then
        local viewType = React.useMemo(function()
            for k, view in views do
                assert(
                    RecyclableViewRegistry.isRegistered(view),
                    `RecyclableViewSwitch: views.{k} is not a Recyclable view type`
                )
            end
            return selectViewType(selected, function(str1: string?)
                return if str1 == nil then nil else views[str1]
            end)
        end, { selected, views })

        return React.createElement(ComposedRecyclableView, { viewType = viewType, itemSignal = tbl1.itemSignal })
    end

    local var1 = React.useMemo(function()
        local result = ({})
        for k, view in views do
            assert(
                RecyclableViewRegistry.isRegistered(view),
                `RecyclableViewSwitch: views.{k} is not a Recyclable view type`
            )
            if type(selected) == "function" then
                result[k] = Signals.createComputed(function(arg1): boolean
                    return selected(arg1) == k
                end)
            else
                result[k] = selected == k
            end
        end
        return result
    end, { selected, views })

    local tbl2 = ({})
    for k, view in views do
        local createElement = React.createElement
        local tbl3 = {
            active = var1[k],
            itemSignal = tbl1.itemSignal
        }
        tbl2[k] = createElement(view, tbl3)
    end

    return React.createElement(React.Fragment, nil, tbl2)
end

return RecyclableViewSwitch
