-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:01:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return {
    rectangle = function(arg1, arg2)
        return { top = arg2, bottom = arg2, left = arg1, right = arg1 }
    end,
    square = function(arg1)
        return { top = arg1, bottom = arg1, left = arg1, right = arg1 }
    end,
    quad = function(top, right, bottom, left)
        return { top = top, bottom = bottom, left = left, right = right }
    end
}
