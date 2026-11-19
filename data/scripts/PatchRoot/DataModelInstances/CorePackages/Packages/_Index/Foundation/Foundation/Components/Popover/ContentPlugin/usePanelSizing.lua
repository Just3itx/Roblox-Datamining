-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:31:40Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Constants = require(Foundation.Constants)
local _Types = require(Foundation.Providers.StudioPanels.Types)
local _PopoverAlign = require(Foundation.Enums.PopoverAlign)
local _PopoverSide = require(Foundation.Enums.PopoverSide)
local React = require(FoundationParent.React)
local positioning = require(script.Parent.Parent.positioning)

local SHADOW_SIZE = Constants.SHADOW_SIZE

local function useConnectSignals(arg1, tbl1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    React.useLayoutEffect(function()
        local tbl2 = ({})
        if arg1 ~= nil then
            for _, value in tbl1 do
                tbl2[value] = arg1:GetPropertyChangedSignal(value):Connect(type(arg2) == "table" and function()
                    arg2.current()
                end or arg2)
            end
        end

        return function()
            for _, value in tbl2 do
                value:Disconnect()
            end
        end
    end, { arg1, arg2 })
end

local function usePanelSizing(arg1, arg2, num1: number?, num2: number?, num3: number?)
    local var1, var2 = React.useBinding(UDim2.new())
    local var3, var4 = React.useBinding(UDim2.new())

    local var5 = React.useRef(nil)
    local var6 = React.useRef(function() end)

    local current = React.useCallback(function()
        if not num1 then
            return
        end

        local absoluteSize = num1.AbsoluteSize
        local var7 = if type(arg1) == "table" then arg1.position else arg1
        local var8 = if type(arg1) ~= "table" then 0 else arg1.offset

        local var9 = if type(arg2) ~= "table" then 0 else arg2.offset

        local var10 = positioning.calculatePopoverBounds(var7, var8, var9, num2 or 0, absoluteSize) + Vector2.new(SHADOW_SIZE * 2, SHADOW_SIZE * 2)

        var4(UDim2.fromOffset(absoluteSize.X, absoluteSize.Y))
        var2(UDim2.fromOffset(var10.X, var10.Y))

        local _absolutePosition = num1.AbsolutePosition

        if not num3 then
            return
        end

        if var5.current then
            task.cancel(var5.current)
        end
        var5.current = task.spawn(function()
            num3.setSizeAsync(var10)
        end)
    end, {
        num1,
        arg1,
        arg2,
        num2,
        num3
    })
    var6.current = current
    useConnectSignals(num1, { "AbsoluteSize" }, var6)

    React.useLayoutEffect(function()
        current()
    end, { current })

    React.useEffect(function()
        return function()
            if var5.current then
                task.cancel(var5.current)
            end
        end
    end, {})

    return var1, var3
end

return usePanelSizing
