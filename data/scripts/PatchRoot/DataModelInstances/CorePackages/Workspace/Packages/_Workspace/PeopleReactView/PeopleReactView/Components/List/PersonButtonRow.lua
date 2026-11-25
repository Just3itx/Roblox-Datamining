-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:30:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleReactView = script:FindFirstAncestor("PeopleReactView")
local PeopleReactViewParent = PeopleReactView.Parent

local React = require(PeopleReactViewParent.React)
local RobloxAppEnums = require(PeopleReactViewParent.RobloxAppEnums)
local RobloxAppHooks = require(PeopleReactViewParent.RobloxAppHooks)
local Foundation = require(PeopleReactViewParent.Foundation)
local PeopleService = require(PeopleReactViewParent.PeopleService)
local SignalsReact = require(PeopleReactViewParent.SignalsReact)

local View = Foundation.View
local PersonButton = require(PeopleReactView.Components.Buttons.PersonButton)
local MuteVolumeButton = require(PeopleReactView.Components.Buttons.MuteVolumeButton)
local useDeviceOrientation = RobloxAppHooks.useDeviceOrientation
local useSignalState = SignalsReact.useSignalState
local PersonButtonConfigs = require(PeopleReactView.Configs.PersonButtonConfigs)
local PeoplePageLayoutContext = require(PeopleReactView.PeoplePageLayoutContext)
local SideSheetFocusContext = require(PeopleReactView.SideSheetFocusContext)
local getPersonButtonRowSelectionBehaviorLeft = require(PeopleReactView.Utils.getPersonButtonRowSelectionBehaviorLeft)

local service = PeopleService.getService("Flags")
local GetFFlagAddPeoplePageCardLayout = service.GetFFlagAddPeoplePageCardLayout
local FFlagVoiceVolumeControlsPerUserPlayerListButton = service.FFlagVoiceVolumeControlsPerUserPlayerListButton
local FFlagSideSheetOpenPeoplePage = require(PeopleReactViewParent.SharedFlags).FFlagSideSheetOpenPeoplePage
local FFlagPeopleListButtonOverflow = require(PeopleReactView.Flags.FFlagPeopleListButtonOverflow)

local function MemoizedButton(tbl1)
    local config = tbl1.config

    local var1 = if GetFFlagAddPeoplePageCardLayout() then React.useMemo(function()
        return PeopleService.getService("Constants")
    end, {}) else nil

    local onMount = React.useCallback(function(arg1)
        tbl1.onButtonMount(arg1, tbl1.buttonId)
    end, { tbl1.onButtonMount })

    local var3 = if GetFFlagAddPeoplePageCardLayout() then React.useCallback(function()
        if config.id == var1.PERSON_BUTTONS.BLOCK_PLAYER then
            config.onActivated("ingame_menu")
        elseif config.id == var1.PERSON_BUTTONS.REPORT_PLAYER then
            config.onActivated("MenuPlayerList")
        else
            config.onActivated(var1.ANALYTICS.ENTRY_POINT.PEOPLE_LIST)
        end
    end, { config.id, config.onActivated }) else nil

    return React.useMemo(function()
        return React.createElement(PersonButton, {
            text = config.text,
            icon = {
                on = config.onIcon,
                off = config.offIcon
            },
            animatedIcon = config.animatedIcon,
            buttonState = config.buttonState,
            LayoutOrder = config.layoutOrder,
            onActivated = if GetFFlagAddPeoplePageCardLayout() then var3 else config.onActivated,
            isGrayedOut = config.isGrayedOut,
            isDisabled = config.isDisabled,
            isBuilderIcon = config.isBuilderIcon,
            buttonVariant = config.buttonVariant,
            onMount = onMount
        })
    end, {
        config.text,
        config.onIcon,
        config.offIcon,
        config.animatedIcon,
        config.buttonState,
        config.layoutOrder,
        config.onActivated,
        config.isGrayedOut,
        config.isDisabled,
        config.isBuilderIcon,
        config.buttonVariant,
        onMount
    })
end

