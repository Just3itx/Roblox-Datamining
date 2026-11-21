-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local FriendsLandingParent = FriendsLanding.Parent

local dependencies = require(FriendsLanding.dependencies)
local EnumScreens = require(FriendsLanding.EnumScreens)
local AppPage = require(FriendsLandingParent.RobloxAppEnums).AppPage
local llama = dependencies.llama
local tutils = dependencies.tutils
local ButtonClickEvents = require(script.Parent.ButtonClickEvents)
local ImpressionEvents = require(script.Parent.ImpressionEvents)
local NavigatedFromPagesEnum = require(script.Parent.NavigatedFromPagesEnum)
local ShowMoreSectionTypeEnum = require(FriendsLanding.Enums.ShowMoreSectionTypeEnum)
local Logger = require(script.Parent.Logger)

local module = {}
module.__index = module

module.DiagCounters = {
    UserLoadedPage = game:DefineFastString("FriendsLandingUserLoadedPageCounter", "FriendsLandingUserLoadedPage"),
    ShowMoreButtonPressedFriends = game:DefineFastString("ShowMoreButtonPressedFriends", "ShowMoreButtonPressedFriends"),
    ShowMoreButtonPressedFriendRequests = game:DefineFastString("ShowMoreButtonPressedFriendRequests", "ShowMoreButtonPressedFriendRequests")
}

module.Navigation = {
    [EnumScreens.AddFriends] = game:DefineFastString("FriendsLandingNavigationAddFriendsCounter", "FriendsLandingNavigationAddFriends"),
    [EnumScreens.ViewUserProfile] = game:DefineFastString("FriendsLandingNavigationViewUserProfileCounter", "FriendsLandingNavigationViewUserProfile"),
    [EnumScreens.GameDetailsPeekView] = game:DefineFastString(
        "FriendsLandingNavigationGameDetailsPeekViewCounter",
        "FriendsLandingNavigationGameDetailsPeekView"
    ),
    [EnumScreens.SearchFriends] = game:DefineFastString("FriendsLandingSearchFriendsCounter", "FriendsLandingSearchFriends")
}

module.Navigation[AppPage.Home] = game:DefineFastString("AddFriendsHomeEntryCounter", "AddFriendsHomeEntry")

module.Navigation.ViewUserProfileAddFriends = game:DefineFastString("FriendsLandingViewUserProfileAddFriendsCounter", "FriendsLandingViewUserProfileAddFriends")

module.Navigation.ConnectWithFriends = game:DefineFastString("AddFriendsConnectWithFriendsCounter", "AddFriendsConnectWithFriends")

module.DiagStats = {
    LoadingPageTime = game:DefineFastString("FriendsLandingLoadingPageTimeStats", "FriendsLandingLoadingPageTime"),
    MountingPageTime = game:DefineFastString("FriendsLandingMountingPageTimeStats", "FriendsLandingMountingPageTime")
}

module.BASE_CONTEXT = "friendsLanding"

function module.new(arg1, localUserId, _getLoadingTimeInfo)
    assert(localUserId, "FriendsLanding must be passed the ID of the local user")

    local tbl1 = {
        _diagImpl = arg1.Diag,
        _eventStreamImpl = arg1.EventStream,
        localUserId = localUserId,
        _getLoadingTimeInfo = _getLoadingTimeInfo,
        _reportedPagePerformanceOnce = {}
    }
    setmetatable(tbl1, module)

    return tbl1
end

function module:navigate(arg1)
    Logger:info("navigate to {}", arg1)
    local var1 = module.Navigation[arg1]
    if var1 then
        self._diagImpl:reportCounter(var1, 1)
        return
    end
    Logger:error("Error from navigate: Invalid destination '{}'", arg1)
end

