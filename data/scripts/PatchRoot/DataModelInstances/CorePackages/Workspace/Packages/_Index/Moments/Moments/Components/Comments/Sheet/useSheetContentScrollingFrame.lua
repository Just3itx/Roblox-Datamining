-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local React = require(MomentsParent.React)

local function useSheetContentScrollingFrame(bool1: boolean)
    local var1, var2 = React.useState(nil)
    local var3 = React.useRef(nil)
    local var4 = React.useCallback(function(scrollingFrame)
        local current = var3.current
        if scrollingFrame ~= nil and (current == nil or current.scrollingFrame ~= scrollingFrame) then
            var3.current = {
                scrollingFrame = scrollingFrame,
                canvasSize = scrollingFrame.CanvasSize
            }
        end
        var2(scrollingFrame)
    end, {})

    React.useLayoutEffect(function()
        local current = var3.current
        if not bool1 and current ~= nil and current.scrollingFrame == var1 then
            current.scrollingFrame.CanvasSize = current.canvasSize
        end
    end, { bool1, var1 })

    return var1, var4
end

return useSheetContentScrollingFrame
