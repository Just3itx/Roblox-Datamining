-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:50:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PromptsServerDrivenUiParent = script:FindFirstAncestor("PromptsServerDrivenUi").Parent

local HttpService = game:GetService("HttpService")
local UrlBuilder = require(PromptsServerDrivenUiParent.UrlBuilder).UrlBuilder

return function(arg1, milestoneId: string)
    return arg1(
        UrlBuilder.fromString("apis:modals-api/v1/prompts/milestones/increment")(),
        "POST",
        {
            postBody = HttpService:JSONEncode({ milestoneId = milestoneId })
        }
    )
end