function module:buttonClick(loadMoreUsers, arg1)
    assert(ButtonClickEvents.isEnumValue(loadMoreUsers), "invalid button name used")
    Logger:info("eventName: buttonClick btn: {}{}", loadMoreUsers, self:_toStringAdditionalArgs(arg1))

    local baseContext = self.BASE_CONTEXT
    if arg1 and arg1.contextOverride then
        baseContext = arg1.contextOverride
    end

    local var1 = llama.Dictionary.join(
        arg1 or {},
        {
            btn = loadMoreUsers:rawValue(),
            uid = self.localUserId,
            contextOverride = llama.None
        }
    )
    self._eventStreamImpl:setRBXEventStream(baseContext, "buttonClick", var1)

    local var2 = nil
    if loadMoreUsers == ButtonClickEvents.LoadMoreUsers then
        if var1.sectionType == ShowMoreSectionTypeEnum.FriendRequests then
            var2 = module.DiagCounters.ShowMoreButtonPressedFriendRequests
        elseif var1.sectionType == ShowMoreSectionTypeEnum.Friends then
            var2 = module.DiagCounters.ShowMoreButtonPressedFriends
        end
    end
    if var2 then
        self._diagImpl:reportCounter(var2, 1)
    end
end

function module:_toStringAdditionalArgs(arg1): string
    if not arg1 then
        return ""
    end

    local var1, _ = string.gsub(" args: " .. tutils.toString(arg1), "%s+", " ")
    return var1
end

function module:pageLoaded()
    Logger:info("pageLoaded")
    local userLoadedPage = module.DiagCounters.UserLoadedPage
    self._diagImpl:reportCounter(userLoadedPage, 1)
end

function module:pageLoadedWithArgs(arg1, arg2)
    self._eventStreamImpl:setRBXEventStream(arg1 or self.BASE_CONTEXT, "luaPageLoad", arg2)
end

function module:_pagePerformanceReport(arg1, arg2, arg3)
    local var1 = arg3 or os.clock()
    local var2 = not self._getLoadingTimeInfo and {} or self._getLoadingTimeInfo() or {}
    local startPage = var2.startPage
    local startTime = var2.startTime

    if not NavigatedFromPagesEnum.fromRawValue(startPage) or type(startTime) ~= "number" then
        Logger:warning("Cannot report loading time: incorrect startPage or startTime")
        return
    end

    local loadingTime = (var1 - startTime) * 1000
    local var3 = NavigatedFromPagesEnum[startPage].rawValue()
    local var5 = arg1 .. "_" .. var3

    local tbl1 = {
        startPage = var3,
        loadingTime = loadingTime,
        uid = self.localUserId
    }

    Logger:info("pageLoaded in " .. loadingTime .. "ms")
    self._diagImpl:reportStats(var5, loadingTime)
    self._eventStreamImpl:setRBXEventStream(self.BASE_CONTEXT, arg2, tbl1)
end

function module:_reportPagePerformanceOnceCheck(arg1): boolean
    if self._reportedPagePerformanceOnce[arg1] then
        return true
    end
    self._reportedPagePerformanceOnce[arg1] = true
    return false
end

function module.pageMountingTimeReport(arg1, arg2)
    if arg1:_reportPagePerformanceOnceCheck("pageMountingTime") then
        return
    end
    arg1:_pagePerformanceReport(module.DiagStats.MountingPageTime, "pageMountingTime", arg2)
end

function module.pageLoadingTimeReport(arg1, arg2)
    if arg1:_reportPagePerformanceOnceCheck("pageLoadingTime") then
        return
    end
    arg1:_pagePerformanceReport(module.DiagStats.LoadingPageTime, "pageLoadingTime", arg2)
end

function module:reportAddFriendsEntrypoint(home, arg1)
    assert(module.Navigation[home] ~= nil, "invalid screen")
    if home == AppPage.Home then
        self._eventStreamImpl:setRBXEventStream("addUniversalFriends", "buttonClick", {
            btn = "LegacyAddFriendsButton",
            absolutePosition = 1,
            showContactImporterModal = if arg1 then arg1.showContactImporterModal else nil
        })
    end
    self._diagImpl:reportCounter(module.Navigation[home], 1)
end

function module:impressionEvent(arg1, arg2)
    assert(ImpressionEvents.isEnumValue(arg1), "invalid impression name used")

    self._eventStreamImpl:setRBXEventStream("addUniversalFriends", arg1:rawValue(), arg2)
    self._diagImpl:reportCounter(arg1:rawValue(), 1)
end

return module
