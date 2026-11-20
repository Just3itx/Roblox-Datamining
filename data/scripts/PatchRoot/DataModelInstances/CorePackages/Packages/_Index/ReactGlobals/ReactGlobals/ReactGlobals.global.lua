-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:20:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
if not require(scriptParentParent.SafeFlags).createGetFFlag("ReactIsolatedGlobalsEnabled")() then
    return _G
end

local function loadFromGlobal(str1: string, arg1) -- Luacid: Inlined by compiler; 17 call sites recovered
    local var1 = _G[str1]
    return if var1 == nil then arg1 else var1
end

return {
    __DEV__ = loadFromGlobal("__DEV__", false),
    __PROFILE__ = loadFromGlobal("__PROFILE__", false),
    __EXPERIMENTAL__ = loadFromGlobal("__EXPERIMENTAL__", false),
    __DEBUG__ = loadFromGlobal("__DEBUG__", false),
    __YOLO__ = loadFromGlobal("__YOLO__", false),
    __DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ = loadFromGlobal("__DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__", false),
    __REACT_DEVTOOLS_GLOBAL_HOOK__ = loadFromGlobal("__REACT_DEVTOOLS_GLOBAL_HOOK__", nil),
    __REACT_DEVTOOLS_ATTACH__ = loadFromGlobal("__REACT_DEVTOOLS_ATTACH__", nil),
    __REACT_DEVTOOLS_APPEND_COMPONENT_STACK__ = loadFromGlobal("__REACT_DEVTOOLS_APPEND_COMPONENT_STACK__", false),
    __REACT_DEVTOOLS_BREAK_ON_CONSOLE_ERRORS__ = loadFromGlobal("__REACT_DEVTOOLS_BREAK_ON_CONSOLE_ERRORS__", false),
    __REACT_DEVTOOLS_COMPONENT_FILTERS__ = loadFromGlobal("__REACT_DEVTOOLS_COMPONENT_FILTERS__", nil),
    __LOCALSTORAGE__ = loadFromGlobal("__LOCALSTORAGE__", nil),
    __SESSIONSTORAGE__ = loadFromGlobal("__SESSIONSTORAGE__", nil),
    __COMPAT_WARNINGS__ = loadFromGlobal("__COMPAT_WARNINGS__", false),
    __TESTEZ_RUNNING_TEST__ = loadFromGlobal("__TESTEZ_RUNNING_TEST__", false),
    __ROACT_17_MOCK_SCHEDULER__ = loadFromGlobal("__ROACT_17_MOCK_SCHEDULER__", false),
    __ROACT_17_INLINE_ACT__ = loadFromGlobal("__ROACT_17_INLINE_ACT__", false)
}
