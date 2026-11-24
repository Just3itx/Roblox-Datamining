-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")

local function openWebview(url: string)
    local str1 = HttpService:JSONEncode({ title = "", presentationStyle = 2, visible = true, url = url })

    GuiService:BroadcastNotification(str1, 20)
end

return openWebview
