-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:40:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChromeShared = script:FindFirstAncestor("ChromeShared")

local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)

local Foundation = require(CorePackages.Packages.Foundation)
local Badge = Foundation.Badge
local View = Foundation.View
local BadgeVariant = Foundation.Enums.BadgeVariant
local BadgeShape = Foundation.Enums.BadgeShape

local Signals = require(CorePackages.Packages.Signals)
local SignalsReact = require(CorePackages.Packages.SignalsReact)

local useLocalization = require(CorePackages.Workspace.Packages.Localization).Hooks.useLocalization

local FFlagEnableCustomTextInMenuTrailingBadge = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnableCustomTextInMenuTrailingBadge

local Service = require(ChromeShared.Service)
local LocalStore = require(ChromeShared.Service.LocalStore)

local _Chrome = require(CorePackages.Workspace.Packages.Chrome)

local signal = Signals.createSignal(nil)

local tbl1 = ({})

local function hasBeenDismissed(integrationId: string, config): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    if tbl1[integrationId] then
        return true
    end

    local maxViewCount = config.maxViewCount
    if maxViewCount <= 0 then
        return true
    end

    local value = LocalStore.getValue(config.localStorageKey)
    return maxViewCount <= (if type(value) ~= "number" then 0 else value)
end

local function recordView(config) -- Luacid: Inlined by compiler; 1 call site recovered
    if config.maxViewCount <= 0 then
        return
    end
    local value = LocalStore.getValue(config.localStorageKey)
    local var1 = if type(value) ~= "number" then 0 else value
    LocalStore.storeForLocalPlayer(config.localStorageKey, var1 + 1)
end

local function renderBadge(text: string, layoutOrder: number?)
    return React.createElement(
        View,
        { tag = "auto-xy", LayoutOrder = layoutOrder },
        {
            Badge = React.createElement(Badge, { text = text, variant = BadgeVariant.Emphasis, shape = BadgeShape.Box })
        }
    )
end

local function MenuTrailingBadge(tbl2)
    local integrationId = tbl2.integrationId
    local config = tbl2.config
    local var1 = if FFlagEnableCustomTextInMenuTrailingBadge then SignalsReact.useSignalState(config.customText or signal) else nil

    local var2, var3 = React.useState(function(): boolean
        local bool1 = not hasBeenDismissed(integrationId, config)
        if bool1 and var1 == nil then
            recordView(config)
        end
        return bool1
    end)

    local var4 = useLocalization({ text = "Feature.Catalog.Label.New" })

    React.useEffect(function()
        if not var2 then
            return
        end

        local connection = Service:onIntegrationActivated():connect(function(arg1)
            if arg1 ~= integrationId then
                return
            end
            tbl1[integrationId] = true
            LocalStore.storeForLocalPlayer(config.localStorageKey, config.maxViewCount)
            var3(false)
        end)

        return function()
            connection:disconnect()
        end
    end, {
        integrationId,
        config.localStorageKey,
        config.maxViewCount,
        var2
    })
    if var1 ~= nil then
        return renderBadge(var1, tbl2.layoutOrder)
    elseif not var2 then
        return nil
    end

    return renderBadge(var4.text, tbl2.layoutOrder)
end

return MenuTrailingBadge
