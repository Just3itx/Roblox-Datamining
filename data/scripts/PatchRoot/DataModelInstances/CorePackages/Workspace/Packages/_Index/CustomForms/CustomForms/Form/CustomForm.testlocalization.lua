-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = { ["Feature.CustomForms.Label.Percent"] = "{number}%" }

return {
    Format = function(_, str1: string, tbl2)
        local var1 = tbl1[str1] or str1

        return (string.gsub(var1, "{(%w+)}", function(str2: string): string
            if not tbl2 or tbl2[str2] == nil then
                return "{" .. str2 .. "}"
            end

            return tostring(tbl2[str2])
        end))
    end,
    GetLocale = function(): string
        return "en-us"
    end
}
