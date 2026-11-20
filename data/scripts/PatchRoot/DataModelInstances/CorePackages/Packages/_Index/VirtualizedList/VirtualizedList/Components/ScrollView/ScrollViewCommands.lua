-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local _LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)

local _React = require(scriptParentParentParentParent.React)

return {
    default = {
        flashScrollIndicators = function(_)
            warn("flashScrollIndicators not implemented")
        end,
        scrollTo = function(arg1, x: number, y: number, bool1: boolean)
            if bool1 then
                arg1._nativeRef.animateScrollTo(x, y)
                return
            end
            arg1._nativeRef.current.CanvasPosition = Vector2.new(x, y)
        end,
        scrollToEnd = function(arg1, bool1: boolean)
            local x = if arg1._nativeRef.current.ScrollingDirection == Enum.ScrollingDirection.Y then 0 else arg1._nativeRef.current.AbsoluteCanvasSize.X
            local y = if arg1._nativeRef.current.ScrollingDirection ~= Enum.ScrollingDirection.Y then 0 else arg1._nativeRef.current.AbsoluteCanvasSize.Y

            if bool1 then
                arg1._nativeRef.animateScrollTo(x, y)
                return
            end
            arg1._nativeRef.current.CanvasPosition = Vector2.new(x, y)
        end,
        zoomToRect = function(_, _, _: boolean?)
            warn("zoomToRect not implemented")
        end
    }
}
