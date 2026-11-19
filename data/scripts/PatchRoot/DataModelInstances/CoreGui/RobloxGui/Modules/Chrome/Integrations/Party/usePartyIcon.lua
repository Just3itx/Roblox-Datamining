-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:00:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)

local CrossExperienceVoice = require(CorePackages.Workspace.Packages.CrossExperienceVoice)
local RoactUtils = require(CorePackages.Workspace.Packages.RoactUtils)
local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)

local getColorFromUserId = require(CorePackages.Workspace.Packages.SquadsCore.getColorFromUserId)
local useLastActiveParticipant = CrossExperienceVoice.Hooks.useLastActiveParticipant
local useSequentialAnimation = CrossExperienceVoice.Hooks.useSequentialAnimation

local usePrevious = RoactUtils.Hooks.usePrevious

local getStandardSizeAvatarHeadShotRbxthumb = require(CorePackages.Workspace.Packages.UserLib).Utils.getStandardSizeAvatarHeadShotRbxthumb

local durationInMs = game:DefineFastInt("PartyVoiceTopbarActivityIndicatorAnimationMs", 50)
local num2 = game:DefineFastInt("PartyVoiceTopbarActivityIndicatorDebounceMs", 50)

local GetFFlagEnableCrossExpVoice = SharedFlags.GetFFlagEnableCrossExpVoice

function createAnimations(value: number, num1: number)
    return {
        ICON_OUT_ANIMATION = {
            value = 0,
            durationInMs = durationInMs,
            easingStyle = Enum.EasingStyle.Linear
        },
        ICON_IN_ANIMATION = {
            value = value,
            durationInMs = durationInMs,
            easingStyle = Enum.EasingStyle.Linear
        },
        AVATAR_IN_ANIMATION = {
            value = num1,
            durationInMs = durationInMs,
            easingStyle = Enum.EasingStyle.Linear
        },
        AVATAR_OUT_ANIMATION = {
            value = 0,
            durationInMs = durationInMs,
            easingStyle = Enum.EasingStyle.Linear
        }
    }
end

function getDisplayImage(num3: number, thumbnail: string)
    local tbl1 = { thumbnail = 0, backgroundColor = 0 }
    if num3 ~= -1 then
        thumbnail = getStandardSizeAvatarHeadShotRbxthumb(tostring(num3))
    end

    tbl1.thumbnail = thumbnail
    tbl1.backgroundColor = if num3 == -1 then nil else getColorFromUserId(num3)
    return tbl1
end

function usePartyIcon(num3: number, num4: number, str1: string)
    if not GetFFlagEnableCrossExpVoice() then
        local size, _ = React.createBinding(num3)
        return {
            image = getDisplayImage(-1, str1),
            size = size
        }
    end

    local var1 = useLastActiveParticipant()

    local userId = var1 and var1.userId or -1

    local var2 = usePrevious(userId)
    local image, var4 = React.useState(getDisplayImage(userId, str1))

    local size, var6 = useSequentialAnimation(if userId == -1 then num3 else num4)

    local var7 = React.useMemo(function()
        return createAnimations(num3, num4)
    end, { num3, num4 })

    local var8 = React.useCallback(function(num5: number)
        var4(function(arg1)
            local displayImage = getDisplayImage(num5, str1)

            return if arg1.thumbnail == displayImage.thumbnail and arg1.backgroundColor == displayImage.backgroundColor then arg1 else displayImage
        end)
    end, { str1, var4 })

    local var9 = React.useMemo(function()
        return CrossExperienceVoice.Utils.debounce(function(tbl1, func1: (...any) -> (...any))
            var6(tbl1, func1)
        end, num2)
    end, {})

    React.useEffect(function()
        if var2 == nil or userId == var2 then
            var8(userId)

            return
        end

        var9.cancel()
        if userId == -1 then
            var9.call({ var7.AVATAR_OUT_ANIMATION, var7.ICON_IN_ANIMATION }, function()
                var8(-1)
            end)

            return
        end

        if var2 ~= -1 then
            var8(userId)
            return
        end

        var6({ var7.ICON_OUT_ANIMATION, var7.AVATAR_IN_ANIMATION }, function()
            var8(userId)
        end)
    end, {
        userId,
        var8,
        var9,
        var7
    })

    return { image = image, size = size }
end

return usePartyIcon
