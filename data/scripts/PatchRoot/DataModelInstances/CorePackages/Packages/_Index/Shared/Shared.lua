-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParent = script.Parent
local _LuauPolyfill = require(scriptParent.LuauPolyfill)

local ReactTypes = require(script.ReactTypes)
local _flowtypesRoblox = require(script["flowtypes.roblox"])
local _ReactElementType = require(script.ReactElementType)
local ReactFiberHostConfig = require(script.ReactFiberHostConfig)
local ReactSharedInternals = require(script.ReactSharedInternals)
local ErrorHandlingRoblox = require(script["ErrorHandling.roblox"])

return {
    checkPropTypes = require(script.checkPropTypes),
    console = require(script.console),
    ConsolePatchingDev = require(script["ConsolePatchingDev.roblox"]),
    consoleWithStackDev = require(script.consoleWithStackDev),
    enqueueTask = require(script["enqueueTask.roblox"]),
    ExecutionEnvironment = require(script.ExecutionEnvironment),
    formatProdErrorMessage = require(script.formatProdErrorMessage),
    getComponentName = require(script.getComponentName),
    invariant = require(script.invariant),
    invokeGuardedCallbackImpl = require(script.invokeGuardedCallbackImpl),
    isValidElementType = require(script.isValidElementType),
    MemoValues = require(script["MemoValues.roblox"]),
    objectIs = require(script.objectIs),
    ReactComponentStackFrame = require(script.ReactComponentStackFrame),
    ReactElementType = require(script.ReactElementType),
    ReactErrorUtils = require(script.ReactErrorUtils),
    ReactFeatureFlags = require(script.ReactFeatureFlags),
    ReactInstanceMap = require(script.ReactInstanceMap),
    ReactSharedInternals = ReactSharedInternals,
    ReactFiberHostConfig = ReactFiberHostConfig,
    ReactSymbols = require(script.ReactSymbols),
    ReactVersion = require(script.ReactVersion),
    shallowEqual = require(script.shallowEqual),
    UninitializedState = require(script["UninitializedState.roblox"]),
    ReactTypes = ReactTypes,
    describeError = ErrorHandlingRoblox.describeError,
    errorToString = ErrorHandlingRoblox.errorToString,
    parseReactError = ErrorHandlingRoblox.parseReactError,
    Symbol = require(script["Symbol.roblox"]),
    Type = require(script["Type.roblox"]),
    Change = require(script.PropMarkers.Change),
    Event = require(script.PropMarkers.Event),
    Tag = require(script.PropMarkers.Tag)
}
