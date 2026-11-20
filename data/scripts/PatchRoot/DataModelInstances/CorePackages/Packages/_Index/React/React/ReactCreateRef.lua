-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)
local enableAllocationTrims = require(scriptParentParent.Shared).ReactFeatureFlags.enableAllocationTrims

local ReactBindingRoblox = require(script.Parent["ReactBinding.roblox"])

local module = {}

function module.createRef()
    local var1, _ = ReactBindingRoblox.create(nil)

    local result = {}

    if ReactGlobals.__DEV__ then
        var1._source = debug.traceback("Ref created at:", 1)
    end

    setmetatable(result, {
        __index = function(_, arg1)
            if arg1 == "current" then
                return var1:getValue()
            end
            return var1[arg1]
        end,
        __newindex = function(_, arg1, arg2)
            if arg1 == "current" then
                ReactBindingRoblox.update(var1, arg2)
            end

            var1[arg1] = arg2
        end,
        __tostring = function(_): string
            return string.format("Ref(%s)", tostring(var1:getValue()))
        end
    })

    return result
end

local function refNewIndex(arg1, arg2, arg3)
    local __index = getmetatable(arg1).__index
    __index[arg2] = arg3
    if arg2 == "current" then
        ReactBindingRoblox.update(__index, arg3)
    end
end

local function refToString(arg1)
    return string.format("Ref(%s)", tostring(getmetatable(arg1).__index:getValue()))
end

local function createRefWithoutClosures()
    local var1 = if ReactGlobals.__DEV__ then debug.traceback("Ref created at:", 1) else nil
    return (setmetatable(
        {},
        {
            __index = ReactBindingRoblox.createWithoutUpdater(nil, var1),
            __newindex = refNewIndex,
            __tostring = refToString
        }
    ))
end

if enableAllocationTrims then
    module.createRef = createRefWithoutClosures
end

return module
