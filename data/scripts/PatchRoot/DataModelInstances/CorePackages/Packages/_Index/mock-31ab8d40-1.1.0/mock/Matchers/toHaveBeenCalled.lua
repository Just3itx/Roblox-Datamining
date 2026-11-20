-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local MagicMock = require(scriptParentParent.MagicMock)
local Spy = require(scriptParentParent.Spy)
local getCalls = require(scriptParentParent.getCalls)

return function(arg1, arg2)
    if not (MagicMock.is(arg1) or Spy.is(arg1)) then
        return {
            pass = false,
            message = string.format(
                "expect(mock) must be a MagicMock or Spy when .toHaveBeenCalled is used. Given %s instead",
                tostring(arg1)
            )
        }
    end
    local num1 = #getCalls(arg1)
    local bool1, var1

    if arg2 then
        if type(arg2) ~= "number" or not (arg2 > 0) or arg2 % 1 ~= 0 then
            return {
                pass = false,
                message = string.format("expectedTimesCalled must be a positive integer. Given %s instead.", tostring(arg2))
            }
        end

        bool1 = arg2 == num1
        var1 = bool1 and string.format("Expected %s to not have been called exactly %d times.", tostring(arg1), arg2)
            or string.format("Expected %s to have been called %d times. Was called %d times instead.", tostring(arg1), arg2, num1)
    else
        bool1 = num1 > 0
        var1 = bool1 and string.format("Expected %s to never have been called. Was called %d times instead.", tostring(arg1), num1)
            or string.format("Expected %s to have been called at least once.", tostring(arg1))
    end

    return { pass = bool1, message = var1 }
end
