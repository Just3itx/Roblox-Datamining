-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:41:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContent = script:FindFirstAncestor("SduiSharedContent")

local HttpService = game:GetService("HttpService")

local SduiSharedContentParent = SduiSharedContent.Parent
local UrlBuilder = require(SduiSharedContentParent.UrlBuilder).UrlBuilder

return function(arg1, promptType: string, promptId: string?)
    return arg1(
        UrlBuilder.fromString("apis:modals-api/v1/prompts/dismiss")(),
        "POST",
        {
            postBody = HttpService:JSONEncode({ promptType = promptType, promptId = promptId })
        }
    )
end
