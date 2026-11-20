-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:20:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local invariant = require(script.Parent.Parent.invariant)

local function shim(...)
    invariant(
        false,
        "The current renderer does not support test selectors. This error is likely caused by a bug in React. Please file an issue."
    )
end

return {
    supportsTestSelectors = false,
    findFiberRoot = shim,
    getBoundingRect = shim,
    getTextContent = shim,
    isHiddenSubtree = shim,
    matchAccessibilityRole = shim,
    setFocusIfFocusable = shim,
    setupIntersectionObserver = shim
}
