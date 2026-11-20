-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChatService = game:GetService("TextChatService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local Url = require(CorePackages.Workspace.Packages.CoreScriptsCommon).Url
local GameSettings = UserSettings().GameSettings
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Utility = require(RobloxGui.Modules.Settings.Utility)
local var1 = require(CorePackages.Workspace.Packages.CoreScriptsInitializer).CoreLogger:new(script.Name)
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local bool1 = game:DefineFastFlag("FixChatLanguageSwitcherLabel", false)
local GetFStringChatTranslationEnabledLocales = require(RobloxGui.Modules.Flags.GetFStringChatTranslationEnabledLocales)
local engineFeature = game:GetEngineFeature("TextChatServiceSettingsSaved")

local var2 = RobloxTranslator:FormatByKey("Feature.SettingsHub.LanguageSelection.Unavailable")

return function(arg1, arg2, callback)
    local tbl1 = { "en_us" }

    local tbl2 = { en_us = 1 }

    local tbl3 = { "English" }

    local url = Url.LOCALE_URL .. string.format("v1/locales?displayValueLocale=%s", Players.LocalPlayer.LocaleId:gsub("-", "_"))
    local var4 = HttpService:RequestInternal({ Url = url, Method = "GET" })

    local function localeCodeToLanguageCodeMappingCallback(bool2: boolean, arg3)
        if not bool2 then
            var1:warning(
                "GameSettings chat language selector initialization failed to get all required information; defaulting to unavailable for the remainder of this session. Error message: "
                    .. (if arg3 == nil then "Locales call did not set error message to non-nil value" else arg3)
            )

            if bool1 then
                local var5 = arg1
                local var6 = arg1
                local var7 = arg1
                local chatLanguageSelectorFrame, chatLanguageSelectorLabel, chatLanguageSelectorMode = Utility:AddNewRow(
                    arg1,
                    RobloxTranslator:FormatByKey("Feature.SettingsHub.Chat.ChatLanguageSelectionLabel"),
                    "DropDown",
                    { var2 },
                    1
                )
                var5.ChatLanguageSelectorFrame = chatLanguageSelectorFrame
                var6.ChatLanguageSelectorLabel = chatLanguageSelectorLabel
                var7.ChatLanguageSelectorMode = chatLanguageSelectorMode
            else
                local var5 = arg1
                local var6 = arg1
                local var7 = arg1
                local chatLanguageSelectorFrame, chatLanguageSelectorLabel, chatLanguageSelectorMode = Utility:AddNewRow(arg1, "Chat Language", "DropDown", { var2 }, 1)
                var5.ChatLanguageSelectorFrame = chatLanguageSelectorFrame
                var6.ChatLanguageSelectorLabel = chatLanguageSelectorLabel
                var7.ChatLanguageSelectorMode = chatLanguageSelectorMode
            end

            arg1.ChatLanguageSelectorFrame.LayoutOrder = arg2.ChatLanguageSelectorFrame
        end

        local var5 = nil

        local chatTranslationLocale = GameSettings.ChatTranslationLocale
        if chatTranslationLocale ~= "" then
            for value, value2 in tbl1 do
                if value2 == chatTranslationLocale then
                    var5 = value
                end
            end
        end

        if chatTranslationLocale == "" or var5 == nil then
            for value, value2 in tbl1 do
                if value2 == LocalPlayer.LocaleId:gsub("-", "_") then
                    TextChatService.ChatTranslationEnabled = true
                    var5 = value
                end
            end
        end

        if var5 == nil then
            TextChatService.ChatTranslationEnabled = false
            var5 = 1
        else
            GameSettings.ChatTranslationLocale = tbl1[var5]
        end

        LocalPlayer:SetChatTranslationSettingsLocaleId(tbl1[var5])

        local var6 = tbl1[var5]

        if bool1 then
            local var7 = arg1
            local var8 = arg1
            local var9 = arg1
            local chatLanguageSelectorFrame, chatLanguageSelectorLabel, chatLanguageSelectorMode = Utility:AddNewRow(arg1, "Chat Translation Language", "DropDown", tbl3, var5)
            var7.ChatLanguageSelectorFrame = chatLanguageSelectorFrame
            var8.ChatLanguageSelectorLabel = chatLanguageSelectorLabel
            var9.ChatLanguageSelectorMode = chatLanguageSelectorMode
        else
            local var7 = arg1
            local var8 = arg1
            local var9 = arg1
            local chatLanguageSelectorFrame, chatLanguageSelectorLabel, chatLanguageSelectorMode = Utility:AddNewRow(arg1, "Chat Language", "DropDown", tbl3, var5)
            var7.ChatLanguageSelectorFrame = chatLanguageSelectorFrame
            var8.ChatLanguageSelectorLabel = chatLanguageSelectorLabel
            var9.ChatLanguageSelectorMode = chatLanguageSelectorMode
        end
        arg1.ChatLanguageSelectorFrame.LayoutOrder = arg2.ChatLanguageSelectorFrame

        arg1.ChatLanguageSelectorMode.IndexChanged:connect(function(arg4) -- name: onChatSelectionIndexUpdated
            local chatTranslationLocale2 = GameSettings.ChatTranslationLocale
            local locale = tbl1[arg4]
            GameSettings.ChatTranslationLocale = locale
            LocalPlayer:SetChatTranslationSettingsLocaleId(locale)
            var6 = locale
            callback("chat_translation_locale", chatTranslationLocale2, locale)
        end)

        local num1 = if TextChatService.ChatTranslationToggleEnabled then 1 else 2

        local var7 = arg1
        local var8 = arg1
        local var9 = arg1
        local chatTranslationToggleFrame, chatTranslationToggleLabel, chatTranslationToggleEnabler = Utility:AddNewRow(
            arg1,
            RobloxTranslator:FormatByKey("Feature.SettingsHub.Chat.TranslationToggleSetting"),
            "Selector",
            { "On", "Off" },
            num1
        )
        var7.ChatTranslationToggleFrame = chatTranslationToggleFrame
        var8.ChatTranslationToggleLabel = chatTranslationToggleLabel
        var9.ChatTranslationToggleEnabler = chatTranslationToggleEnabler

        arg1.ChatTranslationToggleFrame.LayoutOrder = arg2.ChatTranslationToggleFrame

        arg1.ChatTranslationToggleEnabler.IndexChanged:connect(function(arg4)
            local bool3 = arg4 == 1
            local chatTranslationToggleEnabled = TextChatService.ChatTranslationToggleEnabled

            if bool3 == chatTranslationToggleEnabled then
                return
            end

            if engineFeature then
                GameSettings.ChatTranslationToggleEnabled = bool3
            else
                TextChatService.ChatTranslationToggleEnabled = bool3
            end

            callback("chat_translation_toggle", chatTranslationToggleEnabled, bool3, { locale_id = var6 })
        end)

        local num2 = if TextChatService.ChatTranslationEnabled then 1 else 2

        if num2 == 2 then
            arg1.ChatLanguageSelectorFrame.Visible = false
            arg1.ChatTranslationToggleFrame.Visible = false
        end

        local var13 = arg1
        local var14 = arg1
        local var15 = arg1
        local chatTranslationFrame, chatTranslationLabel, chatTranslationEnabler = Utility:AddNewRow(
            arg1,
            RobloxTranslator:FormatByKey("Feature.SettingsHub.Chat.TranslationSetting"),
            "Selector",
            { "On", "Off" },
            num2
        )
        var13.ChatTranslationFrame = chatTranslationFrame
        var14.ChatTranslationLabel = chatTranslationLabel
        var15.ChatTranslationEnabler = chatTranslationEnabler

        arg1.ChatTranslationFrame.LayoutOrder = arg2.ChatTranslationFrame

        arg1.ChatTranslationEnabler.IndexChanged:connect(function(arg4)
            local bool3 = arg4 == 1
            local chatTranslationEnabled = TextChatService.ChatTranslationEnabled

            if engineFeature then
                GameSettings.ChatTranslationEnabled = bool3
            else
                TextChatService.ChatTranslationEnabled = bool3
            end

            callback("chat_translation", chatTranslationEnabled, bool3, { locale_id = LocalPlayer.LocaleId })

            if arg4 == 1 then
                arg1.ChatLanguageSelectorFrame.Visible = true
                arg1.ChatTranslationToggleFrame.Visible = true
                return
            end
            arg1.ChatLanguageSelectorFrame.Visible = false
            arg1.ChatTranslationToggleFrame.Visible = false
        end)
    end

    var4:Start(function(arg3, arg4)
        local success = false
        local result

        if arg3 then
            if arg4.StatusCode == 401 then
                result = "Locale Code to Language Code Mapping Request: Unauthorized"
            elseif arg4.StatusCode < 200 or arg4.StatusCode >= 400 then
                result = "Locale Code to Language Code Mapping Request Status code: " .. arg4.StatusCode
            else
                success, result = pcall(function()
                    local var5 = HttpService:JSONDecode(arg4.Body)

                    local tbl4 = {}

                    for value in (GetFStringChatTranslationEnabledLocales():gmatch("([^,]+)")) do
                        table.insert(tbl4, value)
                    end

                    local function shouldAddLocaleAsChatTranslationOption(locale) -- Luacid: Inlined by compiler; 1 call site recovered
                        for _, value in tbl4 do
                            if value == locale then
                                return true
                            end
                        end

                        return false
                    end

                    local num1 = 2
                    for _, value in pairs(var5.data) do
                        local locale = value.locale.locale
                        local name = value.locale.language.name

                        if locale == "en_us" then
                            tbl3[1] = name
                        elseif shouldAddLocaleAsChatTranslationOption(locale) then
                            table.insert(tbl3, name)
                            tbl1[num1] = locale
                            tbl2[locale] = num1
                            num1 += 1
                        end
                    end
                end)
            end
        else
            result = "Locale Code to Language Code Mapping Request: Connection error"
        end

        if not success then
            var1:warning(
                "GameSettings chat language selector initialization: Failed to get response from Localization API for " .. url .. " with error message: " .. result
            )
        end
        localeCodeToLanguageCodeMappingCallback(success, result)
    end)
end
