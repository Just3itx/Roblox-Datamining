-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:21:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParentParentParent = scriptParent.Parent.Parent.Parent.Parent

local React = require(scriptParentParentParentParentParent.React)

local ResponsiveLayoutContext = require(scriptParent.ResponsiveLayoutContext)
local ResponsiveLayoutConfigReader = require(scriptParent.ResponsiveLayoutConfigReader)

return function(str1: string, kind: string?)
    local var1 = React.useContext(ResponsiveLayoutContext)
    return ResponsiveLayoutConfigReader.getValue(
        {
            config = var1.config,
            breakpoint = var1.breakpoint,
            kind = kind or var1.kind
        },
        str1
    )
end
