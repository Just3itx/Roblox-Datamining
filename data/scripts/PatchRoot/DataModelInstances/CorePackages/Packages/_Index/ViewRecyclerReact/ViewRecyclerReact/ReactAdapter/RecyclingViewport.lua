-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecyclerReact").Flags).FFlagViewRecyclerReact084
local FFlagViewRecyclerReact08 = require(script:FindFirstAncestor("ViewRecyclerReact").Flags).FFlagViewRecyclerReact08
local ViewRecyclerReact = script:FindFirstAncestor("ViewRecyclerReact")
local ViewRecycler = require(ViewRecyclerReact.Parent.ViewRecycler)
local ViewRecyclerRoblox = require(ViewRecyclerReact.Parent.ViewRecyclerRoblox)

local Axis = ViewRecycler.Axis
local React = require(ViewRecyclerReact.Parent.React)
local RecyclingScope = require(ViewRecyclerReact.ReactAdapter.RecyclingScope)

local RecyclingScopeContext = require(ViewRecyclerReact.ReactAdapter.Private.RecyclingScopeContext)
local RecyclingViewportContext = require(ViewRecyclerReact.ReactAdapter.Private.RecyclingViewportContext)

local createElement = React.createElement
local ShallowTable = ViewRecycler.Adapter._Private.ShallowTable
local var1 = table.freeze({ "axis", "activationMargin", "retentionMargin" })

local function assignRef(scrollingFrameRef, current) -- Luacid: Inlined by compiler; 1 call site recovered
    if scrollingFrameRef == nil then
        return
    end

    if type(scrollingFrameRef) == "function" then
        scrollingFrameRef(current)
    else
        scrollingFrameRef.current = current
    end
end

return {
    create = function(arg1) -- name: createRecyclingViewport
        local var2 = RecyclingScope.create(arg1)

        local function RecyclingViewport(tbl1)
            local var3 = if FFlagViewRecyclerReact084 or FFlagViewRecyclerReact08 then nil else React.useContext(RecyclingScopeContext)

            local var4 = React.useState(function()
                return {
                    axis = tbl1.axis,
                    activationMargin = tbl1.activationMargin,
                    retentionMargin = tbl1.retentionMargin
                }
            end)
            assert(
                ShallowTable.containsEqual(tbl1, var4, var1),
                "RecyclingViewport: axis and margins cannot change during its lifetime"
            )

            local var5 = React.useState(function()
                return ViewRecyclerRoblox.ViewportCoordinator.new(var4)
            end)
            local value = React.useState(function()
                return {
                    register = var5.register
                }
            end)
            local scrollingFrameRef = tbl1.scrollingFrameRef
            local ref = React.useCallback(function(current)
                var5.setViewport(current)
                assignRef(scrollingFrameRef, current)
            end, { var5, scrollingFrameRef })

            React.useEffect(function()
                return function()
                    var5.destroy()
                end
            end, { var5 })

            local tbl2 = {
                Size = UDim2.fromScale(1, 1),
                ScrollingDirection = if tbl1.axis == Axis.X then Enum.ScrollingDirection.X else Enum.ScrollingDirection.Y,
                ref = ref
            }
            if tbl1.scrollingFrameProps ~= nil then
                for k, scrollingFrameProp in tbl1.scrollingFrameProps do
                    if tbl2[k] ~= nil then
                        error(`RecyclingViewport: {tostring(k)} is already used by ViewRecycler`)
                    end
                    tbl2[k] = scrollingFrameProp
                end
            end

            local viewport = createElement(
                RecyclingViewportContext.Provider,
                { value = value },
                {
                    Viewport = createElement("ScrollingFrame", tbl2, tbl1.children)
                }
            )
            if not FFlagViewRecyclerReact084 and not FFlagViewRecyclerReact08 and var3 ~= nil then
                assert(
                    tbl1.maxPoolSize == nil and tbl1.diagnostics == nil,
                    "RecyclingViewport: configure recycling options on the ancestor RecyclingScope"
                )

                return viewport
            end

            return createElement(var2, { maxPoolSize = tbl1.maxPoolSize, diagnostics = tbl1.diagnostics }, { Viewport = viewport })
        end

        return RecyclingViewport
    end
}
