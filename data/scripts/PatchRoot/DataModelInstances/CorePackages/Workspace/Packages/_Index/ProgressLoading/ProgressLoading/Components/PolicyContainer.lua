-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProgressLoadingParent = script:FindFirstAncestor("ProgressLoading").Parent

local Foundation = require(ProgressLoadingParent.Foundation)
local Localization = require(ProgressLoadingParent.Localization)
local React = require(ProgressLoadingParent.React)

local useLocalization = Localization.Hooks.useLocalization

local function PolicyContainer(tbl1)
    local var1 = useLocalization({ antiAddictionText = "Authentication.Login.WeChat.AntiAddictionText" })

    return React.createElement(Foundation.Text, {
        Position = tbl1.position,
        Text = var1.antiAddictionText,
        tag = "size-full-0 auto-y text-title-medium text-wrap text-align-x-center content-system-contrast"
    })
end

return PolicyContainer
