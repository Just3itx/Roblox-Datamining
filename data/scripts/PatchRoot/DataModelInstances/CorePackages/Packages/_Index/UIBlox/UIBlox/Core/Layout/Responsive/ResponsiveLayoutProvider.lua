-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:21:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParentParentParent = scriptParent.Parent.Parent.Parent.Parent

local React = require(scriptParentParentParentParentParent.React)

local ResponsiveLayoutContext = require(scriptParent.ResponsiveLayoutContext)
local ResponsiveLayoutConfigReader = require(scriptParent.ResponsiveLayoutConfigReader)

local function ResponsiveLayoutProvider(tbl1)
    local width = tbl1.width or 1
    local config = tbl1.config or {}

    local var1, var2 = React.useState(function()
        return ResponsiveLayoutConfigReader.findBreakpoint(config, width)
    end)

    React.useLayoutEffect(function()
        var2(ResponsiveLayoutConfigReader.findBreakpoint(config, width))
    end, { config })

    React.useLayoutEffect(function()
        local min = var1.min

        if width < min or width > var1.max then
            var2(ResponsiveLayoutConfigReader.findBreakpoint(config, width))
        end
    end, { width, var1.min, var1.max })

    return React.createElement(
        ResponsiveLayoutContext.Provider,
        {
            value = {
                config = config,
                breakpoint = var1.name
            }
        },
        tbl1.children
    )
end
return ResponsiveLayoutProvider
