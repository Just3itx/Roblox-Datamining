-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:31:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local createSignal = require(MomentsParent.Signals).createSignal

local function createUploadStore()
    local getState, var2 = createSignal("Idle")
    local getErrorKind, var4 = createSignal(nil)
    local getUploadedMoment, var6 = createSignal(nil)

    return {
        getState = getState,
        getErrorKind = getErrorKind,
        getUploadedMoment = getUploadedMoment,
        setUploading = function()
            var2("Uploading")
            var4(nil)
            var6(nil)
        end,
        setSuccess = function(arg1)
            var2("Success")
            var4(nil)
            var6(arg1)
        end,
        setFailed = function(str1: string)
            var2("Failed")
            var4(str1)
            var6(nil)
        end,
        reset = function()
            var2("Idle")
            var4(nil)
            var6(nil)
        end
    }
end
return createUploadStore
