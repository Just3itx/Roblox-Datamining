-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:51:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local ContextActionService = game:GetService("ContextActionService")

local React = require(PurchasePromptParent.React)
local useLocalization = require(PurchasePromptParent.Localization).Hooks.useLocalization
local FocusNavigationUtils = require(PurchasePromptParent.FocusNavigationUtils)
local useFocusRoot = FocusNavigationUtils.useFocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum

local default = require(PurchasePromptParent.ExternalContentSharingProtocol).ExternalContentSharingProtocol.default

local _VIPServerConfigurationView = require(script.Parent.VIPServerConfigurationView)
local _types = require(PurchasePrompt.types)

local function trim(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    return (str1:match("^%s*(.-)%s*$"))
end

local function getOtherPlayers(players)
    local otherPlayers = {}
    for _, player in players:GetPlayers() do
        if player ~= players.LocalPlayer then
            table.insert(otherPlayers, player)
        end
    end
    return otherPlayers
end

local function useVIPServerConfigurationViewModel(tbl1)
    local locales = useLocalization({
        title = "Feature.PrivateServers.Heading.ConfigurePrivateServer",
        serverName = "Feature.PrivateServers.Label.ServerName",
        whoCanJoin = "Feature.PrivateServers.Label.WhoCanJoin",
        searchPeople = "Feature.PrivateServers.Label.SearchPeople",
        inThisServer = "Feature.PrivateServers.Label.InThisServer",
        noOne = "Feature.AccountSettings.Label.DropDown.NoOne",
        add = "CommonUI.Features.Label.Add",
        friendsAllowed = "Feature.PrivateServers.Label.FriendsAllowed",
        friendsAllowedDescription = "Feature.PrivateServers.Description.FriendsAllowed",
        privateServerLink = "Feature.PrivateServers.Label.PrivateServerLink",
        anyoneWithThisLinkCanJoin = "Feature.PrivateServers.Label.AnyoneWithThisLinkCanJoin",
        generate = "Feature.PrivateServers.Action.Generate",
        generateLinkPlaceholder = "Feature.PrivateServers.Label.PrivateServerGenerateLinkPlaceholder",
        somethingWentWrong = "CommonUI.Messages.Response.SomethingWentWrong",
        continue = "CommonUI.Controls.Action.Continue"
    })

    local serverName, onServerNameChanged = React.useBinding(tbl1.defaultServerName)
    local searchText, var5 = React.useState("")

    local var6, var7 = React.useState(false)
    local var8, var9 = React.useState(false)

    local var10, var11 = React.useState({})
    local var12, var13 = React.useState({})
    local var14, var15 = React.useState(nil)

    local linkText, var17 = React.useBinding("")
    local isGeneratingLink, var19 = React.useState(false)
    local isLinkCopied, var21 = React.useState(false)
    local var22 = React.useRef(nil)
    local isSaving, var24 = React.useState(false)
    local hasError, var26 = React.useState(false)
    local var27, var28 = React.useState(function()
        return (getOtherPlayers(tbl1.players))
    end)

    local var29 = React.useRef(false)
    local var30 = React.useRef(false)
    local var31 = React.useRef(true)

    React.useEffect(function()
        tbl1.logEvent({
            event_type = "show",
            component = "private_server_config",
            subscription_status = "active",
            server_active = true,
            friends_allowed = false,
            price = tbl1.price,
            offer_type = tbl1.offerType,
            num_server_members = 0
        })
    end, {})

    React.useEffect(function()
        var31.current = true
        return function()
            var31.current = false
            if var22.current then
                task.cancel(var22.current)
            end
        end
    end, {})

    React.useEffect(function()
        local connection = tbl1.players.PlayerAdded:Connect(function(player: Player)
            var28(function(arg1)
                if table.find(arg1, player) then
                    return arg1
                end
                local var32 = table.clone(arg1)
                table.insert(var32, player)
                return var32
            end)
        end)

        local connection2 = tbl1.players.PlayerRemoving:Connect(function(player: Player)
            var28(function(arg1)
                local result = {}
                for _, value in arg1 do
                    if value ~= player then
                        table.insert(result, value)
                    end
                end
                return result
            end)
        end)
        return function()
            connection:Disconnect()
            connection2:Disconnect()
        end
    end, { tbl1.players })

    local var32 = trim(searchText)

    local bool1 = (utf8.len(var32) or 0) >= 3

    React.useEffect(function()
        if not bool1 then
            var13({})
            return nil
        end

        local bool2 = true
        local var33 = task.delay(0.3, function()
            tbl1.searchUsers(var32):andThen(function(tbl2)
                if bool2 then
                    var13(tbl2)
                end
            end):catch(function()
                if bool2 then
                    var13({})
                end
            end)
        end)
        return function()
            bool2 = false
            task.cancel(var33)
        end
    end, { var32, bool1, tbl1.searchUsers })

    local var33 = React.useCallback(function(num1: number, str1: string?)
        var11(function(arg1)
            local var33 = table.clone(arg1)
            if str1 then
                var33[num1] = str1
            else
                var33[num1] = nil
            end
            return var33
        end)
    end, {})

    local players = React.useMemo(function()
        local result = {}
        for _, value in var27 do
            local userId = value.UserId
            local displayName = value.DisplayName
            local isAdded = var10[userId] ~= nil
            table.insert(result, {
                userId = userId,
                displayName = displayName,
                isAdded = isAdded,
                onToggleAdded = function()
                    var33(userId, if isAdded then nil else displayName)
                end
            })
        end
        return result
    end, { var27, var10, var33 })

    local userId = tbl1.players.LocalPlayer.UserId
    local searchResults = React.useMemo(function()
        local result = {}
        if not bool1 then
            return result
        end
        for _, value in var12 do
            if value.userId == userId or var10[value.userId] ~= nil then
                continue
            end

            local tbl2 = {
                userId = value.userId,
                displayName = value.displayName,
                onSelected = 0
            }

            function tbl2.onSelected()
                var33(value.userId, value.displayName)
                var5("")
            end

            table.insert(result, tbl2)
        end

        return result
    end, {
        bool1,
        var12,
        var10,
        userId,
        var33
    })
    local addedPlayers = React.useMemo(function()
        local result = {}
        for value, displayName in var10 do
            table.insert(result, {
                userId = value,
                displayName = displayName,
                onRemove = function()
                    var33(value, nil)
                end
            })
        end
        table.sort(result, function(arg1, arg2): boolean
            return arg1.displayName < arg2.displayName
        end)
        return result
    end, { var10, var33 })

    local onGenerateLink = React.useCallback(function()
        if var29.current then
            return
        end
        var29.current = true
        var19(true)
        var26(false)
        tbl1.logEvent({
            event_type = "click",
            component = "private_server_config",
            subcomponent = "generate_private_server_link_btn",
            action = "generate"
        })

        tbl1.generateLink():andThen(function(str1: string)
            if var31.current then
                var15(str1)
                var17(str1)
                var19(false)
            end
        end):catch(function()
            var29.current = false
            if var31.current then
                var19(false)
                var26(true)
            end
        end)
    end, { tbl1.generateLink, tbl1.logEvent, var17 })

    local onLinkTextChanged = React.useCallback(function(str1: string)
        if var14 ~= nil and str1 ~= var14 then
            var17(var14)
        end
    end, { var14, var17 })

    local onCopyLink = React.useCallback(function()
        if var14 == nil then
            return
        end
        tbl1.logEvent(
            {
                event_type = "click",
                component = "private_server_config",
                subcomponent = "copy_private_server_link_btn"
            }
        )
        default:setClipboardText({ context = "PurchasePromptVIPServerLink", text = var14 })

        var21(true)
        if var22.current then
            task.cancel(var22.current)
        end
        var22.current = task.delay(2, function()
            var22.current = nil
            var21(false)
        end)
    end, { var14, tbl1.logEvent })

    local onFriendsAllowedChanged = React.useCallback(function(bool2: boolean)
        tbl1.logEvent({
            event_type = "click",
            component = "private_server_config",
            subcomponent = "friends_allowed_toggle",
            target_state = if bool2 then "enabled" else "disabled"
        })
        var9(bool2)
    end, { tbl1.logEvent })

    local onSave = React.useCallback(function()
        if var30.current then
            return
        end
        var30.current = true
        var24(true)
        var26(false)
        local var41 = trim((serverName:getValue()))
        local usersToAdd = {}
        for value in var10 do
            table.insert(usersToAdd, value)
        end
        tbl1.logEvent({
            event_type = "click",
            component = "private_server_config",
            subcomponent = "cta_btn",
            added_count = #usersToAdd,
            friends_allowed = var8
        })

        local save = tbl1.save
        local tbl3 = { name = 0, friendsAllowed = 0, usersToAdd = 0 }
        if var41 == "" or var41 == tbl1.defaultServerName then
            var41 = nil
        end

        tbl3.name = var41
        tbl3.friendsAllowed = var8
        tbl3.usersToAdd = usersToAdd

        save(tbl3):andThen(function()
            if var31.current then
                tbl1.onSaved()
            end
        end):catch(function()
            var30.current = false
            if var31.current then
                var24(false)
                var26(true)
            end
        end)
    end, {
        serverName,
        var10,
        var8,
        tbl1.save,
        tbl1.onSaved,
        tbl1.defaultServerName,
        tbl1.logEvent
    })

    local isSearchMenuOpen = #searchResults > 0 and not var6

    local onSearchTextChanged = React.useCallback(function(str1: string)
        var7(false)
        var5(str1)
    end, {})

    local onSearchMenuDismissed = React.useCallback(function()
        var7(true)
    end, {})

    local onDismiss = React.useCallback(function()
        tbl1.logEvent({ event_type = "click", component = "private_server_config", subcomponent = "cancel_btn" })
        tbl1.onClose()
    end, { tbl1.onClose, tbl1.logEvent })

    local var45 = React.useCallback(function()
        if isSearchMenuOpen then
            var7(true)
        elseif not var30.current then
            onDismiss()
        end
    end, { isSearchMenuOpen, onDismiss })

    local focusRootRef = useFocusRoot({
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.CentralOverlay,
        isAutoFocusRoot = true,
        isFocusable = not isSearchMenuOpen
    })

    local var47 = React.useRef(var45)
    var47.current = var45

    React.useEffect(function()
        ContextActionService:BindCoreAction("VIPServerConfigurationCancelButtonBind", function(_, userInputState)
            if userInputState == Enum.UserInputState.Begin then
                var47.current()
            end
        end, false, Enum.KeyCode.ButtonB)
        return function()
            ContextActionService:UnbindCoreAction("VIPServerConfigurationCancelButtonBind")
        end
    end, {})

    return {
        locales = locales,
        serverName = serverName,
        onServerNameChanged = onServerNameChanged,
        searchText = searchText,
        onSearchTextChanged = onSearchTextChanged,
        isSearchMenuOpen = isSearchMenuOpen,
        onSearchMenuDismissed = onSearchMenuDismissed,
        searchResults = searchResults,
        players = players,
        addedPlayers = addedPlayers,
        friendsAllowed = var8,
        onFriendsAllowedChanged = onFriendsAllowedChanged,
        link = var14,
        linkText = linkText,
        onLinkTextChanged = onLinkTextChanged,
        isGeneratingLink = isGeneratingLink,
        onGenerateLink = onGenerateLink,
        onCopyLink = onCopyLink,
        isLinkCopied = isLinkCopied,
        hasError = hasError,
        isSaving = isSaving,
        onSave = onSave,
        onCancel = var45,
        onDismiss = onDismiss,
        focusRootRef = focusRootRef
    }
end

return useVIPServerConfigurationViewModel
