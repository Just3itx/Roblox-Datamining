-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:41:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecyclerRoblox").Flags).FFlagViewRecyclerReact084
local ViewRecyclerRoblox = script:FindFirstAncestor("ViewRecyclerRoblox")
local ViewRecycler = require(ViewRecyclerRoblox.Parent.ViewRecycler)

local CanvasItemPlacer = require(ViewRecyclerRoblox.RobloxAdapter.CanvasItemPlacer)
local HostPresentationPhase = require(ViewRecyclerRoblox.RobloxAdapter.HostPresentationPhase)
local transparentFrame = require(ViewRecyclerRoblox.RobloxAdapter.transparentFrame)

local Axis = ViewRecycler.Axis

local module = {}

function module.isPlacedFromLayoutOffsets(state): boolean
    return not (state.index == nil) and state.canvasPlacement.mainAxisOffset == nil
end

local uDim2 = UDim2.new()

local function createStackFrame(str1: string, bool1: boolean, offset: number, arg1)
    local var1 = transparentFrame(str1)
    var1.Size = if bool1 then UDim2.fromScale(1, 0) else UDim2.fromScale(0, 1)

    var1.AutomaticSize = if bool1 then Enum.AutomaticSize.Y else Enum.AutomaticSize.X
    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.FillDirection = if bool1 then Enum.FillDirection.Vertical else Enum.FillDirection.Horizontal
    uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
    uiListLayout.Padding = UDim.new(0, offset)
    uiListLayout.Parent = var1
    var1.Parent = arg1
    return var1
end

