-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:00:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local str1 = game:DefineFastString("RccInExperienceNameSettingsEnabledAllowList", "")

local var1 = nil

return {
    isAllowListedUserId = function(arg1): boolean
        local str2 = tostring(arg1)

        if var1 == nil then
            var1 = {}
            for value in string.gmatch(str1, "[^,]+") do
                var1[value] = true
            end
        end

        return var1[str2] == true
    end
}
