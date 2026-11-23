-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function nonEmpty(str1: string?): string? -- Luacid: Inlined by compiler; 2 call sites recovered
    return if str1 == nil or str1 == "" then nil else str1
end

local function resolveMomentShareCardMetadataText(str1: string?, str2: string?, str3: string?)
    local var1 = nonEmpty(str1) or nonEmpty(str2)

    if not var1 then
        if str3 ~= nil and str3 ~= "" then
            return str3
        end

        var1 = nil
    end

    return var1
end

return resolveMomentShareCardMetadataText
