-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local Url = require(CorePackages.Workspace.Packages.CoreScriptsCommon).Url
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Utility = require(RobloxGui.Modules.Settings.Utility)
local var1 = require(CorePackages.Workspace.Packages.CoreScriptsInitializer).CoreLogger:new(script.Name)

local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local engineFeature = game:GetEngineFeature("UgcLocaleFromGameJoinEnabled")

local tbl1 = {
    sq = "sq_al",
    ar = "ar_001",
    bn = "bn_bd",
    nb = "nb_no",
    bs = "bs_ba",
    bg = "bg_bg",
    my = "my_mm",
    ["zh-hans"] = "zh_cn",
    ["zh-hant"] = "zh_tw",
    hr = "hr_hr",
    cs = "cs_cz",
    da = "da_dk",
    nl = "nl_nl",
    en = "en_us",
    et = "et_ee",
    fil = "fil_ph",
    fi = "fi_fi",
    fr = "fr_fr",
    ka = "ka_ge",
    de = "de_de",
    el = "el_gr",
    hi = "hi_in",
    hu = "hu_hu",
    id = "id_id",
    it = "it_it",
    ja = "ja_jp",
    kk = "kk_kz",
    km = "km_kh",
    ko = "ko_kr",
    lv = "lv_lv",
    lt = "lt_lt",
    ms = "ms_my",
    pl = "pl_pl",
    pt = "pt_br",
    ro = "ro_ro",
    ru = "ru_ru",
    sr = "sr_rs",
    si = "si_lk",
    sk = "sk_sk",
    sl = "sl_sl",
    es = "es_es",
    sv = "sv_se",
    th = "th_th",
    tr = "tr_tr",
    uk = "uk_ua",
    vi = "vi_vn"
}

