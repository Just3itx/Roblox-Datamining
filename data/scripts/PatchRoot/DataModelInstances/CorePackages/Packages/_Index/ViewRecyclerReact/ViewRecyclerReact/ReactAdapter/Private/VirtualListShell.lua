-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:40:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecyclerReact = script:FindFirstAncestor("ViewRecyclerReact")
local ViewRecycler = require(ViewRecyclerReact.Parent.ViewRecycler)
local ViewRecyclerRoblox = require(ViewRecyclerReact.Parent.ViewRecyclerRoblox)

local Axis = ViewRecycler.Axis
local React = require(ViewRecyclerReact.Parent.React)
local ScrollbarOverlay = ViewRecyclerRoblox.Internal.ScrollbarOverlay

local createElement = React.createElement

local function VirtualListShell(tbl1)
    local var1 = React.useRef(nil)
    local function refreshScrollBar() -- Luacid: Inlined by compiler; 2 call sites recovered
        local current = var1.current
        if current ~= nil then
            var1.current = nil
            current()
        end
        local current2 = tbl1.internalRef.current
        local current3 = tbl1.viewportOverlayRef.current
        if current2 ~= nil and current3 ~= nil then
            var1.current = ScrollbarOverlay.connect(current2, current3, tbl1.axis)
        end
    end
    local tbl2 = {
        Size = UDim2.fromScale(1, 1),
        ScrollingDirection = if tbl1.axis == Axis.X then Enum.ScrollingDirection.X else Enum.ScrollingDirection.Y,
        [React.Tag] = tbl1.tag
    }
    local tbl3 = {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1)
    }
    local tbl4 = {
        CanvasSize = true,
        CanvasPosition = true,
        ref = true,
        [React.Tag] = true,
        [React.Change.AbsoluteWindowSize] = true,
        [React.Change.CanvasPosition] = true
    }

    if tbl1.scrollingFrameProps ~= nil then
        for k, scrollingFrameProp in tbl1.scrollingFrameProps do
            if tbl2[k] ~= nil or tbl4[k] then
                error(`VirtualList: {tostring(k)} is already used by ViewRecycler`)
            end
            if k == "AnchorPoint" or k == "LayoutOrder" or k == "Position" or k == "Rotation" then
                tbl3[k] = scrollingFrameProp
            else
                tbl2[k] = scrollingFrameProp
            end
        end
    end

    if tbl2.Visible ~= nil then
        tbl3.Visible = tbl2.Visible
    end
    if tbl2.ZIndex ~= nil then
        tbl3.ZIndex = tbl2.ZIndex
    end

    tbl2.ref = React.useCallback(function(current)
        tbl1.internalRef.current = current
        tbl1.onScrollingFrameChanged(current)
        refreshScrollBar()
    end, {
        tbl1.axis,
        tbl1.internalRef,
        tbl1.onScrollingFrameChanged,
        tbl1.viewportOverlayRef
    })
    local ref = React.useCallback(function(current)
        tbl1.viewportOverlayRef.current = current
        tbl1.onViewportOverlayChanged(current)
        refreshScrollBar()
    end, {
        tbl1.axis,
        tbl1.internalRef,
        tbl1.onViewportOverlayChanged,
        tbl1.viewportOverlayRef
    })

    return createElement("Frame", tbl3, {
        ScrollingFrame = createElement("ScrollingFrame", tbl2),
        ViewRecyclerOverlay = createElement("Frame", {
            Active = false,
            BackgroundTransparency = 1,
            ClipsDescendants = true,
            Name = "ViewRecyclerOverlay",
            Selectable = false,
            ZIndex = tbl2.ZIndex,
            ref = ref
        })
    })
end

return VirtualListShell
