-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1, arg2, callback)
    local module = {}
    module.__index = module
    function module.__tostring(arg3)
        return getmetatable(arg1).__tostring(arg3)
    end

    local tbl1 = {}

    function module.new(...)
        local tbl2 = {}
        callback(tbl2, ...)
        return (setmetatable(tbl2, module))
    end

    if typeof((getmetatable(arg1))) == "table" and getmetatable(arg1).__call then
        function tbl1.__call(_, ...)
            return module.new(...)
        end
    end

    tbl1.__index = arg1
    function tbl1.__tostring(arg3)
        if arg3 == module then
            return tostring(arg2)
        end
        return getmetatable(arg1).__tostring(arg3)
    end

    setmetatable(module, tbl1)

    return module
end
