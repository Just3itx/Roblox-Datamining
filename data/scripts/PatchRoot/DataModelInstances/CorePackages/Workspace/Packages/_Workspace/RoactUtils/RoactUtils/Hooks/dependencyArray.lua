-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:31:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoactUtilsParent = script:FindFirstAncestor("RoactUtils").Parent

local var1 = require(RoactUtilsParent.AppCommonLib).Symbol.named("NilDependency")

local function dependencyArray(...)
    local result = ({})
    local select2 = select

    for i = 1, select2("#", ...) do
        local select = select
        local var2 = select(i, ...)
        if var2 == nil then
            var2 = var1
        end
        result[i] = var2
    end
    return result
end

return dependencyArray
