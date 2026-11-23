-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionService = game:GetService("CollectionService")

local VideoUtils = script:FindFirstAncestor("VideoUtils")
local VideoUtilsParent = VideoUtils.Parent

local React = require(VideoUtilsParent.React)

local _FeedVideoPlaybackContext = require(script.Parent.FeedVideoPlaybackContext)
local ViewportAutoplayVideoKeyAttribute = require(script.Parent.ViewportAutoplayVideoKeyAttribute)
local UserIntentModeAutoplayCandidateTag = require(script.Parent.UserIntentModeAutoplayCandidateTag)
local VideoEndReason = require(VideoUtils.Analytics.Enums).VideoEndReason
local ViewportAutoplayCandidateTag = require(script.Parent.ViewportAutoplayCandidateTag)
local ViewportAutoplayRowSpanAttribute = require(script.Parent.ViewportAutoplayRowSpanAttribute)
local ViewportAutoplayCellVerticalPaddingAttribute = require(script.Parent.ViewportAutoplayCellVerticalPaddingAttribute)
local ViewportAutoplayAlignmentTypeAttribute = require(script.Parent.ViewportAutoplayAlignmentTypeAttribute)
local AlignmentType = require(VideoUtilsParent.DiscoveryTypes).GameCollectionItemTypes.AlignmentType

local FFlagLuaAppOneByTwoHoverIdleAutoplay = require(VideoUtilsParent.SharedFlags).FFlagLuaAppOneByTwoHoverIdleAutoplay
local FFlagLuaAppTileVideoCandidateOnly = require(VideoUtilsParent.SharedFlags).FFlagLuaAppTileVideoCandidateOnly
local FFlagLuaAppFixHiddenTileVideoCleanup = require(VideoUtilsParent.SharedFlags).FFlagLuaAppFixHiddenTileVideoCleanup
local FFlagLuaAppVideoAutoplayFeedElection = require(VideoUtilsParent.SharedFlags).FFlagLuaAppVideoAutoplayFeedElection
local FFlagLuaAppVideoAutoplayElectOnNewCandidate = require(script.Parent.FFlagLuaAppVideoAutoplayElectOnNewCandidate)

local function isVideoAutoplayCandidate(bool1: boolean?): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return not FFlagLuaAppTileVideoCandidateOnly or bool1 == true
end

local function shouldTagUserIntentModeCandidate(bool1: boolean?, bool2: boolean?, bool3: boolean): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not (FFlagLuaAppFixHiddenTileVideoCleanup and bool2) and (isVideoAutoplayCandidate(bool1) or bool3)
end

local function shouldNotifyUserIntentModeCandidateRegistered(bool1: boolean, electOnNewCandidate: boolean) -- Luacid: Inlined by compiler; 1 call site recovered
    return bool1 or FFlagLuaAppVideoAutoplayFeedElection and (electOnNewCandidate or FFlagLuaAppVideoAutoplayElectOnNewCandidate)
end

local function useTagAsViewportAutoplayCandidate(tbl1, arg1, bool1: boolean?, bool2: boolean?, num1: number?, num2: number?, str1: string?, tbl2)
    local viewportVideoAutoplayController = if arg1 then arg1.viewportVideoAutoplayController else nil
    local videoKey = if FFlagLuaAppOneByTwoHoverIdleAutoplay and tbl2 then tbl2.videoKey else nil
    local var1 = FFlagLuaAppOneByTwoHoverIdleAutoplay

    if var1 then
        if tbl2 == nil then
            var1 = false
        else
            var1 = tbl2.isUserIntentModeAutoplayCandidate
        end
    end

    local var2 = FFlagLuaAppOneByTwoHoverIdleAutoplay and tbl2 ~= nil

    local useEffect = React.useEffect
    local function func1()
        if not viewportVideoAutoplayController then
            return
        end

        if FFlagLuaAppOneByTwoHoverIdleAutoplay then
            if not shouldTagUserIntentModeCandidate(bool1, bool2, var1) then
                return
            end
        else
            if FFlagLuaAppTileVideoCandidateOnly and not bool1 then
                return
            end

            if FFlagLuaAppFixHiddenTileVideoCleanup and bool2 then
                return
            end
        end

        local current = tbl1.current
        if not current then
            return
        end

        if num1 == 2 and str1 ~= AlignmentType.LeftPin and str1 ~= AlignmentType.RightPin then
            return
        end

        if FFlagLuaAppOneByTwoHoverIdleAutoplay and videoKey then
            current:SetAttribute(ViewportAutoplayVideoKeyAttribute, videoKey)
        end

        if num1 ~= nil then
            current:SetAttribute(ViewportAutoplayRowSpanAttribute, num1)
            current:SetAttribute(ViewportAutoplayCellVerticalPaddingAttribute, num2)
            current:SetAttribute(ViewportAutoplayAlignmentTypeAttribute, str1)
        end

        if not FFlagLuaAppOneByTwoHoverIdleAutoplay or isVideoAutoplayCandidate(bool1) then
            CollectionService:AddTag(current, ViewportAutoplayCandidateTag)
        end
        if FFlagLuaAppOneByTwoHoverIdleAutoplay and var1 then
            CollectionService:AddTag(current, UserIntentModeAutoplayCandidateTag)
        end

        if FFlagLuaAppOneByTwoHoverIdleAutoplay then
            if shouldNotifyUserIntentModeCandidateRegistered(
                var2 and viewportVideoAutoplayController:isUserIntentWithSelectiveAutoplay(),
                viewportVideoAutoplayController.electOnNewCandidate
            ) then
                viewportVideoAutoplayController:onCandidateRegistered(current)
            end
        elseif FFlagLuaAppVideoAutoplayFeedElection
            and (viewportVideoAutoplayController.electOnNewCandidate or FFlagLuaAppVideoAutoplayElectOnNewCandidate)
        then
            viewportVideoAutoplayController:onCandidateRegistered(current)
        end

        return function()
            CollectionService:RemoveTag(current, ViewportAutoplayCandidateTag)
            if FFlagLuaAppOneByTwoHoverIdleAutoplay then
                CollectionService:RemoveTag(current, UserIntentModeAutoplayCandidateTag)
            end

            if num1 ~= nil then
                current:SetAttribute(ViewportAutoplayRowSpanAttribute, nil)
                current:SetAttribute(ViewportAutoplayCellVerticalPaddingAttribute, nil)
                current:SetAttribute(ViewportAutoplayAlignmentTypeAttribute, nil)
            end

            if FFlagLuaAppOneByTwoHoverIdleAutoplay then
                current:SetAttribute(ViewportAutoplayVideoKeyAttribute, nil)
            end

            viewportVideoAutoplayController:resetIfActiveInstance(current, VideoEndReason.Unmounted)
        end
    end

    local var3 = if FFlagLuaAppTileVideoCandidateOnly then bool1 else nil
    local var4 = if FFlagLuaAppFixHiddenTileVideoCleanup then bool2 else nil
    local var5 = if FFlagLuaAppOneByTwoHoverIdleAutoplay then videoKey else nil
    local var6 = if FFlagLuaAppOneByTwoHoverIdleAutoplay then var1 else nil
    local var7 = if FFlagLuaAppOneByTwoHoverIdleAutoplay then var2 else nil
    useEffect(func1, { viewportVideoAutoplayController, tbl1, var3, var4, num1, num2, str1, var5, var6, var7 })
end

return useTagAsViewportAutoplayCandidate
