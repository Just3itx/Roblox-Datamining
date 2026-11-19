-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")
local Chat = game:GetService("Chat")

local tbl1 = {
    System = "InGame.Chat.Label.SystemMessagePrefix",
    Team = "InGame.Chat.Label.TeamMessagePrefix"
}

local tbl2 = {
    ["From(%s.+)"] = { English = "From", LocalizationKey = "InGame.Chat.Label.From" },
    ["To(%s.+)"] = { English = "To", LocalizationKey = "InGame.Chat.Label.To" }
}

local module = { _hasFetchedLocalization = false }

function module._getTranslator(arg1)
    if not (arg1._translator or arg1._hasFetchedLocalization) then
        arg1._hasFetchedLocalization = true

        local chatLocalization = Chat:WaitForChild("ChatLocalization", 4)
        if chatLocalization then
            arg1._translator = chatLocalization:GetTranslator(LocalizationService.RobloxLocaleId)
            LocalizationService:GetPropertyChangedSignal("RobloxLocaleId"):Connect(function()
                arg1._hasFetchedLocalization = false
                arg1._translator = nil
            end)
        else
            warn("Missing ChatLocalization. Chat interface will not be localized.")
        end
    end
    return arg1._translator
end

function module.Get<T>(arg1, arg2, arg3: T, arg4): T
    local var1 = arg3
    pcall(function()
        local var2 = arg1:_getTranslator()
        if var2 then
            var1 = var2:FormatByKey(arg2, arg4)
            return
        end
        warn("Missing Translator. Used default for", arg2)
    end)

    return var1
end

function module.LocalizeFormattedMessage(arg1, arg2)
    local var1, var2 = string.find(arg2, "{RBX_LOCALIZATION_KEY}")
    if not var1 then
        return arg2
    end

    local var3, var4 = string.find(arg2, "{RBX_LOCALIZATION_DEFAULT}")
    if not var3 then
        return arg2
    end

    local var5, var6 = string.find(arg2, "{RBX_LOCALIZATION_PARAMS}")
    local str1 = string.sub(arg2, var2 + 1, var3 - 1)

    if not var5 then
        local var7 = var4 + 1
        return arg1:Get(str1, string.sub(arg2, var7))
    end

    local str2 = string.sub(arg2, var4 + 1, var5 - 1)
    local str3 = string.sub(arg2, var6 + 1)
    local tbl3 = ({})
    for value, value2 in string.gmatch(str3, "([^%s]+)=([^%s]+)") do
        tbl3[value] = value2
    end

    return arg1:Get(str1, str2, tbl3)
end

function module.FormatMessageToSend(_, arg1, arg2, arg3, arg4)
    if arg3 and arg4 then
        return "{RBX_LOCALIZATION_KEY}" .. arg1 .. "{RBX_LOCALIZATION_DEFAULT}" .. arg2 .. "{RBX_LOCALIZATION_PARAMS}" .. arg3 .. "=" .. arg4
    end

    return "{RBX_LOCALIZATION_KEY}" .. arg1 .. "{RBX_LOCALIZATION_DEFAULT}" .. arg2
end

function module.tryLocalize(arg1, arg2)
    if tbl1[arg2] then
        return arg1:Get(tbl1[arg2], arg2)
    end

    for k, value in pairs(tbl1) do
        if string.find(arg2, k) then
            local var1 = arg1:Get(value, k)
            return string.gsub(arg2, k, var1, 1)
        end
    end

    for k, value in pairs(tbl2) do
        local var1 = string.find(arg2, k)
        local var2 = string.match(arg2, k)
        if var1 and var2 then
            local var3 = arg1:Get(value.LocalizationKey, value.English)
            return (if var1 > 1 then arg2:sub(1, var1 - 1) else "") .. var3 .. var2
        end
    end

    return arg2
end

return module
