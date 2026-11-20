-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)
local _LuauPolyfill = require(scriptParentParent.LuauPolyfill)

local ReactMutableSource = require(scriptParent.ReactMutableSource)
local ReactSharedInternals = require(scriptParentParent.Shared).ReactSharedInternals
local ReactBaseClasses = require(scriptParent.ReactBaseClasses)
local ReactChildren = require(scriptParent.ReactChildren)
local ReactElementValidator = require(scriptParent.ReactElementValidator)
local ReactElement = require(scriptParent.ReactElement)
local ReactCreateRef = require(scriptParent.ReactCreateRef)
local ReactForwardRef = require(scriptParent.ReactForwardRef)
local ReactHooks = require(scriptParent.ReactHooks)
local ReactMemo = require(scriptParent.ReactMemo)
local ReactContext = require(scriptParent.ReactContext)
local ReactLazy = require(scriptParent.ReactLazy)

local ReactBindingRoblox = require(scriptParent["ReactBinding.roblox"])

local NoneRoblox = require(scriptParent["None.roblox"])

local ReactSymbols = require(scriptParentParent.Shared).ReactSymbols

local var1 = ReactGlobals.__DEV__ or ReactGlobals.__DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__
local _Shared = require(scriptParentParent.Shared)
local createElement = if var1 then ReactElementValidator.createElementWithValidation else ReactElement.createElement
local cloneElement = if var1 then ReactElementValidator.cloneElementWithValidation else ReactElement.cloneElement
return {
    Children = ReactChildren,
    createMutableSource = ReactMutableSource,
    createRef = ReactCreateRef.createRef,
    Component = ReactBaseClasses.Component,
    PureComponent = ReactBaseClasses.PureComponent,
    createContext = ReactContext.createContext,
    forwardRef = ReactForwardRef.forwardRef,
    lazy = ReactLazy.lazy,
    memo = ReactMemo.memo,
    useCallback = ReactHooks.useCallback,
    useContext = ReactHooks.useContext,
    useEffect = ReactHooks.useEffect,
    useImperativeHandle = ReactHooks.useImperativeHandle,
    useDebugValue = ReactHooks.useDebugValue,
    useLayoutEffect = ReactHooks.useLayoutEffect,
    useMemo = ReactHooks.useMemo,
    useMutableSource = ReactHooks.useMutableSource,
    useReducer = ReactHooks.useReducer,
    useRef = ReactHooks.useRef,
    useBinding = ReactHooks.useBinding,
    useState = ReactHooks.useState,
    Fragment = ReactSymbols.REACT_FRAGMENT_TYPE,
    Profiler = ReactSymbols.REACT_PROFILER_TYPE,
    StrictMode = ReactSymbols.REACT_STRICT_MODE_TYPE,
    unstable_DebugTracingMode = ReactSymbols.REACT_DEBUG_TRACING_MODE_TYPE,
    Suspense = ReactSymbols.REACT_SUSPENSE_TYPE,
    createElement = createElement,
    cloneElement = cloneElement,
    isValidElement = ReactElement.isValidElement,
    __SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED = ReactSharedInternals,
    unstable_LegacyHidden = ReactSymbols.REACT_LEGACY_HIDDEN_TYPE,
    createBinding = ReactBindingRoblox.create,
    joinBindings = ReactBindingRoblox.join,
    None = NoneRoblox,
    __subscribeToBinding = ReactBindingRoblox.subscribe,
    Event = require(scriptParentParent.Shared).Event,
    Change = require(scriptParentParent.Shared).Change,
    Tag = require(scriptParentParent.Shared).Tag,
    unstable_parseReactError = require(scriptParentParent.Shared).parseReactError
}
