-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local HttpService = game:GetService("HttpService")

local MediaGalleryParent = script:FindFirstAncestor("MediaGallery").Parent

local CentralOverlay = require(MediaGalleryParent.CentralOverlay)
local RobloxAppEnums = require(MediaGalleryParent.RobloxAppEnums)
local UniversalAppPolicy = require(MediaGalleryParent.UniversalAppPolicy)

local SetCentralOverlay = CentralOverlay.Actions.SetCentralOverlay
local CentralOverlayType = RobloxAppEnums.CentralOverlayType
local getAppFeaturePolicies = UniversalAppPolicy.getAppFeaturePolicies

local function openYouTubeVideoWithAgeCheck(str1: string, title: string?, callback: (...any) -> (...any), callback2: ((...any) -> (...any))?)
    if not str1 or #str1 == 0 then
        return
    end

    local function doOpen()
        local url = `https://www.youtube-nocookie.com/embed/{str1}?autoplay=1&controls=0&modestbranding=1&rel=0&loop=0&cc_load_policy=0&playsinline=0`
        local str3 = HttpService:JSONEncode({ url = url, title = title or "", animated = true })

        GuiService:BroadcastNotification(str3, 23)

        if callback2 then
            callback2()
        end
    end

    if getAppFeaturePolicies().getShowYouTubeAgeAlert() then
        callback(SetCentralOverlay(CentralOverlayType.LeaveRobloxAlert, { continueFunc = doOpen }))
        return
    end

    doOpen()
end

return openYouTubeVideoWithAgeCheck
