-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:40:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppComposition = script:FindFirstAncestor("AppComposition")
local AppCompositionParent = AppComposition.Parent

local Foundation = require(AppCompositionParent.Foundation)
local React = require(AppCompositionParent.React)

local useStyleSheet = Foundation.Hooks.useStyleSheet
local useTokens = Foundation.Hooks.useTokens

local setupCompositionStyleRules = require(AppComposition.setupCompositionStyleRules)

local function CompositionStyleSheet()
    local ref = React.useRef(nil)
    local var2 = useStyleSheet()
    local var3 = useTokens()

    React.useLayoutEffect(function()
        if not (ref.current and var2) then
            return function() end
        end

        ref.current:SetDerives({ var2 })
        return setupCompositionStyleRules(ref.current, var3)
    end, { ref, var2, var3 })

    return React.createElement(React.Fragment, nil, {
        CompositionStyleSheet = React.createElement("StyleSheet", { ref = ref }),
        CompositionStyleLink = React.createElement("StyleLink", { StyleSheet = ref.current })
    })
end

return CompositionStyleSheet
