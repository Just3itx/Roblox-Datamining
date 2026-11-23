-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function asTable(arg1): {[any]: any}? -- Luacid: Inlined by compiler; 5 call sites recovered
    return if type(arg1) == "table" then arg1 else nil
end

local function decodeEmoji(arg1)
    local var1 = asTable(arg1)

    if var1 == nil then
        return nil
    end

    local id = var1.id
    if type(id) ~= "string" or id == "" then
        return nil
    end
    local name = var1.name
    return if type(name) == "string" and name ~= "" then { id = id, name = name } else nil
end

local function decodeEmojiSets(arg1)
    local result = {}
    local var1 = asTable(arg1)
    local var2 = if var1 == nil then nil else asTable(var1.emoji_sets)

    if var2 == nil then
        return result
    end

    for _, value in var2 do
        local var3 = asTable(value)
        local var4 = if var3 == nil then nil else asTable(var3.emoji_page)

        if var4 == nil then
            continue
        end

        for _, value2 in var4 do
            local var5 = decodeEmoji(value2)
            if var5 ~= nil then
                table.insert(result, var5)
            end
        end
    end

    return result
end

return decodeEmojiSets
