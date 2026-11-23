-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:01:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return {
    isCardVisibleInScrollViewport = function(arg1, arg2): boolean
        local absoluteWindowSize = arg1.AbsoluteWindowSize
        local absoluteSize = arg2.AbsoluteSize
        if not arg1.Visible or not arg2.Visible or absoluteWindowSize.X <= 0 or absoluteWindowSize.Y <= 0 then
            return false
        end
        if absoluteSize.X <= 0 or absoluteSize.Y <= 0 then
            return false
        end

        local absolutePosition = arg1.AbsolutePosition
        local var1 = absolutePosition + absoluteWindowSize
        local absolutePosition2 = arg2.AbsolutePosition
        local var2 = absolutePosition2 + absoluteSize

        return var2.X > absolutePosition.X
            and absolutePosition2.X < var1.X
            and var2.Y > absolutePosition.Y
            and absolutePosition2.Y < var1.Y
    end
}