return function(arg1, arg2, callback)
    local num1 = 1
    local num2 = 1
    local bool1 = false

    local locale = nil
    local var2 = Players.LocalPlayer.LocaleId:gsub("-", "_")
    local var3 = nil
    local tbl2 = ({})
    local tbl3 = {}

    local tbl4 = ({})
    local tbl5 = ({})

    local tbl6 = ({})

    local tbl7 = {}

    local url = Url.LOCALE_URL .. string.format("v1/locales?displayValueLocale=%s", Players.LocalPlayer.LocaleId:gsub("-", "_"))
    local var5 = HttpService:RequestInternal({ Url = url, Method = "GET" })

    local var4 = Url.GAME_INTERNATIONALIZATION_URL .. string.format("v1/source-language/games/%d", game.GameId)
    local var7 = HttpService:RequestInternal({ Url = var4, Method = "GET" })

    local var6 = Url.GAME_INTERNATIONALIZATION_URL .. string.format("v1/supported-languages/games/%d/in-experience-language-selection", game.GameId)
    local var9 = HttpService:RequestInternal({ Url = var6, Method = "GET" })

    local var8 = Url.GAME_INTERNATIONALIZATION_URL .. string.format("v1/user-localization-settings/universe/%d", game.GameId)
    local var11 = HttpService:RequestInternal({ Url = var8, Method = "GET" })

    local function tryGetErrorMessage(arg3, arg4) -- Luacid: Inlined by compiler; 11 call sites recovered
        local statusCode = nil
        if not (arg3 and arg4 and arg4.StatusCode) then
            return "Connection error"
        end

        if arg4.StatusCode == 401 then
            return "Unauthorized"
        end

        if arg4.StatusCode < 200 or arg4.StatusCode >= 400 then
            statusCode = arg4.StatusCode
        end
        return statusCode
    end

    local function createSessionDormantLanguageSwitcherRow()
        local var12 = arg1
        local var13 = arg1
        local var14 = arg1
        local languageSelectorFrame, languageSelectorLabel, languageSelectorMode = Utility:AddNewRow(
            arg1,
            RobloxTranslator:FormatByKey("Feature.SettingsHub.LanguageSelection.SettingLabel"),
            "DropDown",
            { RobloxTranslator:FormatByKey("Feature.SettingsHub.LanguageSelection.Unavailable") },
            1
        )
        var12.LanguageSelectorFrame = languageSelectorFrame
        var13.LanguageSelectorLabel = languageSelectorLabel
        var14.LanguageSelectorMode = languageSelectorMode

        arg1.LanguageSelectorMode:SetInteractable(false)
        arg1.LanguageSelectorFrame.LayoutOrder = arg2.LanguageSelectorFrame
    end

    local function userExperienceLanguageSettingsCallback(bool2: boolean, arg3) -- Luacid: Inlined by compiler; 9 call sites recovered
        if not bool2 then
            var1:warning(
                "GameSettings language selector initialization failed to get all required information; defaulting to player locale and disabling language selection toggle. Earliest error message: "
                    .. (if arg3 == nil then "Execution path did not set earliest error to non-nil value." else arg3)
            )

            createSessionDormantLanguageSwitcherRow()
            return
        end

        local bool3 = false

        for _, value in tbl3 do
            if value == var3 then
                bool3 = true
            end

            if value ~= locale then
                table.insert(tbl7, tbl4[value].localeName)
            end
        end

        table.sort(tbl7)

        if locale == nil or tbl4[locale].localeName == nil then
            createSessionDormantLanguageSwitcherRow()
            return
        end

        table.insert(tbl7, 1, tbl4[locale].localeName .. " (Original)")

        if bool3 == true then
            for value, value2 in tbl7 do
                if value ~= 1 and tbl2[value2] == var3 then
                    num1 = value
                    num2 = value
                end
            end
        end

        local var12 = arg1
        local var13 = arg1
        local var14 = arg1
        local languageSelectorFrame, languageSelectorLabel, languageSelectorMode = Utility:AddNewRow(
            arg1,
            RobloxTranslator:FormatByKey("Feature.SettingsHub.LanguageSelection.SettingLabel"),
            "DropDown",
            tbl7,
            num1
        )
        var12.LanguageSelectorFrame = languageSelectorFrame
        var13.LanguageSelectorLabel = languageSelectorLabel
        var14.LanguageSelectorMode = languageSelectorMode

        arg1.LanguageSelectorFrame.LayoutOrder = arg2.LanguageSelectorFrame

        if not engineFeature then
            if num1 == 1 then
                LocalPlayer:SetExperienceSettingsLocaleId(locale)
            else
                local locale2 = tbl2[tbl7[num1]]
                LocalPlayer:SetExperienceSettingsLocaleId(locale2)
            end
        end

        arg1.LanguageSelectorMode.CurrentLocale = arg1.LanguageSelectorMode.DropDownFrame.DropDownFrameTextLabel.Text

        arg1.LanguageSelectorMode.IndexChanged:connect(function(arg4) -- name: toggleTranslation
            arg1.LanguageSelectorMode:SetInteractable(false)
            local localeId = if arg4 == 1 and tbl4[locale] ~= nil then tbl4[locale].localeId else tbl4[tbl2[tbl7[arg4]]].localeId
            local currentLocale = arg1.LanguageSelectorMode.CurrentLocale
            local var10 = tbl7[arg4]
            if currentLocale ~= var10 then
                arg1.LanguageSelectorMode.CurrentLocale = var10
                callback("experience_locale", currentLocale, var10)
            end

            local var15 = Url.GAME_INTERNATIONALIZATION_URL .. string.format("v1/user-localization-settings/universe/%d", game.GameId)
            local var20 = HttpService:RequestInternal({
                Url = var15,
                Method = "POST",
                Headers = { ["Content-Type"] = "application/json" },
                Body = HttpService:JSONEncode({ settingValue = { settingType = "SupportedLocale", settingTargetId = localeId } })
            })

            local function userExperienceLanguageSettingsUpdateCallback(bool4: boolean, arg5) -- Luacid: Inlined by compiler; 3 call sites recovered
                if bool4 then
                    num2 = arg4
                    if arg4 == 1 then
                        LocalPlayer:SetExperienceSettingsLocaleId(locale)
                    else
                        local locale2 = tbl2[tbl7[arg4]]
                        LocalPlayer:SetExperienceSettingsLocaleId(locale2)
                    end
                else
                    var1:warning(
                        "Request to update user experience language status failed, keeping language toggle disabled for the remainder of the session. Error: " .. arg5
                    )

                    bool1 = true
                    arg1.LanguageSelectorMode:SetSelectionIndex(num2)
                end

                arg1.LanguageSelectorMode:SetInteractable(true)
            end

            if RunService:IsStudio() then
                userExperienceLanguageSettingsUpdateCallback(true, nil)
                return
            end

            if bool1 then
                bool1 = false
                userExperienceLanguageSettingsUpdateCallback(true, nil)
                return
            end
            if localeId == nil then
                userExperienceLanguageSettingsUpdateCallback(false, nil)
                return
            end

            var20:Start(function(arg5, arg6)
                local var21 = tryGetErrorMessage(arg5, arg6)
                local bool4 = false

                if var21 ~= nil then
                    var21 = "User Experience Language Settings Update Request: " .. var21
                    var1:warning(
                        "GameSettings language selector toggle: Failed to update user experience language status from GameInternationalization API for " .. var15 .. " with error message: " .. var21
                    )
                else
                    var1:info("User Experience Language Settings Update Request: " .. "Succeeded with code - " .. arg6.StatusCode)
                    bool4 = true
                end

                userExperienceLanguageSettingsUpdateCallback(bool4, var21)
            end)
        end)
    end
    local function experienceSourceLanguageCallback(arg3, arg4) -- Luacid: Inlined by compiler; 3 call sites recovered
        if not arg3 then
            userExperienceLanguageSettingsCallback(false, arg4)
            return
        end

        var11:Start(function(arg5, arg6)
            local var12 = tryGetErrorMessage(arg5, arg6)
            local success = false
            local result

            if var12 ~= nil then
                result = "User Experience Language Setting Get Request: " .. var12
            else
                success, result = pcall(function()
                    local userUniverseLocalizationSettingValue = HttpService:JSONDecode(arg6.Body).userUniverseLocalizationSettingValue
                    if userUniverseLocalizationSettingValue == nil then
                        var3 = var2
                        return
                    end

                    local settingTargetId = userUniverseLocalizationSettingValue.settingTargetId
                    local settingType = userUniverseLocalizationSettingValue.settingType
                    if settingTargetId == nil then
                        var3 = var2
                    end

                    if settingType == "SourceOrTranslation" then
                        if settingTargetId == 1 then
                            var3 = locale
                            return
                        end
                        var3 = var2
                        return
                    end
                    if settingType == "LanguageFamily" then
                        if tbl6[settingTargetId] == nil then
                            var3 = var2
                            return
                        end

                        var3 = tbl5[tbl6[settingTargetId]]
                    elseif settingType == "SupportedLocale" then
                        if tbl5[settingTargetId] == nil then
                            var3 = var2
                            return
                        end

                        var3 = tbl5[settingTargetId]
                    end
                end)
            end

            if not success then
                var1:warning(
                    "GameSettings language selector initialization: Failed to get response from GameInternationalization API for " .. var8 .. " with error message: " .. result
                )
            end
            userExperienceLanguageSettingsCallback(success, result)
        end)
    end

    local function experienceSupportedLanguagesCallback(arg3, arg4) -- Luacid: unused: defined but never referenced
        if not arg3 then
            userExperienceLanguageSettingsCallback(false, arg4)

            return
        end

        var7:Start(function(arg5, arg6)
            local success = false
            local var12 = tryGetErrorMessage(arg5, arg6)
            local result

            if var12 ~= nil then
                result = "Experience Source Language Request: " .. var12
            else
                success, result = pcall(function()
                    local languageCode = HttpService:JSONDecode(arg6.Body).languageCode
                    locale = tbl1[languageCode]
                end)
            end
            if not success then
                var1:warning(
                    "GameSettings language selector initialization: Failed to get response from GameInternationalization API for " .. var4 .. " with error message: " .. result
                )
            end

            if arg4 == nil then
                arg4 = result
            end

            experienceSourceLanguageCallback(success and arg3, arg4)
        end)
    end

    local function localeInformationCallback(arg3, arg4) -- Luacid: unused: defined but never referenced
        if not arg3 then
            userExperienceLanguageSettingsCallback(false, arg4)

            return
        end

        var9:Start(function(arg5, arg6)
            local success = false
            local var12 = tryGetErrorMessage(arg5, arg6)
            local result

            if var12 ~= nil then
                result = "Experience Supported Language Language Request: " .. var12
            else
                success, result = pcall(function()
                    local var13 = HttpService:JSONDecode(arg6.Body)
                    local tbl8 = ({})

                    for k, value in pairs(var13.data) do
                        tbl8[k] = value.languageCode
                    end

                    for _, value in tbl8 do
                        for value2, value3 in tbl4 do
                            if value3.languageCode == value then
                                table.insert(tbl3, value2)
                            end
                        end
                    end
                end)
            end

            if not success then
                var1:warning(
                    "GameSettings language selector initialization: Failed to get response from Localization API for " .. var6 .. " with error message: " .. result
                )
            end

            if arg4 == nil then
                arg4 = result
            end

            local var13 = success and arg3
            local var14 = arg4

            if not var13 then
                userExperienceLanguageSettingsCallback(false, var14)

                return
            end

            var7:Start(function(arg7, arg8)
                local success2 = false
                local var15 = tryGetErrorMessage(arg7, arg8)
                local result2

                if var15 ~= nil then
                    result2 = "Experience Source Language Request: " .. var15
                else
                    success2, result2 = pcall(function()
                        local languageCode = HttpService:JSONDecode(arg8.Body).languageCode
                        locale = tbl1[languageCode]
                    end)
                end
                if not success2 then
                    var1:warning(
                        "GameSettings language selector initialization: Failed to get response from GameInternationalization API for " .. var4 .. " with error message: " .. result2
                    )
                end

                if var14 == nil then
                    var14 = result2
                end

                experienceSourceLanguageCallback(success2 and var13, var14)
            end)
        end)
    end

    var5:Start(function(arg3, arg4)
        local success = false
        local var12 = tryGetErrorMessage(arg3, arg4)
        local result

        if var12 ~= nil then
            result = "Locale Information Request: " .. var12
        else
            success, result = pcall(function()
                local var13 = HttpService:JSONDecode(arg4.Body)

                for _, value in pairs(var13.data) do
                    local languageCode = value.locale.language.languageCode
                    local id = value.locale.language.id
                    local name = value.locale.language.name
                    local locale2 = value.locale.locale
                    local id2 = value.locale.id
                    local name2 = value.locale.name

                    if tbl1[languageCode] == locale2 then
                        tbl6[id] = id2
                    end

                    tbl4[locale2] = {
                        localeName = name2,
                        localeId = id2,
                        languageName = name,
                        languageId = id,
                        languageCode = languageCode
                    }

                    tbl5[id2] = locale2
                    tbl2[name2] = locale2
                end
            end)
        end
        if not success then
            var1:warning(
                "GameSettings language selector initialization: Failed to get response from Localization API for " .. url .. " with error message: " .. result
            )
        end

        if not success then
            userExperienceLanguageSettingsCallback(false, result)

            return
        end

        var9:Start(function(arg5, arg6)
            local success2 = false
            local var13 = tryGetErrorMessage(arg5, arg6)
            local result2

            if var13 ~= nil then
                result2 = "Experience Supported Language Language Request: " .. var13
            else
                success2, result2 = pcall(function()
                    local var14 = HttpService:JSONDecode(arg6.Body)
                    local tbl8 = ({})

                    for k, value in pairs(var14.data) do
                        tbl8[k] = value.languageCode
                    end

                    for _, value in tbl8 do
                        for value2, value3 in tbl4 do
                            if value3.languageCode == value then
                                table.insert(tbl3, value2)
                            end
                        end
                    end
                end)
            end

            if not success2 then
                var1:warning(
                    "GameSettings language selector initialization: Failed to get response from Localization API for " .. var6 .. " with error message: " .. result2
                )
            end

            if result == nil then
                result = result2
            end

            local bool2 = success2 and success
            local var14 = result

            if not bool2 then
                userExperienceLanguageSettingsCallback(false, var14)

                return
            end

            var7:Start(function(arg7, arg8)
                local success3 = false
                local var15 = tryGetErrorMessage(arg7, arg8)
                local result3

                if var15 ~= nil then
                    result3 = "Experience Source Language Request: " .. var15
                else
                    success3, result3 = pcall(function()
                        local languageCode = HttpService:JSONDecode(arg8.Body).languageCode
                        locale = tbl1[languageCode]
                    end)
                end
                if not success3 then
                    var1:warning(
                        "GameSettings language selector initialization: Failed to get response from GameInternationalization API for " .. var4 .. " with error message: " .. result3
                    )
                end

                if var14 == nil then
                    var14 = result3
                end

                experienceSourceLanguageCallback(success3 and bool2, var14)
            end)
        end)
    end)
end
