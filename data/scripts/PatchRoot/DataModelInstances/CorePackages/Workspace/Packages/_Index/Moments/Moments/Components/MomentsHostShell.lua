-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)
local SharedFlags = require(MomentsParent.SharedFlags)

local MomentsSessionContext = require(Moments.Stores.GetMomentsStore.MomentsSessionContext)
local MomentsHostContext = require(Moments.MomentsHostContext)
local _createMomentsStore = require(Moments.Stores.GetMomentsStore.createMomentsStore)
local ExperienceDetailsSheet = require(Moments.ExperienceDetailsSheet).ExperienceDetailsSheet
local getExperienceDetailsSheetStore = require(Moments.ExperienceDetailsSheet.Sheet.getExperienceDetailsSheetStore)
local ToastOverlay = require(Moments.Components.ToastOverlay)

local function getPostStatusCardContainer()
    return require(Moments.Components.PostFeedback.PostStatusCard.PostStatusCardContainer)
end
local useIsTopMomentsShell = require(Moments.Hooks.useIsTopMomentsShell)
local FFlagMomentsCreateAvatarPosts = SharedFlags.FFlagMomentsCreateAvatarPosts
local FFlagMomentsOverlaysInTopShellOnly = require(Moments.Flags.FFlagMomentsOverlaysInTopShellOnly)
local FFlagMomentsComments = SharedFlags.FFlagMomentsComments
local FFlagMomentsAvatarLookTryOn = SharedFlags.FFlagMomentsAvatarLookTryOn
local FFlagProfileRenderAvatarMoments = SharedFlags.FFlagProfileRenderAvatarMoments
local FFlagMomentsPostFeedback = SharedFlags.FFlagMomentsPostFeedback
local Sheet = if FFlagMomentsComments then require(Moments.Components.Comments.Sheet) else nil
local FFlagMomentsCreatorAnalytics = require(Moments.Flags.FFlagMomentsCreatorAnalytics)
local PostInsights = if FFlagMomentsCreatorAnalytics then require(Moments.Components.PostInsights) else nil

local function closeSheets(arg1)
    getExperienceDetailsSheetStore(false).close()
    if Sheet ~= nil then
        local commentsSheetStore = Sheet.getCommentsSheetStore(false)
        if commentsSheetStore.getIsOpen(false) then
            commentsSheetStore.close(if arg1 == "popped" then "unmounted" else "navigation_hidden")
        end
    end
    if PostInsights ~= nil then
        PostInsights.getPostInsightsPageStore(false).close()
    end
end

local function ignoreTopShellChange(_) end

local function MomentsHostShell(tbl1)
    local bool1 = not (FFlagMomentsOverlaysInTopShellOnly or FFlagProfileRenderAvatarMoments)
        or useIsTopMomentsShell(if FFlagMomentsOverlaysInTopShellOnly then closeSheets else ignoreTopShellChange)

    local value = React.useMemo(function()
        return {
            isTopShell = if FFlagProfileRenderAvatarMoments then bool1 else nil,
            openProfile = tbl1.openProfile,
            openOwnMoments = tbl1.openOwnMoments,
            openAvatarMomentsCreation = if FFlagMomentsCreateAvatarPosts then tbl1.openAvatarMomentsCreation else nil,
            openMomentsFeedReport = tbl1.openMomentsFeedReport,
            openAvatarLookTryOn = if FFlagMomentsAvatarLookTryOn then tbl1.openAvatarLookTryOn else nil,
            openMomentCommentReport = tbl1.openMomentCommentReport,
            openBlockUser = tbl1.openBlockUser
        }
    end, {
        if FFlagProfileRenderAvatarMoments then bool1 else nil,
        tbl1.openProfile,
        tbl1.openOwnMoments,
        if FFlagMomentsCreateAvatarPosts then tbl1.openAvatarMomentsCreation else nil,
        tbl1.openMomentsFeedReport,
        tbl1.openMomentCommentReport,
        tbl1.openBlockUser,
        if FFlagMomentsAvatarLookTryOn then tbl1.openAvatarLookTryOn else nil
    })

    local var2 = not FFlagMomentsOverlaysInTopShellOnly or bool1

    local createElement = React.createElement
    local provider = MomentsSessionContext.MomentsSessionContext.Provider
    local tbl2 = {
        value = tbl1.sessionStore
    }
    local tbl3 = {
        Host = React.createElement(MomentsHostContext.MomentsHostContext.Provider, { value = value }, {
            Content = React.createElement(
                React.Fragment,
                nil,
                tbl1.children,
                if var2 then React.createElement(ExperienceDetailsSheet) else nil,
                if FFlagMomentsComments and Sheet ~= nil and var2 then React.createElement(Sheet.CommentsSheetContainer) else nil,
                if FFlagMomentsCreatorAnalytics and PostInsights ~= nil and var2 then React.createElement(PostInsights.PostInsightsPageContainer) else nil,
                if FFlagMomentsPostFeedback and var2 then React.createElement(getPostStatusCardContainer()) else nil,
                if var2 then React.createElement(ToastOverlay) else nil
            )
        })
    }
    return createElement(provider, tbl2, tbl3)
end

return MomentsHostShell
