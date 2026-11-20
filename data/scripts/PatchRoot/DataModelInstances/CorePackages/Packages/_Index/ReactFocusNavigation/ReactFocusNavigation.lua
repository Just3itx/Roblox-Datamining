-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParent = script.Parent
local FocusNavigation = require(scriptParent.FocusNavigation)

local FocusNavigationContext = require(script.FocusNavigationContext)
local useActiveEventMap = require(script.useActiveEventMap)
local useFocusedGuiObject = require(script.useFocusedGuiObject)
local useFocusGuiObject = require(script.useFocusGuiObject)
local useEventMap = require(script.useEventMap)
local useEventHandler = require(script.useEventHandler)
local useEventHandlerMap = require(script.useEventHandlerMap)
local useContainerFocusBehavior = require(script.useContainerFocusBehavior)
local useDispatchSyntheticEvent = require(script.useDispatchSyntheticEvent)
local useEventDispatched = require(script.useEventDispatched)
local FocusBehaviorHooks = require(script.FocusBehaviorHooks)

return {
    FocusNavigationService = FocusNavigation.FocusNavigationService,
    EngineInterface = FocusNavigation.EngineInterface,
    FocusNavigationContext = FocusNavigationContext,
    useActiveEventMap = useActiveEventMap,
    useFocusedGuiObject = useFocusedGuiObject,
    useEventDispatched = useEventDispatched,
    useFocusGuiObject = useFocusGuiObject,
    useEventMap = useEventMap,
    useEventHandler = useEventHandler,
    useEventHandlerMap = useEventHandlerMap,
    useContainerFocusBehavior = useContainerFocusBehavior,
    useDefaultFocusBehavior = FocusBehaviorHooks.useDefaultFocusBehavior,
    useMostRecentFocusBehavior = FocusBehaviorHooks.useMostRecentFocusBehavior,
    useMostRecentOrDefaultFocusBehavior = FocusBehaviorHooks.useMostRecentOrDefaultFocusBehavior,
    useDispatchSyntheticEvent = useDispatchSyntheticEvent
}
