-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _ReactRobloxHostTypesRoblox = require(script.Parent["ReactRobloxHostTypes.roblox"])

local ReactGlobals = require(scriptParentParentParent.ReactGlobals)
local _ReactReconciler = require(scriptParentParentParent.ReactReconciler)

local _Shared = require(scriptParentParentParent.Shared)

local _ReactReconciler2 = require(scriptParentParentParent.ReactReconciler)

local ReactRobloxComponentTree = require(script.Parent.ReactRobloxComponentTree)

local markContainerAsRoot = ReactRobloxComponentTree.markContainerAsRoot
local unmarkContainerAsRoot = ReactRobloxComponentTree.unmarkContainerAsRoot

local ReactReconcilerRoblox = require(script.Parent.Parent["ReactReconciler.roblox"])
local createContainer = ReactReconcilerRoblox.createContainer
local updateContainer = ReactReconcilerRoblox.updateContainer

local invariant = require(scriptParentParentParent.Shared).invariant

local enableEagerRootListeners = require(scriptParentParentParent.Shared).ReactFeatureFlags.enableEagerRootListeners

local flushSync = ReactReconcilerRoblox.flushSync
local flushPassiveEffects = ReactReconcilerRoblox.flushPassiveEffects

local BlockingRoot = ReactReconcilerRoblox.ReactRootTags.BlockingRoot
local ConcurrentRoot = ReactReconcilerRoblox.ReactRootTags.ConcurrentRoot
local LegacyRoot = ReactReconcilerRoblox.ReactRootTags.LegacyRoot

local var1 = nil

local tbl1 = {}
tbl1.__index = tbl1

function tbl1.new(arg1, arg2)
    local self = (setmetatable({}, tbl1))
    self._internalRoot = var1(arg1, ConcurrentRoot, arg2)

    return self
end

local function createBlockingRoot(arg1, arg2, arg3) -- Luacid: Inlined by compiler; 2 call sites recovered
    local self = (setmetatable({}, tbl1))
    self._internalRoot = var1(arg1, arg2, arg3)

    return self
end

function tbl1:render(arg1)
    local _internalRoot = self._internalRoot

    updateContainer(arg1, _internalRoot, nil)
end

function tbl1:unmount()
    local _internalRoot = self._internalRoot
    local containerInfo = _internalRoot.containerInfo

    flushSync(function()
        updateContainer(nil, _internalRoot, nil, function()
            unmarkContainerAsRoot(containerInfo)
        end)
    end)

    flushPassiveEffects()
end

var1 = function(arg1, arg2, arg3)
    local bool1 = not (arg3 == nil) and arg3.hydrate == true
    local hydrationOptions = if arg3 == nil then nil else arg3.hydrationOptions
    local _mutableSources = if arg3 == nil or arg3.hydrationOptions == nil then nil else arg3.hydrationOptions.mutableSources or nil
    local container = createContainer(arg1, arg2, bool1, hydrationOptions)
    markContainerAsRoot(container.current, arg1)

    return container
end

local module = {}

local function isValidContainer(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return typeof(arg1) == "Instance"
end

module.isValidContainer = isValidContainer

function module.createRoot(arg1, arg2)
    invariant(not not isValidContainer(arg1), "createRoot(...): Target container is not a Roblox Instance.")

    warnIfReactDOMContainerInDEV(arg1)
    return tbl1.new(arg1, arg2)
end

function module.createBlockingRoot(arg1, arg2)
    invariant(not not isValidContainer(arg1), "createRoot(...): Target container is not a Roblox Instance.")

    warnIfReactDOMContainerInDEV(arg1)
    return createBlockingRoot(arg1, BlockingRoot, arg2)
end

function module.createLegacyRoot(arg1, arg2)
    return createBlockingRoot(arg1, LegacyRoot, arg2)
end

function warnIfReactDOMContainerInDEV(_)
    if ReactGlobals.__DEV__ then
    end
end

return module
