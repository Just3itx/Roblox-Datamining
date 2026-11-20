-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local _PopoverAlign = require(Foundation.Enums.PopoverAlign)
local _PopoverSide = require(Foundation.Enums.PopoverSide)
local React = require(FoundationParent.React)
local positioning = require(script.Parent.positioning)

local _Types = require(Foundation.Components.Types)

local function useConnectSignals(arg1, tbl1, arg2)
    local var1 = React.useRef({})

    React.useLayoutEffect(function()
        if arg1 ~= nil then
            for _, value in tbl1 do
                local var2 = if typeof(arg1) == "Instance" then arg1:GetPropertyChangedSignal(value) else arg1:GetPropertyChangedSignal(value)

                var1.current[value] = var2:Connect(type(arg2) == "table" and function()
                    arg2.current()
                end or arg2)
            end
        end

        return function()
            for _, value in var1.current do
                value:Disconnect()
            end
        end
    end, { arg1, arg2 })
end

local function useFloating(bool1: boolean, arg1, arg2, arg3, arg4, arg5, num1: number?)
    local var1, var2 = React.useBinding(Vector2.new())
    local var3, var4 = React.useBinding(true)
    local var5, var6 = React.useBinding(UDim2.new())
    local var7, var8 = React.useBinding(Vector2.new())
    local var9, var10 = React.useBinding(Vector2.new())
    local var11, var12 = React.useBinding(Vector2.new(0, 0))
    local var13 = React.useRef(function() end)
    local var14 = React.useRef({})
    local var15 = React.useRef(false)

    local var16 = React.useCallback(function()
        if not (bool1 and arg1 and arg2 and arg3) then
            var4(false)
            return
        end

        local absolutePosition = arg1.AbsolutePosition
        local absoluteSize = arg1.AbsoluteSize

        local absoluteSize2 = arg2.AbsoluteSize

        local absoluteSize3 = arg3.AbsoluteSize
        local absolutePosition2 = arg3.AbsolutePosition
        local rect = Rect.new(absolutePosition, absolutePosition + absoluteSize)
        local rect2 = Rect.new(absolutePosition2, absolutePosition2 + absoluteSize3)

        if not positioning.isOnScreen(rect, rect2) then
            var4(false)
            return
        end

        local var16 = nil

        for _, value in var14.current do
            local rect3 = Rect.new(value.AbsolutePosition, value.AbsolutePosition + value.AbsoluteSize)

            if var16 == nil then
                var16 = rect3
            else
                var16 = Rect.new(
                    Vector2.new(math.max(var16.Min.X, rect3.Min.X), math.max(var16.Min.Y, rect3.Min.Y)),
                    Vector2.new(math.min(var16.Max.X, rect3.Max.X), math.min(var16.Max.Y, rect3.Max.Y))
                )
            end
        end
        if var16 and not positioning.isOnScreen(rect, var16) then
            var4(false)
            return
        end

        local var17 = if type(arg4) == "table" then arg4.position else arg4
        local var18 = if type(arg4) ~= "table" then 0 else arg4.offset
        local var19 = arg5
        local offset

        if type(arg5) == "table" then
            var19 = arg5.position
            offset = arg5.offset
        else
            offset = 0
        end

        local num2 = num1 or 0

        local popoverBounds = positioning.calculatePopoverBounds(var17, var18, offset, num2, absoluteSize2)

        local side = positioning.calculateSide(var17, rect, rect2, popoverBounds)

        local var20, var21, var22 = positioning.calculatePositions(side, var18, var19, offset, rect, rect2, num2, absoluteSize2)

        var6(UDim2.fromOffset(absoluteSize2.X, absoluteSize2.Y))
        var8(absoluteSize3)
        var10(var21 + var20)
        var2(var20)
        var12(var22)
        var4(true)

        local _absolutePosition = arg2.AbsolutePosition
    end, {
        bool1,
        arg1,
        arg2,
        arg3,
        arg4,
        arg5,
        num1
    })

    function var13.current()
        if var15.current then
            return
        end
        var15.current = true
        task.defer(function()
            var15.current = false
            var16()
        end)
    end
    useConnectSignals(arg1, { "AbsolutePosition", "AbsoluteSize" }, var13)
    useConnectSignals(arg2, { "AbsoluteSize" }, var13)
    useConnectSignals(arg3, { "AbsoluteSize" }, var13)
    React.useLayoutEffect(function()
        if not bool1 then
            return
        end
        if typeof(arg1) ~= "Instance" or not arg1:IsA("GuiObject") then
            return
        end
        local guiObject = arg1
        local var17 = var14
        local tbl1 = {}

        local function rebuild()
            for _, value in tbl1 do
                value:Disconnect()
            end
            table.clear(tbl1)

            local guiObjectParent = guiObject.Parent
            local current = {}

            while guiObjectParent and guiObjectParent:IsA("GuiObject") do
                if guiObjectParent.ClipsDescendants then
                    table.insert(current, guiObjectParent)

                    local tbl3 = tbl1
                    local absolutePositionChanged = guiObjectParent:GetPropertyChangedSignal("AbsolutePosition")

                    table.insert(tbl3, absolutePositionChanged:Connect(function()
                        var13.current()
                    end))

                    local tbl4 = tbl1
                    local absoluteSizeChanged = guiObjectParent:GetPropertyChangedSignal("AbsoluteSize")

                    table.insert(tbl4, absoluteSizeChanged:Connect(function()
                        var13.current()
                    end))
                end

                guiObjectParent = guiObjectParent.Parent
            end

            var17.current = current

            if #current > 0 then
                var13.current()
            end
        end

        rebuild()
        local connection = guiObject.AncestryChanged:Connect(rebuild)

        return function()
            connection:Disconnect()
            for _, value in tbl1 do
                value:Disconnect()
            end
            var17.current = {}
        end
    end, { arg1, bool1 })

    React.useLayoutEffect(function()
        var16()
    end, { var16 })

    return var1, var3, var5, var9, var7, var11
end

return useFloating
