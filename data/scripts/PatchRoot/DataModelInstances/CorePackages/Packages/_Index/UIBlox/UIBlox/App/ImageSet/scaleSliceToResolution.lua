-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:40:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1, arg2)
    if arg1.SliceCenter then
        local min = arg1.SliceCenter.Min * arg2
        local max = arg1.SliceCenter.Max * arg2
        arg1.SliceCenter = Rect.new(min, max)
        arg1.SliceScale = (arg1.SliceScale or 1) / arg2
    end

    return arg1
end
