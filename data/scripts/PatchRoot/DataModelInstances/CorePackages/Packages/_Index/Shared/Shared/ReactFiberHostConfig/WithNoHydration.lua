-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local invariant = require(script.Parent.Parent.invariant)

function shim(...)
    invariant(
        false,
        "The current renderer does not support hydration. This error is likely caused by a bug in React. Please file an issue."
    )
end

return {
    supportsHydration = false,
    canHydrateInstance = shim,
    canHydrateTextInstance = shim,
    canHydrateSuspenseInstance = shim,
    isSuspenseInstancePending = shim,
    isSuspenseInstanceFallback = shim,
    registerSuspenseInstanceRetry = shim,
    getNextHydratableSibling = shim,
    getFirstHydratableChild = shim,
    hydrateInstance = shim,
    hydrateTextInstance = shim,
    hydrateSuspenseInstance = shim,
    getNextHydratableInstanceAfterSuspenseInstance = shim,
    commitHydratedContainer = shim,
    commitHydratedSuspenseInstance = shim,
    clearSuspenseBoundary = shim,
    clearSuspenseBoundaryFromContainer = shim,
    didNotMatchHydratedContainerTextInstance = shim,
    didNotMatchHydratedTextInstance = shim,
    didNotHydrateContainerInstance = shim,
    didNotHydrateInstance = shim,
    didNotFindHydratableContainerInstance = shim,
    didNotFindHydratableContainerTextInstance = shim,
    didNotFindHydratableContainerSuspenseInstance = shim,
    didNotFindHydratableInstance = shim,
    didNotFindHydratableTextInstance = shim,
    didNotFindHydratableSuspenseInstance = shim
}
