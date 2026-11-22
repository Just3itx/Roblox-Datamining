-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:21:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")

local preloadConstants = require(MomentsCommon.Media.Preload.preloadConstants)

game:DefineFastInt("MomentsPreloadDownloadWindowForward", preloadConstants.downloadWindow.forward)
game:DefineFastInt("MomentsPreloadDownloadWindowBack", preloadConstants.downloadWindow.back)
game:DefineFastInt("MomentsPreloadDecodeWindowForward", preloadConstants.decodeWindow.forward)
game:DefineFastInt("MomentsPreloadDecodeWindowBack", preloadConstants.decodeWindow.back)
game:DefineFastInt("MomentsPreloadDecodeRetryDelayMs", 2000)
game:DefineFastInt("MomentsPreloadMaxDecodeRetries", 2)
game:DefineFastInt("MomentsScreenshotDurationSeconds", preloadConstants.screenshotDurationSeconds)

return {
    getDownloadWindow = function()
        return {
            forward = game:GetFastInt("MomentsPreloadDownloadWindowForward"),
            back = game:GetFastInt("MomentsPreloadDownloadWindowBack")
        }
    end,
    getDecodeWindow = function()
        return {
            forward = game:GetFastInt("MomentsPreloadDecodeWindowForward"),
            back = game:GetFastInt("MomentsPreloadDecodeWindowBack")
        }
    end,
    getDecodeRetryDelayMs = function(): number
        return game:GetFastInt("MomentsPreloadDecodeRetryDelayMs")
    end,
    getMaxDecodeRetries = function(): number
        return game:GetFastInt("MomentsPreloadMaxDecodeRetries")
    end,
    getScreenshotDurationSeconds = function(): number
        return game:GetFastInt("MomentsScreenshotDurationSeconds")
    end
}
