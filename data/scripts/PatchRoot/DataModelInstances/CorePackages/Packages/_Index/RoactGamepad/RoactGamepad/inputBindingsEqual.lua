-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function inputBindingsEqual(arg1, arg2)
    if arg1 == arg2 then
        return true
    end

    for k, value in pairs(arg1) do
        local var1 = arg2[k]

        if var1 == nil then
            return false
        end

        if value.kind ~= var1.kind or value.keyCode ~= var1.keyCode or value.action ~= var1.action then
            return false
        end

        local meta = value.meta
        local meta2 = var1.meta
        if meta == meta2 then
            continue
        end

        if typeof(meta) ~= "table" or typeof(meta2) ~= "table" then
            return false
        end

        for k2, value2 in pairs(meta) do
            if value2 ~= meta2[k2] then
                return false
            end
        end

        for k2 in pairs(meta2) do
            if meta[k2] == nil then
                return false
            end
        end
    end

    for k in pairs(arg2) do
        if arg1[k] == nil then
            return false
        end
    end

    return true
end

return inputBindingsEqual
