-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")
local SduiSharedUtilitiesParent = SduiSharedUtilities.Parent

local AppPage = require(SduiSharedUtilitiesParent.RobloxAppEnums).AppPage
local SharedFlags = require(SduiSharedUtilitiesParent.SharedFlags)
local SduiCoreSystem = require(SduiSharedUtilitiesParent.SduiCoreSystem)
local SduiErrors = SduiCoreSystem.SduiErrors
local SduiLogger = SduiCoreSystem.SduiLogger
local SduiParseHelpers = SduiCoreSystem.SduiParseHelpers

local SduiLoadTimer = require(SduiSharedUtilities.SduiLoadTimer)
local fetchSduiTemplates = require(SduiSharedUtilities.fetchSduiTemplates)

local function makePrewarmTimerKey(experienceDetail: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    return `{experienceDetail}Prewarm`
end

local tbl1 = {{
    surfaceKeys = { AppPage.ExperienceDetail },
    timerKey = makePrewarmTimerKey(AppPage.ExperienceDetail),
    isEnabled = function()
        return SharedFlags.FFlagSduiEdpTemplatePrewarm
    end
}}

local function prewarmSurface(tbl2)
    local loadTimer = SduiLoadTimer.createLoadTimer(tbl2.timerKey)
    loadTimer.start("preload")

    local var1 = fetchSduiTemplates({ surfaceKeys = tbl2.surfaceKeys, loadTimer = loadTimer })

    local name = table.concat(tbl2.surfaceKeys, ",")
    var1:catch(function(arg1)
        SduiLogger.reportError(
            SduiErrors.SduiErrorType.FailedToPrewarmTemplates,
            {
                message = SduiParseHelpers.stringifyValue(arg1),
                name = name
            },
            name
        )
    end)
    return var1
end

local function prewarmAppTemplatesOnLaunch()
    local result = {}
    for _, value in tbl1 do
        if value.isEnabled() then
            table.insert(result, (prewarmSurface(value)))
        end
    end
    return result
end

return prewarmAppTemplatesOnLaunch
