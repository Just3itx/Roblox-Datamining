-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:50:44Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local _DialogSize = require(Foundation.Enums.DialogSize)

local getResponsiveSize = require(script.Parent.getResponsiveSize)
local useOverlay = require(Foundation.Providers.Overlay.useOverlay)
local useTokens = require(Foundation.Providers.Style.useTokens)

local DialogContext = require(script.Parent.DialogContext)

local function DialogProvider(tbl1)
    local var1 = useOverlay()
    local var2 = useTokens()

    local responsiveSize, setResponsiveSize = React.useState(function()
        if var1 then
            return getResponsiveSize(var1.AbsoluteSize.X, tbl1.size, var2)
        end

        return tbl1.responsiveSize or tbl1.size
    end)

    local hasHeroMedia, setHasHeroMedia = React.useState(tbl1.hasHeroMedia)

    local closeAffordanceRef = React.useRef(nil)
    local contentStartRef, setContentStartRef = React.useState(nil)

    local value = React.useMemo(function()
        return {
            size = tbl1.size,
            responsiveSize = responsiveSize,
            setResponsiveSize = setResponsiveSize,
            hasHeroMedia = hasHeroMedia,
            setHasHeroMedia = setHasHeroMedia,
            testId = tbl1.testId,
            closeAffordanceRef = closeAffordanceRef,
            contentStartRef = contentStartRef,
            setContentStartRef = setContentStartRef
        }
    end, {
        tbl1.size,
        responsiveSize,
        hasHeroMedia,
        tbl1.testId,
        contentStartRef
    })

    return React.createElement(DialogContext.Provider, { value = value }, tbl1.children)
end

return DialogProvider
