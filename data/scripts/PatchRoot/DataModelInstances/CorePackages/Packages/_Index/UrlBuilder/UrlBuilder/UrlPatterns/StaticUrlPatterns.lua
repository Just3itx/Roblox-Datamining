-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("EnableShopGiftCardsURL", false)

return function(arg1)
    local function isQQ() -- Luacid: Inlined by compiler; 4 call sites recovered
        return string.find(arg1.fromString("corp:")(), "qq.com")
    end

    return {
        catalog = arg1.fromString("www:catalog"),
        buildersClub = arg1.fromString("www:mobile-app-upgrades/native-ios/bc"),
        trades = arg1.fromString("www:trades"),
        profile = arg1.fromString("www:users/profile"),
        friends = arg1.fromString("www:users/friends"),
        groups = arg1.fromString("www:my/communities"),
        inventory = arg1.fromString("www:users/inventory"),
        messages = arg1.fromString("www:my/messages"),
        feed = arg1.fromString("www:feeds/inapp"),
        develop = arg1.fromString("www:develop"),
        creatorHub = arg1.fromString("create:"),
        blog = arg1.fromString("blog:"),
        giftCards = function(source)
            local str1 = if game:GetFastFlag("EnableShopGiftCardsURL") then "www:shopgiftcards?ref={source}" else "www:giftcards?ref={source}"
            return arg1.fromString(str1)({ source = source or "" })
        end,
        giftCardsWithRedeem = function(source, arg2)
            if not arg2 or arg2 == "" then
                return arg1.fromString("www:shopgiftcards?ref={source}")({ source = source })
            end

            local var1 = "www:giftcards-" .. arg2 .. "?ref={source}"
            return arg1.fromString(var1)({ source = source })
        end,
        redeem = arg1.fromString("www:redeem"),
        amazonStore = arg1.fromString("https://www.amazon.com/roblox"),
        help = arg1.fromString(if isQQ() then "corp:faq" else "www:help"),
        safetyDashboard = {
            main = arg1.fromString("www:safety-dashboard?t_source={source|app}"),
            reportInbox = function(arg2)
                return arg1.fromString("www:safety-dashboard?t_source={source|app}")(arg2) .. "#/report-inbox"
            end,
            violation = arg1.fromString("www:safety-dashboard?vid={id}&t_source={source|app}"),
            violations = function(arg2)
                return arg1.fromString("www:safety-dashboard?t_source={source|app}")(arg2) .. "#/violations"
            end
        },
        appealsPortal = {
            main = arg1.fromString("www:report-appeals?t_source={source|app}"),
            violation = arg1.fromString("www:report-appeals?vid={id}&t_source={source|app}")
        },
        supportCenter = {
            main = arg1.fromString("www:support-center"),
            ticket = arg1.fromString("www:support-center#!/tickets/{universeId}/{ticketId}")
        },
        email = {
            getSetEmail = arg1.fromString("accountSettings:v1/email"),
            sendVerificationEmail = arg1.fromString("accountSettings:v1/email/verify")
        },
        about = {
            us = function(localeCode)
                return arg1.fromString("www:info/about-us?locale={localeCode}")({ localeCode = localeCode or "" })
            end,
            careers = function(localeCode)
                if isQQ() then
                    return arg1.fromString("corp:careers.html")
                end
                return arg1.fromString("www:info/jobs?locale={localeCode}")({ localeCode = localeCode or "" })
            end,
            parents = function(localeCode)
                return arg1.fromString("www:info/parents?locale={localeCode}")({ localeCode = localeCode or "" })
            end,
            terms = function(arg2)
                if isQQ() and arg2.useGameQQUrls then
                    return arg1.fromString("https://game.qq.com/contract.shtml")()
                end
                return arg1.fromString("www:info/terms")()
            end,
            privacy = function(arg2)
                if isQQ() and arg2.useGameQQUrls then
                    return arg1.fromString("https://game.qq.com/privacy_guide.shtml")()
                end
                return arg1.fromString("www:info/privacy")()
            end,
            guidelines = arg1.fromString("www:info/community-guidelines"),
            support = arg1.fromString("www:support")
        },
        settings = {
            account = arg1.fromString("www:my/account#!/info"),
            security = arg1.fromString("www:my/account#!/security"),
            privacy = arg1.fromString("www:my/account#!/privacy"),
            parentalControls = arg1.fromString("www:my/account#!/parental-controls"),
            billing = arg1.fromString("www:my/account#!/billing"),
            subscriptions = arg1.fromString("www:my/account#!/subscriptions"),
            robux = arg1.fromString("www:my/account#!/robux"),
            notifications = arg1.fromString("www:my/account#!/notifications"),
            appPermissions = arg1.fromString("www:my/account#!/app-permissions"),
            screentimeSettings = arg1.fromString("www:my/account#!/privacy/Screentime"),
            blockedExperiencesSettings = arg1.fromString("www:my/account#!/privacy/ContentRestrictions/BlockedExperiences"),
            blockedUsersSettings = arg1.fromString("www:my/account#!/privacy/BlockedUsers"),
            experienceChatSettings = arg1.fromString("www:my/account#!/privacy/Communication/ExperienceChat"),
            partySettings = arg1.fromString("www:my/account#!/privacy/Communication/Party"),
            partySettingsV2 = arg1.fromString("www:my/account#!/privacy/Communication/PartyAndPartyChat"),
            communicationSettings = arg1.fromString("www:my/account#!/privacy/Communication"),
            voiceSettings = arg1.fromString("www:my/account#!/privacy/Communication/Voice"),
            tradingInventorySettings = arg1.fromString("www:my/account#!/privacy/TradingAndInventory"),
            friendsContactsSettings = arg1.fromString("www:my/account#!/privacy/FriendsAndContacts"),
            privateServerSettings = arg1.fromString("www:my/account#!/privacy/VisibilityAndPrivateServers/PrivateServerPrivacy"),
            visibilitySettings = arg1.fromString("www:my/account#!/privacy/VisibilityAndPrivateServers/Visibility")
        },
        tencent = {
            childrenPrivacyGuide = arg1.fromString("https://game.qq.com/privacy_guide_children.shtml"),
            luobuRiderTerms = arg1.fromString("https://roblox.qq.com/web201904/newsdetail.html?newsid=12429812"),
            reputationInfo = arg1.fromString("https://gamecredit.qq.com/static/games/index.htm"),
            luobuThirdPartyDataUse = arg1.fromString("https://game.qq.com/zlkdatasys/privacy_SDK.html")
        },
        idVerification = {
            verify = arg1.fromString("www:id-verification/verify"),
            getAge = arg1.fromString("apis:age-verification-service/v1/age-verification/get-verified-age")
        },
        notifications = {
            clearUnread = arg1.fromString("notifications:stream-notifications/clear-unread"),
            unreadCount = arg1.fromString("notifications:stream-notifications/unread-count")
        },
        securityAlert = arg1.fromString("www:security-feedback?payload={payload}&username={username}"),
        securityAlertWithChannel = arg1.fromString("www:security-feedback?payload={payload}&username={username}&channel={channel}")
    }
end
