-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePromptParent = script:FindFirstAncestor("PurchasePrompt").Parent
local React = require(PurchasePromptParent.React)
local StyleProviderWithDefaultTheme = require(PurchasePromptParent.Style).StyleProviderWithDefaultTheme

return function(arg1, arg2)
    return React.createElement(
        StyleProviderWithDefaultTheme,
        {
            withUiModeSupport = if arg2 then arg2.withUiModeSupport else false,
            withDarkTheme = not arg2 or arg2.withDarkTheme
        },
        arg1
    )
end
