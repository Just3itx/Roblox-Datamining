-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:51:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")
local Players = game:GetService("Players")

local translatorForPlayer = nil
local LocalPlayer = nil
local LocaleId = nil
local connection = nil
local bindableEvent = Instance.new("BindableEvent")

local function handlePlayerOrLocaleChanged() -- Luacid: Inlined by compiler; 3 call sites recovered
    if LocalPlayer and LocalPlayer.LocaleId ~= LocaleId then
        LocaleId = LocalPlayer.LocaleId
        bindableEvent:Fire(LocaleId)
    end
end

local function reset() -- Luacid: Inlined by compiler; 1 call site recovered
    translatorForPlayer = nil
    LocalPlayer = nil

    if connection then
        connection:Disconnect()
        connection = nil
    end
end

local function getTranslator() -- Luacid: Inlined by compiler; 1 call site recovered
    LocalPlayer = not translatorForPlayer and Players.LocalPlayer

    if LocalPlayer then
        translatorForPlayer = LocalizationService:GetTranslatorForPlayer(LocalPlayer)
        handlePlayerOrLocaleChanged()
        connection = LocalPlayer:GetPropertyChangedSignal("LocaleId"):Connect(handlePlayerOrLocaleChanged)
    end

    return translatorForPlayer
end

local tbl1 = ({})

local function unregisterGui(arg1: Instance) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = tbl1[arg1]
    if not var1 then
        return
    end
    var1.connection:Disconnect()
    tbl1[arg1] = nil
end

local function makeAncestryChangedHandler(arg1: Instance, tbl2: {hasBeenAdded: boolean}) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(_, _)
        if not game:IsAncestorOf(arg1) then
            if tbl2.hasBeenAdded then
                unregisterGui(arg1)
            end
        else
            tbl2.hasBeenAdded = true
        end
    end
end

local function updateRegistryInfo(arg1, context, text) -- Luacid: Inlined by compiler; 3 call sites recovered
    arg1.context = context
    arg1.text = text
end

local function makeRegistryInfo(descendant: Instance, context, text)
    local tbl2 = {
        hasBeenAdded = game:IsAncestorOf(descendant)
    }
    updateRegistryInfo(tbl2, context, text)
    tbl2.connection = descendant.AncestryChanged:Connect((makeAncestryChangedHandler(descendant, tbl2)))

    return tbl2
end

local function registerGui(arg1, context, text) -- Luacid: Inlined by compiler; 1 call site recovered
    if tbl1[arg1] == nil then
        tbl1[arg1] = makeRegistryInfo(arg1, context, text)
        return
    end
    updateRegistryInfo(tbl1[arg1], context, text)
end

Players:GetPropertyChangedSignal("LocalPlayer"):Connect(function()
    reset()
    LocalPlayer = not translatorForPlayer and Players.LocalPlayer

    if LocalPlayer then
        translatorForPlayer = LocalizationService:GetTranslatorForPlayer(LocalPlayer)
        handlePlayerOrLocaleChanged()
        connection = LocalPlayer:GetPropertyChangedSignal("LocaleId"):Connect(handlePlayerOrLocaleChanged)
    end
end)

local module = {
    LocaleChanged = bindableEvent.Event
}

function module:TranslateGameText(context, text)
    local translator = getTranslator()

    if translator then
        return translator:RobloxOnlyTranslate(context, text)
    end
    return text
end

LocalizationService.AutoTranslateWillRun:Connect(function() -- name: retranslateAll
    for k, value in pairs(tbl1) do
        k.Text = module:TranslateGameText(value.context, value.text)
    end
end)

function module.TranslateAndRegister<T>(arg1, arg2, context, text: T): T
    arg2.Text = arg1:TranslateGameText(context, text)
    registerGui(arg2, context, text)
    return text
end

return module
