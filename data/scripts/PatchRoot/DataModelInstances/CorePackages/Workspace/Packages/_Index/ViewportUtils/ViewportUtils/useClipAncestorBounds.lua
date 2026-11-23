-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewportUtilsParent = script:FindFirstAncestor("ViewportUtils").Parent
local React = require(ViewportUtilsParent.React)
local SharedFlags = require(ViewportUtilsParent.SharedFlags)

local intersectBounds = require(script.Parent.intersectBounds)

local FIntLuaAppUpdateImpressionsViewportBoundsPositionThreshold = SharedFlags.FIntLuaAppUpdateImpressionsViewportBoundsPositionThreshold
local FIntLuaAppViewportBoundsScreenSizeThreshold = SharedFlags.FIntLuaAppViewportBoundsScreenSizeThreshold

local function getGuiAncestors(arg1)
    local parent = arg1.Parent
    local guiAncestors = {}

    while parent and parent ~= game and parent:IsA("GuiObject") do
        table.insert(guiAncestors, parent)
        parent = parent.Parent
    end
    return guiAncestors
end

local function computeBounds(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local absolutePosition = arg1.AbsolutePosition
    return {
        min = absolutePosition,
        max = absolutePosition + arg1.AbsoluteSize
    }
end

local function computeClipBounds(tbl1)
    local var1 = nil
    for _, value in tbl1 do
        if not value.ClipsDescendants and value:GetStyled("ClipsDescendants") ~= true then
            continue
        end

        local tbl2 = computeBounds(value)

        if var1 then
            var1 = intersectBounds(var1, tbl2)
        else
            var1 = tbl2
        end
    end
    return var1
end

local function useClipAncestorBounds(tbl1)
    local var1, var2 = React.useState(nil)

    React.useEffect(function()
        local current = if tbl1 then tbl1.current else nil

        if not current then
            var2(nil)
            return
        end

        local tbl2 = {}
        local tbl3 = {}
        local var3 = nil

        local function cancelPendingUpdate() -- Luacid: Inlined by compiler; 2 call sites recovered
            if var3 then
                task.cancel(var3)
                var3 = nil
            end
        end

        local function scheduleUpdateBounds() -- Luacid: Inlined by compiler; 2 call sites recovered
            if var3 then
                return
            end
            var3 = task.defer(function()
                var3 = nil
                var2((computeClipBounds(tbl3)))
            end)
        end

        local function disconnectAncestorConnections()
            for _, value in tbl2 do
                if value.Connected then
                    value:Disconnect()
                end
            end
            tbl2 = {}
        end

        local function connectToAncestors()
            cancelPendingUpdate()
            disconnectAncestorConnections()

            tbl3 = getGuiAncestors(current)
            var2((computeClipBounds(tbl3)))

            for _, value in tbl3 do
                table.insert(tbl2, value:GetPropertyChangedSignal("ClipsDescendants"):Connect(connectToAncestors))

                table.insert(tbl2, value:GetStyledPropertyChangedSignal("ClipsDescendants"):Connect(connectToAncestors))

                if not value.ClipsDescendants and value:GetStyled("ClipsDescendants") ~= true then
                    continue
                end

                local absolutePosition = value.AbsolutePosition

                local tbl4 = tbl2
                local absolutePositionChanged = value:GetPropertyChangedSignal("AbsolutePosition")

                table.insert(tbl4, absolutePositionChanged:Connect(function()
                    local absolutePosition2 = value.AbsolutePosition
                    local var4 = FIntLuaAppUpdateImpressionsViewportBoundsPositionThreshold
                    local var5 = absolutePosition2 - absolutePosition
                    if math.abs(var5.X) < var4 and math.abs(var5.Y) < var4 then
                        return
                    end
                    absolutePosition = absolutePosition2
                    scheduleUpdateBounds()
                end))

                local absoluteSize = value.AbsoluteSize

                local tbl5 = tbl2
                local absoluteSizeChanged = value:GetPropertyChangedSignal("AbsoluteSize")

                table.insert(tbl5, absoluteSizeChanged:Connect(function()
                    local absoluteSize2 = value.AbsoluteSize
                    local var4 = FIntLuaAppViewportBoundsScreenSizeThreshold
                    local var5 = absoluteSize2 - absoluteSize
                    if math.abs(var5.X) < var4 and math.abs(var5.Y) < var4 then
                        return
                    end
                    absoluteSize = absoluteSize2
                    scheduleUpdateBounds()
                end))
            end
        end

        connectToAncestors()

        local connection = current.AncestryChanged:Connect(function()
            connectToAncestors()
        end)

        return function()
            cancelPendingUpdate()
            connection:Disconnect()
            disconnectAncestorConnections()
        end
    end, { tbl1 })

    return var1
end

return useClipAncestorBounds