function module.new(arg1, arg2, offset: number, bool1: boolean)
    local bool2 = arg2 == Axis.Y
    local var1 = transparentFrame("ViewRecyclerStack")
    var1.Size = UDim2.fromScale(1, 1)
    local stackFrame = createStackFrame("Leading", bool2, offset, var1)
    stackFrame.AnchorPoint = if bool2 then Vector2.yAxis else Vector2.xAxis
    local stackFrame2 = createStackFrame("Trailing", bool2, offset, var1)
    var1.Parent = arg1
    local uiListLayout = stackFrame:FindFirstChildOfClass("UIListLayout")
    local uiListLayout2 = stackFrame2:FindFirstChildOfClass("UIListLayout")

    local num1 = 1
    local num2 = 0
    local num3 = 1
    local tbl1 = {}

    local tbl2 = ({})
    local num4 = 0
    local tbl3 = ({})

    local var2 = if FFlagViewRecyclerReact084 then setmetatable({}, { __mode = "k" }) else nil

    local tbl4 = ({})
    local tbl5 = ({})
    local tbl6 = {}
    local tbl7 = ({})
    local bool3 = false
    local bool4 = true
    local var3 = nil

    local function frameFor(num5: number) -- Luacid: Inlined by compiler; 3 call sites recovered
        return if num5 < num3 then stackFrame else stackFrame2
    end

    local function contains(num5: number): boolean -- Luacid: Inlined by compiler; 5 call sites recovered
        return num1 <= num5 and num5 <= num2
    end

    local function releasePlaceholder(num5: number) -- Luacid: Inlined by compiler; 2 call sites recovered
        local var4 = tbl5[num5]
        if var4 ~= nil then
            tbl5[num5] = nil
            var4.Parent = nil
            table.insert(tbl6, var4)
        end
    end

    local function refresh(layoutOrder: number)
        if not contains(layoutOrder) or (tbl4[layoutOrder] or 0) > 0 then
            releasePlaceholder(layoutOrder)
            return
        end
        local var4 = tbl5[layoutOrder]
        if var4 == nil then
            var4 = table.remove(tbl6)
            if var4 == nil then
                var4 = transparentFrame("Placeholder")
            end
            tbl5[layoutOrder] = var4
        end

        local var5 = tbl2[layoutOrder] or 0
        local num5 = math.round(var5 + (tbl1[layoutOrder] or 0)) - math.round(var5)
        local uDim2_2 = if bool2 then UDim2.new(1, 0, 0, num5) else UDim2.new(0, num5, 1, 0)

        if var4.Size ~= uDim2_2 then
            var4.Size = uDim2_2
        end
        if var4.LayoutOrder ~= layoutOrder then
            var4.LayoutOrder = layoutOrder
        end

        local var6 = frameFor(layoutOrder)

        if var4.Parent ~= var6 then
            var4.Parent = var6
        end
    end

    local function setOffset(stackFrame3, num5: number) -- Luacid: Inlined by compiler; 6 call sites recovered
        local num6 = math.round(num5 + num4)
        local uDim2_2 = if bool2 then UDim2.fromOffset(0, num6) else UDim2.fromOffset(num6, 0)

        if stackFrame3.Position ~= uDim2_2 then
            stackFrame3.Position = uDim2_2
        end
    end

    local function positionFrames() -- Luacid: Inlined by compiler; 2 call sites recovered
        local var4 = tbl2[num3] or 0
        setOffset(stackFrame, var4 - offset)
        setOffset(stackFrame2, var4)
    end

    local function setOccupying(num5: number?, num6: number?) -- Luacid: Inlined by compiler; 2 call sites recovered
        if num6 == num5 then
            return
        end
        if num6 ~= nil then
            local tbl8 = tbl4
            tbl8[num6] -= 1
            if tbl4[num6] == 0 then
                tbl4[num6] = nil
            end
            tbl7[num6] = true
        end
        if num5 ~= nil then
            tbl4[num5] = (tbl4[num5] or 0) + 1
            tbl7[num5] = true
        end
    end

    return {
        matches = function(arg3, arg4, arg5, arg6): boolean
            return var1.Parent == arg3 and arg4 == arg2 and arg5 == offset and arg6 == bool1
        end,
        setWindow = function(arg3, arg4)
            local huge = math.huge
            local huge2 = -math.huge
            local num5 = 0
            local tbl8 = ({})
            local mountedRange = arg3.mountedRange
            for _, mountedView in arg3.mountedViews do
                local state = mountedView.state
                local index = state.index

                if index == nil
                    or not (module.isPlacedFromLayoutOffsets(state) or mountedRange.firstIndex <= index and index <= mountedRange.lastIndex)
                then
                    continue
                end

                tbl8[index] = state.itemLayout.length
                if index < huge then
                    num5 = state.itemLayout.startOffset + state.contentStartOffset
                    huge = index
                end
                huge2 = math.max(huge2, index)
            end

            if huge2 < huge then
                huge = 1
                huge2 = 0
                num5 = 0
            end

            local scrollAnchor = arg3.scrollAnchor
            local var4 = if scrollAnchor == nil then huge elseif scrollAnchor.alignment == ViewRecycler.ScrollAlignment.End then scrollAnchor.index + 1 else scrollAnchor.index
            num1 = huge
            num2 = huge2
            tbl1 = tbl8
            num3 = math.clamp(var4, huge, math.max(huge, huge2 + 1))
            table.clear(tbl2)

            for i = huge, huge2 + 1 do
                tbl2[i] = num5
                num5 += (tbl8[i] or 0) + offset
            end
            num4 = arg4
            bool3 = true
            bool4 = true
            positionFrames()
        end,
        setOriginOffset = function(arg3)
            if arg3 ~= num4 then
                num4 = arg3
                positionFrames()
            end
        end,
        place = function(arg3, arg4, arg5, presented)
            local index = arg5.index
            local tbl8 = tbl3[arg3]
            if tbl8 == nil then
                tbl8 = {
                    index = index,
                    geometry = {},
                    inWindow = false,
                    visible = false,
                    restoreLayoutOrder = arg3.LayoutOrder
                }
                tbl3[arg3] = tbl8

                if FFlagViewRecyclerReact084 then
                    var2[arg3] = nil
                end
            end

            local visible = presented == HostPresentationPhase.Presented and contains(index)
            local geometry = CanvasItemPlacer.getGeometry(arg5.itemLayout, arg5.canvasPlacement, arg2, bool1, 0, tbl8.geometry)

            geometry.position = uDim2
            CanvasItemPlacer.place(arg3, frameFor(index), geometry, arg4, visible)
            local var4 = if visible then index else nil
            local index2 = if tbl8.visible then tbl8.index else nil
            setOccupying(var4, index2)
            tbl8.index = index
            tbl8.inWindow = contains(index)
            tbl8.visible = visible
            if arg3.LayoutOrder ~= index then
                arg3.LayoutOrder = index
            end
            bool4 = true
            return visible
        end,
        remove = function(arg3)
            local var4 = tbl3[arg3]
            if var4 == nil then
                return
            end
            tbl3[arg3] = nil

            if FFlagViewRecyclerReact084 then
                var2[arg3] = true
            end

            local index = if var4.visible then var4.index else nil
            setOccupying(nil, index)
            arg3.LayoutOrder = var4.restoreLayoutOrder
            bool4 = true
        end,
        isStacked = function(arg3): boolean
            return tbl3[arg3] ~= nil
        end,
        isStackFrame = FFlagViewRecyclerReact084 and function(arg3): boolean
            return arg3 == stackFrame or arg3 == stackFrame2
        end or nil,
        getStaleHosts = function()
            local staleHosts = {}
            for value, value2 in tbl3 do
                if contains(value2.index) ~= value2.inWindow or value.Parent ~= frameFor(value2.index) then
                    table.insert(staleHosts, value)
                end
            end
            return staleHosts
        end,
        takeChanged = function()
            local var4 = uiListLayout.AbsoluteContentSize + uiListLayout2.AbsoluteContentSize
            local bool5 = bool4 or var4 ~= var3
            bool4 = false
            var3 = var4
            return bool5
        end,
        commit = function()
            if not bool3 then
                for value in tbl7 do
                    refresh(value)
                end
                table.clear(tbl7)
                return
            end

            bool3 = false
            for value in tbl5 do
                if not contains(value) then
                    releasePlaceholder(value)
                end
            end

            for i = num1, num2 do
                refresh(i)
            end
            table.clear(tbl7)
        end,
        destroy = function()
            for value, value2 in tbl3 do
                value.LayoutOrder = value2.restoreLayoutOrder
            end

            if FFlagViewRecyclerReact084 then
                for value in var2 do
                    if value.Parent == stackFrame or value.Parent == stackFrame2 then
                        value.Parent = arg1
                    end
                end
                table.clear(var2)
            end
            table.clear(tbl3)
            table.clear(tbl4)
            table.clear(tbl5)
            table.clear(tbl6)
            table.clear(tbl7)
            var1:Destroy()
        end
    }
end

return module
