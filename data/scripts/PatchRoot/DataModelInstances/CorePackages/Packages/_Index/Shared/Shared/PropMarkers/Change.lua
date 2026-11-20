-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:20:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TypeRoblox = require(script.Parent.Parent["Type.roblox"])

local tbl1 = ({})

local tbl2 = {
    __tostring = function(arg1): string
        return string.format("RoactHostChangeEvent(%s)", arg1.name)
    end
}

setmetatable(tbl1, {
    __index = function(_, name)
        local tbl3 = {
            [TypeRoblox] = TypeRoblox.HostChangeEvent,
            name = name
        }

        setmetatable(tbl3, tbl2)
        tbl1[name] = tbl3

        return tbl3
    end
})

return tbl1
