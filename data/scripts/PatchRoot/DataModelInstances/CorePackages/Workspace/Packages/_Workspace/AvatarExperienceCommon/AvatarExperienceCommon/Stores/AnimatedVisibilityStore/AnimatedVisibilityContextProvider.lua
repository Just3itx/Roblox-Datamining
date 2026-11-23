-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local React = require(AvatarExperienceCommonParent.React)

local createAnimatedVisibilityStore = require(script.Parent.createAnimatedVisibilityStore)
local AnimatedVisibilityContext = require(script.Parent.AnimatedVisibilityContext)

local function AnimatedVisibilityProvider(tbl1)
    local animatedMenusStore = React.useMemo(function()
        return createAnimatedVisibilityStore(tbl1.initialRatio)
    end, {})

    React.useEffect(function()
        return function()
            animatedMenusStore.destroy()
        end
    end, { animatedMenusStore })

    return React.createElement(
        AnimatedVisibilityContext.Provider,
        {
            value = { animatedMenusStore = animatedMenusStore }
        },
        tbl1.children
    )
end
return AnimatedVisibilityProvider
