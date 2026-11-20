-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local var1 = require(scriptParentParentParentParent.Shared).Symbol.named("Nil")
local tbl1 = ({})

local function tryPropertyName(arg1, arg2)
    return arg1[arg2]
end

local function getDefaultInstanceProperty(className: string, arg1)
    local tbl2 = tbl1[className]

    if tbl2 then
        local var2 = tbl2[arg1]

        if var2 == var1 then
            return true, nil
        end

        if var2 ~= nil then
            return true, var2
        end
    else
        tbl2 = {}
        tbl1[className] = tbl2
    end

    local instance = Instance.new(className)
    local success, result = pcall(tryPropertyName, instance, arg1)

    instance:Destroy()

    if success then
        if result == nil then
            tbl2[arg1] = var1
            return success, result
        end
        tbl2[arg1] = result
    end

    return success, result
end

return getDefaultInstanceProperty
