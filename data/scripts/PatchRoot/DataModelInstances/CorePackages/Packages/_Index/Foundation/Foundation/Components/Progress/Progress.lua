-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Dash = require(FoundationParent.Dash)
local React = require(FoundationParent.React)

local ProgressBar = require(script.Parent.ProgressBar)

local ProgressCircle = require(script.Parent.ProgressCircle)

local ProgressShape = require(Foundation.Enums.ProgressShape)

local _ProgressSize = require(Foundation.Enums.ProgressSize)

local withDefaults = require(Foundation.Utility.withDefaults)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local tbl1 = { testId = "--foundation-progress" }

return React.memo(React.forwardRef(function(arg1, ref) -- name: Progress
    local var1 = withDefaults(arg1, tbl1)

    if var1.shape == ProgressShape.Circle then
        return React.createElement(ProgressCircle, Dash.join(var1, { ref = ref }))
    end

    return React.createElement(ProgressBar, Dash.join(var1, { ref = ref }))
end))
