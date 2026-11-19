-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:21:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local ArgCheck = require(CorePackages.Workspace.Packages.ArgCheck)

local tbl1 = {
    50,
    128,
    150,
    256,
    512
}

return function(arg1)
    ArgCheck.isNonNegativeNumber(arg1, "Game Icon Size")

    local num1 = #tbl1

    for _, value in ipairs(tbl1) do
        if arg1 <= value then
            return value
        end
    end

    return tbl1[num1]
end
