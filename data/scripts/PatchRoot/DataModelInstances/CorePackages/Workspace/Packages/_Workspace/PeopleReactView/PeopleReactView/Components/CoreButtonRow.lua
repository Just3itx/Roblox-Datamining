-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:30:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleReactView = script:FindFirstAncestor("PeopleReactView")
local PeopleReactViewParent = PeopleReactView.Parent

local Foundation = require(PeopleReactViewParent.Foundation)
local React = require(PeopleReactViewParent.React)
local PeopleService = require(PeopleReactViewParent.PeopleService)

local View = Foundation.View
local CoreButton = require(PeopleReactView.Components.Buttons.CoreButton)
local CoreButtonConfigs = require(PeopleReactView.Configs.CoreButtonConfigs)

local service = PeopleService.getService("Flags")
local GetFFlagAddPeoplePageCardLayout = service.GetFFlagAddPeoplePageCardLayout
local FFlagEnablePeoplePageButtonOnMount = service.FFlagEnablePeoplePageButtonOnMount

local function MemoizedButton(tbl1)
    local config = tbl1.config

    local onMount = React.useCallback(function(arg1)
        tbl1.onButtonMount(arg1, config.id)
        if FFlagEnablePeoplePageButtonOnMount and arg1 and config.onMount then
            config.onMount()
        end
    end, { config.onMount, tbl1.onButtonMount, config.id })

    return React.useMemo(function()
        return React.createElement(CoreButton, {
            text = config.text,
            icon = {
                on = config.onIcon,
                off = config.offIcon
            },
            animatedIcon = config.animatedIcon,
            buttonState = config.buttonState,
            isNewIcon = config.isNewIcon,
            LayoutOrder = config.layoutOrder,
            onActivated = config.onActivated,
            onMount = onMount
        })
    end, {
        config.text,
        config.onIcon,
        config.offIcon,
        config.animatedIcon,
        config.buttonState,
        config.isNewIcon,
        config.layoutOrder,
        config.onActivated,
        onMount
    })
end

return function(tbl1)
    local var1 = CoreButtonConfigs(tbl1.chromeEnabled, tbl1.buttonActivatedTable)

    local var2 = React.useMemo(function()
        return PeopleService.getService("FocusNavigationService")
    end, {})

    local var3 = React.useRef(nil)
    local var4 = React.useRef({})

    local onButtonMount = React.useCallback(function(arg1, str1: string)
        if arg1 then
            var4.current[str1] = arg1
            return
        end
        var4.current[str1] = nil
    end, {})

    local ref = React.useCallback(function(current)
        var3.current = current

        if not current then
            return
        end

        var2.registerScrollCallback(-1, function()
            local var6 = PeopleService.getService("SettingsHubService").hubRef()

            if var6 and var6.ScrollToFrame and var3.current then
                var6:ScrollToFrame(var3.current, true)
            end
        end)
    end, { var2 })

    local tbl2 = {
        var2,
        (React.useMemo(function(): string
            local tbl2 = {}
            for _, value in ipairs(var1) do
                if value.shouldShow() then
                    table.insert(tbl2, value.id)
                end
            end
            table.sort(tbl2)
            return table.concat(tbl2, ",")
        end, { var1 }))
    }

    React.useEffect(function()
        local tbl3 = {}
        for _, value in ipairs(var1) do
            if not value.shouldShow() then
                continue
            end

            local var7 = var4.current[value.id]
            if var7 then
                table.insert(tbl3, var7)
            end
        end

        if #tbl3 > 0 then
            table.sort(tbl3, function(arg1, arg2): boolean
                return arg1.LayoutOrder < arg2.LayoutOrder
            end)

            var2.registerButtonRow(-1, tbl3, 0)
        end
    end, tbl2)

    React.useEffect(function()
        return function()
            var2.unregisterScrollCallback(-1)
            var2.unregisterButtonRow(-1)
        end
    end, { var2 })

    local var7 = React.useMemo(function()
        local result = {}

        for _, config in ipairs(var1) do
            if not config.shouldShow() then
                continue
            end

            table.insert(
                result,
                React.createElement(MemoizedButton, { key = config.id, config = config, onButtonMount = onButtonMount })
            )
        end

        return result
    end, { var1, onButtonMount })

    if #var7 == 0 then
        return nil
    end

    local function getButtonElements() -- Luacid: Inlined by compiler; 1 call site recovered
        local buttonElements = {}
        for i, value in ipairs(var7) do
            buttonElements["Button" .. i] = value
        end
        return buttonElements
    end

    return React.createElement(View, {
        tag = "size-full-0 auto-y row gap-large",
        LayoutOrder = if GetFFlagAddPeoplePageCardLayout() then tbl1.LayoutOrder else 1,
        ref = ref
    }, { (getButtonElements()) })
end
