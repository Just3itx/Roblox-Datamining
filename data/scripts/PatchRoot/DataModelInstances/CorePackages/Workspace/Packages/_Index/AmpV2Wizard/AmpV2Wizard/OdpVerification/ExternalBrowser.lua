-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LinkingService = game:GetService("LinkingService")

return {
    open = function(url: string)
        LinkingService:OpenUrl(url)
    end
}
