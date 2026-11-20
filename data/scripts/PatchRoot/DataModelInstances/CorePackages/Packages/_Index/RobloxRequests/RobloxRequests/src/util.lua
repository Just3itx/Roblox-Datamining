-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.deprecate(arg1, arg2, arg3)
    return function(...)
        if arg2 then
            warn(
                ("[http] %s deprecated in version %s. See documentation at http://requests.paric.xyz/"):format(arg3, arg2 or "Function")
            )
        else
            warn(("[http] %s deprecated. See documentation at http://requests.paric.xyz/"):format(arg3 or "Function"))
        end

        return arg1(...)
    end
end

return module
