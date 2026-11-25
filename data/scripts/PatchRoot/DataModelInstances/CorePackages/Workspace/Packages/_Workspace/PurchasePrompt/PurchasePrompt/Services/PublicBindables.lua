-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:31:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.new(tbl1)
    local module2 = {}

    setmetatable(module2, {
        __tostring = function(): string
            return "Service(PublicBindables)"
        end
    })

    function module2.getWindowStateChangedBindable()
        return tbl1.windowStateChangedBindable
    end

    return module2
end

return module
