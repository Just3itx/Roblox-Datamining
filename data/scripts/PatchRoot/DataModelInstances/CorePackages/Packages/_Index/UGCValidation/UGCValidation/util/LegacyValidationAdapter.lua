-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _Types = require(scriptParentParent.util.Types)
local ValidationManager = require(scriptParentParent.validationSystem.ValidationManager)

local ErrorSourceStrings = require(scriptParentParent.validationSystem.ErrorSourceStrings)
local module = { LegacyValidator = "LegacyValidator" }

local function fallbackLocalizationFunction(arg1, relevantSourceStrings)
    local relevantSourceString = if relevantSourceStrings then relevantSourceStrings[arg1.key] else nil

    if relevantSourceString == nil then
        local var1 = arg1.key:split(".")
        local var2 = var1[#var1]
        relevantSourceString = ErrorSourceStrings.Values[var2]
    end

    if relevantSourceString == nil then
        return arg1.key
    end

    local tbl1 = {}
    local var1 = nil
    for i = 1, #relevantSourceString do
        local str1 = string.sub(relevantSourceString, i, i)
        if str1 == "{" then
            var1 = {}
        elseif str1 == "}" then
            if var1 ~= nil then
                local str2 = table.concat(var1)

                if arg1.params[str2] ~= nil then
                    table.insert(tbl1, tostring(arg1.params[str2]))
                end

                var1 = nil
            end
        elseif var1 ~= nil then
            table.insert(var1, str1)
        else
            table.insert(tbl1, str1)
        end
    end

    return table.concat(tbl1)
end

function module.getPrecomputedEditables<T>(arg1: T, arg2: T)
    local tbl1 = {
        {},
        {}
    }

    for value, value2 in { arg1, arg2 } do
        for value3, value4 in value2 do
            for value5, value6 in value4 do
                pcall(function()
                    local var1 = value3[value5]
                    if var1 ~= nil and var1 ~= "" then
                        tbl1[value][var1] = value6.instance
                    end
                end)
            end
        end
    end

    return tbl1[1], tbl1[2]
end

local function fetchString(func1: ((...any) -> (...any))?, arg1, relevantSourceStrings)
    if arg1.key == module.LegacyValidator then
        return arg1.params.Message or ""
    end

    local success, result

    if func1 then
        success, result = pcall(function()
            return func1(arg1)
        end)
    else
        success = nil
        result = nil
    end

    if success and result ~= arg1.key then
        return result
    end
    return fallbackLocalizationFunction(arg1, relevantSourceStrings)
end

function module.combineResultsIntoLegacy(bool1: boolean, tbl1, arg1, func1: ((...any) -> (...any))?)
    local pass = bool1 and arg1.pass

    if next(arg1.failureMap) ~= nil then
        tbl1 = tbl1 == nil and {} or tbl1

        for _, value in arg1.failureMap do
            for _, value2 in value do
                table.insert(
                    tbl1,
                    fetchString(func1, { key = value2.failureStringKey, params = value2.failureStringParams }, arg1.relevantSourceStrings)
                )
            end
        end
    end

    if not pass and (tbl1 == nil or #tbl1 == 0) then
        tbl1 = tbl1 == nil and {} or tbl1

        table.insert(
            tbl1,
            fetchString(
                func1,
                {
                    key = ErrorSourceStrings.Keys.InternalError,
                    params = {
                        ValidationJobId = arg1.validationJobId
                    }
                },
                arg1.relevantSourceStrings
            )
        )
    end
    return pass, tbl1
end

function module.mergeLegacyIntoModern(bool1: boolean, tbl1, arg1)
    arg1.pass = arg1.pass and bool1

    if not tbl1 or not (#tbl1 > 0) then
        return
    end

    local tbl2 = {}
    for _, message in tbl1 do
        if message == "" then
            continue
        end

        table.insert(
            tbl2,
            {
                failureStringKey = module.LegacyValidator,
                failureStringParams = { Message = message },
                instancePath = ""
            }
        )
    end

    if #tbl2 > 0 then
        arg1.failureMap[module.LegacyValidator] = tbl2
        arg1.numFailures += #tbl2
    end
end

function module.studioRFUAssetValidation(arg1, telemetryBundleId: string, bool1: boolean, tbl1)
    local str1 = "Toolbox"
    local enforceShadowValidations = if arg1.bypassFlags then arg1.bypassFlags.enforceShadowValidations or false else false

    if arg1.bypassFlags and arg1.bypassFlags.studioPluginName then
        str1 = arg1.bypassFlags.studioPluginName
    end

    local preloadedEditableMeshes, preloadedEditableImages = module.getPrecomputedEditables(arg1.editableMeshes or {}, arg1.editableImages or {})

    local var3 = ValidationManager.ValidateAsset(arg1.instances, arg1.assetTypeEnum, {
        source = str1,
        enforceR15FolderStructure = arg1.requireAllFolders or false,
        enforceShadowValidations = enforceShadowValidations,
        telemetryBundleId = telemetryBundleId,
        preloadedEditableMeshes = preloadedEditableMeshes,
        preloadedEditableImages = preloadedEditableImages,
        backendConfigs = arg1.restrictedUserIds and {
            restrictedUserIds = arg1.restrictedUserIds
        } or nil,
        iecConfigs = arg1.token and {
            token = arg1.token,
            universeId = arg1.universeId
        } or nil
    })

    return module.combineResultsIntoLegacy(
        bool1,
        tbl1,
        var3,
        if arg1.bypassFlags == nil then nil else arg1.bypassFlags.localizationCallback
    )
end

function module.studioRFUBundleValidation(arg1, arg2, arg3, telemetryBundleId: string, bool1: boolean, tbl1)
    local source = if arg3.bypassFlags and arg3.bypassFlags.studioPluginName then arg3.bypassFlags.studioPluginName else "Toolbox"
    local enforceShadowValidations = if arg3.bypassFlags then arg3.bypassFlags.enforceShadowValidations or false else false
    local preloadedEditableMeshes, preloadedEditableImages = module.getPrecomputedEditables(arg3.editableMeshes or {}, arg3.editableImages or {})

    local var4 = ValidationManager.ValidateFinalizedBundle(arg1, arg2, {
        source = source,
        enforceR15FolderStructure = arg3.requireAllFolders or false,
        enforceShadowValidations = enforceShadowValidations,
        telemetryBundleId = telemetryBundleId,
        preloadedEditableMeshes = preloadedEditableMeshes,
        preloadedEditableImages = preloadedEditableImages,
        backendConfigs = arg3.restrictedUserIds and {
            restrictedUserIds = arg3.restrictedUserIds
        } or nil,
        iecConfigs = arg3.token and {
            token = arg3.token,
            universeId = arg3.universeId
        } or nil
    })

    assert(arg3.bypassFlags)
    assert(arg3.bypassFlags.localizationCallback)
    return module.combineResultsIntoLegacy(
        bool1,
        tbl1,
        var4,
        if arg3.bypassFlags == nil then nil else arg3.bypassFlags.localizationCallback
    )
end

return module
