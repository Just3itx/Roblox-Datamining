-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local Object = require(scriptParentParentParent.LuauPolyfill).Object

local RobloxComponentProps = require(script.Parent.roblox.RobloxComponentProps)

local _ReactRobloxHostTypesRoblox = require(script.Parent["ReactRobloxHostTypes.roblox"])

local module = {
    setInitialProperties = RobloxComponentProps.setInitialProperties
}

function module.diffProperties(_, _: string, tbl1, tbl2, _)
    local var1 = nil

    for value, _ in tbl1 do
        if tbl2[value] == nil then
            var1 = var1 or table.create(2)
            table.insert(var1, value)
            table.insert(var1, Object.None)
        end
    end
    for value, value2 in tbl2 do
        local var2 = if tbl1 == nil then nil else tbl1[value]

        if value2 ~= var2 then
            var1 = var1 or table.create(2)
            table.insert(var1, value)
            table.insert(var1, value2)
        end
    end

    return var1
end

module.updateProperties = RobloxComponentProps.updateProperties
module.cleanupHostComponent = RobloxComponentProps.cleanupHostComponent

return module
