-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function buildHomePromptClientAttributes(tbl1)
    local var1 = tbl1 or game:GetService("AppStorageService")
    local homePromptClientAttributes = ({})

    local success, result = pcall(var1.GetItem, var1, "KidsAccountHasResetToDefaultTheme")
    if success and typeof(result) == "string" and result ~= "" then
        homePromptClientAttributes.KidsAccountHasResetToDefaultTheme = result
    end

    return homePromptClientAttributes
end

return buildHomePromptClientAttributes
