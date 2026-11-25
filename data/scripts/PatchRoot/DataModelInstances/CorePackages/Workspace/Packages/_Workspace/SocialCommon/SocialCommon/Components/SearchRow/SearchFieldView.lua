-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:11:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCommonParent = script:FindFirstAncestor("SocialCommon").Parent
local React = require(SocialCommonParent.React)
local Foundation = require(SocialCommonParent.Foundation)

local SearchInput = Foundation.SearchInput

local function SearchFieldView(tbl1)
    local testId = tbl1.testId or "SearchField"

    return React.createElement(Foundation.View, {
        tag = "size-full-0 auto-y",
        testId = `{testId}View`,
        LayoutOrder = tbl1.LayoutOrder,
        ref = tbl1.containerRef
    }, {
        Input = React.createElement(SearchInput, {
            text = tbl1.text,
            placeholder = tbl1.placeholder,
            onChanged = tbl1.onChanged,
            onFocusGained = tbl1.onFocusGained,
            onFocusLost = tbl1.onFocusLost,
            ref = tbl1.inputRef,
            width = UDim.new(1, 0),
            testId = `{testId}Input`
        })
    })
end

return SearchFieldView
