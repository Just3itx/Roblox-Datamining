-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:40:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local ReactGlobals = require(scriptParentParentParent.ReactGlobals)
local _Shared = require(scriptParentParentParent.Shared)

local _ReactRobloxHostTypesRoblox = require(script.Parent["ReactRobloxHostTypes.roblox"])

local ReactRobloxRoot = require(script.Parent.ReactRobloxRoot)
local createRoot = ReactRobloxRoot.createRoot
local createBlockingRoot = ReactRobloxRoot.createBlockingRoot
local createLegacyRoot = ReactRobloxRoot.createLegacyRoot
local isValidContainer = ReactRobloxRoot.isValidContainer

local ReactReconcilerRoblox = require(script.Parent.Parent["ReactReconciler.roblox"])

local batchedUpdates = ReactReconcilerRoblox.batchedUpdates

local flushSync = ReactReconcilerRoblox.flushSync

local injectIntoDevTools = ReactReconcilerRoblox.injectIntoDevTools
local flushPassiveEffects = ReactReconcilerRoblox.flushPassiveEffects
local IsThisRendererActing = ReactReconcilerRoblox.IsThisRendererActing

local createPortal = ReactReconcilerRoblox.createPortal

local ReactVersion = require(scriptParentParentParent.Shared).ReactVersion
local invariant = require(scriptParentParentParent.Shared).invariant
local enableNewReconciler = require(scriptParentParentParent.Shared).ReactFeatureFlags.enableNewReconciler

local ReactRobloxComponentTree = require(script.Parent.ReactRobloxComponentTree)
local getInstanceFromNode = ReactRobloxComponentTree.getInstanceFromNode
local getNodeFromInstance = ReactRobloxComponentTree.getNodeFromInstance
local getFiberCurrentPropsFromNode = ReactRobloxComponentTree.getFiberCurrentPropsFromNode
local getClosestInstanceFromNode = ReactRobloxComponentTree.getClosestInstanceFromNode

local tbl1 = {
    createPortal = function(arg1, arg2, str1: string?)
        invariant(isValidContainer(arg2), "Target container is not a Roblox Instance.")

        return createPortal(arg1, arg2, nil, str1)
    end,
    unstable_batchedUpdates = batchedUpdates,
    flushSync = flushSync,
    __SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED = {
        Events = {
            getInstanceFromNode = getInstanceFromNode,
            getNodeFromInstance = getNodeFromInstance,
            getFiberCurrentPropsFromNode = getFiberCurrentPropsFromNode,
            flushPassiveEffects = flushPassiveEffects,
            IsThisRendererActing = IsThisRendererActing
        }
    },
    version = ReactVersion,
    createRoot = createRoot,
    createBlockingRoot = createBlockingRoot,
    createLegacyRoot = createLegacyRoot,
    Event = require(scriptParentParentParent.Shared).Event,
    Change = require(scriptParentParentParent.Shared).Change,
    Tag = require(scriptParentParentParent.Shared).Tag,
    unstable_isNewReconciler = enableNewReconciler,
    act = function(_: (...any) -> (...any))
        error(
            "ReactRoblox.act is only available in testing environments, not production. Enable the `__ROACT_17_MOCK_SCHEDULER__` global in your test configuration in order to use `act`."
        )
    end
}

if ReactGlobals.__ROACT_17_MOCK_SCHEDULER__ then
    tbl1.act = ReactReconcilerRoblox.act
end

injectIntoDevTools({
    findFiberByHostInstance = getClosestInstanceFromNode,
    bundleType = if ReactGlobals.__DEV__ then 1 else 0,
    version = ReactVersion,
    rendererPackageName = "ReactRoblox"
})

if ReactGlobals.__DEV__ then
end

tbl1.robloxReactProfiling = ReactReconcilerRoblox.robloxReactProfiling
tbl1.schedulingProfiler = ReactReconcilerRoblox.schedulingProfiler

return tbl1
