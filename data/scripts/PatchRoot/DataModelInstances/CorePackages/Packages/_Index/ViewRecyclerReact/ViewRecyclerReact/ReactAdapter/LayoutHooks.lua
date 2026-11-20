-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ViewRecyclerReact = script:FindFirstAncestor("ViewRecyclerReact")

local Layout = require(ViewRecyclerReact.Parent.ViewRecycler).Layout
local React = require(ViewRecyclerReact.Parent.React)

local function useManagedLayout(arg1, tbl1: {any})
    local var1 = React.useMemo(arg1, tbl1)
    React.useEffect(function()
        return function()
            var1.destroy()
        end
    end, { var1 })
    return var1
end

return {
    useMeasuredLayout = function(arg1)
        local var1 = React.useMemo(function()
            return Layout.measured(arg1)
        end, {})
        React.useEffect(function()
            return function()
                var1.destroy()
            end
        end, { var1 })
        return var1
    end,
    useUniformLayout = function(arg1)
        return (useManagedLayout(function()
            return Layout.uniform(arg1)
        end, {
            arg1.itemLength,
            arg1.spacing,
            arg1.paddingBefore,
            arg1.paddingAfter
        }))
    end
}
