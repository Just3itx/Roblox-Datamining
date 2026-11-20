-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:10:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local asFocusable = require(script.Parent.asFocusable)

local function checkHostProperties(className: string)
    assert(Instance.new(className):IsA("GuiObject"))
end

local function isValidFocusable(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local str1 = typeof(arg1)
    if str1 ~= "string" then
        return str1 == "function" or str1 == "table"
    end

    local success, _result = pcall(checkHostProperties, arg1)
    return success
end

local function createFocusableCache()
    local focusableCache = ({})

    setmetatable(focusableCache, {
        __index = function(_, arg1)
            if not isValidFocusable(arg1) then
                error("Component " .. tostring(arg1) .. " (" .. typeof(arg1) .. ") is not a valid focusable component", 2)
            end

            local var1 = asFocusable(arg1)
            focusableCache[arg1] = var1

            return var1
        end,
        __tostring = function(arg1): string
            local str1 = "{"
            for k, value in pairs(arg1) do
                str1 = ("%s\n\t%s -> %s"):format(str1, tostring(k), tostring(value))
            end
            return str1 .. "\n}"
        end
    })

    return focusableCache
end

return createFocusableCache
