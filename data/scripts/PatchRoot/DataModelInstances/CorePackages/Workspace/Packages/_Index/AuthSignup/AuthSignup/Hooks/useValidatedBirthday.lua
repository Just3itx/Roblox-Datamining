-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthSignup = script:FindFirstAncestor("AuthSignup")
local AuthSignupParent = AuthSignup.Parent

local React = require(AuthSignupParent.React)
local buildValidatedBirthday = require(AuthSignup.Util.buildValidatedBirthday)

local function isSameDate(arg1, arg2): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    if arg1 == nil or arg2 == nil then
        return arg1 == arg2
    end

    return arg1.Month == arg2.Month and arg1.Day == arg2.Day and arg1.Year == arg2.Year
end

local function useValidatedBirthday(num1: number)
    local var1, var2 = React.useState(nil)
    local var3 = React.useRef(nil)

    return var1, (React.useCallback(function(num2: number?, num3: number?, num4: number?)
        local validatedBirthday = buildValidatedBirthday(num2, num3, num4, num1)
        local current = var3.current

        if if isSameDate(current, nil) or isSameDate(validatedBirthday, nil) then current == validatedBirthday else current.Month == validatedBirthday.Month
            and current.Day == validatedBirthday.Day
            and current.Year == validatedBirthday.Year then
            return
        end

        var3.current = validatedBirthday
        var2(validatedBirthday)
    end, { num1 }))
end

return useValidatedBirthday
