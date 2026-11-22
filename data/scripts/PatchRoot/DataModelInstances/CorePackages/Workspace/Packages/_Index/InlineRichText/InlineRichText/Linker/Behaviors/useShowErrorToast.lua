-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:10:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InlineRichText = script:FindFirstAncestor("InlineRichText")
local InlineRichTextParent = InlineRichText.Parent

local NotificationModalsManager = require(InlineRichTextParent.NotificationModalsManager)
local React = require(InlineRichTextParent.React)
local useLocalization = require(InlineRichTextParent.Localization).Hooks.useLocalization

local _Types = require(InlineRichText.Types)

return function(tbl1)
    local var1 = useLocalization({ errorToastText = "CommonUI.Messages.Response.SomethingWentWrong" })
    local toastTitle = if tbl1.errorToastTextOverride and tbl1.errorToastTextOverride ~= "" then tbl1.errorToastTextOverride else var1.errorToastText

    return React.useCallback(function()
        NotificationModalsManager.SetUIBloxToast({ toastTitle = toastTitle, sequenceNumber = DateTime.now().UnixTimestamp })
    end, { toastTitle })
end
