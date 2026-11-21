-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:11:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function validateProps(func1: (...any) -> (...any), arg1)
    if not _G.__DEV__ and not _G.__DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ then
        return
    end

    local var1, var2 = func1(arg1)
    if not var1 then
        local str1 = `prop validation failed: {var2}`
        error(str1)
    end
end

return validateProps
