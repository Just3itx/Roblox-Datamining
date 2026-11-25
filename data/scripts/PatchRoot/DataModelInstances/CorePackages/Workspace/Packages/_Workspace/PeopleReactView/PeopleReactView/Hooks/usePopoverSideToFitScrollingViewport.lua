-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleReactView = script:FindFirstAncestor("PeopleReactView")
local PeopleReactViewParent = PeopleReactView.Parent

local Foundation = require(PeopleReactViewParent.Foundation)
local React = require(PeopleReactViewParent.React)
local Signals = require(PeopleReactViewParent.Signals)
local SignalsReact = require(PeopleReactViewParent.SignalsReact)

local GetScrollingFrameStore = require(PeopleReactView.Stores.GetScrollingFrameStore)

local PopoverSide = Foundation.Enums.PopoverSide

local function choosePopoverSideForViewport(arg1, arg2, num1: number, num2: number, absolutePositionY: number, num3: number, num4: number, num5: number)
    if num4 <= 0 then
        return arg1
    end

    local num6 = num4 + num5
    local num7 = num1 - absolutePositionY
    local num8 = num3 - num2

    local function spaceFor(top): number -- Luacid: Inlined by compiler; 3 call sites recovered
        return if top == PopoverSide.Top then num7 else num8
    end

    local function fits(arg3): boolean -- Luacid: unused: defined but never referenced
        local num9 = spaceFor(arg3)
        return num6 <= num9
    end

    if arg2 ~= nil then
        arg1 = arg2
    end

    if num6 <= spaceFor(arg1) then
        return arg1
    end

    local var1 = if arg1 == PopoverSide.Top then PopoverSide.Bottom else PopoverSide.Top

    if num6 <= spaceFor(var1) then
        return var1
    end

    if num7 < num8 then
        return PopoverSide.Bottom
    end

    return PopoverSide.Top
end

local function usePopoverSideToFitScrollingViewport(bool1: boolean, arg1, arg2, num1: number, num2: number)
    local var1 = SignalsReact.useSignalState(GetScrollingFrameStore)
    local var2, var3 = React.useState(nil)

    React.useEffect(function()
        if not bool1 then
            var3(nil)
            return
        end

        local function updateSide()
            local current = arg2.current
            if not current then
                return
            end

            local absolutePositionY = var1.getAbsolutePositionY(false)
            local absoluteSizeY = var1.getAbsoluteSizeY(false)
            if absoluteSizeY <= 0 then
                return
            end

            local absolutePositionY2 = current.AbsolutePosition.Y
            local var4 = absolutePositionY2 + current.AbsoluteSize.Y
            local var5 = absolutePositionY + absoluteSizeY

            var3(function(arg3)
                return (choosePopoverSideForViewport(arg1, arg3, absolutePositionY2, var4, absolutePositionY, var5, num1, num2))
            end)
        end

        local effect = Signals.createEffect(function(arg3)
            var1.getCanvasPositionY(arg3)
            var1.getAbsolutePositionY(arg3)
            var1.getAbsoluteSizeY(arg3)

            updateSide()
        end)

        local tbl1 = {}
        if arg2.current then
            local absolutePositionChanged = arg2.current:GetPropertyChangedSignal("AbsolutePosition")
            table.insert(tbl1, absolutePositionChanged:Connect(updateSide))

            local absoluteSizeChanged = arg2.current:GetPropertyChangedSignal("AbsoluteSize")
            table.insert(tbl1, absoluteSizeChanged:Connect(updateSide))
        end

        return function()
            effect()
            for _, value in tbl1 do
                value:Disconnect()
            end
        end
    end, {
        bool1,
        arg1,
        num1,
        num2,
        var1
    })
    return if bool1 then var2 or arg1 else arg1
end

return usePopoverSideToFitScrollingViewport
