-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MediaGallery = script:FindFirstAncestor("MediaGallery")
local MediaGalleryParent = MediaGallery.Parent

local React = require(MediaGalleryParent.React)
local FocusNavigationEventNameEnum = require(MediaGalleryParent.FocusNavigationUtils).FocusNavigationEventNameEnum
local ReactFocusNavigation = require(MediaGalleryParent.ReactFocusNavigation)
local InputHandlers = require(MediaGalleryParent.InputHandlers)

local FFlagLuaAppMediaGalleryGamepadSupport = require(MediaGalleryParent.SharedFlags).FFlagLuaAppMediaGalleryGamepadSupport

local _MediaGalleryTypes = require(MediaGallery.MediaGalleryTypes)

local function useCarouselGamepadInput(tbl1)
    local var1 = React.useCallback(function()
        if tbl1.onFullscreenToggle then
            tbl1.onFullscreenToggle()
        end
    end, { tbl1.onFullscreenToggle })

    local var2 = React.useCallback(function()
        if tbl1.isVideoActive then
            tbl1.toggleMuteSignal:fire()
        end
    end, { tbl1.toggleMuteSignal, tbl1.isVideoActive })

    local var3 = React.useMemo(function()
        return {
            [Enum.KeyCode.ButtonL1] = if FFlagLuaAppMediaGalleryGamepadSupport then nil else FocusNavigationEventNameEnum.TabBackward,
            [Enum.KeyCode.ButtonR1] = if FFlagLuaAppMediaGalleryGamepadSupport then nil else FocusNavigationEventNameEnum.TabForward,
            [Enum.KeyCode.ButtonL2] = if FFlagLuaAppMediaGalleryGamepadSupport then FocusNavigationEventNameEnum.PageBackward else nil,
            [Enum.KeyCode.ButtonR2] = if FFlagLuaAppMediaGalleryGamepadSupport then FocusNavigationEventNameEnum.PageForward else nil,
            [Enum.KeyCode.ButtonA] = if FFlagLuaAppMediaGalleryGamepadSupport and tbl1.isVideoActive and tbl1.isVideoReady then if tbl1.isVideoPlaying then FocusNavigationEventNameEnum.PauseVideo else FocusNavigationEventNameEnum.PlayVideo else nil,
            [Enum.KeyCode.ButtonR3] = if tbl1.isFullscreen then FocusNavigationEventNameEnum.ExitFullscreen else FocusNavigationEventNameEnum.Fullscreen,
            [Enum.KeyCode.ButtonL3] = if tbl1.isVideoActive then if tbl1.isMuted then FocusNavigationEventNameEnum.Unmute else FocusNavigationEventNameEnum.Mute else nil
        }
    end, {
        tbl1.isFullscreen,
        tbl1.isMuted,
        tbl1.isVideoActive,
        if FFlagLuaAppMediaGalleryGamepadSupport then tbl1.isVideoPlaying else nil,
        if FFlagLuaAppMediaGalleryGamepadSupport then tbl1.isVideoReady else nil
    })

    local var4 = React.useMemo(function()
        local tbl2 = {
            [FocusNavigationEventNameEnum.Fullscreen] = {
                handler = InputHandlers.onRelease(var1)
            },
            [FocusNavigationEventNameEnum.ExitFullscreen] = {
                handler = InputHandlers.onRelease(var1)
            },
            [FocusNavigationEventNameEnum.Mute] = {
                handler = InputHandlers.onRelease(var2)
            },
            [FocusNavigationEventNameEnum.Unmute] = {
                handler = InputHandlers.onRelease(var2)
            }
        }

        if not FFlagLuaAppMediaGalleryGamepadSupport then
            tbl2[FocusNavigationEventNameEnum.TabBackward] = {
                handler = InputHandlers.onRelease(tbl1.scrollLeft)
            }
            tbl2[FocusNavigationEventNameEnum.TabForward] = {
                handler = InputHandlers.onRelease(tbl1.scrollRight)
            }

            return tbl2
        end

        tbl2[FocusNavigationEventNameEnum.PageBackward] = {
            handler = InputHandlers.onPress(tbl1.scrollLeft)
        }
        tbl2[FocusNavigationEventNameEnum.PageForward] = {
            handler = InputHandlers.onPress(tbl1.scrollRight)
        }

        tbl2[FocusNavigationEventNameEnum.PlayVideo] = {
            handler = InputHandlers.onRelease(function() end)
        }
        tbl2[FocusNavigationEventNameEnum.PauseVideo] = {
            handler = InputHandlers.onRelease(function() end)
        }
        return tbl2
    end, {
        tbl1.scrollLeft,
        tbl1.scrollRight,
        var1,
        var2
    })
    local var5 = ReactFocusNavigation.useEventMap(var3)
    return (ReactFocusNavigation.useEventHandlerMap(var4, var5))
end

return useCarouselGamepadInput
