-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:21:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local Responsive = scriptParent.Parent.Responsive
local scriptParentParentParentParentParent = scriptParent.Parent.Parent.Parent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)

local ResponsiveLayoutContext = require(Responsive.ResponsiveLayoutContext)
local ResponsiveLayoutConfigReader = require(Responsive.ResponsiveLayoutConfigReader)

return function(arg1, kind)
    return function(arg2)
        return Roact.createElement(ResponsiveLayoutContext.Consumer, {
            render = function(arg3)
                local tbl1 = ({})
                for k, value in pairs(arg1) do
                    local getValue = ResponsiveLayoutConfigReader.getValue
                    local tbl2 = {
                        config = arg3.config,
                        breakpoint = arg3.breakpoint,
                        kind = kind or arg3.kind
                    }
                    tbl1[k] = getValue(tbl2, k)

                    if tbl1[k] == nil then
                        tbl1[k] = value
                    end
                end
                return arg2(tbl1)
            end
        })
    end
end
