-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local _InputSize = require(Foundation.Enums.InputSize)

local InputVariant = require(Foundation.Enums.InputVariant)

local _Radius = require(Foundation.Enums.Radius)

local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local getInputVariantsFactory = require(script.Parent.getInputVariantsFactory)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local function composeInputFieldVariants(arg1, arg2, utility, arg3, bool1: boolean?, bool2: boolean?, bool3: boolean?)
    local inputVariantsFactory = getInputVariantsFactory(arg1)
    local variant = inputVariantsFactory.variants[utility or InputVariant.Standard]

    return composeStyleVariant(
        inputVariantsFactory.common,
        inputVariantsFactory.sizes[arg2],
        utility == InputVariant.Utility and {} or variant,
        if arg3 then inputVariantsFactory.radius[arg3] else inputVariantsFactory.defaultRadius[arg2],
        bool2 == nil and {} or inputVariantsFactory.hoverState[bool2],
        bool1 == nil and {} or inputVariantsFactory.focusedState[bool1],
        bool3 == nil and {} or inputVariantsFactory.errorState[bool3],
        utility ~= InputVariant.Utility and {} or variant
    )
end

return composeInputFieldVariants
