-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:31:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InputUiParent = script:FindFirstAncestor("InputUi").Parent
local _Style = require(InputUiParent.Style)

return function(_, _)
    return {
        designWidth = 1920,
        imageWidth = 580,
        imageHeight = 450,
        textContainerWidth = 850,
        horizontalInnerPadding = 78,
        verticalPadding = 96
    }
end
