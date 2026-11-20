-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function toThrow(callback: (...any) -> (...any), str1: string?, bool1: boolean?)
    local success, result = pcall(callback)

    if success then
        return { pass = false, message = "Expected function to throw" }
    end

    if typeof(str1) ~= "string" then
        return { pass = true, message = "Expected function not to throw" }
    end

    local message = nil
    if typeof(result) == "string" then
        message = result
    elseif typeof(result) == "table" and typeof(result.message) == "string" then
        message = result.message
    end

    if message == nil then
        return {
            pass = false,
            message = string.format(
                "Matcher Error:\nExpected function to throw a string or an Error object, but it threw an error of type '%s'.\nYou may wish to use `pcall` instead and run custom expectations on the returned error",
                typeof(result)
            )
        }
    end

    if message:find(str1, 1, not bool1) == nil then
        return {
            pass = false,
            message = string.format("Expected function to throw with\n'%s'\nbut threw\n'%s'\ninstead", str1, message)
        }
    end

    return {
        pass = true,
        message = string.format("Expected function not to throw with '%s'", str1)
    }
end

return toThrow
