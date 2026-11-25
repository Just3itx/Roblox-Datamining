-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:10:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatformParent = script:FindFirstAncestor("ProfilePlatform").Parent

local _Signals = require(ProfilePlatformParent.Signals)
local createSessionScopedSignal = require(ProfilePlatformParent.SignalsUtils).createSessionScopedSignal
local _React = require(ProfilePlatformParent.React)
local _EditProfileBackground = require(ProfilePlatformParent.EditProfileBackground)

local function createInspectAvatarHeroStore()
    local getScenes, var2 = createSessionScopedSignal({})
    local getChromeFades, var4 = createSessionScopedSignal({})

    return {
        getScenes = getScenes,
        setScene = function(str1: string, arg1)
            local var5 = getScenes(false)
            if var5[str1] == arg1 then
                return
            end
            local var6 = table.clone(var5)
            var6[str1] = arg1
            var2(var6)
        end,
        clearScene = function(str1: string, arg1)
            local var5 = getScenes(false)
            if var5[str1] ~= arg1 then
                return
            end
            local var6 = table.clone(var5)
            var6[str1] = nil
            var2(var6)
        end,
        getChromeFades = getChromeFades,
        setChromeFade = function(str1: string, arg1)
            local var5 = getChromeFades(false)
            if var5[str1] == arg1 then
                return
            end
            local var6 = table.clone(var5)
            var6[str1] = arg1
            var4(var6)
        end,
        reset = function()
            var2({})
            var4({})
        end
    }
end
return createInspectAvatarHeroStore
