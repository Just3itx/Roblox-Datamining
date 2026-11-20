-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")
local CoreGui = game:GetService("CoreGui")
local AppStorageService = game:GetService("AppStorageService")

local useLocalization = require(CorePackages.Workspace.Packages.Localization).Hooks.useLocalization

local React = require(CorePackages.Packages.React)
local Cryo = require(CorePackages.Packages.Cryo)
local UIBlox = require(CorePackages.Packages.UIBlox)
local withTooltip = UIBlox.App.Dialog.TooltipV2.withTooltip
local TooltipOrientation = UIBlox.App.Dialog.Enum.TooltipOrientation

local _Signal = require(CorePackages.Workspace.Packages.AppCommonLib).Signal

local LuauPolyfill = require(CorePackages.Packages.LuauPolyfill)
local clearTimeout = LuauPolyfill.clearTimeout
local setTimeout = LuauPolyfill.setTimeout

local tbl1 = {
    showDelay = 1000,
    dismissDelay = 7000,
    onDismissed = function(_: boolean, _: string?) end
}

return function(tbl2)
    local var1 = Cryo.Dictionary.union(tbl1, tbl2)
    local var2, var3 = React.useState(false)
    local var4, var5 = React.useState(false)
    local var6 = React.useRef(setTimeout(function() end, var1.showDelay))
    local var7 = React.useRef(setTimeout(function() end, var1.dismissDelay))

    local bool1 = not (React.useMemo(function()
        local bool1

        if var1.localStorageKey then
            local success, result = pcall(function(): string
                return AppStorageService:GetItem(var1.localStorageKey)
            end)
            if success then
                return result == "true"
            end

            bool1 = true
        else
            bool1 = false
        end
        return bool1
    end, { var1.localStorageKey }) or var4)
    local active = var2 and bool1

    local var9 = useLocalization({ headerText = var1.headerKey, bodyText = var1.bodyKey })

    local var10 = React.useCallback(function(str1: string?)
        if var1.onDismissed then
            var1.onDismissed(active, str1)
        end
        var5(true)
    end, { var5, active })

    React.useEffect(function()
        local tbl3 = {
            GuiService.MenuOpened:Connect(function()
                if bool1 then
                    var10("menuOpened")
                end
            end),
            var1.iconClickedSignal:connect(function()
                if bool1 then
                    var10("chatIconClicked")
                end
            end)
        }

        return function()
            for _, value in tbl3 do
                if value.disconnect then
                    value:disconnect()
                elseif value.Disconnect then
                    value:Disconnect()
                end
            end
        end
    end, {
        GuiService.MenuOpened,
        var1.iconClickedSignal,
        bool1,
        var10
    })

    React.useEffect(function()
        clearTimeout(var6.current)
        if not bool1 then
            return
        end

        var6.current = setTimeout(function()
            if bool1 then
                var3(true)
            end
        end, var1.showDelay)
    end, { bool1, var6 })

    React.useEffect(function()
        clearTimeout(var7.current)
        if var2 then
            var7.current = setTimeout(function()
                var10("timeout")
            end, var1.dismissDelay)
        end
    end, { var2, var7 })

    React.useEffect(function()
        if active and var1.localStorageKey then
            pcall(function()
                AppStorageService:SetItem(var1.localStorageKey, "true")
            end)
        end
    end, { active, var1.localStorageKey })

    return withTooltip(
        {
            headerText = var9.headerText,
            bodyText = var9.bodyText
        },
        {
            DisplayOrder = 10,
            active = active,
            guiTarget = CoreGui,
            preferredOrientation = TooltipOrientation.Bottom
        },
        function(arg1)
            return React.createElement("Frame", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                [React.Change.AbsoluteSize] = arg1,
                [React.Change.AbsolutePosition] = arg1
            })
        end
    )
end
