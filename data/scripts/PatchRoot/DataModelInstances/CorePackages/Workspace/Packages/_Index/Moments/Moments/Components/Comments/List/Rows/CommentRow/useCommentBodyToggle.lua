-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local React = require(MomentsParent.React)

local function useCommentBodyToggle(tbl1, callback: ((...any) -> (...any))?, current: string, bool1: boolean, bool2: boolean)
    local containsPoint = tbl1.containsPoint

    local var1 = React.useRef(nil)

    local var2 = React.useCallback(function(vector2: Vector2, num1: number)
        var1.current = nil
        if callback == nil or not containsPoint(vector2) then
            return
        end
        local bool3 = num1 < 2
        if not bool2 or bool3 and not bool1 then
            callback(current)
        elseif bool3 then
            var1.current = current
        end
    end, {
        callback,
        containsPoint,
        current,
        bool1,
        bool2
    })
    local var3 = React.useCallback(function()
        local current = var1.current
        var1.current = nil
        if current ~= nil and callback ~= nil then
            callback(current)
        end
    end, { callback })

    local isActive = callback ~= nil
    local isTruncatable = isActive and tbl1.isTruncatable
    local tbl2 = {
        isActive = isActive,
        canToggle = isTruncatable,
        onTap = 0,
        onSingleTapConfirmed = 0
    }

    if not isTruncatable then
        var2 = nil
    end

    tbl2.onTap = var2
    if not (isTruncatable and bool2) then
        var3 = nil
    end

    tbl2.onSingleTapConfirmed = var3
    return tbl2
end

return useCommentBodyToggle
