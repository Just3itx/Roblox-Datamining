-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T23:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local WhatsNew = script:FindFirstAncestor("WhatsNew")
local WhatsNewParent = WhatsNew.Parent

local Enums = require(WhatsNew.Enums)
local _Types = require(WhatsNew.Types)
local Localization = require(WhatsNewParent.InExperienceLocales).Localization
local _ScopeActions = require(script.Parent.ScopeActions)
local validateRegistry = require(script.Parent.validateRegistry)
local buildTourTips = require(script.Parent.buildTourTips)

local LocalizationService = game:GetService("LocalizationService")

local function makeRootTourKey(str1: string, arg1): string -- Luacid: Inlined by compiler; 1 call site recovered
    return `{str1}:{arg1}`
end

local function collectScreenScopeIds(scopeTours)
    local result = {}
    for k, scopeTour in scopeTours do
        if scopeTour.parentScopeId == nil then
            table.insert(result, k)
        end
    end
    table.sort(result)
    return result
end

local function getRegistryEntries(arg1, whatsNew) -- Luacid: Inlined by compiler; 1 call site recovered
    return if whatsNew == Enums.TourType.WhatsNew then arg1.whatsNew else arg1.onboarding
end

local function assertValidationPassed(arg1, tbl1)
    local var1 = validateRegistry(arg1, { scopeActions = if tbl1 then tbl1.scopeActions else nil })

    assert(#var1.errors == 0, `loadWhatsNewRegistry validation failed: {table.concat(var1.errors, "; ")}`)
end

local function localizeOptional(arg1, str1: string?) -- Luacid: Inlined by compiler; 4 call sites recovered
    if str1 == nil or str1 == "" then
        return str1
    end
    return arg1:Format(str1)
end

local function localizeRegistry(updates)
    local localization = Localization.new(LocalizationService.RobloxLocaleId)

    local scopeTours = ({})
    for k, scopeTour in updates.scopeTours do
        local var1 = table.clone(scopeTour)
        var1.onboardingTitle = localizeOptional(localization, scopeTour.onboardingTitle)
        var1.onboardingText = localizeOptional(localization, scopeTour.onboardingText)
        var1.updatesTitle = localizeOptional(localization, scopeTour.updatesTitle)
        var1.updatesText = localizeOptional(localization, scopeTour.updatesText)
        scopeTours[k] = var1
    end

    local function localizeEntries(tbl2)
        local result = ({})
        for value, value2 in tbl2 do
            local var1 = table.clone(value2)
            var1.title = localization:Format(value2.title)
            var1.text = localization:Format(value2.text)
            result[value] = var1
        end
        return result
    end

    return {
        constants = updates.constants,
        scopeTours = scopeTours,
        whatsNew = localizeEntries(updates.whatsNew),
        onboarding = localizeEntries(updates.onboarding)
    }
end

local function loadWhatsNewRegistry(arg1, arg2, tbl1)
    assertValidationPassed(arg1, tbl1 or {})

    local result = ({})
    for _, screenScopeId in (collectScreenScopeIds(arg1.scopeTours)) do
        for _, tourType in Enums.TourTypeList do
            local tourTips = buildTourTips(arg1, arg2, screenScopeId, tourType, getRegistryEntries(arg1, tourType), nil)
            local rootTourKey = makeRootTourKey(screenScopeId, tourType)

            result[rootTourKey] = {
                screenScopeId = screenScopeId,
                tourType = tourType,
                scopeTree = tourTips.scope,
                globalTotalSteps = tourTips.globalTotalSteps,
                truncated = tourTips.truncated
            }
        end
    end

    return result
end

return {
    loadWhatsNewRegistry = loadWhatsNewRegistry,
    loadBundledRegistry = function(arg1, tbl1)
        local updates = require(script.Parent.Updates)
        return (loadWhatsNewRegistry(localizeRegistry(updates), arg1, tbl1))
    end,
    makeRootTourKey = makeRootTourKey
}
