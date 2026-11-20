-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function func1(_: string?) end

func1 = _G.__DEV__ and function(str1: string?)
    if str1 == nil then
        error("invariant requires an error message argument")
    end
end or func1

local function invariant(bool1: boolean, str1: string?, ...)
    func1(str1)

    if bool1 then
        return
    end

    if str1 == nil then
        error(
            "Minified exception occurred; use the non-minified dev environment for the full error message and additional helpful warnings.",
            2
        )
        return
    end

    error(string.format(str1, ...), 2)
end

return invariant
