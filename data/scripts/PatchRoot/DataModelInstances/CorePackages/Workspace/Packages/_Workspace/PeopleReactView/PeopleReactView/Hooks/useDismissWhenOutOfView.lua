-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleReactView = script:FindFirstAncestor("PeopleReactView")
local PeopleReactViewParent = PeopleReactView.Parent

local React = require(PeopleReactViewParent.React)
local Signals = require(PeopleReactViewParent.Signals)
local SignalsReact = require(PeopleReactViewParent.SignalsReact)

local GetScrollingFrameStore = require(PeopleReactView.Stores.GetScrollingFrameStore)

local function isGuiObjectOutOfScrollingFrameView(num1: number, num2: number, absolutePositionY: number, absoluteSizeY: number): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local num3 = absolutePositionY + absoluteSizeY

    return num1 + num2 < absolutePositionY or num3 < num1
end

local function useDismissWhenOutOfView(bool1: boolean, callback: (...any) -> (...any), arg1)
    local var1 = SignalsReact.useSignalState(GetScrollingFrameStore)

    React.useEffect(function()
        if not bool1 then
            return
        end

        local bool2 = false

        local function dismissIfOutOfView()
            if bool2 then
                return
            end

            local current = arg1.current
            if not current then
                return
            end

            local absoluteSizeY = var1.getAbsoluteSizeY(false)
            if absoluteSizeY <= 0 then
                return
            end

            if isGuiObjectOutOfScrollingFrameView(
                current.AbsolutePosition.Y,
                current.AbsoluteSize.Y,
                var1.getAbsolutePositionY(false),
                absoluteSizeY
            ) then
                bool2 = true
                callback()
            end
        end

        local effect = Signals.createEffect(function(arg2)
            var1.getCanvasPositionY(arg2)
            var1.getAbsolutePositionY(arg2)
            var1.getAbsoluteSizeY(arg2)

            dismissIfOutOfView()
        end)

        local connection = if arg1.current then arg1.current:GetPropertyChangedSignal("AbsolutePosition"):Connect(dismissIfOutOfView) else nil

        return function()
            effect()
            if connection then
                connection:Disconnect()
            end
        end
    end, { bool1, callback, var1 })
end

return useDismissWhenOutOfView
