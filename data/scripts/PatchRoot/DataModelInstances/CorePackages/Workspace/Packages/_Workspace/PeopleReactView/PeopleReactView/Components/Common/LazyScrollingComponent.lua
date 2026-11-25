-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:30:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleReactViewParent = script:FindFirstAncestor("PeopleReactView").Parent

local React = require(PeopleReactViewParent.React)
local Signals = require(PeopleReactViewParent.Signals)

local View = require(PeopleReactViewParent.Foundation).View

local FFlagEnablePeopleListLazyRender = require(PeopleReactViewParent.PeopleService).getService("Flags").FFlagEnablePeopleListLazyRender

local num1 = game:DefineFastInt("PeoplePageLazyRenderThreshold", 100)

function LazyScrollingComponent(tbl1)
    local var1, var2 = React.useState(false)

    local var3 = React.useCallback(function(num2: number, num3: number, num4: number): boolean
        return num2 < num3 + num4 + num1
    end, {})

    local ref = React.useRef(nil)

    React.useEffect(function()
        if var1 or not ref.current then
            return
        end

        var2(
            var3(
                ref.current.AbsolutePosition.Y,
                tbl1.scrollingFrameAbsolutePositionY(false),
                tbl1.scrollingFrameAbsoluteSizeY(false)
            )
        )

        local connection = ref.current:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
            if not ref.current then
                return
            end

            var2(
                var3(
                    ref.current.AbsolutePosition.Y,
                    tbl1.scrollingFrameAbsolutePositionY(false),
                    tbl1.scrollingFrameAbsoluteSizeY(false)
                )
            )
        end)

        local effect = Signals.createEffect(function(arg1)
            tbl1.scrollingFrameCanvasPositionY(arg1)

            local var5 = tbl1.scrollingFrameAbsolutePositionY(arg1)
            local var6 = tbl1.scrollingFrameAbsoluteSizeY(arg1)

            if not ref.current then
                return
            end

            var2(var3(ref.current.AbsolutePosition.Y, var5, var6))
        end)

        return function()
            if connection then
                connection:Disconnect()
            end
            effect()
        end
    end, { var1 })

    if var1 then
        return tbl1.children
    end

    return React.createElement(View, {
        tag = if FFlagEnablePeopleListLazyRender then "size-full-0 auto-xy" else "auto-xy",
        ref = ref,
        LayoutOrder = tbl1.placeholderLayoutOrder
    }, {
        Placeholder = tbl1.placeholder
    })
end
return React.memo(LazyScrollingComponent)
