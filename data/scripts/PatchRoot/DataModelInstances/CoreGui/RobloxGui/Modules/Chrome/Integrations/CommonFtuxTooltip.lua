-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:50:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")

local UserInputService = game:GetService("UserInputService")

local useLocalization = require(CorePackages.Workspace.Packages.Localization).Hooks.useLocalization

local React = require(CorePackages.Packages.React)
local Cryo = require(CorePackages.Packages.Cryo)
local Service = require(Chrome.Service)
local LocalStore = require(Chrome.ChromeShared.Service.LocalStore)
local TooltipContext = require(Chrome.ChromeShared.Unibar.Tooltips.TooltipContext)
local _TooltipProvider = require(Chrome.ChromeShared.Unibar.Tooltips.TooltipProvider)
local useIsTooltipTurn = require(Chrome.ChromeShared.Unibar.Tooltips.useIsTooltipTurn)

local menuIconHoveredSignal = require(Chrome.Parent.TopBar.Components.Presentation.menuIconHoveredSignal)

local FtuxTooltipAnchor = require(Chrome.Integrations.FtuxTooltipAnchor)

local tbl1 = {
    id = nil,
    priority = 1,
    showDelay = 3000,
    dismissDelay = 5000,
    onDismissed = function(_: boolean, _: string?) end
}

local function func1(arg1)
    local ref = React.useRef(nil)
    local var2, _ = React.useState(false)
    local var3, var4 = React.useState(false)

    local var5 = React.useContext(TooltipContext)
    local var6 = useIsTooltipTurn(arg1.id) or false

    local var7 = React.useMemo(function()
        return if arg1.localStorageKey then LocalStore.getValue(arg1.localStorageKey) or false else false
    end, { arg1.localStorageKey })

    local var8 = arg1.isIconVisible and not (var7 or var3)
    local shouldShowTooltip = var8 and var6

    local var10 = useLocalization({ headerText = arg1.headerKey, bodyText = arg1.bodyKey })

    local var11 = React.useCallback(function(str1: string?)
        if arg1.onDismissed then
            arg1.onDismissed(shouldShowTooltip, str1)
        end
        var4(true)
        if var5 and arg1.id then
            var5.dismissTooltip(arg1.id, str1)
        end
    end, { var4, shouldShowTooltip })

    React.useEffect(function()
        local connection = if arg1.dismissOnOutsideInput and var2 and not var3 then UserInputService.InputBegan:Connect(function(input: InputObject)
            if input.UserInputType ~= Enum.UserInputType.Touch and input.UserInputType ~= Enum.UserInputType.MouseButton1
                or ref.current == nil
            then
                return
            end
            local inputPosition = input.Position
            local absolutePosition = ref.current.AbsolutePosition
            local absoluteSize = ref.current.AbsoluteSize

            if var8
                and not (inputPosition.X >= absolutePosition.X
                    and inputPosition.X <= absolutePosition.X + absoluteSize.X
                    and inputPosition.Y >= absolutePosition.Y
                    and inputPosition.Y <= absolutePosition.Y + absoluteSize.Y)
            then
                var11("outsideInput")
            end
        end) else nil

        return function()
            if connection then
                connection:Disconnect()
                connection = nil
            end
        end
    end, { var3, var2, var8 })

    React.useEffect(function()
        if var5 and arg1.id and var8 then
            var5.registerTooltip(arg1.id, arg1.priority, arg1.showDelay or tbl1.showDelay, arg1.dismissDelay or tbl1.dismissDelay)
        end

        return function()
            if var5 and arg1.id and var8 then
                var5.unregisterTooltip(arg1.id)
            end
        end
    end, { var8, arg1.id })

    React.useEffect(function()
        local tbl2 = {
            Service:onIntegrationActivated():connect(function()
                if var8 then
                    var11("unibarActivated")
                end
            end),
            Service:onIntegrationHovered():connect(function()
                if var8 then
                    var11("unibarHovered")
                end
            end),
            GuiService.MenuOpened:Connect(function()
                if var8 then
                    var11("menuOpened")
                end
            end),
            menuIconHoveredSignal:connect(function(arg2)
                if var8 and arg2 then
                    var11("menuIconHovered")
                end
            end)
        }

        return function()
            for _, value in tbl2 do
                if value.disconnect then
                    value:disconnect()
                elseif value.Disconnect then
                    value:Disconnect()
                end
            end
        end
    end, {
        Service,
        GuiService,
        menuIconHoveredSignal,
        var8,
        var11
    })
    React.useEffect(function()
        if shouldShowTooltip and arg1.localStorageKey then
            LocalStore.storeForLocalPlayer(arg1.localStorageKey, true)
        end
    end, { shouldShowTooltip, arg1.localStorageKey })

    return React.createElement(
        FtuxTooltipAnchor,
        {
            ref = ref,
            bodyText = var10.bodyText,
            headerText = var10.headerText,
            shouldShowTooltip = shouldShowTooltip
        }
    )
end

return function(tbl2)
    local var1 = Cryo.Dictionary.union(tbl1, tbl2)
    return React.createElement(func1, var1)
end
