-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:11:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Config = require(script.Parent.Config)

local function trimTrailingNewline(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    if arg1:sub(-1, -1) == "\n" then
        return arg1:sub(1, -2)
    end

    return arg1
end

return function(arg1, arg2, arg3)
    if typeof(arg2) ~= "string" then
        error("Bad argument #2 - expected a string for the name of the library")
    end
    if typeof(arg3) ~= "table" then
        error("Bad argument #3 - expected a default config table for the library")
    end

    local tbl1 = {}
    local config = Config.new(arg3)

    function tbl1.init(arg4)
        setmetatable(tbl1, nil)

        if arg4 then
            config.set(arg4)
        end

        tbl1.Config = config.get()

        local var1 = arg1(tbl1.Config)
        for k, value in pairs(var1) do
            tbl1[k] = value
        end

        local var2 = trimTrailingNewline((debug.traceback()))
        function tbl1.init(arg5)
            if arg5 == arg4 then
                return
            end

            local var3 = trimTrailingNewline((debug.traceback()))
            warn(
                string.format(
                    "%s has already been configured\nFirst init traceback:\n%s\nCurrent init traceback:\n%s",
                    arg2,
                    var2,
                    var3
                )
            )
        end

        if _G.__UIBLOX_TRACK_USAGE__ then
            return (setmetatable(tbl1, (getmetatable(var1))))
        end

        return (setmetatable(tbl1, {
            __index = function(_, arg5)
                local str1 = ("%q (%s) is not a valid member of %s"):format(tostring(arg5), typeof(arg5), arg2)

                error(str1, 2)
            end,
            __newindex = function(_, arg5, _)
                local str1 = ("%q (%s) is not a valid member of %s"):format(tostring(arg5), typeof(arg5), arg2)

                error(str1, 2)
            end
        }))
    end

    return (setmetatable(tbl1, {
        __index = function(_, _)
            error(("You must call %s.init(config) before using it!"):format(arg2), 2)
        end,
        __newindex = function(_, _, _)
            error(("You must call %s.init(config) before using it!"):format(arg2), 2)
        end
    }))
end
