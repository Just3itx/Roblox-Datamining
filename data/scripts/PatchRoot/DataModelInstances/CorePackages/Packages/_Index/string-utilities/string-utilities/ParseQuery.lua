-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local StringSplit = require(script.Parent.StringSplit)

function assertIsType(was, arg1, arg2)
    if RunService:IsStudio() or _G.__TESTEZ_RUNNING_TEST__ then
        assert(typeof(was) == arg1, string.format("expects %s to be a %s! it was: %s", arg2, arg1, typeof(was)))
    end
end

local function urlDecode(arg1)
    assertIsType(arg1, "string", "input")
    local var1 = string.gsub(arg1, "%%(%x%x)", function(arg2): string
        return string.char(tonumber(arg2, 16))
    end)
    return (string.gsub(var1, "+", " "))
end

local function ParseQuery(arg1, arg2)
    if arg1 ~= nil then
        assertIsType(arg1, "string", "input")
    end
    if arg2 ~= nil then
        assertIsType(arg2, "function", "listKeyMapper")
    end

    local bool1 = type(arg2) == "function"
    local result = ({})
    if arg1 and #arg1 > 0 then
        local var1 = StringSplit(arg1, "[&;]")
        for _, value in ipairs(var1) do
            if not (value and #value > 0) then
                continue
            end

            local var2, var3 = unpack(string.split(value, "="))

            local var4 = urlDecode(var2)
            local var5 = urlDecode(if var3 == nil then "" else var3)
            if bool1 then
                if result[var4] ~= nil then
                    local var6 = arg2(var4)
                    if var6 == nil then
                        var6 = var4
                    end

                    if type(result[var6]) ~= "table" then
                        result[var6] = { result[var4] }
                    end
                    table.insert(result[var6], var5)
                    if var4 ~= var6 then
                        result[var4] = var5
                    end
                else
                    result[var4] = var5
                end
            else
                if result[var4] == nil then
                    result[var4] = {}
                end
                table.insert(result[var4], var5)
            end
        end
    end

    return result
end

return ParseQuery
