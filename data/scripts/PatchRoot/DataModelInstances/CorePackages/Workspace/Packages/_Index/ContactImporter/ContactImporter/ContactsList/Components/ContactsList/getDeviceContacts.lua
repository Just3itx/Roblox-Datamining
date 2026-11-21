-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:21:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContactImporter = script:FindFirstAncestor("ContactImporter")
local Dash = require(ContactImporter.dependencies).Dash
local _LocalTypes = require(ContactImporter.Common.LocalTypes)

local tbl1 = {}

local function func1(arg1)
    return arg1.byDeviceContactId or tbl1
end

local function func2(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(arg2)
        local var1 = arg1.hasSentRequest or tbl1

        return Dash.map(arg2, function(arg3)
            return Dash.join(arg3, { hasSentRequest = var1[arg3.id] })
        end)
    end
end

local function func3(arg1)
    return Dash.map(arg1, function(arg2)
        return Dash.join(arg2, { phoneNumber = tostring(arg2.phoneNumbers[1]), phoneNumbers = Dash.None })
    end)
end

local function func4(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(arg2)
        local result = {}

        Dash.forEach(arg2, function(arg3)
            if arg1.deviceContactToRobloxContact and arg1.deviceContactToRobloxContact[arg3.id] then
                return
            end
            result[arg3.id] = Dash.join(arg3, { deviceContactId = arg3.id, isMatchedContact = false, id = Dash.None })
        end)

        return result
    end
end

local function func5(arg1)
    return Dash.values(arg1)
end

local function stripLeadingWhitespace(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    return string.gsub(str1, "^%s*(.*)$", "%1")
end

local function func6(tbl2)
    table.sort(tbl2, function(arg1, arg2)
        if arg1.contactName and arg2.contactName then
            local var1 = stripLeadingWhitespace(string.upper(arg1.contactName))
            local var2 = stripLeadingWhitespace(string.upper(arg2.contactName))
            if var1 and var2 and var1 ~= var2 then
                return var1 < var2
            end
        end
        return arg1.deviceContactId < arg2.deviceContactId
    end)
    return tbl2
end

return function(arg1)
    local var1 = arg1 or tbl1
    local pipe = Dash.pipe
    local func7 = func2(var1)
    local func8 = func4(var1)
    return pipe(func1, func7, func3, func8, func5, func6)(var1 or {})
end
