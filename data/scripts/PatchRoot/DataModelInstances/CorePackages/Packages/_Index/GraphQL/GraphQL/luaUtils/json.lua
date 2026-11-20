-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

local function kind_of(arg1)
    if type(arg1) ~= "table" then
        return type(arg1)
    end
    local num1 = 1
    for _ in pairs(arg1) do
        if arg1[num1] == nil then
            return "table"
        end

        num1 += 1
    end

    return if num1 == 1 then "table" else "array"
end

local function escape_str(str1: string)
    local tbl1 = {
        "\\",
        "\"",
        "/",
        "b",
        "f",
        "n",
        "r",
        "t"
    }

    for i, value in ipairs({ "\\", "\"", "/", "\8", "\f", "\n", "\r", "\t" }) do
        str1 = str1:gsub(value, "\\" .. tbl1[i])
    end
    return str1
end

function module.stringify(arg1, bool1: boolean?)
    local tbl1 = {}
    local str1 = kind_of(arg1)
    if str1 == "array" then
        if bool1 then
            error("Can't encode array as key.")
        end
        tbl1[#tbl1 + 1] = "["
        for i, value in ipairs(arg1) do
            if i > 1 then
                tbl1[#tbl1 + 1] = ", "
            end
            tbl1[#tbl1 + 1] = module.stringify(value)
        end
        tbl1[#tbl1 + 1] = "]"
    elseif str1 == "table" then
        if bool1 then
            error("Can't encode table as key.")
        end
        tbl1[#tbl1 + 1] = "{"
        for k, value in pairs(arg1) do
            if #tbl1 > 1 then
                tbl1[#tbl1 + 1] = ", "
            end
            tbl1[#tbl1 + 1] = module.stringify(k, true)
            tbl1[#tbl1 + 1] = ":"
            tbl1[#tbl1 + 1] = module.stringify(value)
        end
        tbl1[#tbl1 + 1] = "}"
    else
        if str1 == "string" then
            return "\"" .. escape_str(arg1) .. "\""
        elseif str1 == "number" then
            if bool1 then
                return "\"" .. tostring(arg1) .. "\""
            end
            return tostring(arg1)
        elseif str1 == "boolean" then
            return tostring(arg1)
        elseif str1 == "nil" then
            return "null"
        end
        error("Unjsonifiable type: " .. str1 .. ".")
    end
    return table.concat(tbl1)
end

return module
