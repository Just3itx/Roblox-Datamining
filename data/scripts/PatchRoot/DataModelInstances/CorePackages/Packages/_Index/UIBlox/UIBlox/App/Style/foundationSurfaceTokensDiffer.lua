-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _StyleTypes = require(script.Parent.StyleTypes)

return function(arg1, arg2): boolean
    if arg1 == nil or arg2 == nil then
        return false
    end

    return arg1.Color.Surface.Surface_0.Color3 ~= arg2.Color.Surface.Surface_0.Color3
        or arg1.Color.Surface.Surface_100.Color3 ~= arg2.Color.Surface.Surface_100.Color3
        or arg1.Color.Surface.Surface_200.Color3 ~= arg2.Color.Surface.Surface_200.Color3
        or arg1.Color.Surface.Surface_300.Color3 ~= arg2.Color.Surface.Surface_300.Color3
end
