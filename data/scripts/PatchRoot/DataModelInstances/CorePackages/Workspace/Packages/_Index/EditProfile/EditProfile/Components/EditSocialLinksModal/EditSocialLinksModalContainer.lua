-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfile = script:FindFirstAncestor("EditProfile")
local HttpService = game:GetService("HttpService")
local EditSocialLinksModal = require(script.Parent.EditSocialLinksModal)
local EditProfileParent = EditProfile.Parent
local React = require(EditProfileParent.React)
local LuaSocialLibrariesDeps = require(EditProfileParent.LuaSocialLibrariesDeps)
local NavigateDown = require(EditProfileParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(EditProfileParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(EditProfileParent.RobloxAppNavigation).NavigationCommands else nil
local AppPage = require(EditProfileParent.RobloxAppEnums).AppPage
local getDeepValue = LuaSocialLibrariesDeps.SocialLibraries.config({}).Dictionary.getDeepValue
local SocialLinksNetworking = require(EditProfile.Networking.SocialLinksNetworking)
local useDispatch = require(EditProfileParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useLocalUserId = require(EditProfileParent.RobloxAppHooks).useLocalUserId
local useNavigation = require(EditProfileParent.Navigation).useNavigation
local useSelector = require(EditProfileParent.RoactUtils).Hooks.RoactRodux.useSelector

local FFlagProfileEnableSocialNetworksUsernames = require(EditProfileParent.SharedFlags).FFlagProfileEnableSocialNetworksUsernames

local function EditSocialLinksModalContainer()
    local var1 = useDispatch()
    local userId = useLocalUserId()
    local var3 = useNavigation()

    local var4 = useSelector(function(arg1)
        return getDeepValue(arg1, "Profile.SocialLinks.selfSocialLinks")
    end)

    local function cancelOnActivated() -- Luacid: Inlined by compiler; 1 call site recovered
        var3.goBack()
    end

    local function openEditSocialNetworksErrorModal(errorCode)
        local tbl1 = {
            name = AppPage.EditSocialNetworksError,
            extraProps = { errorCode = errorCode }
        }

        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
            return
        end
        var1(NavigateDown(tbl1))
    end

    return React.createElement(EditSocialLinksModal, {
        socialNetworksVisbility = var4.visibility,
        socialNetworks = var4.socialLinks,
        cancelOnActivated = cancelOnActivated,
        saveOnActivated = function(promotionChannelsVisibilityPrivacy: string, facebook: string, twitter: string, youtube: string, twitch: string, guilded: string) -- name: saveSocialLinks
            return var1(
                SocialLinksNetworking.SetSocialLinks.API({
                    promotionChannelsVisibilityPrivacy = promotionChannelsVisibilityPrivacy,
                    facebook = facebook,
                    twitter = twitter,
                    youtube = youtube,
                    twitch = twitch,
                    guilded = guilded
                })
            ):andThen(
                function(_)
                    var1(SocialLinksNetworking.GetSelfSocialLinks.API({ alwaysReturnUrls = false, filterLink = false })):catch(function(_) end)

                    var1(SocialLinksNetworking.GetSocialLinks.API({ userId = userId, alwaysReturnUrls = true, filterLink = true })):andThen(
                        function(_)
                            if not FFlagProfileEnableSocialNetworksUsernames then
                                return
                            end

                            var1(SocialLinksNetworking.GetSocialLinks.API({ userId = userId, alwaysReturnUrls = false, filterLink = true }))
                        end
                    ):catch(
                        function(_) end
                    )

                    cancelOnActivated()
                end
            ):catch(
                function(arg1)
                    local success, result = pcall(function()
                        return HttpService:JSONDecode(arg1.Body)
                    end)

                    local code = success and result and result.errors and result.errors[1] and result.errors[1].code or -1

                    openEditSocialNetworksErrorModal(code)
                end
            )
        end
    })
end

return EditSocialLinksModalContainer
