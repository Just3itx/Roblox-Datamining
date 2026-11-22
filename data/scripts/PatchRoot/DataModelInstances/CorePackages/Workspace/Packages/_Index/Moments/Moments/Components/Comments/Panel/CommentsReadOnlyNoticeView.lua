-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:00:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Foundation = require(MomentsParent.Foundation)
local Localization = require(MomentsParent.Localization)
local React = require(MomentsParent.React)

local useLocalization = Localization.Hooks.useLocalization

local tbl1 = { readOnly = "Feature.Moments.Label.CommentsReadOnly" }

local function CommentsReadOnlyNoticeView()
    local var1 = useLocalization(tbl1)

    return React.createElement(
        Foundation.Text,
        {
            Text = var1.readOnly,
            tag = "auto-xy text-body-small content-muted",
            testId = "moments-comments-read-only"
        }
    )
end

return CommentsReadOnlyNoticeView
