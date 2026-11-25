-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Foundation = require(scriptParentParent.Foundation)
local React = require(scriptParentParent.React)

local FoundationText = Foundation.Text

return React.memo(function(tbl1) -- name: HeaderText
    return React.createElement(
        FoundationText,
        {
            tag = "auto-xy content-emphasis text-heading-small",
            Text = tbl1.text,
            testId = "settings-header-text"
        }
    )
end)
