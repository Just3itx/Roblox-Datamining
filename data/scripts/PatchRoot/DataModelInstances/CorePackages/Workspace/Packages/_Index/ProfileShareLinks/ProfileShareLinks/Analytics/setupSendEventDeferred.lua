-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:51:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileShareLinksParent = script:FindFirstAncestor("ProfileShareLinks").Parent
local getPlatformTarget = require(ProfileShareLinksParent.Analytics).getPlatformTarget

return function(arg1)
    return function(_, str1: string, str2: string, tbl1)
        if tbl1 then
            str1 = tbl1.context
        end

        arg1:sendEventDeferred(getPlatformTarget(), str1, str2, tbl1)
    end
end
