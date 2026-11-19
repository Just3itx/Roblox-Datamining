-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:40:49Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Dash = require(FoundationParent.Dash)
local React = require(FoundationParent.React)

local ProgressBar = require(script.Parent.ProgressBar)

local ProgressCircle = require(script.Parent.ProgressCircle)

local ProgressShape = require(Foundation.Enums.ProgressShape)

local _ProgressSize = require(Foundation.Enums.ProgressSize)

local Flags = require(Foundation.Utility.Flags)
local withDefaults = require(Foundation.Utility.withDefaults)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local tbl1 = { testId = "--foundation-progress" }

return React.memo(React.forwardRef(function(arg1, ref) -- name: Progress
    local var1 = withDefaults(arg1, tbl1)

    if not Flags.FoundationProgressBarBetaUpdate then
        var1.ref = ref
    end

    if var1.shape == ProgressShape.Circle then
        local createElement = React.createElement
        local var2 = ProgressCircle
        if Flags.FoundationProgressBarBetaUpdate then
            var1 = Dash.join(var1, { ref = ref })
        end

        return createElement(var2, var1)
    end

    local createElement = React.createElement
    local var2 = ProgressBar
    if Flags.FoundationProgressBarBetaUpdate then
        var1 = Dash.join(var1, { ref = ref })
    end

    return createElement(var2, var1)
end))
