-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameSettings = UserSettings().GameSettings

local bool1 = game:DefineFastFlag("IGMResetGfxQuality", false)
local bool2 = game:DefineFastFlag("IGMRevertGfxQuality", false)
local bool3 = game:DefineFastFlag("IGMRevertGfxLv5Only", false)

local bool4 = game:DefineFastFlag("IGMResetGfxLv5Only", false)
local bool5 = game:DefineFastFlag("IGMAlwaysResetGfxLv5", false)
local num1 = game:DefineFastInt("IGMTempOverrideGfxLv5", 0)

local function SavedQualitySettingEnumFromValue(qualityResetLevel) -- Luacid: Inlined by compiler; 1 call site recovered
    for _, enumItem in (Enum.SavedQualitySetting:GetEnumItems()) do
        if enumItem.Value == qualityResetLevel then
            return enumItem
        end
    end
    return Enum.SavedQualitySetting.Automatic
end

function applicationId()
    local AppStorageService = game:GetService("AppStorageService")
    if not AppStorageService then
        return nil
    end

    local item = AppStorageService:GetItem("AppInstallationId")
    local str1 = typeof(item)

    if str1 == "number" then
        return tonumber(item) or nil
    end

    if str1 ~= "string" then
        return nil
    end

    if string.len(item) <= 0 then
        return nil
    end

    return tonumber(string.sub(item, -string.len(tostring(1000))))
end

return {
    RunGfxReset = function()
        local bool6 = bool5
        local bool7 = GameSettings.SavedQualityLevel == Enum.SavedQualitySetting.QualityLevel5

        if bool6 and bool7 then
            GameSettings.SavedQualityLevel = Enum.SavedQualitySetting.Automatic
        end

        if not game:GetEngineFeature("QualityLevelReset") then
            return
        end
        if bool2 then
            if GameSettings.QualityResetLevel >= 0 then
                local savedQualityLevel = SavedQualitySettingEnumFromValue(GameSettings.QualityResetLevel)

                if bool3 and savedQualityLevel == Enum.SavedQualitySetting.QualityLevel5 or bool3 == false then
                    GameSettings.SavedQualityLevel = savedQualityLevel
                    GameSettings.QualityResetLevel = -1
                end
            end

            return
        end

        if not bool1 then
            return
        end

        local bool8 = bool4
        local qualityResetLevel = GameSettings.QualityResetLevel

        if not (qualityResetLevel < 0) and qualityResetLevel ~= nil then
            return
        end
        local savedQualityLevelValue = GameSettings.SavedQualityLevel.Value
        if bool7 and bool8 or bool8 == false then
            GameSettings.SavedQualityLevel = Enum.SavedQualitySetting.Automatic
        end
        GameSettings.QualityResetLevel = savedQualityLevelValue
    end,
    TemporaryOverride = function(arg1)
        if ((applicationId() or 0) + 329) % 1000 < num1
            and (arg1 == Enum.SavedQualitySetting.QualityLevel5 or arg1 == Enum.SavedQualitySetting.QualityLevel5.Value)
        then
            return true, Enum.SavedQualitySetting.Automatic.Value
        end

        return false, Enum.SavedQualitySetting.Automatic.Value
    end
}
