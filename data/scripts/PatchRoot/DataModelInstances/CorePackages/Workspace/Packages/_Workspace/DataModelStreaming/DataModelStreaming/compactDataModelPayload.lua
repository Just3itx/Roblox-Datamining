-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    "-inf",
    "-inf",
    "inf",
    "inf"
}
local tbl2 = { 0, 0 }

local tbl3 = {
    0,
    0,
    0,
    0
}

local function roundToDecimalPrecision(num1: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    if num1 >= 0 then
        return math.floor(num1 * 100000 + 0.5) / 100000
    end
    return math.ceil(num1 * 100000 - 0.5) / 100000
end

local function applyNumericPrecision(arg1)
    if typeof(arg1) == "number" then
        return roundToDecimalPrecision(arg1)
    end
    if typeof(arg1) ~= "table" then
        return arg1
    end

    local result = ({})
    for value, value2 in arg1 do
        result[value] = applyNumericPrecision(value2)
    end
    return result
end

local function toVectorCode(tbl4)
    local num1 = #tbl4

    if num1 ~= 2 and num1 ~= 4 then
        return nil
    end

    if num1 == 4 and tbl4[1] == "-inf" and tbl4[2] == "-inf" and tbl4[3] == "inf" and tbl4[4] == "inf" then
        return 0
    end

    for _, value in tbl4 do
        if typeof(value) ~= "number" or value ~= 0 then
            return nil
        end
    end

    return if num1 == 2 then 1 else 2
end

local function getSchemaName(str1: string, arg1): string -- Luacid: Inlined by compiler; 2 call sites recovered
    local str2 = typeof(arg1)

    local str3 = str2 ~= "number" and (if str2 == "boolean" then "b_" else "s_") or (if arg1 % 1 == 0 then "i_" else "n_")

    return (if str2 == "table" then "v_" else str3) .. str1
end

local function compressPackedProperties(tbl4): string
    local num1 = 0
    for value, value2 in tbl4 do
        if value2 ~= "" then
            num1 = value
        end
    end

    if num1 == 0 then
        return ""
    end

    local num2 = 1
    local tbl5 = {}

    while num2 <= num1 do
        if tbl4[num2] == "" then
            local num3 = num2

            while num2 <= num1 and tbl4[num2] == "" do
                num2 += 1
            end
            local num4 = num2 - num3
            if num4 > 2 then
                table.insert(tbl5, "-" .. tostring(num4))
            else
                for _ = 1, num4 do
                    table.insert(tbl5, "")
                end
            end
        else
            table.insert(tbl5, tbl4[num2])
            num2 += 1
        end
    end

    return table.concat(tbl5, ",")
end

local function collectSchema(tbl4)
    local tbl5 = {}

    local function collectProperties(tbl6)
        for value, value2 in tbl6.Properties do
            if value2 ~= nil then
                tbl5[getSchemaName(value, value2)] = true
            end
        end
        for _, child in tbl6.Children do
            collectProperties(child)
        end
    end

    collectProperties(tbl4)

    local tbl6 = {}
    for value, _ in tbl5 do
        table.insert(tbl6, value)
    end
    table.sort(tbl6)

    local tbl7 = ({})
    for value, value2 in tbl6 do
        tbl7[value2] = value
    end

    return tbl6, tbl7
end

local function compactDataModelPayload(tbl4)
    local schema, tbl6 = collectSchema(tbl4)

    local tbl7 = ({})
    local mappings = { [0] = tbl1, [1] = tbl2, [2] = tbl3 }

    local num1 = 3

    local function serializeMappingValue(arg1)
        local str1 = typeof(arg1)
        if str1 == "nil" then
            return "nil"
        elseif str1 == "boolean" then
            return if arg1 then "b:1" else "b:0"
        elseif str1 == "number" then
            return "n:" .. tostring(arg1)
        elseif str1 == "string" then
            return "s:" .. arg1
        end

        if str1 ~= "table" then
            return str1 .. ":" .. tostring(arg1)
        end

        local num2 = #arg1
        local var1 = table.create(num2)
        for i = 1, num2 do
            var1[i] = serializeMappingValue(arg1[i])
        end

        local tbl9 = {}
        for value, value2 in arg1 do
            if typeof(value) ~= "number" or value < 1 or num2 < value or value % 1 ~= 0 then
                table.insert(tbl9, serializeMappingValue(value) .. "=" .. serializeMappingValue(value2))
            end
        end
        table.sort(tbl9)
        return "t:[" .. table.concat(var1, ",") .. "]{" .. table.concat(tbl9, ",") .. "}"
    end

    local function mapValue(arg1)
        if typeof(arg1) == "table" then
            local var1 = toVectorCode(arg1)
            if var1 ~= nil then
                return var1
            end
        end

        local var1 = serializeMappingValue(arg1)
        local var2 = tbl7[var1]
        if var2 ~= nil then
            return var2
        end

        while mappings[num1] ~= nil do
            num1 += 1
        end

        local num2 = num1
        num1 += 1
        tbl7[var1] = num2
        mappings[num2] = arg1
        return num2
    end

    local function encodeProperties(properties): string
        local tbl9 = ({})
        for i = 1, #schema do
            tbl9[i] = ""
        end
        for value, value2 in properties do
            if value2 == nil then
                continue
            end

            local schemaName = getSchemaName(value, value2)
            local var1 = tbl6[schemaName]
            if var1 ~= nil then
                tbl9[var1] = tostring((mapValue((applyNumericPrecision(value2)))))
            end
        end

        return compressPackedProperties(tbl9)
    end

    local tbl9 = {}
    local num2 = 1

    local function appendNode(tbl10, parentId: number)
        local id = num2
        num2 += 1

        local tbl11 = {
            id = id,
            parentId = parentId,
            p = encodeProperties(tbl10.Properties)
        }
        local str1 = `{tbl11.id},{tbl11.parentId}`
        if tbl11.p ~= "" then
            str1 ..= `,{tbl11.p}`
        end
        table.insert(tbl9, str1)

        for _, child in tbl10.Children do
            appendNode(child, id)
        end
    end

    local str1 = encodeProperties(tbl4.Properties)
    local str2 = "0,-1"
    if str1 ~= "" then
        str2 ..= `,{str1}`
    end
    table.insert(tbl9, str2)

    for _, child in tbl4.Children do
        appendNode(child, 0)
    end

    return {
        mappings = mappings,
        root = table.concat(tbl9, "\n"),
        schema = schema
    }
end

return compactDataModelPayload
