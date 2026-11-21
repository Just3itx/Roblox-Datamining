-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:31:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContactImporterParent = script:FindFirstAncestor("ContactImporter").Parent

local IXPService = game:GetService("IXPService")
local MessageBusService = game:GetService("MessageBusService")

local React = require(ContactImporterParent.React)
local useNavigation = require(ContactImporterParent.Navigation).useNavigation
local SocialModalsCommon = require(ContactImporterParent.SocialModalsCommon)
local Promise = require(ContactImporterParent.Promise)
local PermissionsProtocol = require(ContactImporterParent.PermissionsProtocol).PermissionsProtocol
local AppUserLayers = require(ContactImporterParent.ExperimentLayers).AppUserLayers
local RoactAppExperiment = require(ContactImporterParent.RoactAppExperiment)
local useAppPolicy = require(ContactImporterParent.UniversalAppPolicy).useAppPolicy

local getDeepValue = require(ContactImporterParent.LuaSocialLibrariesDeps).SocialLibraries.config({}).Dictionary.getDeepValue

local default = PermissionsProtocol.default
local tbl1 = { PermissionsProtocol.Permissions.CONTACTS_ACCESS }
local EnumScreens = SocialModalsCommon.EnumScreens
local SettingsRoute = require(ContactImporterParent.LinkingProtocol).Enums.SettingsRoute

local SharedFlags = require(ContactImporterParent.SharedFlags)
local FFlagCIDeeplinkEnabledForAll = SharedFlags.FFlagCIDeeplinkEnabledForAll
local FFlagCiDeprecateFindFriendsModal = SharedFlags.FFlagCiDeprecateFindFriendsModal
local FFlagAddFriendsPageFAEUpsell = SharedFlags.FFlagAddFriendsPageFAEUpsell

local autoPromptStatus = require(script.Parent.Parent.Signals.autoPromptStatus)

local messageId = MessageBusService:GetMessageId("Realtime", "appResume")

local function useBeginContactImporter(tbl2)
    local var1 = useNavigation()
    local var2, var3 = React.useState(false)

    local var4 = useAppPolicy(function(arg1)
        return arg1.getContactImporterEnabled()
    end)

    local entryPoint = tbl2 and tbl2.entryPoint or nil
    local bool1 = (getDeepValue(var1, "state.routeName") or {}) == EnumScreens.ContactImporter

    local var5 = useAppPolicy(function(arg1)
        return arg1.getContactImporterEncouraged()
    end)

    local var6 = if FFlagCIDeeplinkEnabledForAll then nil else RoactAppExperiment.useUserExperiment({ AppUserLayers.ContactImporterDevicePermissionNeededModalExposure }, function(arg1)
        return (arg1[AppUserLayers.ContactImporterDevicePermissionNeededModalExposure] or {}).systemSettingsDeeplinkEnabled
    end, false)

    local bool2 = not var5

    local var7 = React.useCallback(function(arg1)
        local bool3 = arg1.status == PermissionsProtocol.Status.AUTHORIZED
        var3(bool3)

        if bool3 then
            var1.navigate(EnumScreens.ContactsList, { shouldUpdateUserSettings = true, entrypoint = entryPoint })
        end
    end, { var1, entryPoint })

    local var8 = React.useCallback(function(arg1)
        local status = arg1.status

        if status == PermissionsProtocol.Status.AUTHORIZED then
            var3(true)
            if FFlagAddFriendsPageFAEUpsell then
                autoPromptStatus.setStatus(false)
            end
        elseif status == PermissionsProtocol.Status.DENIED then
            if var5 then
                if FFlagAddFriendsPageFAEUpsell then
                    local startTime = os.clock()
                    default:requestPermissions(tbl1):andThen(function(arg2)
                        local bool3 = os.clock() - startTime >= 0.5 or arg2.status == PermissionsProtocol.Status.AUTHORIZED
                        autoPromptStatus.setStatus(bool3)
                        return arg2
                    end):andThen(var7)
                else
                    default:requestPermissions(tbl1):andThen(var7)
                end
            elseif FFlagAddFriendsPageFAEUpsell then
                autoPromptStatus.setStatus(false)
            end
        elseif FFlagAddFriendsPageFAEUpsell then
            autoPromptStatus.setStatus(false)
        end
        return Promise.resolve(arg1.status)
    end, { var7, var5 })

    local var9 = React.useCallback(function()
        if FFlagCiDeprecateFindFriendsModal and bool1 then
            default:requestPermissions(tbl1):andThen(function(arg1)
                if arg1.status == PermissionsProtocol.Status.AUTHORIZED then
                    var3(true)
                    var1.replace(EnumScreens.ContactsList, { entrypoint = entryPoint })
                    return
                end
                var1.replace(EnumScreens.SettingsPermissionInteractiveAlert, { settingsRoute = SettingsRoute.Contacts })
            end)

            return
        end

        if var5 then
            if var2 then
                var1.navigate(EnumScreens.ContactsList, { entrypoint = entryPoint })
                return
            end

            if not FFlagCIDeeplinkEnabledForAll then
                IXPService:LogUserLayerExposure(AppUserLayers.ContactImporterDevicePermissionNeededModalExposure)
            end

            if var6 or FFlagCIDeeplinkEnabledForAll then
                var1.navigate(EnumScreens.SettingsPermissionInteractiveAlert, { settingsRoute = SettingsRoute.Contacts })
                return
            end

            var1.navigate(EnumScreens.ContactsRevokedAccessDialog)
            return
        end

        if not bool2 then
            return
        end

        default:requestPermissions(tbl1):andThen(function(arg1)
            if arg1.status == PermissionsProtocol.Status.AUTHORIZED then
                var1.navigate(EnumScreens.ContactsList, { entrypoint = entryPoint })
                return
            end

            if not FFlagCIDeeplinkEnabledForAll then
                IXPService:LogUserLayerExposure(AppUserLayers.ContactImporterDevicePermissionNeededModalExposure)
            end

            if var6 or FFlagCIDeeplinkEnabledForAll then
                var1.navigate(EnumScreens.SettingsPermissionInteractiveAlert, { settingsRoute = SettingsRoute.Contacts })
                return
            end

            var1.navigate(EnumScreens.ContactsRevokedAccessDialog)
        end)
    end, {
        var2,
        var4,
        var5,
        bool2,
        entryPoint,
        var6
    })

    React.useEffect(function(): (() -> ())?
        if FFlagAddFriendsPageFAEUpsell then
            autoPromptStatus.setStatus(nil)
        end
        local var10 = default:hasPermissions(tbl1)
        if var4 and (var5 or bool2) then
            var10:andThen(var8)
        elseif FFlagAddFriendsPageFAEUpsell then
            autoPromptStatus.setStatus(false)
        end

        return if FFlagAddFriendsPageFAEUpsell then function()
            autoPromptStatus.setStatus(nil)
        end else nil
    end, { var4, var5, bool2 })

    React.useEffect(function()
        if not (var6 or FFlagCIDeeplinkEnabledForAll) then
            return nil
        end

        local var10 = MessageBusService:Subscribe(messageId, function()
            default:hasPermissions(tbl1):andThen(function(arg1)
                if arg1 and arg1.status == PermissionsProtocol.Status.AUTHORIZED then
                    var3(true)
                end
            end)
        end, false, true)
        return function()
            var10:Disconnect()
        end
    end, { var6 })

    if var4 then
        if var5 or bool2 then
            return var2, var9
        end
        return nil, nil
    end

    return nil, nil
end

return useBeginContactImporter