return function(tbl1)
    local var1 = React.useContext(PeoplePageLayoutContext)
    local var2 = PersonButtonConfigs(tbl1.userId, if FFlagPeopleListButtonOverflow then var1.isCompact else false)

    local var3 = useDeviceOrientation() == RobloxAppEnums.DeviceOrientationMode.Portrait
        or FFlagPeopleListButtonOverflow and var1.isCompact

    local var4 = React.useMemo(function()
        return PeopleService.getService("FocusNavigationService")
    end, {})

    local var5 = if FFlagVoiceVolumeControlsPerUserPlayerListButton then React.useMemo(function()
        return PeopleService.getService("Constants")
    end, {}) else nil

    local var6 = if FFlagVoiceVolumeControlsPerUserPlayerListButton then React.useMemo(function()
        return PeopleService.getService("PeopleVoiceChatStore")
    end, {}) else nil

    local var7 = if FFlagVoiceVolumeControlsPerUserPlayerListButton then useSignalState(var6.getShowVolumeControl) else false
    local var8 = React.useRef({})

    local onButtonMount = React.useCallback(function(arg1, str1: string)
        if arg1 then
            var8.current[str1] = arg1
            return
        end
        var8.current[str1] = nil
    end, {})

    local var10 = React.useMemo(function(): string
        local tbl2 = {}
        if GetFFlagAddPeoplePageCardLayout() then
            for _, value in var2 do
                if value.shouldShow() then
                    table.insert(tbl2, value.id)
                end
            end
        else
            for _, value in ipairs(var2) do
                if value.shouldShow() then
                    table.insert(tbl2, value.id)
                end
            end
        end
        table.sort(tbl2)
        return table.concat(tbl2, ",")
    end, { var2 })

    React.useEffect(function()
        local tbl2 = {}

        if FFlagVoiceVolumeControlsPerUserPlayerListButton then
            local function appendVisibleConfig(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
                if not arg1.shouldShow() then
                    return
                end

                local var11 = var8.current[arg1.id]
                if var11 then
                    table.insert(tbl2, var11)
                end
                if not var7 or arg1.id ~= var5.PERSON_BUTTONS.MUTE_PLAYER then
                    return
                end

                local var12 = var8.current[arg1.id .. "_volume"]
                if var12 then
                    table.insert(tbl2, var12)
                end
            end

            if GetFFlagAddPeoplePageCardLayout() then
                for _, value in var2 do
                    appendVisibleConfig(value)
                end
            else
                for _, value in ipairs(var2) do
                    appendVisibleConfig(value)
                end
            end
        elseif GetFFlagAddPeoplePageCardLayout() then
            for _, value in var2 do
                if not value.shouldShow() then
                    continue
                end

                local var11 = var8.current[value.id]
                if var11 then
                    table.insert(tbl2, var11)
                end
            end
        else
            for _, value in ipairs(var2) do
                if not value.shouldShow() then
                    continue
                end

                local var11 = var8.current[value.id]
                if var11 then
                    table.insert(tbl2, var11)
                end
            end
        end

        if not (#tbl2 > 0) then
            return
        end

        table.sort(tbl2, function(arg1, arg2): boolean
            return arg1.LayoutOrder < arg2.LayoutOrder
        end)

        local index = tbl1.index or 0
        var4.registerButtonRow(tbl1.userId, tbl2, index)
    end, FFlagVoiceVolumeControlsPerUserPlayerListButton and {
        tbl1.userId,
        tbl1.index,
        var4,
        var10,
        var7
    }
        or {
            tbl1.userId,
            tbl1.index,
            var4,
            var10
        })

    React.useEffect(function()
        return function()
            var4.handlePersonRemoved(tbl1.userId)
            var4.unregisterButtonRow(tbl1.userId)
        end
    end, { tbl1.userId, var4 })

    local var11 = React.useMemo(function()
        return var4.hasSelectablePlatformButton(tbl1.userId)
    end, { tbl1.userId, var4 })

    local var12 = if FFlagSideSheetOpenPeoplePage then React.useContext(SideSheetFocusContext) else false

    local selectionBehaviorLeft = React.useMemo(function()
        if FFlagSideSheetOpenPeoplePage then
            return getPersonButtonRowSelectionBehaviorLeft(var11, var12)
        end

        return if var11 then Enum.SelectionBehavior.Escape else Enum.SelectionBehavior.Stop
    end, { var12, var11 })

    if not React.useMemo(function()
        if GetFFlagAddPeoplePageCardLayout() then
            for _, value in var2 do
                if value.shouldShow() then
                    return true
                end
            end
        else
            for _, value in ipairs(var2) do
                if value.shouldShow() then
                    return true
                end
            end
        end
        return false
    end, { var2 }) then
        return nil
    end

    local tbl2 = {}
    if GetFFlagAddPeoplePageCardLayout() then
        for _, config in var2 do
            if not config.shouldShow() then
                continue
            end
            if FFlagVoiceVolumeControlsPerUserPlayerListButton and var7 and config.id == var5.PERSON_BUTTONS.MUTE_PLAYER then
                table.insert(
                    tbl2,
                    React.createElement(MuteVolumeButton, {
                        key = config.id,
                        config = config,
                        userId = tbl1.userId,
                        entryPoint = var5.ANALYTICS.ENTRY_POINT.PEOPLE_LIST,
                        muteButtonName = config.id,
                        volumeButtonName = config.id .. "_volume",
                        onButtonMount = onButtonMount
                    })
                )
            else
                table.insert(
                    tbl2,
                    React.createElement(
                        MemoizedButton,
                        {
                            key = config.id,
                            config = config,
                            buttonId = config.id,
                            onButtonMount = onButtonMount
                        }
                    )
                )
            end
        end
    else
        for _, config in ipairs(var2) do
            if not config.shouldShow() then
                continue
            end
            if FFlagVoiceVolumeControlsPerUserPlayerListButton and var7 and config.id == var5.PERSON_BUTTONS.MUTE_PLAYER then
                table.insert(
                    tbl2,
                    React.createElement(MuteVolumeButton, {
                        key = config.id,
                        config = config,
                        userId = tbl1.userId,
                        entryPoint = var5.ANALYTICS.ENTRY_POINT.PEOPLE_LIST,
                        muteButtonName = config.id,
                        volumeButtonName = config.id .. "_volume",
                        onButtonMount = onButtonMount
                    })
                )
            else
                table.insert(
                    tbl2,
                    React.createElement(
                        MemoizedButton,
                        {
                            key = config.id,
                            config = config,
                            buttonId = config.id,
                            onButtonMount = onButtonMount
                        }
                    )
                )
            end
        end
    end

    return React.createElement(View, {
        tag = {
            ["auto-xy row"] = true,
            ["gap-small"] = var3,
            ["gap-medium"] = not var3
        },
        LayoutOrder = 1,
        selectionGroup = {
            SelectionBehaviorLeft = selectionBehaviorLeft,
            SelectionBehaviorRight = Enum.SelectionBehavior.Stop
        }
    }, tbl2)
end
