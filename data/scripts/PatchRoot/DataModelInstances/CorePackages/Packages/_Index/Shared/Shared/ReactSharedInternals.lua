-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:20:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)
local console = require(scriptParentParent.LuauPolyfill).console
local function onlyInTestError(str1: string) -- Luacid: unused: defined but never referenced
    return function()
        console.error(str1 .. " is only available in tests, not in production")
    end
end

local ReactCurrentDispatcher = require(script.ReactCurrentDispatcher)

local ReactCurrentBatchConfig = require(script.ReactCurrentBatchConfig)
local ReactCurrentOwner = require(script.ReactCurrentOwner)
local ReactDebugCurrentFrame = require(script.ReactDebugCurrentFrame)
return {
    ReactCurrentDispatcher = ReactCurrentDispatcher,
    ReactCurrentBatchConfig = ReactCurrentBatchConfig,
    ReactCurrentOwner = ReactCurrentOwner,
    IsSomeRendererActing = require(script.IsSomeRendererActing),
    ReactDebugCurrentFrame = not ReactGlobals.__DEV__ and {
        setExtraStackFrame = function(_: string?) end
    } or ReactDebugCurrentFrame
}
