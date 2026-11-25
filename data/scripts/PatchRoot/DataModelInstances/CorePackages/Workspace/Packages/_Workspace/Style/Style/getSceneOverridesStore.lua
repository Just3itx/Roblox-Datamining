-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local getSceneOverrides = nil
local tbl1 = {}

local tbl2 = {
    getSceneOverrides = function()
        return getSceneOverrides
    end,
    setSceneOverrides = function(arg1)
        getSceneOverrides = arg1
        for _, value in tbl1 do
            value(arg1)
        end
    end,
    subscribe = function(arg1)
        table.insert(tbl1, arg1)
        return function()
            local var2 = table.find(tbl1, arg1)
            if var2 then
                table.remove(tbl1, var2)
            end
        end
    end
}

local function getSceneOverridesStore()
    return tbl2
end

return getSceneOverridesStore
