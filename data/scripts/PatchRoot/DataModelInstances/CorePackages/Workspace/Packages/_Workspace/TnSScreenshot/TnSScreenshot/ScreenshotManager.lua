-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TnSScreenshotParent = script:FindFirstAncestor("TnSScreenshot").Parent

local GetFFlagEnableInAppBugReporting = require(TnSScreenshotParent.SharedFlags).GetFFlagEnableInAppBugReporting

local function func1(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return game:GetEngineFeature("ReportAnythingScreenshot") and game:GetEngineFeature("ReportAnythingScreenshotUploadedSignal")
end

local module = {}
module.__index = module

local tbl1 = ({})
local tbl2 = ({})

local bool1 = false

local function func2(safetyService: SafetyService)
    safetyService.ScreenshotUploaded:Connect(function(screenshotJobId: number, screenshotId: string)
        local var1 = tbl1[screenshotJobId]
        if not var1 then
            return
        end

        var1(screenshotId)
        table.remove(tbl1, screenshotJobId)
    end)
    safetyService.ScreenshotContentReady:Connect(function(screenshotJobId: number, contentId: ContentId)
        local var1 = tbl2[screenshotJobId]
        if not var1 then
            return
        end

        var1(contentId)
        table.remove(tbl2, screenshotJobId)
    end)
    bool1 = true
end

function module.TakeScreenshotWithCallback(_, func3: (...any) -> (...any), func4: ((...any) -> (...any))?, str1: string?): boolean
    if not func1() then
        return false
    end
    local SafetyService = game:GetService("SafetyService")
    local num1 = SafetyService:TakeScreenshot(
        {
            registerContent = if func4 == nil then 0 else 1,
            reason = GetFFlagEnableInAppBugReporting() and str1 or "RAABTest"
        }
    )

    tbl1[num1] = func3
    tbl2[num1] = func4
    if not bool1 then
        func2(SafetyService)
    end

    return true
end

return module
